#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Sets up GitHub secrets and variables for the Azure deployment workflow.

.DESCRIPTION
    This PowerShell script uses the GitHub CLI to interactively set up the required 
    secrets and variables for the Azure deployment workflow using OIDC authentication.

.EXAMPLE
    .\setup-github-secrets.ps1
    
.NOTES
    Author: GitHub Copilot
    Date: June 25, 2025
    Purpose: Configure GitHub secrets and variables for Azure deployment workflow
    Prerequisites: 
    - GitHub CLI (gh) must be installed and authenticated
    - User must have admin access to the repository
#>

# Set error action preference to stop on errors
$ErrorActionPreference = "Stop"

try {
    Write-Host "🔐 GitHub Secrets and Variables Setup for Azure Deployment Workflow" -ForegroundColor Cyan
    Write-Host "=" * 80 -ForegroundColor Gray
    
    # Check if GitHub CLI is installed and authenticated
    Write-Host "🔍 Checking GitHub CLI..." -ForegroundColor Yellow
    $ghStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ GitHub CLI is not authenticated. Please run 'gh auth login' first." -ForegroundColor Red
        exit 1
    } # end if
    Write-Host "✅ GitHub CLI is authenticated" -ForegroundColor Green
    
    # Generate random resource suffix
    Write-Host "🎲 Generating random resource suffix..." -ForegroundColor Yellow
    $randomResourceSuffix = (New-Guid).ToString().Substring(0,8)
    Write-Host "✅ Random suffix generated: $randomResourceSuffix" -ForegroundColor Green
    
    # Define secrets and variables
    $secrets = @{
        'AZURE_SUBSCRIPTION_ID' = 'Azure subscription ID where resources will be deployed'
        'AZURE_CLIENT_ID' = 'Client ID from the Azure app registration'
        'AZURE_TENANT_ID' = 'Tenant ID from the Azure app registration'
    }
    
    $variables = @{
        'RESOURCE_GROUP_NAME' = 'gaw-iac-azure-deployment'
        'LOCATION' = 'eastus2'
        'RANDOM_RESOURCE_SUFFIX' = $randomResourceSuffix
        'STORAGE_ACCOUNT_NAME' = "1sta$randomResourceSuffix"
        'CONTAINER_REGISTRY_NAME' = "acr$randomResourceSuffix"
    }
    
    Write-Host "" -ForegroundColor White
    Write-Host "🔑 Setting up GitHub Secrets..." -ForegroundColor Cyan
    Write-Host "Note: You will be prompted to enter values interactively" -ForegroundColor Yellow
    Write-Host "" -ForegroundColor White
    
    # Set secrets interactively
    foreach ($secretName in $secrets.Keys) {
        $description = $secrets[$secretName]
        Write-Host "Setting secret: $secretName" -ForegroundColor White
        Write-Host "Description: $description" -ForegroundColor Gray
        
        # Read secret value securely
        $secretValue = Read-Host "Enter value for $secretName" -AsSecureString
        $plainTextValue = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secretValue))
        
        if ([string]::IsNullOrWhiteSpace($plainTextValue)) {
            Write-Host "⚠️  Skipping empty value for $secretName" -ForegroundColor Yellow
            continue
        } # end if
        
        # Set the secret using GitHub CLI
        $result = echo $plainTextValue | gh secret set $secretName
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Secret $secretName set successfully" -ForegroundColor Green
        } else {
            Write-Host "❌ Failed to set secret $secretName" -ForegroundColor Red
        } # end if
        
        Write-Host "" -ForegroundColor White
    } # end foreach
    
    Write-Host "📊 Setting up GitHub Variables..." -ForegroundColor Cyan
    Write-Host "" -ForegroundColor White
    
    # Set variables
    foreach ($variableName in $variables.Keys) {
        $variableValue = $variables[$variableName]
        Write-Host "Setting variable: $variableName = $variableValue" -ForegroundColor White
        
        $result = gh variable set $variableName --body $variableValue
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Variable $variableName set successfully" -ForegroundColor Green
        } else {
            Write-Host "❌ Failed to set variable $variableName" -ForegroundColor Red
        } # end if
    } # end foreach
    
    Write-Host "" -ForegroundColor White
    Write-Host "📋 Summary of Configuration:" -ForegroundColor Cyan
    Write-Host "Secrets configured:" -ForegroundColor White
    foreach ($secretName in $secrets.Keys) {
        Write-Host "  ✓ $secretName" -ForegroundColor Green
    } # end foreach
    
    Write-Host "Variables configured:" -ForegroundColor White
    foreach ($variableName in $variables.Keys) {
        $variableValue = $variables[$variableName]
        Write-Host "  ✓ $variableName = $variableValue" -ForegroundColor Green
    } # end foreach
    
    Write-Host "" -ForegroundColor White
    Write-Host "🎉 GitHub secrets and variables setup completed successfully!" -ForegroundColor Green
    Write-Host "=" * 80 -ForegroundColor Gray
    
    Write-Host "" -ForegroundColor White
    Write-Host "📝 Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Ensure your Azure App Registration has federated credentials configured" -ForegroundColor White
    Write-Host "2. Assign appropriate Azure permissions to the service principal" -ForegroundColor White
    Write-Host "3. Create GitHub environments (dev/prd) with protection rules" -ForegroundColor White
    Write-Host "4. Run the Azure deployment workflow to test the configuration" -ForegroundColor White
    
} catch {
    Write-Host "" -ForegroundColor White
    Write-Host "❌ ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "📍 Location: $($_.InvocationInfo.ScriptName):$($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
    Write-Host "=" * 80 -ForegroundColor Gray
    exit 1
} # end try-catch
