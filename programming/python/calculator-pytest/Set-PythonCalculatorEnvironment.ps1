<#
.SYNOPSIS
    Sets up the Python calculator project with virtual environment and dependencies.

.DESCRIPTION
    Creates a Python virtual environment and installs required dependencies for the
    calculator-pytest project.

.EXAMPLE
    .\Set-PythonCalculatorEnvironment.ps1

.NOTES
    This script creates a virtual environment in the current directory.
#>

$projectPath = Get-Location
$venvPath = Join-Path $projectPath "venv"

Write-Host "Setting up Python calculator environment..." -ForegroundColor Cyan
Write-Host "Project path: $projectPath" -ForegroundColor Gray

# Create virtual environment
Write-Host "`nCreating virtual environment..." -ForegroundColor Cyan
if (Test-Path $venvPath) {
    Write-Host "Virtual environment already exists." -ForegroundColor Yellow
} else {
    & python -m venv venv
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Virtual environment created successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to create virtual environment." -ForegroundColor Red
        exit 1
    }
}

# Activate virtual environment
Write-Host "`nActivating virtual environment..." -ForegroundColor Cyan
& ".\venv\Scripts\Activate.ps1"

# Upgrade pip
Write-Host "`nUpgrading pip..." -ForegroundColor Cyan
& python -m pip install --upgrade pip

# Install dependencies
Write-Host "`nInstalling dependencies..." -ForegroundColor Cyan
if (Test-Path "requirements.txt") {
    & pip install -r requirements.txt
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Dependencies installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to install dependencies." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "requirements.txt not found." -ForegroundColor Yellow
}

Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "Virtual environment path: $venvPath" -ForegroundColor Green
Write-Host "`nTo run tests: python -m pytest tests/ -v" -ForegroundColor Gray
Write-Host "To run calculator: python calculator.py" -ForegroundColor Gray
Write-Host "To deactivate environment: deactivate" -ForegroundColor Gray
