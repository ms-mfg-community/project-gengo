#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Sets up GitHub repository secrets for Azure OIDC authentication.

.DESCRIPTION
    This script helps configure the required GitHub repository secrets for OIDC-based 
    authentication to Azure. It provides instructions and examples for setting up the 
    necessary Azure App Registration and GitHub secrets.

.PARAMETER RepositoryName
    The name of the GitHub repository (format: owner/repo).

.PARAMETER SubscriptionId
    The Azure subscription ID to use for deployment.

.PARAMETER TenantId
    The Azure tenant ID.

.PARAMETER ClientId
    The Azure App Registration client ID.

.EXAMPLE
    .\setup-github-secrets.ps1 -RepositoryName "myorg/myrepo" -SubscriptionId "12345678-1234-1234-1234-123456789abc"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$RepositoryName,
    
    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,
    
    [Parameter(Mandatory = $false)]
    [string]$TenantId,
    
    [Parameter(Mandatory = $false)]
    [string]$ClientId
)

Write-Host "=== GitHub Repository Secrets Setup for Azure OIDC ===" -ForegroundColor Green
Write-Host "This script will help you set up the required secrets for Azure authentication." -ForegroundColor Cyan
Write-Host ""

#region Prerequisites
Write-Host "=== Prerequisites ===" -ForegroundColor Yellow
Write-Host "1. Azure CLI installed and logged in" -ForegroundColor White
Write-Host "2. GitHub CLI installed and authenticated" -ForegroundColor White
Write-Host "3. Appropriate permissions in Azure and GitHub" -ForegroundColor White
Write-Host ""

# Check Azure CLI
if (Get-Command "az" -ErrorAction SilentlyContinue) {
    Write-Host "✅ Azure CLI found" -ForegroundColor Green
    
    # Get current subscription if not provided
    if (-not $SubscriptionId) {
        try {
            $currentSub = az account show --query "{subscriptionId:id, name:name, tenantId:tenantId}" -o json | ConvertFrom-Json
            $SubscriptionId = $currentSub.subscriptionId
            $TenantId = $currentSub.tenantId
            Write-Host "📋 Using current Azure subscription:" -ForegroundColor Cyan
            Write-Host "   Subscription ID: $SubscriptionId" -ForegroundColor Gray
            Write-Host "   Tenant ID: $TenantId" -ForegroundColor Gray
        } catch {
            Write-Warning "Could not get current Azure subscription. Please ensure you're logged in with 'az login'"
        }
    }
} else {
    Write-Warning "❌ Azure CLI not found. Please install it first."
}

# Check GitHub CLI
if (Get-Command "gh" -ErrorAction SilentlyContinue) {
    Write-Host "✅ GitHub CLI found" -ForegroundColor Green
    
    # Get current repository if not provided
    if (-not $RepositoryName) {
        try {
            $RepositoryName = gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>$null
            if ($RepositoryName) {
                Write-Host "📋 Using current GitHub repository: $RepositoryName" -ForegroundColor Cyan
            }
        } catch {
            Write-Warning "Could not detect current GitHub repository."
        }
    }
} else {
    Write-Warning "❌ GitHub CLI not found. Please install it first."
}
Write-Host ""
#endregion

#region Azure App Registration Setup
Write-Host "=== Azure App Registration Setup ===" -ForegroundColor Yellow

if (-not $ClientId) {
    Write-Host "You need to create an Azure App Registration for OIDC authentication." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Run the following commands to create the App Registration:" -ForegroundColor White
    Write-Host ""
    Write-Host "# Create App Registration" -ForegroundColor Gray
    Write-Host "az ad app create --display-name 'gaw-iac-azure-deployment-oidc'" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "# Create Service Principal" -ForegroundColor Gray
    Write-Host "az ad sp create --id <APP_ID>" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "# Assign Contributor role to the Service Principal" -ForegroundColor Gray
    Write-Host "az role assignment create --assignee <APP_ID> --role Contributor --scope /subscriptions/$SubscriptionId" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "# Add federated credential for GitHub Actions" -ForegroundColor Gray
    Write-Host "az ad app federated-credential create --id <APP_ID> --parameters '{" -ForegroundColor Yellow
    Write-Host "  \"name\": \"github-actions\"," -ForegroundColor Yellow
    Write-Host "  \"issuer\": \"https://token.actions.githubusercontent.com\"," -ForegroundColor Yellow
    Write-Host "  \"subject\": \"repo:$RepositoryName:ref:refs/heads/main\"," -ForegroundColor Yellow
    Write-Host "  \"description\": \"GitHub Actions OIDC\"," -ForegroundColor Yellow
    Write-Host "  \"audiences\": [\"api://AzureADTokenExchange\"]" -ForegroundColor Yellow
    Write-Host "}'" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "✅ Using provided Client ID: $ClientId" -ForegroundColor Green
}
#endregion

#region GitHub Secrets Setup
Write-Host "=== GitHub Repository Secrets Setup ===" -ForegroundColor Yellow

$secrets = @{
    "AZURE_CLIENT_ID" = $ClientId
    "AZURE_TENANT_ID" = $TenantId
    "AZURE_SUBSCRIPTION_ID" = $SubscriptionId
}

Write-Host "The following secrets need to be set in your GitHub repository:" -ForegroundColor Cyan
Write-Host ""

foreach ($secret in $secrets.GetEnumerator()) {
    $value = if ($secret.Value) { $secret.Value } else { "<REPLACE_WITH_ACTUAL_VALUE>" }
    Write-Host "Secret: $($secret.Key)" -ForegroundColor White
    Write-Host "Value:  $value" -ForegroundColor Gray
    Write-Host ""
    
    if ($RepositoryName -and $secret.Value -and (Get-Command "gh" -ErrorAction SilentlyContinue)) {
        try {
            Write-Host "Setting secret $($secret.Key) in repository $RepositoryName..." -ForegroundColor Cyan
            $secretValue = $secret.Value | gh secret set $secret.Key --repo $RepositoryName
            Write-Host "✅ Secret $($secret.Key) set successfully" -ForegroundColor Green
        } catch {
            Write-Warning "❌ Failed to set secret $($secret.Key): $_"
            Write-Host "You can set it manually using:" -ForegroundColor Yellow
            Write-Host "gh secret set $($secret.Key) --repo $RepositoryName" -ForegroundColor Gray
        }
    } else {
        Write-Host "Manual setup required. Use GitHub CLI:" -ForegroundColor Yellow
        Write-Host "gh secret set $($secret.Key) --repo $RepositoryName" -ForegroundColor Gray
    }
    Write-Host ""
}
#endregion

#region Environment Setup
Write-Host "=== GitHub Environments Setup ===" -ForegroundColor Yellow
Write-Host "This workflow uses two environments:" -ForegroundColor Cyan
Write-Host "1. 'dev' - For planning and validation" -ForegroundColor White
Write-Host "2. 'prd' - For deployment (requires manual approval)" -ForegroundColor White
Write-Host ""
Write-Host "To set up environments:" -ForegroundColor Cyan
Write-Host "1. Go to your GitHub repository" -ForegroundColor White
Write-Host "2. Navigate to Settings > Environments" -ForegroundColor White
Write-Host "3. Create 'dev' environment (no restrictions)" -ForegroundColor White
Write-Host "4. Create 'prd' environment with:" -ForegroundColor White
Write-Host "   - Required reviewers: 1 or more" -ForegroundColor Gray
Write-Host "   - Deployment branches: main only" -ForegroundColor Gray
Write-Host ""
#endregion

#region Validation
Write-Host "=== Validation ===" -ForegroundColor Yellow
Write-Host "After setting up the secrets and environments, you can test the workflow by:" -ForegroundColor Cyan
Write-Host "1. Go to the Actions tab in your GitHub repository" -ForegroundColor White
Write-Host "2. Find the 'gaw-iac-azure-deployment' workflow" -ForegroundColor White
Write-Host "3. Click 'Run workflow' and test with 'plan-only' mode first" -ForegroundColor White
Write-Host ""
#endregion

Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host "Your GitHub repository should now be configured for Azure OIDC authentication." -ForegroundColor Cyan
Write-Host "Remember to replace any placeholder values with actual values!" -ForegroundColor Yellow
Write-Host ""
