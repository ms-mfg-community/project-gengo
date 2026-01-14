<#
.SYNOPSIS
    Removes the calculator-xunit-testing solution and all its contents to reset the exercise.

.DESCRIPTION
    This script deletes the calculator-xunit-testing directory completely, removing the solution,
    projects, and all files created during the calculator exercise. Use this to reset the exercise
    and start fresh.

.PARAMETER Path
    Optional. The path to the workspace directory. Defaults to the current git repository root
    followed by the programming/dotnet/csharp/workspace path.

.EXAMPLE
    .\Remove-DotnetSlnForCalculator.ps1
    
    Removes the calculator-xunit-testing directory from the default workspace path.

.EXAMPLE
    .\Remove-DotnetSlnForCalculator.ps1 -Path "C:\custom\path"
    
    Removes the calculator-xunit-testing directory from a custom path.

.NOTES
    File Name      : Remove-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : PowerShell 5.0+
    Version        : 1.0

#>

param(
    [Parameter(Mandatory=$false, HelpMessage="Path to the workspace directory")]
    [string]$Path
)

# If path not provided, calculate it from git root
if ([string]::IsNullOrWhiteSpace($Path)) {
    try {
        $gitRoot = git rev-parse --show-toplevel
        $Path = Join-Path $gitRoot "programming\dotnet\csharp\workspace"
    }
    catch {
        Write-Error "Could not determine git repository root. Please provide -Path parameter."
        exit 1
    }
}

$targetPath = Join-Path $Path "calculator-xunit-testing"

if (Test-Path $targetPath) {
    Write-Host "Removing calculator-xunit-testing directory..."
    Remove-Item $targetPath -Recurse -Force
    Write-Host "✓ Successfully removed: $targetPath" -ForegroundColor Green
} else {
    Write-Host "Directory not found at: $targetPath" -ForegroundColor Yellow
}
