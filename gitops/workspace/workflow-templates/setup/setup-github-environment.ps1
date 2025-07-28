# .NET CI/CD GitHub Environment Setup Script
# PowerShell script to automate GitHub environments, secrets, and variables setup

param(
    [Parameter(Mandatory = $true)]
    [string]$Owner,
    
    [Parameter(Mandatory = $true)]
    [string]$Repo,
    
    [Parameter(Mandatory = $false)]
    [string]$EnvFile = ".env"
)

# Script configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Color output functions
function Write-Success { param([string]$Message) Write-Host "✅ $Message" -ForegroundColor Green }
function Write-Info { param([string]$Message) Write-Host "ℹ️  $Message" -ForegroundColor Blue }
function Write-Warning { param([string]$Message) Write-Host "⚠️  $Message" -ForegroundColor Yellow }
function Write-Error { param([string]$Message) Write-Host "❌ $Message" -ForegroundColor Red }

# Function to check if GitHub CLI is installed and authenticated
function Test-GitHubCLI {
    Write-Info "Checking GitHub CLI installation and authentication..."
    
    # Check if gh is installed
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        Write-Error "GitHub CLI (gh) is not installed. Please install it first:"
        Write-Host "  Windows: winget install GitHub.cli"
        Write-Host "  Or visit: https://cli.github.com/"
        exit 1
    }
    
    # Check if authenticated
    try {
        $authStatus = gh auth status 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Error "GitHub CLI is not authenticated. Please run: gh auth login"
            exit 1
        }
        Write-Success "GitHub CLI is installed and authenticated"
    } catch {
        Write-Error "Failed to check GitHub CLI authentication status"
        exit 1
    }
}

# Function to load environment variables from .env file
function Get-EnvironmentVariables {
    param([string]$EnvFilePath)
    
    if (-not (Test-Path $EnvFilePath)) {
        Write-Error "Environment file not found: $EnvFilePath"
        Write-Info "Please copy .env.template to .env and fill in your values"
        exit 1
    }
    
    Write-Info "Loading environment variables from $EnvFilePath..."
    
    $envVars = @{}
    Get-Content $EnvFilePath | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith('#')) {
            $parts = $line.Split('=', 2)
            if ($parts.Length -eq 2) {
                $key = $parts[0].Trim()
                $value = $parts[1].Trim()
                $envVars[$key] = $value
            }
        }
    }
    
    # Validate required variables
    $requiredVars = @(
        'AZURE_CLIENT_ID',
        'AZURE_CLIENT_SECRET', 
        'AZURE_TENANT_ID',
        'AZURE_SUBSCRIPTION_ID'
    )
    
    foreach ($var in $requiredVars) {
        if (-not $envVars.ContainsKey($var) -or $envVars[$var] -eq "your-$($var.ToLower().Replace('_', '-'))-here") {
            Write-Error "Required environment variable $var is not set or has placeholder value"
            exit 1
        }
    }
    
    Write-Success "Environment variables loaded successfully"
    return $envVars
}

# Function to create GitHub environments
function New-GitHubEnvironment {
    param(
        [string]$EnvironmentName,
        [hashtable]$Config
    )
    
    Write-Info "Creating GitHub environment: $EnvironmentName"
    
    try {
        # Create environment
        $createResult = gh api "repos/$Owner/$Repo/environments/$EnvironmentName" --method PUT --silent 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Environment '$EnvironmentName' created successfully"
        } else {
            Write-Warning "Environment '$EnvironmentName' may already exist or there was an issue"
        }
        
        # Configure environment protection rules based on environment type
        if ($Config.ContainsKey('protection_rules')) {
            Write-Info "Configuring protection rules for $EnvironmentName..."
            
            $protectionConfig = @{
                wait_timer = $Config.protection_rules.wait_timer
                reviewers = @()
                deployment_branch_policy = @{
                    protected_branches = $Config.protection_rules.protected_branches
                    custom_branch_policies = $Config.protection_rules.custom_branch_policies
                }
            }
            
            if ($Config.protection_rules.reviewers -gt 0) {
                # Note: In a real scenario, you would need to get actual user IDs
                Write-Info "Protection rules require $($Config.protection_rules.reviewers) reviewers"
                Write-Warning "Manual step required: Configure reviewers in GitHub UI"
            }
            
            $protectionJson = $protectionConfig | ConvertTo-Json -Depth 5
            $protectionResult = gh api "repos/$Owner/$Repo/environments/$EnvironmentName" --method PUT --input - <<< $protectionJson
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Protection rules configured for $EnvironmentName"
            } else {
                Write-Warning "Failed to configure protection rules for $EnvironmentName"
            }
        }
        
    } catch {
        Write-Error "Failed to create environment $EnvironmentName`: $_"
    }
}

# Function to set repository secrets
function Set-RepositorySecret {
    param(
        [string]$SecretName,
        [string]$SecretValue
    )
    
    Write-Info "Setting repository secret: $SecretName"
    
    try {
        $result = gh secret set $SecretName --body $SecretValue --repo "$Owner/$Repo" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Repository secret '$SecretName' set successfully"
        } else {
            Write-Error "Failed to set repository secret '$SecretName': $result"
        }
    } catch {
        Write-Error "Error setting repository secret '$SecretName': $_"
    }
}

# Function to set environment secrets
function Set-EnvironmentSecret {
    param(
        [string]$EnvironmentName,
        [string]$SecretName,
        [string]$SecretValue
    )
    
    Write-Info "Setting environment secret: $SecretName for $EnvironmentName"
    
    try {
        $result = gh secret set $SecretName --body $SecretValue --env $EnvironmentName --repo "$Owner/$Repo" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Environment secret '$SecretName' set for $EnvironmentName"
        } else {
            Write-Error "Failed to set environment secret '$SecretName' for $EnvironmentName`: $result"
        }
    } catch {
        Write-Error "Error setting environment secret '$SecretName' for $EnvironmentName`: $_"
    }
}

# Function to set environment variables
function Set-EnvironmentVariable {
    param(
        [string]$EnvironmentName,
        [string]$VariableName,
        [string]$VariableValue
    )
    
    Write-Info "Setting environment variable: $VariableName for $EnvironmentName"
    
    try {
        $result = gh variable set $VariableName --body $VariableValue --env $EnvironmentName --repo "$Owner/$Repo" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Environment variable '$VariableName' set for $EnvironmentName"
        } else {
            Write-Error "Failed to set environment variable '$VariableName' for $EnvironmentName`: $result"
        }
    } catch {
        Write-Error "Error setting environment variable '$VariableName' for $EnvironmentName`: $_"
    }
}

# Function to configure branch protection rules
function Set-BranchProtection {
    param(
        [string]$Branch,
        [hashtable]$Rules
    )
    
    Write-Info "Configuring branch protection for: $Branch"
    
    $protectionConfig = @{
        required_status_checks = @{
            strict = $true
            contexts = @()
        }
        enforce_admins = $false
        required_pull_request_reviews = @{
            dismiss_stale_reviews = $true
            require_code_owner_reviews = $true
            required_approving_review_count = $Rules.required_reviewers
        }
        restrictions = $null
        allow_force_pushes = $false
        allow_deletions = $false
    }
    
    try {
        $protectionJson = $protectionConfig | ConvertTo-Json -Depth 5
        $result = gh api "repos/$Owner/$Repo/branches/$Branch/protection" --method PUT --input - <<< $protectionJson
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Branch protection configured for $Branch"
        } else {
            Write-Warning "Failed to configure branch protection for $Branch"
        }
    } catch {
        Write-Error "Error configuring branch protection for $Branch`: $_"
    }
}

# Main execution
function Main {
    Write-Info "Starting .NET CI/CD GitHub Environment Setup"
    Write-Info "Repository: $Owner/$Repo"
    Write-Info "Environment file: $EnvFile"
    
    # Step 1: Verify prerequisites
    Test-GitHubCLI
    
    # Step 2: Load environment variables
    $envVars = Get-EnvironmentVariables -EnvFilePath $EnvFile
    
    # Step 3: Define environment configurations
    $environments = @{
        'dev' = @{
            protection_rules = @{
                wait_timer = 0
                reviewers = 0
                protected_branches = $true
                custom_branch_policies = $false
            }
        }
        'qa' = @{
            protection_rules = @{
                wait_timer = 0
                reviewers = 1
                protected_branches = $true
                custom_branch_policies = $false
            }
        }
        'prod' = @{
            protection_rules = @{
                wait_timer = 300  # 5 minutes
                reviewers = 2
                protected_branches = $true
                custom_branch_policies = $false
            }
        }
    }
    
    # Step 4: Create GitHub environments
    foreach ($env in $environments.Keys) {
        New-GitHubEnvironment -EnvironmentName $env -Config $environments[$env]
    }
    
    # Step 5: Set repository-level secrets
    Write-Info "Setting repository-level secrets..."
    Set-RepositorySecret -SecretName "AZURE_CLIENT_ID" -SecretValue $envVars['AZURE_CLIENT_ID']
    Set-RepositorySecret -SecretName "AZURE_CLIENT_SECRET" -SecretValue $envVars['AZURE_CLIENT_SECRET']
    Set-RepositorySecret -SecretName "AZURE_TENANT_ID" -SecretValue $envVars['AZURE_TENANT_ID']
    Set-RepositorySecret -SecretName "AZURE_SUBSCRIPTION_ID" -SecretValue $envVars['AZURE_SUBSCRIPTION_ID']
    
    # Step 6: Set environment-specific variables and secrets
    $envMappings = @{
        'dev' = @{
            'AZURE_WEBAPP_NAME' = $envVars['AZURE_WEBAPP_NAME_DEV']
            'AZURE_RESOURCE_GROUP' = $envVars['AZURE_RESOURCE_GROUP_DEV']
            'DEPLOYMENT_SLOT' = $envVars['AZURE_WEBAPP_SLOT_DEV']
        }
        'qa' = @{
            'AZURE_WEBAPP_NAME' = $envVars['AZURE_WEBAPP_NAME_QA']
            'AZURE_RESOURCE_GROUP' = $envVars['AZURE_RESOURCE_GROUP_QA']
            'DEPLOYMENT_SLOT' = $envVars['AZURE_WEBAPP_SLOT_QA']
        }
        'prod' = @{
            'AZURE_WEBAPP_NAME' = $envVars['AZURE_WEBAPP_NAME_PROD']
            'AZURE_RESOURCE_GROUP' = $envVars['AZURE_RESOURCE_GROUP_PROD']
            'DEPLOYMENT_SLOT' = $envVars['AZURE_WEBAPP_SLOT_PROD']
        }
    }
    
    foreach ($env in $envMappings.Keys) {
        Write-Info "Configuring environment: $env"
        foreach ($varName in $envMappings[$env].Keys) {
            $varValue = $envMappings[$env][$varName]
            if ($varValue) {
                Set-EnvironmentVariable -EnvironmentName $env -VariableName $varName -VariableValue $varValue
            }
        }
    }
    
    # Step 7: Configure branch protection rules
    Write-Info "Configuring branch protection rules..."
    Set-BranchProtection -Branch "main" -Rules @{ required_reviewers = 1 }
    
    # Step 8: Summary
    Write-Success "GitHub environment setup completed successfully!"
    Write-Info "Next steps:"
    Write-Info "1. Review the created environments in GitHub: https://github.com/$Owner/$Repo/settings/environments"
    Write-Info "2. Configure reviewers for qa and prod environments"
    Write-Info "3. Add Azure Web App publish profiles as environment secrets"
    Write-Info "4. Test the workflows by creating a pull request"
    
    Write-Warning "Important: Remember to add publish profiles manually:"
    Write-Host "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<publish_profile_xml>`" --env dev"
    Write-Host "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<publish_profile_xml>`" --env qa"
    Write-Host "  gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<publish_profile_xml>`" --env prod"
}

# Execute main function
try {
    Main
} catch {
    Write-Error "Script execution failed: $_"
    exit 1
}

# end Main
