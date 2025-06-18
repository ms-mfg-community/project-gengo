#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Validates Bicep templates and performs comprehensive linting and build verification.

.DESCRIPTION
    This script validates the Bicep templates in the infra directory using Azure CLI commands.
    It performs linting, compilation, and structural validation to ensure templates are
    ready for deployment.

.PARAMETER BicepFilePath
    Path to the main Bicep file to validate. Defaults to '../main.bicep'.

.PARAMETER ParametersFilePath
    Path to the Bicep parameters file. Defaults to '../main.bicepparam'.

.PARAMETER ValidateModules
    Switch to enable validation of individual Bicep modules.

.EXAMPLE
    .\validate-bicep.ps1
    
.EXAMPLE
    .\validate-bicep.ps1 -BicepFilePath "../../infra/main.bicep" -ValidateModules
#>

[CmdletBinding()]
param(    [string]$BicepFilePath = "main.bicep",
    [string]$ParametersFilePath = "main.bicepparam",
    [switch]$ValidateModules
)

Write-Host "=== Bicep Template Validation Script ===" -ForegroundColor Green
Write-Host "Validation started at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
Write-Host ""

# Change to the parent directory (infra directory) to ensure relative paths work correctly
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$infraDir = Split-Path -Parent $scriptDir
Set-Location $infraDir
Write-Host "Working directory: $(Get-Location)" -ForegroundColor Cyan
Write-Host ""

# Initialize validation results
$validationResults = @{
    AzCliAvailable = $false
    BicepExtensionInstalled = $false
    MainBicepLint = $false
    MainBicepBuild = $false
    ParametersFileValid = $false
    ModulesValid = $false
    OverallSuccess = $false
}

#region Prerequisites Check
Write-Host "=== Prerequisites Check ===" -ForegroundColor Yellow

# Check if az CLI is available
Write-Host "Checking Azure CLI availability..." -ForegroundColor Cyan
if (-not (Get-Command "az" -ErrorAction SilentlyContinue)) {
    Write-Error "❌ Azure CLI (az) is not installed or not in PATH."
    Write-Host "Please install Azure CLI first: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli" -ForegroundColor Red
    exit 1
} else {
    $azVersion = az version --query '."azure-cli"' -o tsv 2>$null
    Write-Host "✅ Azure CLI found - Version: $azVersion" -ForegroundColor Green
    $validationResults.AzCliAvailable = $true
}

# Check if Bicep extension is installed
Write-Host "Checking Bicep extension..." -ForegroundColor Cyan
try {
    $bicepVersion = az bicep version 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Installing Bicep extension..." -ForegroundColor Yellow
        az bicep install
        if ($LASTEXITCODE -eq 0) {
            $bicepVersion = az bicep version 2>&1
            Write-Host "✅ Bicep extension installed successfully - Version: $bicepVersion" -ForegroundColor Green
            $validationResults.BicepExtensionInstalled = $true
        } else {
            Write-Error "❌ Failed to install Bicep extension"
            exit 1
        }
    } else {
        Write-Host "✅ Bicep extension found - Version: $bicepVersion" -ForegroundColor Green
        $validationResults.BicepExtensionInstalled = $true
    }
} catch {
    Write-Error "❌ Failed to check/install Bicep extension: $_"
    exit 1
}

# Upgrade Bicep to latest version
Write-Host "Ensuring latest Bicep version..." -ForegroundColor Cyan
az bicep upgrade 2>$null
Write-Host ""
#endregion

#region File Existence Check
Write-Host "=== File Existence Check ===" -ForegroundColor Yellow

# Check if main Bicep file exists
if (-not (Test-Path $BicepFilePath)) {
    Write-Error "❌ Main Bicep file not found: $BicepFilePath"
    exit 1
} else {
    Write-Host "✅ Main Bicep file found: $BicepFilePath" -ForegroundColor Green
}

# Check if parameters file exists (optional)
if (Test-Path $ParametersFilePath) {
    Write-Host "✅ Parameters file found: $ParametersFilePath" -ForegroundColor Green
} else {
    Write-Warning "⚠️  Parameters file not found: $ParametersFilePath (this is optional)"
}

Write-Host ""
#endregion

#region Main Bicep Validation
Write-Host "=== Main Bicep Template Validation ===" -ForegroundColor Yellow

# Lint the main Bicep template
Write-Host "Linting main Bicep template..." -ForegroundColor Cyan
try {
    $lintOutput = az bicep lint --file $BicepFilePath 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Bicep lint completed successfully!" -ForegroundColor Green
        $validationResults.MainBicepLint = $true
        
        # Display lint output if there are warnings
        if ($lintOutput -and $lintOutput.Length -gt 0) {
            Write-Host "Lint output:" -ForegroundColor Cyan
            Write-Host $lintOutput -ForegroundColor Gray
        }
    } else {
        Write-Error "❌ Bicep lint found issues:"
        Write-Host $lintOutput -ForegroundColor Red
    }
} catch {
    Write-Error "❌ Failed to lint Bicep template: $_"
}

Write-Host ""

# Build/Compile the main Bicep template
Write-Host "Building main Bicep template..." -ForegroundColor Cyan
try {
    $buildOutput = az bicep build --file $BicepFilePath 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Bicep build completed successfully!" -ForegroundColor Green
        $validationResults.MainBicepBuild = $true
        
        # Check if ARM template was generated
        $armTemplatePath = $BicepFilePath -replace '\.bicep$', '.json'
        if (Test-Path $armTemplatePath) {
            $armTemplateSize = (Get-Item $armTemplatePath).Length
            Write-Host "✅ ARM template generated: $armTemplatePath ($armTemplateSize bytes)" -ForegroundColor Green
        }
    } else {
        Write-Error "❌ Bicep build failed:"
        Write-Host $buildOutput -ForegroundColor Red
    }
} catch {
    Write-Error "❌ Failed to build Bicep template: $_"
}

Write-Host ""
#endregion

#region Parameters File Validation
if (Test-Path $ParametersFilePath) {
    Write-Host "=== Parameters File Validation ===" -ForegroundColor Yellow
    
    try {
        Write-Host "Validating parameters file structure..." -ForegroundColor Cyan
        
        # Read and validate parameters file content
        $parametersContent = Get-Content $ParametersFilePath -Raw -ErrorAction Stop
        
        if ($parametersContent) {
            # Check for basic .bicepparam structure
            if ($parametersContent -match "using\s+") {
                Write-Host "✅ Parameters file has valid 'using' statement" -ForegroundColor Green
            } else {
                Write-Warning "⚠️  Parameters file missing 'using' statement"
            }
            
            # Check for parameter definitions
            if ($parametersContent -match "param\s+\w+\s*=") {
                Write-Host "✅ Parameters file contains parameter definitions" -ForegroundColor Green
                $validationResults.ParametersFileValid = $true
            } else {
                Write-Warning "⚠️  No parameter definitions found in parameters file"
            }
            
            # Display parameter count
            $paramCount = ([regex]::Matches($parametersContent, "param\s+\w+\s*=")).Count
            Write-Host "📊 Found $paramCount parameter(s) in parameters file" -ForegroundColor Cyan
        } else {
            Write-Warning "⚠️  Parameters file is empty"
        }
    } catch {
        Write-Warning "⚠️  Failed to validate parameters file: $_"
    }
    
    Write-Host ""
}
#endregion

#region Module Validation
if ($ValidateModules) {
    Write-Host "=== Bicep Modules Validation ===" -ForegroundColor Yellow
    
    $modulesPath = Split-Path $BicepFilePath -Parent | Join-Path -ChildPath "modules"
    
    if (Test-Path $modulesPath) {
        $moduleFiles = Get-ChildItem -Path $modulesPath -Filter "*.bicep" -ErrorAction SilentlyContinue
        
        if ($moduleFiles.Count -gt 0) {
            Write-Host "Found $($moduleFiles.Count) module(s) to validate:" -ForegroundColor Cyan
            
            $allModulesValid = $true
            
            foreach ($module in $moduleFiles) {
                Write-Host "  Validating: $($module.Name)" -ForegroundColor Gray
                
                try {
                    # Lint module
                    $moduleLintOutput = az bicep lint --file $module.FullName 2>&1
                    if ($LASTEXITCODE -eq 0) {
                        Write-Host "    ✅ Lint: Passed" -ForegroundColor Green
                    } else {
                        Write-Host "    ❌ Lint: Failed" -ForegroundColor Red
                        Write-Host "    $moduleLintOutput" -ForegroundColor Red
                        $allModulesValid = $false
                    }
                    
                    # Build module
                    $moduleBuildOutput = az bicep build --file $module.FullName 2>&1
                    if ($LASTEXITCODE -eq 0) {
                        Write-Host "    ✅ Build: Passed" -ForegroundColor Green
                    } else {
                        Write-Host "    ❌ Build: Failed" -ForegroundColor Red
                        Write-Host "    $moduleBuildOutput" -ForegroundColor Red
                        $allModulesValid = $false
                    }
                } catch {
                    Write-Host "    ❌ Error validating module: $_" -ForegroundColor Red
                    $allModulesValid = $false
                }
            }
            
            if ($allModulesValid) {
                Write-Host "✅ All modules validated successfully!" -ForegroundColor Green
                $validationResults.ModulesValid = $true
            } else {
                Write-Host "❌ Some modules failed validation" -ForegroundColor Red
            }
        } else {
            Write-Host "No Bicep modules found in: $modulesPath" -ForegroundColor Gray
            $validationResults.ModulesValid = $true  # No modules to validate
        }
    } else {
        Write-Host "Modules directory not found: $modulesPath" -ForegroundColor Gray
        $validationResults.ModulesValid = $true  # No modules directory
    }
    
    Write-Host ""
}
#endregion

#region Validation Summary
Write-Host "=== Validation Summary ===" -ForegroundColor Green

$validationResults.OverallSuccess = $validationResults.AzCliAvailable -and 
                                   $validationResults.BicepExtensionInstalled -and
                                   $validationResults.MainBicepLint -and
                                   $validationResults.MainBicepBuild

# Include modules validation if requested
if ($ValidateModules) {
    $validationResults.OverallSuccess = $validationResults.OverallSuccess -and $validationResults.ModulesValid
}

Write-Host "Validation Results:" -ForegroundColor Cyan
Write-Host "  Azure CLI Available: $(if($validationResults.AzCliAvailable){'✅ Yes'}else{'❌ No'})" -ForegroundColor $(if($validationResults.AzCliAvailable){'Green'}else{'Red'})
Write-Host "  Bicep Extension: $(if($validationResults.BicepExtensionInstalled){'✅ Yes'}else{'❌ No'})" -ForegroundColor $(if($validationResults.BicepExtensionInstalled){'Green'}else{'Red'})
Write-Host "  Main Bicep Lint: $(if($validationResults.MainBicepLint){'✅ Passed'}else{'❌ Failed'})" -ForegroundColor $(if($validationResults.MainBicepLint){'Green'}else{'Red'})
Write-Host "  Main Bicep Build: $(if($validationResults.MainBicepBuild){'✅ Passed'}else{'❌ Failed'})" -ForegroundColor $(if($validationResults.MainBicepBuild){'Green'}else{'Red'})
Write-Host "  Parameters File: $(if($validationResults.ParametersFileValid){'✅ Valid'}else{'⚠️  Not validated'})" -ForegroundColor $(if($validationResults.ParametersFileValid){'Green'}else{'Yellow'})

if ($ValidateModules) {
    Write-Host "  Modules Validation: $(if($validationResults.ModulesValid){'✅ Passed'}else{'❌ Failed'})" -ForegroundColor $(if($validationResults.ModulesValid){'Green'}else{'Red'})
}

Write-Host ""
Write-Host "Overall Result: $(if($validationResults.OverallSuccess){'✅ SUCCESS - Templates are ready for deployment!'}else{'❌ FAILED - Please fix the issues above before deployment'})" -ForegroundColor $(if($validationResults.OverallSuccess){'Green'}else{'Red'})

Write-Host ""
Write-Host "Validation completed at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Green
#endregion

# Exit with appropriate code
if ($validationResults.OverallSuccess) {
    exit 0
} else {
    exit 1
}
