#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates Bicep files before deployment.

.DESCRIPTION
    This PowerShell script validates Bicep files using the Azure CLI 'az bicep build' 
    command to ensure the templates are valid and can be deployed successfully.

.PARAMETER BicepFilePath
    The path to the Bicep file to validate. Defaults to 'main.bicep' in the current directory.

.PARAMETER ModulesPath
    The path to the Bicep modules directory. Defaults to 'modules' in the current directory.

.EXAMPLE
    .\validate-bicep.ps1
    .\validate-bicep.ps1 -BicepFilePath "infra/main.bicep" -ModulesPath "infra/modules"
    
.NOTES
    Author: GitHub Copilot
    Date: June 25, 2025
    Purpose: Validate Bicep templates before deployment
    Prerequisites: 
    - Azure CLI must be installed
    - Bicep extension must be installed (az bicep install)
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$BicepFilePath = "main.bicep",
    
    [Parameter(Mandatory = $false)]
    [string]$ModulesPath = "modules"
)

# Set error action preference to stop on errors
$ErrorActionPreference = "Stop"

try {
    Write-Host "🔍 Bicep Template Validation" -ForegroundColor Cyan
    Write-Host "=" * 60 -ForegroundColor Gray
    
    # Check if Azure CLI is installed
    Write-Host "⚙️  Checking Azure CLI..." -ForegroundColor Yellow
    $azVersion = az --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Azure CLI is not installed or not available in PATH"
    } # end if
    Write-Host "✅ Azure CLI is available" -ForegroundColor Green
    
    # Check if Bicep extension is installed
    Write-Host "🔧 Checking Bicep extension..." -ForegroundColor Yellow
    $bicepVersion = az bicep version 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "📦 Installing Bicep extension..." -ForegroundColor Yellow
        az bicep install
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to install Bicep extension"
        } # end if
    } # end if
    Write-Host "✅ Bicep extension is available" -ForegroundColor Green
    
    # Change to the parent directory (infra directory) to ensure relative paths work correctly
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $infraDir = Split-Path -Parent $scriptDir
    Set-Location $infraDir
    
    # Get current directory for context
    $currentDir = Get-Location
    Write-Host "📂 Working directory: $currentDir" -ForegroundColor Gray
    
    # Validate main Bicep file
    Write-Host "" -ForegroundColor White
    Write-Host "📋 Validating main Bicep file..." -ForegroundColor Cyan
    $mainBicepFile = Join-Path $currentDir $BicepFilePath
    
    if (-not (Test-Path $mainBicepFile)) {
        throw "Main Bicep file not found: $mainBicepFile"
    } # end if
    
    Write-Host "🔍 Validating: $mainBicepFile" -ForegroundColor White
    
    # Build the main Bicep file to validate syntax
    $buildOutput = az bicep build --file $mainBicepFile 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Main Bicep file validation successful" -ForegroundColor Green
    } else {
        Write-Host "❌ Main Bicep file validation failed:" -ForegroundColor Red
        Write-Host $buildOutput -ForegroundColor Red
        throw "Main Bicep file validation failed"
    } # end if
    
    # Validate module files if modules directory exists
    $modulesDir = Join-Path $currentDir $ModulesPath
    if (Test-Path $modulesDir) {
        Write-Host "" -ForegroundColor White
        Write-Host "📋 Validating Bicep modules..." -ForegroundColor Cyan
        
        $moduleFiles = Get-ChildItem -Path $modulesDir -Filter "*.bicep"
        if ($moduleFiles.Count -eq 0) {
            Write-Host "ℹ️  No Bicep module files found in: $modulesDir" -ForegroundColor Blue
        } else {
            foreach ($moduleFile in $moduleFiles) {
                Write-Host "🔍 Validating module: $($moduleFile.Name)" -ForegroundColor White
                
                $moduleBuildOutput = az bicep build --file $moduleFile.FullName 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "✅ Module $($moduleFile.Name) validation successful" -ForegroundColor Green
                } else {
                    Write-Host "❌ Module $($moduleFile.Name) validation failed:" -ForegroundColor Red
                    Write-Host $moduleBuildOutput -ForegroundColor Red
                    throw "Module $($moduleFile.Name) validation failed"
                } # end if
            } # end foreach
        } # end if
    } else {
        Write-Host "ℹ️  Modules directory not found: $modulesDir" -ForegroundColor Blue
    } # end if
    
    # Check for parameter files
    Write-Host "" -ForegroundColor White
    Write-Host "📋 Checking parameter files..." -ForegroundColor Cyan
    
    $paramFiles = Get-ChildItem -Path $currentDir -Filter "*.bicepparam"
    if ($paramFiles.Count -eq 0) {
        Write-Host "ℹ️  No Bicep parameter files found" -ForegroundColor Blue
    } else {
        foreach ($paramFile in $paramFiles) {
            Write-Host "📄 Found parameter file: $($paramFile.Name)" -ForegroundColor White
            
            # Note: az bicep build-params is available in newer versions
            # For now, we'll just report that parameter files were found
            Write-Host "✅ Parameter file $($paramFile.Name) detected" -ForegroundColor Green
        } # end foreach
    } # end if
    
    Write-Host "" -ForegroundColor White
    Write-Host "📊 Validation Summary:" -ForegroundColor Cyan
    Write-Host "✅ Main Bicep file: Valid" -ForegroundColor Green
    if ($moduleFiles) {
        Write-Host "✅ Module files: $($moduleFiles.Count) validated" -ForegroundColor Green
    } # end if
    if ($paramFiles) {
        Write-Host "✅ Parameter files: $($paramFiles.Count) found" -ForegroundColor Green
    } # end if
    
    Write-Host "" -ForegroundColor White
    Write-Host "🎉 All Bicep template validations completed successfully!" -ForegroundColor Green
    Write-Host "=" * 60 -ForegroundColor Gray
    
} catch {
    Write-Host "" -ForegroundColor White
    Write-Host "❌ ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "📍 Location: $($_.InvocationInfo.ScriptName):$($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
    Write-Host "=" * 60 -ForegroundColor Gray
    exit 1
} # end try-catch
