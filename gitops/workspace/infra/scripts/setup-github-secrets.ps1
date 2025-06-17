#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Sets up GitHub secrets and variables for Azure deployment workflow.

.DESCRIPTION
    This script configures the required GitHub secrets and variables for the
    gaw-iac-azure-deployment workflow. It uses the GitHub CLI to set secrets
    and variables interactively.

.NOTES
    Prerequisites:
    - GitHub CLI installed and authenticated
    - Azure app registration configured for OIDC
    - Appropriate repository permissions

.EXAMPLE
    .\setup-github-secrets.ps1
#>

[CmdletBinding()]
param()

# Set error action preference
$ErrorActionPreference = "Stop"

Write-Host "=== GitHub Secrets and Variables Setup for Azure Deployment ===" -ForegroundColor Green
Write-Host ""

# Check if GitHub CLI is installed and authenticated
try {
    $ghStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Error "GitHub CLI is not authenticated. Please run 'gh auth login' first."
        exit 1
    }
    Write-Host "✓ GitHub CLI is authenticated" -ForegroundColor Green
} catch {
    Write-Error "GitHub CLI is not installed or not available in PATH."
    exit 1
}

# Generate random resource suffix
$randomResourceSuffix = (New-Guid).ToString().Substring(0,8)
Write-Host "Generated random resource suffix: $randomResourceSuffix" -ForegroundColor Yellow

# Define variables
$variables = @{
    "RESOURCE_GROUP_NAME" = "gaw-iac-azure-deployment"
    "LOCATION" = "eastus2"
    "RANDOM_RESOURCE_SUFFIX" = $randomResourceSuffix
    "STORAGE_ACCOUNT_NAME" = "1sta$randomResourceSuffix"
    "CONTAINER_REGISTRY_NAME" = "acr$randomResourceSuffix"
}

Write-Host ""
Write-Host "=== Setting up GitHub Secrets ===" -ForegroundColor Cyan

# Set up secrets interactively
$secrets = @(
    @{
        Name = "AZURE_SUBSCRIPTION_ID"
        Description = "The Azure subscription ID where resources will be deployed"
    },
    @{
        Name = "AZURE_CLIENT_ID"
        Description = "The Client ID from the Azure app registration"
    },
    @{
        Name = "AZURE_TENANT_ID"
        Description = "The Tenant ID from the Azure app registration"
    }
)

foreach ($secret in $secrets) {
    Write-Host ""
    Write-Host "Setting secret: $($secret.Name)" -ForegroundColor Yellow
    Write-Host "Description: $($secret.Description)" -ForegroundColor Gray
    
    do {
        $secretValue = Read-Host "Enter value for $($secret.Name)" -AsSecureString
        $plainTextSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secretValue))
        
        if ([string]::IsNullOrWhiteSpace($plainTextSecret)) {
            Write-Host "❌ Secret value cannot be empty. Please try again." -ForegroundColor Red
        }
    } while ([string]::IsNullOrWhiteSpace($plainTextSecret))
    
    try {
        # Use gh secret set command
        $plainTextSecret | gh secret set $secret.Name
        Write-Host "✓ Secret $($secret.Name) set successfully" -ForegroundColor Green
    } catch {
        Write-Error "Failed to set secret $($secret.Name): $_"
        exit 1
    }
}

Write-Host ""
Write-Host "=== Setting up GitHub Variables ===" -ForegroundColor Cyan

foreach ($variable in $variables.GetEnumerator()) {
    Write-Host "Setting variable: $($variable.Key) = $($variable.Value)" -ForegroundColor Yellow
    
    try {
        gh variable set $variable.Key --body $variable.Value
        Write-Host "✓ Variable $($variable.Key) set successfully" -ForegroundColor Green
    } catch {
        Write-Error "Failed to set variable $($variable.Key): $_"
        exit 1
    }
}

Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Green
Write-Host "✓ All GitHub secrets and variables have been configured successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Secrets configured:" -ForegroundColor Cyan
foreach ($secret in $secrets) {
    Write-Host "  - $($secret.Name)" -ForegroundColor White
}

Write-Host ""
Write-Host "Variables configured:" -ForegroundColor Cyan
foreach ($variable in $variables.GetEnumerator()) {
    Write-Host "  - $($variable.Key): $($variable.Value)" -ForegroundColor White
}

Write-Host ""
Write-Host "You can now use the gaw-iac-azure-deployment workflow!" -ForegroundColor Green

# end script
