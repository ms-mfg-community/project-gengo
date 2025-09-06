<#
.SYNOPSIS
    Removes the calculator solution to reset the exercise.

.DESCRIPTION
    This script removes the calculator-xunit-testing solution directory to reset
    the exercise environment. It navigates to the appropriate workspace directory
    and safely removes the calculator solution folder if it exists.

.EXAMPLE
    .\Remove-DotnetSlnForCalculator.ps1
    
    Removes the calculator solution directory to reset the exercise.

.NOTES
    File Name      : Remove-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : PowerShell 5.1 or later
    Version        : 1.0
    
    Requirements:
    - PowerShell 5.1 or later
    - Write permissions to the workspace directory
    
    Change Log:
    - Version 1.0: Initial creation

.LINK
    https://docs.microsoft.com/en-us/powershell/

#>

# Get the repository root path
Write-Host "Determining repository root path..." -ForegroundColor Green
$repositoryRoot = git rev-parse --show-toplevel 2>$null

if (-not $repositoryRoot) 
{
    # If git command fails, try to find the repository root by looking for .git directory
    $currentPath = Get-Location
    $searchPath = $currentPath
    
    while ($searchPath -and $searchPath.Path -ne $searchPath.Root) 
    {
        if (Test-Path (Join-Path $searchPath.Path ".git")) 
        {
            $repositoryRoot = $searchPath.Path
            break
        } # end if
        $searchPath = $searchPath.Parent
    } # end while
    
    if (-not $repositoryRoot) 
    {
        Write-Error "Could not determine repository root. Please run this script from within a git repository."
        exit 1
    } # end if
} # end if

Write-Host "Repository root found: $repositoryRoot" -ForegroundColor Cyan

# Append the workspace path
$workspacePath = Join-Path $repositoryRoot "programming\dotnet\csharp\workspace"
Write-Host "Target workspace path: $workspacePath" -ForegroundColor Cyan

# Verify the workspace directory exists
if (-not (Test-Path $workspacePath)) 
{
    Write-Error "Workspace directory does not exist: $workspacePath"
    exit 1
} # end if

# Set the current path to the target
Write-Host "Navigating to workspace directory..." -ForegroundColor Green
Set-Location -Path $workspacePath

# Define the calculator solution directory path
$calculatorSolutionPath = Join-Path $workspacePath "calculator-xunit-testing"

# Remove the calculator solution directory
if (Test-Path $calculatorSolutionPath) 
{
    Write-Host "Found calculator solution directory: $calculatorSolutionPath" -ForegroundColor Yellow
    Write-Host "Removing calculator solution directory..." -ForegroundColor Green
    
    try 
    {
        Remove-Item -Path $calculatorSolutionPath -Recurse -Force
        Write-Host "Successfully removed calculator solution directory!" -ForegroundColor Green
        Write-Host "Exercise has been reset and is ready for a fresh start." -ForegroundColor Cyan
    }
    catch 
    {
        Write-Error "Failed to remove calculator solution directory: $($_.Exception.Message)"
        exit 1
    } # end try-catch
}
else 
{
    Write-Host "Calculator solution directory not found. Nothing to remove." -ForegroundColor Yellow
    Write-Host "Exercise environment is already clean." -ForegroundColor Cyan
} # end if

# Display final status
Write-Host "`nReset Summary:" -ForegroundColor Green
Write-Host "==============" -ForegroundColor Green
Write-Host "Repository root: $repositoryRoot" -ForegroundColor White
Write-Host "Workspace path: $workspacePath" -ForegroundColor White
Write-Host "Calculator solution removed: $(if (Test-Path $calculatorSolutionPath) { 'No (still exists)' } else { 'Yes (successfully removed)' })" -ForegroundColor White

Write-Host "`nTo recreate the calculator solution, run:" -ForegroundColor Yellow
Write-Host ".\Set-DotnetSlnForCalculator.ps1" -ForegroundColor Cyan

Write-Host "`nScript execution completed successfully!" -ForegroundColor Green
