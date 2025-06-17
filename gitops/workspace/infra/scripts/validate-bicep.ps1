#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates Bicep templates and parameters.

.DESCRIPTION
    This script validates the Bicep templates and parameter files for the
    Azure deployment workflow. It checks for syntax errors, parameter
    compatibility, and best practices.

.PARAMETER BicepFile
    Path to the main Bicep file to validate.

.PARAMETER ParametersFile
    Path to the Bicep parameters file to validate.

.PARAMETER ResourceGroupName
    Name of the target resource group for validation.

.PARAMETER Location
    Azure region for resource deployment validation.

.EXAMPLE
    .\validate-bicep.ps1 -BicepFile "main.bicep" -ParametersFile "main.bicepparam"

.EXAMPLE
    .\validate-bicep.ps1 -BicepFile "main.bicep" -ParametersFile "main.bicepparam" -ResourceGroupName "gaw-iac-azure-deployment" -Location "eastus2"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$BicepFile,
    
    [Parameter(Mandatory = $true)]
    [string]$ParametersFile,
    
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "gaw-iac-azure-deployment",
    
    [Parameter(Mandatory = $false)]
    [string]$Location = "eastus2"
)

# Set error action preference
$ErrorActionPreference = "Stop"

Write-Host "=== Bicep Template Validation ===" -ForegroundColor Green
Write-Host ""

# Check if Azure CLI is installed
try {
    $azVersion = az version --output json 2>$null | ConvertFrom-Json
    Write-Host "✓ Azure CLI version: $($azVersion.'azure-cli')" -ForegroundColor Green
} catch {
    Write-Error "Azure CLI is not installed or not available in PATH."
    exit 1
}

# Check if Bicep extension is installed
try {
    $bicepVersion = az bicep version 2>$null
    Write-Host "✓ Bicep version: $bicepVersion" -ForegroundColor Green
} catch {
    Write-Host "Installing Bicep extension..." -ForegroundColor Yellow
    az bicep install
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install Bicep extension."
        exit 1
    }
    Write-Host "✓ Bicep extension installed successfully" -ForegroundColor Green
}

# Validate file paths
if (!(Test-Path $BicepFile)) {
    Write-Error "Bicep file not found: $BicepFile"
    exit 1
}

if (!(Test-Path $ParametersFile)) {
    Write-Error "Parameters file not found: $ParametersFile"
    exit 1
}

Write-Host "✓ Input files exist" -ForegroundColor Green
Write-Host "  - Bicep file: $BicepFile" -ForegroundColor Gray
Write-Host "  - Parameters file: $ParametersFile" -ForegroundColor Gray

Write-Host ""
Write-Host "=== Bicep Syntax Validation ===" -ForegroundColor Cyan

# Build Bicep template to check syntax
try {
    Write-Host "Validating Bicep syntax..." -ForegroundColor Yellow
    az bicep build --file $BicepFile --stdout > $null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Bicep syntax validation passed" -ForegroundColor Green
    } else {
        Write-Error "Bicep syntax validation failed."
        exit 1
    }
} catch {
    Write-Error "Error during Bicep syntax validation: $_"
    exit 1
}

Write-Host ""
Write-Host "=== Template Deployment Validation ===" -ForegroundColor Cyan

# Validate deployment (what-if analysis)
try {
    Write-Host "Running deployment validation (what-if)..." -ForegroundColor Yellow
    
    $whatIfOutput = az deployment sub what-if `
        --template-file $BicepFile `
        --parameters $ParametersFile `
        --location $Location `
        --output json 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Deployment validation passed" -ForegroundColor Green
        
        # Parse and display what-if results
        try {
            $whatIfResult = $whatIfOutput | ConvertFrom-Json
            Write-Host ""
            Write-Host "What-if results:" -ForegroundColor Cyan
            Write-Host $whatIfOutput -ForegroundColor Gray
        } catch {
            Write-Host "What-if output:" -ForegroundColor Cyan
            Write-Host $whatIfOutput -ForegroundColor Gray
        }
    } else {
        Write-Error "Deployment validation failed: $whatIfOutput"
        exit 1
    }
} catch {
    Write-Error "Error during deployment validation: $_"
    exit 1
}

Write-Host ""
Write-Host "=== Validation Summary ===" -ForegroundColor Green
Write-Host "✓ All validations passed successfully!" -ForegroundColor Green
Write-Host "  - Bicep syntax: Valid" -ForegroundColor White
Write-Host "  - Template deployment: Valid" -ForegroundColor White
Write-Host "  - Parameters: Compatible" -ForegroundColor White

Write-Host ""
Write-Host "Template is ready for deployment!" -ForegroundColor Green

# end script
