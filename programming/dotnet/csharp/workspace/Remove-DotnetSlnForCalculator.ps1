#Requires -Version 5.1
<#
.SYNOPSIS
    Removes the .NET 8.0 calculator solution with xUnit testing framework.

.DESCRIPTION
    This script removes the calculator-xunit-testing solution and all its associated
    projects, allowing for a fresh setup if needed.

.EXAMPLE
    PS> .\Remove-DotnetSlnForCalculator.ps1

.NOTES
    This script will delete the entire solution directory without confirmation.
    Use with caution.
#>

Set-StrictMode -Version Latest

# Configuration
$SolutionName = 'calculator-xunit-testing'

# Import color support for better output
function Write-Status {
    param(
        [string]$Message,
        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Level = 'Info'
    )
    
    $color = @{
        'Info'    = 'Cyan'
        'Success' = 'Green'
        'Warning' = 'Yellow'
        'Error'   = 'Red'
    }
    
    Write-Host "[$Level] $Message" -ForegroundColor $color[$Level]
}

# Detect repository root
Write-Status 'Detecting git repository root...' 'Info'
try {
    $RepositoryRoot = git rev-parse --show-toplevel
    Write-Status "Repository root: $RepositoryRoot" 'Success'
}
catch {
    Write-Status "Failed to detect repository root: $_" 'Error'
    exit 1
}
# end try-catch

# Define solution directory path
$SolutionDir = Join-Path -Path $RepositoryRoot -ChildPath 'programming' `
    | Join-Path -ChildPath 'dotnet' `
    | Join-Path -ChildPath 'csharp' `
    | Join-Path -ChildPath 'workspace' `
    | Join-Path -ChildPath $SolutionName

Write-Status "Solution directory: $SolutionDir" 'Info'

# Verify directory exists
if (-not (Test-Path -Path $SolutionDir)) {
    Write-Status "Solution directory does not exist: $SolutionDir" 'Warning'
    exit 0
}
# end if

# Confirm deletion
Write-Host "`nWARNING: This will permanently delete the entire solution directory!`n" -ForegroundColor Red
$promptMessage = "Are you sure you want to remove $SolutionDir`? (yes/no): "
$response = Read-Host -Prompt $promptMessage

if ($response -ne 'yes') {
    Write-Status "Cleanup cancelled by user" 'Info'
    exit 0
}
# end if

# Remove solution directory
try {
    Write-Status "Removing solution directory..." 'Info'
    Remove-Item -Path $SolutionDir -Recurse -Force
    
    if (-not (Test-Path -Path $SolutionDir)) {
        Write-Status "Solution directory successfully removed" 'Success'
    }
    else {
        Write-Status "Failed to remove solution directory" 'Error'
        exit 1
    }
    # end if-else
}
catch {
    Write-Status "Error removing solution directory: $_" 'Error'
    exit 1
}
# end try-catch

Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
Write-Status "Cleanup Complete" 'Success'
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

