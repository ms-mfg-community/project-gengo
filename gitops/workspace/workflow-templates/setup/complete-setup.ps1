# .NET CI/CD Complete Setup Script
# This script automates the entire onboarding process for .NET developers

param(
    [Parameter(Mandatory = $true)]
    [string]$Owner,
    
    [Parameter(Mandatory = $true)]
    [string]$Repo,
    
    [Parameter(Mandatory = $false)]
    [string]$EnvFile = ".env",
    
    [Parameter(Mandatory = $false)]
    [switch]$SkipWorkflowCopy,
    
    [Parameter(Mandatory = $false)]
    [switch]$SkipGitConfig,
    
    [Parameter(Mandatory = $false)]
    [switch]$DryRun
)

# Script configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Color output functions
function Write-Success { param([string]$Message) Write-Host "✅ $Message" -ForegroundColor Green }
function Write-Info { param([string]$Message) Write-Host "ℹ️  $Message" -ForegroundColor Blue }
function Write-Warning { param([string]$Message) Write-Host "⚠️  $Message" -ForegroundColor Yellow }
function Write-Error { param([string]$Message) Write-Host "❌ $Message" -ForegroundColor Red }
function Write-Header { param([string]$Message) Write-Host "`n🚀 $Message" -ForegroundColor Cyan }

# Function to show usage
function Show-Usage {
    Write-Host @"
.NET CI/CD Complete Setup Script

USAGE:
    .\complete-setup.ps1 -Owner <github-owner> -Repo <github-repo> [OPTIONS]

PARAMETERS:
    -Owner              GitHub username or organization (required)
    -Repo               GitHub repository name (required)
    -EnvFile            Path to environment file (default: .env)
    -SkipWorkflowCopy   Skip copying workflow files to target repository
    -SkipGitConfig      Skip git configuration and .gitignore setup
    -DryRun             Show what would be done without making changes

EXAMPLES:
    .\complete-setup.ps1 -Owner "myorg" -Repo "myapp"
    .\complete-setup.ps1 -Owner "myorg" -Repo "myapp" -EnvFile ".env.prod"
    .\complete-setup.ps1 -Owner "myorg" -Repo "myapp" -DryRun

PREREQUISITES:
    - GitHub CLI (gh) installed and authenticated
    - Azure CLI (az) installed and authenticated (optional)
    - Git installed and configured
    - PowerShell 5.1+ or PowerShell Core 6+

"@
}

# Function to check prerequisites
function Test-Prerequisites {
    Write-Header "Checking Prerequisites"
    
    $prerequisites = @(
        @{ Name = "GitHub CLI"; Command = "gh"; Required = $true },
        @{ Name = "Git"; Command = "git"; Required = $true },
        @{ Name = "Azure CLI"; Command = "az"; Required = $false }
    )
    
    $allGood = $true
    
    foreach ($prereq in $prerequisites) {
        Write-Info "Checking $($prereq.Name)..."
        
        if (Get-Command $prereq.Command -ErrorAction SilentlyContinue) {
            Write-Success "$($prereq.Name) is installed"
        } else {
            if ($prereq.Required) {
                Write-Error "$($prereq.Name) is required but not found"
                $allGood = $false
            } else {
                Write-Warning "$($prereq.Name) is not installed (optional)"
            }
        }
    }
    
    # Check GitHub CLI authentication
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        try {
            $authStatus = gh auth status 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Success "GitHub CLI is authenticated"
            } else {
                Write-Error "GitHub CLI is not authenticated. Please run: gh auth login"
                $allGood = $false
            }
        } catch {
            Write-Error "Failed to check GitHub CLI authentication"
            $allGood = $false
        }
    }
    
    if (-not $allGood) {
        Write-Error "Prerequisites check failed. Please install missing tools."
        exit 1
    }
    
    Write-Success "All prerequisites met"
}

# Function to validate environment file
function Test-EnvironmentFile {
    Write-Header "Validating Environment Configuration"
    
    if (-not (Test-Path $EnvFile)) {
        Write-Warning "Environment file not found: $EnvFile"
        
        if (Test-Path ".env.template") {
            Write-Info "Copying template file..."
            if (-not $DryRun) {
                Copy-Item ".env.template" $EnvFile
            }
            Write-Warning "Please edit $EnvFile with your actual values before continuing"
            Write-Info "Required values:"
            Write-Host "  - AZURE_CLIENT_ID" -ForegroundColor Yellow
            Write-Host "  - AZURE_CLIENT_SECRET" -ForegroundColor Yellow
            Write-Host "  - AZURE_TENANT_ID" -ForegroundColor Yellow
            Write-Host "  - AZURE_SUBSCRIPTION_ID" -ForegroundColor Yellow
            Write-Host "  - GitHub repository information" -ForegroundColor Yellow
            Write-Host "  - Azure Web App names for each environment" -ForegroundColor Yellow
            
            if (-not $DryRun) {
                $continue = Read-Host "Have you completed the environment file? (y/N)"
                if ($continue -ne "y" -and $continue -ne "Y") {
                    Write-Info "Please complete the environment file and run the script again"
                    exit 0
                }
            }
        } else {
            Write-Error "No environment template found. Please create $EnvFile manually."
            exit 1
        }
    }
    
    Write-Success "Environment file validation completed"
}

# Function to setup Git configuration
function Set-GitConfiguration {
    Write-Header "Configuring Git Repository"
    
    if ($SkipGitConfig) {
        Write-Info "Skipping Git configuration (SkipGitConfig flag set)"
        return
    }
    
    # Check if we're in a git repository
    if (-not (Test-Path ".git")) {
        Write-Info "Initializing Git repository..."
        if (-not $DryRun) {
            git init
        }
    }
    
    # Copy .gitignore if it doesn't exist
    if (-not (Test-Path ".gitignore")) {
        Write-Info "Creating .gitignore file..."
        if (-not $DryRun) {
            Copy-Item ".gitignore" ".gitignore" -Force
        }
    } else {
        Write-Info "Adding .env exclusion to existing .gitignore..."
        if (-not $DryRun) {
            $gitignoreContent = Get-Content ".gitignore" -Raw
            if ($gitignoreContent -notmatch "\.env") {
                Add-Content ".gitignore" "`n# Environment Configuration`n.env`n.env.*"
            }
        }
    }
    
    Write-Success "Git configuration completed"
}

# Function to copy workflow files
function Copy-WorkflowFiles {
    Write-Header "Setting Up GitHub Workflows"
    
    if ($SkipWorkflowCopy) {
        Write-Info "Skipping workflow file copy (SkipWorkflowCopy flag set)"
        return
    }
    
    # Create .github/workflows directory
    $workflowDir = ".github/workflows"
    if (-not (Test-Path $workflowDir)) {
        Write-Info "Creating workflow directory..."
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $workflowDir -Force | Out-Null
        }
    }
    
    # Copy workflow files
    $workflowFiles = @(
        @{ Source = "master-ci-cd-dotnet-appservices-commented.yaml"; Target = "ci-cd-dotnet.yaml" },
        @{ Source = "references/deploy-child.yaml"; Target = "deploy-child.yaml" }
    )
    
    foreach ($file in $workflowFiles) {
        $sourcePath = Join-Path "workflow-templates" $file.Source
        $targetPath = Join-Path $workflowDir $file.Target
        
        if (Test-Path $sourcePath) {
            Write-Info "Copying workflow file: $($file.Target)"
            if (-not $DryRun) {
                Copy-Item $sourcePath $targetPath -Force
            }
        } else {
            Write-Warning "Source workflow file not found: $sourcePath"
        }
    }
    
    Write-Success "Workflow files setup completed"
}

# Function to run GitHub environment setup
function Invoke-GitHubEnvironmentSetup {
    Write-Header "Setting Up GitHub Environments"
    
    $setupScript = "setup/setup-github-environment.ps1"
    
    if (-not (Test-Path $setupScript)) {
        Write-Error "GitHub environment setup script not found: $setupScript"
        return
    }
    
    Write-Info "Running GitHub environment setup script..."
    
    if ($DryRun) {
        Write-Info "DRY RUN: Would execute: $setupScript -Owner $Owner -Repo $Repo -EnvFile $EnvFile"
    } else {
        try {
            & $setupScript -Owner $Owner -Repo $Repo -EnvFile $EnvFile
            Write-Success "GitHub environment setup completed"
        } catch {
            Write-Error "GitHub environment setup failed: $_"
            throw
        }
    }
}

# Function to create Azure resources (optional)
function New-AzureResources {
    Write-Header "Azure Resources Setup (Optional)"
    
    if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
        Write-Warning "Azure CLI not found. Skipping Azure resource setup."
        return
    }
    
    Write-Info "Checking Azure CLI authentication..."
    try {
        $azAccount = az account show --query "user.name" -o tsv 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Azure CLI is authenticated as: $azAccount"
        } else {
            Write-Warning "Azure CLI is not authenticated. Skipping Azure resource setup."
            Write-Info "To authenticate: az login"
            return
        }
    } catch {
        Write-Warning "Could not verify Azure CLI authentication"
        return
    }
    
    # Load environment variables to check for Azure resources
    $envVars = @{}
    if (Test-Path $EnvFile) {
        Get-Content $EnvFile | ForEach-Object {
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
    }
    
    # Check if Azure resources exist
    $environments = @('DEV', 'QA', 'PROD')
    foreach ($env in $environments) {
        $webAppName = $envVars["AZURE_WEBAPP_NAME_$env"]
        $resourceGroup = $envVars["AZURE_RESOURCE_GROUP_$env"]
        
        if ($webAppName -and $resourceGroup) {
            Write-Info "Checking Azure Web App: $webAppName in $resourceGroup"
            
            if ($DryRun) {
                Write-Info "DRY RUN: Would check Azure Web App: $webAppName"
            } else {
                $webApp = az webapp show --name $webAppName --resource-group $resourceGroup --query "name" -o tsv 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "Azure Web App found: $webAppName"
                } else {
                    Write-Warning "Azure Web App not found: $webAppName"
                    Write-Info "You may need to create Azure resources manually or update the environment file"
                }
            }
        }
    }
}

# Function to validate the complete setup
function Test-Setup {
    Write-Header "Validating Complete Setup"
    
    $validationItems = @(
        @{ Name = "Environment file"; Path = $EnvFile },
        @{ Name = "Git repository"; Path = ".git" },
        @{ Name = "Gitignore file"; Path = ".gitignore" },
        @{ Name = "Workflow directory"; Path = ".github/workflows" },
        @{ Name = "Main workflow"; Path = ".github/workflows/ci-cd-dotnet.yaml" },
        @{ Name = "Child workflow"; Path = ".github/workflows/deploy-child.yaml" }
    )
    
    $allValid = $true
    
    foreach ($item in $validationItems) {
        if (Test-Path $item.Path) {
            Write-Success "$($item.Name) ✓"
        } else {
            Write-Error "$($item.Name) ✗"
            $allValid = $false
        }
    }
    
    if ($allValid) {
        Write-Success "All validation checks passed!"
    } else {
        Write-Warning "Some validation checks failed. Please review the setup."
    }
    
    return $allValid
}

# Function to show completion summary
function Show-CompletionSummary {
    Write-Header "Setup Complete! 🎉"
    
    Write-Host @"

✅ Your .NET CI/CD pipeline is now set up!

📋 What was configured:
   • GitHub environments (dev, qa, prod)
   • Repository and environment secrets
   • Branch protection rules
   • CI/CD workflow files
   • Git configuration and .gitignore

🔗 Next steps:
   1. Review GitHub environments: https://github.com/$Owner/$Repo/settings/environments
   2. Configure reviewers for qa and prod environments
   3. Add Azure Web App publish profiles as secrets
   4. Test the workflow by pushing code or creating a PR

📝 Manual steps required:
   • Add publish profiles to environment secrets:
     gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "<profile_xml>" --env dev
     gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "<profile_xml>" --env qa
     gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "<profile_xml>" --env prod

🤖 Using GitHub Copilot:
   Use these prompts to customize your workflow:
   • "Help me add custom build steps to my .NET CI/CD pipeline"
   • "Show me how to add database migrations to my deployment"
   • "Help me troubleshoot deployment issues"

📚 Resources:
   • Onboarding guide: setup/onboarding-guide.md
   • Workflow templates: .github/workflows/
   • Environment template: .env.template

🎯 Success criteria:
   ✅ Workflows run successfully
   ✅ Deployments work for all environments
   ✅ Approval processes function correctly
   ✅ Monitoring and alerts are configured

"@

    if ($DryRun) {
        Write-Warning "This was a DRY RUN. No actual changes were made."
        Write-Info "Run the script without -DryRun to perform the actual setup."
    }
}

# Main execution function
function main {
    try {
        Write-Header "Starting Complete .NET CI/CD Setup"
        Write-Info "Repository: $Owner/$Repo"
        Write-Info "Environment file: $EnvFile"
        
        if ($DryRun) {
            Write-Warning "DRY RUN MODE - No changes will be made"
        }
        
        # Step 1: Check prerequisites
        Test-Prerequisites
        
        # Step 2: Validate environment file
        Test-EnvironmentFile
        
        # Step 3: Setup Git configuration
        Set-GitConfiguration
        
        # Step 4: Copy workflow files
        Copy-WorkflowFiles
        
        # Step 5: Run GitHub environment setup
        Invoke-GitHubEnvironmentSetup
        
        # Step 6: Optional Azure resources check
        New-AzureResources
        
        # Step 7: Validate complete setup
        $setupValid = Test-Setup
        
        # Step 8: Show completion summary
        Show-CompletionSummary
        
        if ($setupValid) {
            Write-Success "Setup completed successfully! 🚀"
            exit 0
        } else {
            Write-Warning "Setup completed with warnings. Please review the output."
            exit 1
        }
        
    } catch {
        Write-Error "Setup failed: $_"
        Write-Info "Please check the error above and retry."
        exit 1
    }
}

# Handle help parameter
if ($args -contains "--help" -or $args -contains "-h") {
    Show-Usage
    exit 0
}

# Execute main function
main

# end main
