<#
.SYNOPSIS
    Cleans up the Python calculator project by removing virtual environment.

.DESCRIPTION
    Removes the Python virtual environment and other generated files from the
    calculator-pytest project to reset it to a clean state.

.EXAMPLE
    .\Remove-PythonCalculatorEnvironment.ps1

.NOTES
    This script removes the venv directory and __pycache__ directories.
#>

$projectPath = Get-Location
$venvPath = Join-Path $projectPath "venv"
$pycachePath = Join-Path $projectPath "__pycache__"

Write-Host "Cleaning up Python calculator environment..." -ForegroundColor Cyan
Write-Host "Project path: $projectPath" -ForegroundColor Gray

# Remove virtual environment
if (Test-Path $venvPath) {
    Write-Host "`nRemoving virtual environment..." -ForegroundColor Cyan
    Remove-Item $venvPath -Recurse -Force
    Write-Host "Virtual environment removed." -ForegroundColor Green
} else {
    Write-Host "`nVirtual environment not found." -ForegroundColor Yellow
}

# Remove __pycache__ directories
Write-Host "`nRemoving __pycache__ directories..." -ForegroundColor Cyan
Get-ChildItem -Path $projectPath -Include "__pycache__" -Recurse -Directory | ForEach-Object {
    Remove-Item $_.FullName -Recurse -Force
    Write-Host "  Removed: $($_.FullName)" -ForegroundColor Gray
}

# Remove .pytest_cache
$pytestCachePath = Join-Path $projectPath ".pytest_cache"
if (Test-Path $pytestCachePath) {
    Write-Host "`nRemoving .pytest_cache..." -ForegroundColor Cyan
    Remove-Item $pytestCachePath -Recurse -Force
    Write-Host ".pytest_cache removed." -ForegroundColor Green
}

# Remove *.pyc files
Write-Host "`nRemoving *.pyc files..." -ForegroundColor Cyan
Get-ChildItem -Path $projectPath -Include "*.pyc" -Recurse | ForEach-Object {
    Remove-Item $_.FullName -Force
    Write-Host "  Removed: $($_.Name)" -ForegroundColor Gray
}

Write-Host "`nCleanup complete!" -ForegroundColor Green
Write-Host "Project has been reset to a clean state." -ForegroundColor Green
