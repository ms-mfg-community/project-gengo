#Requires -Version 7.0
<#
.SYNOPSIS
    Deploy Flask app to Azure App Service using a container from ACR
    and provision AI Foundry with GPT-Realtime model using AZD.

.DESCRIPTION
    This script provides two deployment modes:
    1) Full deployment (AI Foundry + Container + App Service) - ~15 minutes
    2) Container update only (requires full deployment first) - ~5 minutes

.EXAMPLE
    .\azdeploy.ps1
#>

# Only change the rg (resource group) and location variables below if needed.
$rg = "rg-voicelive"          # Replace with your resource group
$location = "eastus2"          # Or a location near you

# ============================================================================
# DON'T CHANGE ANYTHING BELOW THIS LINE.
# ============================================================================

$ErrorActionPreference = "Stop"

# Ensure azd can find Bicep CLI
$bicepPath = (Get-Command bicep -ErrorAction SilentlyContinue).Source
if ($bicepPath) {
    $env:AZD_BICEP_TOOL_PATH = $bicepPath
}

# ============================================================================
# Deployment Mode Selection
# ============================================================================
Clear-Host
Write-Host "Select deployment mode:"
Write-Host "  1) Full deployment (AI Foundry + Container + App Service) - ~15 minutes"
Write-Host "  2) Container update only (requires full deployment first) - ~5 minutes"
Write-Host ""
$deploy_mode = Read-Host "Enter choice (1 or 2)"

if ($deploy_mode -ne "1" -and $deploy_mode -ne "2") {
    Write-Host "ERROR: Invalid choice. Please enter 1 or 2." -ForegroundColor Red
    exit 1
}

# ============================================================================
# Service Name Generation (shared by both modes)
# ============================================================================
# Use the current console username plus a short 4-char deterministic hash to set service names.
$user_name = $env:USERNAME
if (-not $user_name) { $user_name = "user" }

# Sanitize username: lowercase and remove non-alphanumeric characters
$full_safe_user = ($user_name.ToLower() -replace '[^a-z0-9]', '')
if ([string]::IsNullOrEmpty($full_safe_user)) {
    $full_safe_user = "user"
}

# Truncate for human-readable resource prefixes (8 chars)
$safe_user = $full_safe_user.Substring(0, [Math]::Min(8, $full_safe_user.Length))

# 4-char hash from the full sanitized username (preserves uniqueness even if truncated)
$sha1 = [System.Security.Cryptography.SHA1]::Create()
$hashBytes = $sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($full_safe_user))
$short_hash = ([BitConverter]::ToString($hashBytes) -replace '-', '').Substring(0, 4).ToLower()

# Build ACR name by concatenating truncated username + hash + 'acr' (no hyphens)
$acr_name = "${safe_user}${short_hash}acr"

# Ensure ACR name starts with a letter; prepend 'a' if it doesn't
if ($acr_name -notmatch '^[a-z]') {
    $acr_name = "a$acr_name"
}

# Ensure minimum length 5 (ACR requires 5-50 chars). Pad with 'a' if too short.
while ($acr_name.Length -lt 5) {
    $acr_name = "${acr_name}a"
}

# App Service plan and webapp (hyphens allowed)
$appsvc_plan = "${safe_user}-appplan-${short_hash}"
$webapp_name = "${safe_user}-webapp-${short_hash}"
$image = "rt-voice"
$tag = "v1"
$azd_env_name = "gpt-realtime"  # Forced as unique at each run

# ============================================================================
# Mode 2: Container Update Only
# ============================================================================
if ($deploy_mode -eq "2") {
    Clear-Host
    Write-Host "Starting container update (rebuild + redeploy)..."
    Write-Host ""
    
    # Verify that the resources exist
    Write-Host "  - Verifying existing resources..."
    $acrExists = az acr show -n $acr_name -g $rg 2>$null
    if (-not $acrExists) {
        Write-Host "ERROR: ACR '$acr_name' not found in resource group '$rg'" -ForegroundColor Red
        Write-Host "You must run a full deployment (option 1) first."
        exit 1
    }
    
    $webappExists = az webapp show -n $webapp_name -g $rg 2>$null
    if (-not $webappExists) {
        Write-Host "ERROR: Web App '$webapp_name' not found in resource group '$rg'" -ForegroundColor Red
        Write-Host "You must run a full deployment (option 1) first."
        exit 1
    }
    
    Write-Host "  - Resources verified: ACR and Web App exist"
    
    # Build image
    Write-Host "  - Building updated image in ACR...(takes 3-5 minutes)"
    $max_retries = 3
    $retry_count = 0

    while ($retry_count -lt $max_retries) {
        Write-Host "  - Attempt $($retry_count + 1) of $max_retries`: building image..."
        
        az acr build -r $acr_name --image "${acr_name}.azurecr.io/${image}:${tag}" --file Dockerfile . 2>$null | Out-Null

        $repoCheck = az acr repository show --name $acr_name --repository $image 2>$null
        if ($repoCheck) {
            Write-Host "  - Image successfully built and verified in ACR"
            break
        } else {
            Write-Host "  - Image not found in ACR, retrying build..."
            $retry_count++
            if ($retry_count -lt $max_retries) {
                Write-Host "  - Waiting 5 seconds before retry..."
                Start-Sleep -Seconds 5
            }
        }
    }

    if ($retry_count -eq $max_retries) {
        Write-Host "ERROR: Failed to build image after $max_retries attempts" -ForegroundColor Red
        exit 1
    }
    
    # Restart web app to pull new image
    Write-Host "  - Restarting Web App to pull updated container..."
    az webapp restart --name $webapp_name --resource-group $rg | Out-Null
    
    Write-Host ""
    Write-Host "Container update complete!" -ForegroundColor Green
    Write-Host " - Your app is available at: https://${webapp_name}.azurewebsites.net"
    Write-Host " - App may take 1-2 minutes to restart with the new image."
    Write-Host ""
    exit 0
}

# ============================================================================
# Mode 1: Full Deployment (original script flow)
# ============================================================================

# Create the .env file
$envContent = @"
# Do not change any settings in this file. Endpoint, API key, and model name are set automatically during deployment
AZURE_VOICE_LIVE_ENDPOINT=""
AZURE_VOICE_LIVE_API_KEY=""
VOICE_LIVE_MODEL=""
VOICE_LIVE_VOICE="en-US-JennyNeural"
VOICE_LIVE_INSTRUCTIONS="You are a helpful AI assistant with a focus on world history. Respond naturally and conversationally. Keep your responses concise but engaging."
VOICE_LIVE_VERBOSE=""
"@
$envContent | Out-File -FilePath ".env" -Encoding utf8 -Force

Clear-Host
Write-Host "Starting FULL deployment with AZD provisioning + App Service, takes about 15 minutes..."

# Step 1: Provision AI Foundry with GPT Realtime model using AZD
Write-Host ""
Write-Host "Step 1: Provisioning AI Foundry with GPT Realtime model..."
Write-Host "  - Setting up AZD environment..."

# Clear local azd state only (safe for students - doesn't delete Azure resources)
if (Test-Path "$env:USERPROFILE\.azd") {
    Remove-Item -Recurse -Force "$env:USERPROFILE\.azd" -ErrorAction SilentlyContinue
}
# Also clear any project-level azd state
if (Test-Path ".azure") {
    Remove-Item -Recurse -Force ".azure" -ErrorAction SilentlyContinue
}

# Create fresh environment with unique name
$null = azd env new $azd_env_name 2>$null
$null = azd env set AZURE_LOCATION $location
$null = azd env set AZURE_RESOURCE_GROUP $rg
Write-Host "  - AZD environment '$azd_env_name' created (fresh state)"

Write-Host "  - Provisioning AI resources (forcing new deployment)..."
# Verify azd authentication
$authStatus = azd auth login --check-status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "  - Authenticating azd with Azure..."
    azd auth login 2>$null
}

# Force a completely fresh deployment by combining multiple techniques
$timestamp = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
azd config set alpha.infrastructure.deployment.name "azd-gpt-realtime-$timestamp"
# Clear any cached deployment state and force deployment
$null = azd env refresh --no-prompt 2>$null
azd provision

Write-Host "  - Retrieving AI Foundry endpoint, API key, and model name..."
$azdValues = azd env get-values --output json | ConvertFrom-Json
$endpoint = $azdValues.AZURE_OPENAI_ENDPOINT
$api_key = $azdValues.AZURE_OPENAI_API_KEY
$model_name = $azdValues.AZURE_OPENAI_REALTIME_MODEL_NAME

if ([string]::IsNullOrEmpty($endpoint) -or [string]::IsNullOrEmpty($api_key) -or [string]::IsNullOrEmpty($model_name)) {
    Write-Host "ERROR: Failed to retrieve AI Foundry endpoint, API key, or model name from azd" -ForegroundColor Red
    Write-Host "Please check the azd provision output and try again"
    exit 1
}

Write-Host "  - Updating .env file with AI Foundry credentials..."
# Update .env file with the retrieved values
if (Test-Path ".env") {
    $envFileContent = Get-Content ".env" -Raw
    $envFileContent = $envFileContent -replace 'AZURE_VOICE_LIVE_ENDPOINT=.*', "AZURE_VOICE_LIVE_ENDPOINT=`"$endpoint`""
    $envFileContent = $envFileContent -replace 'AZURE_VOICE_LIVE_API_KEY=.*', "AZURE_VOICE_LIVE_API_KEY=`"$api_key`""
    $envFileContent = $envFileContent -replace 'VOICE_LIVE_MODEL=.*', "VOICE_LIVE_MODEL=`"$model_name`""
    $envFileContent | Out-File -FilePath ".env" -Encoding utf8 -Force
    Write-Host "  - .env file updated with AI Foundry credentials and model name"
} else {
    Write-Host "ERROR: .env file not found" -ForegroundColor Red
    exit 1
}

Write-Host "  - AI Foundry provisioning complete!"

# Step 2: Continue with App Service deployment
Write-Host ""
Write-Host "Step 2: Create ACR and App Service resources..."

# Create ACR and build image from Dockerfile
Write-Host "  - Creating Azure Container Registry resource..."
az acr create -n $acr_name -g $rg --sku Basic --admin-enabled true | Out-Null
Write-Host "  - Resource created"
Write-Host "  - Starting image build process in 10 seconds to reduce build failures."
Start-Sleep -Seconds 10  # To give time for the ACR service to be ready for build operations
Write-Host "  - Building image in ACR...(takes 3-5 minutes per attempt)"

# Build image with retry logic
$max_retries = 3
$retry_count = 0

while ($retry_count -lt $max_retries) {
    Write-Host "  - Attempt $($retry_count + 1) of $max_retries`: building image..."
    
    # Run the build command
    az acr build -r $acr_name --image "${acr_name}.azurecr.io/${image}:${tag}" --file Dockerfile . 2>$null | Out-Null

    # Check if the image exists in the registry
    $repoCheck = az acr repository show --name $acr_name --repository $image 2>$null
    if ($repoCheck) {
        Write-Host "  - Image successfully built and verified in ACR..."
        break
    } else {
        Write-Host "  - Image not found in ACR, retrying build..."
        $retry_count++
        if ($retry_count -lt $max_retries) {
            Write-Host "  - Waiting 5 seconds before retry..."
            Start-Sleep -Seconds 5
        }
    }
}

if ($retry_count -eq $max_retries) {
    Write-Host "ERROR: Failed to build image after $max_retries attempts" -ForegroundColor Red
    Write-Host "Please check your Dockerfile and try again manually with:"
    Write-Host "az acr build -r $acr_name --image ${acr_name}.azurecr.io/${image}:${tag} --file Dockerfile ."
    exit 1
}

Write-Host "  - Container image build complete!"

Write-Host ""
Write-Host "Step 3: Configuring Azure App Service with updated credentials..."

Write-Host "  - Gathering environment variables from .env file for App Service deployment.."
# Parse the .env file and bring values into the script environment
$envVars = @{}
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        $line = $_.Trim()
        # Skip comments and empty lines
        if ($line -and -not $line.StartsWith("#")) {
            $parts = $line -split '=', 2
            if ($parts.Length -eq 2) {
                $key = $parts[0].Trim()
                $val = $parts[1].Trim().Trim('"').Trim("'")
                $envVars[$key] = $val
            }
        }
    }
}

# Build env_vars for App Service
$appSettings = @(
    "AZURE_VOICE_LIVE_ENDPOINT=$($envVars['AZURE_VOICE_LIVE_ENDPOINT'])"
    "AZURE_VOICE_LIVE_API_KEY=$($envVars['AZURE_VOICE_LIVE_API_KEY'])"
    "VOICE_LIVE_MODEL=$($envVars['VOICE_LIVE_MODEL'])"
    "VOICE_LIVE_VOICE=$($envVars['VOICE_LIVE_VOICE'])"
    "VOICE_LIVE_INSTRUCTIONS=$($envVars['VOICE_LIVE_INSTRUCTIONS'])"
)

Write-Host "  - Retrieving ACR credentials so App Service can access the container image..."
# Use the retrieved ACR credentials to allow AppSvc to pull the image.
$acr_user = (az acr credential show -n $acr_name --query username -o tsv).Trim()
$acr_pass = (az acr credential show -n $acr_name --query "passwords[0].value" -o tsv).Trim()
$acr_login_server = (az acr show --name $acr_name --query "loginServer" --output tsv).Trim()
$acr_image = "${acr_login_server}/${image}:${tag}"

Write-Host "  - Creating App Service plan: $appsvc_plan Linux B1..."
az appservice plan create --name $appsvc_plan `
    --resource-group $rg `
    --is-linux `
    --sku B1 | Out-Null

Write-Host "  - Creating Web App: ${webapp_name}..."
# Create the webapp with Docker runtime for container deployment
az webapp create --resource-group $rg `
    --plan $appsvc_plan `
    --name $webapp_name `
    --runtime "PYTHON:3.10" | Out-Null

Write-Host "  - Applying environment variables to web app..."
az webapp config appsettings set --resource-group $rg `
    --name $webapp_name `
    --settings @appSettings | Out-Null

Write-Host "  - Configuring Web App container settings to pull from ACR..."
az webapp config container set `
    --name $webapp_name `
    --resource-group $rg `
    --container-image-name $acr_image `
    --container-registry-url "https://$acr_login_server" `
    --container-registry-user $acr_user `
    --container-registry-password $acr_pass | Out-Null

Write-Host "  - Configuring app settings..."
az webapp config set --resource-group $rg `
    --name $webapp_name `
    --startup-file "" `
    --always-on true | Out-Null

# Start / Restart to ensure container is pulled
Start-Sleep -Seconds 5
Write-Host "  - Restarting Web App to ensure new container image is pulled..."
az webapp restart --name $webapp_name --resource-group $rg | Out-Null
Start-Sleep -Seconds 10  # Time for the service to restart and pull image

# Show final URL and cleanup info
Write-Host ""
Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host ""
Write-Host " - AI Foundry with GPT Realtime model: PROVISIONED"
Write-Host " - Flask app deployed to App Service: READY"
Write-Host " - Your app is available at: https://${webapp_name}.azurewebsites.net"
Write-Host ""
Write-Host "Note: App may take a few minutes to start after loading the web page."
Write-Host ""
Write-Host "To update the container with new code changes, run this script again and select option 2 (Container update only)."
Write-Host ""
