<#
.SYNOPSIS
    Removes the calculator solution directory to reset the exercise.

.DESCRIPTION
    This script removes the calculator-xunit-testing solution directory
    from the workspace. It performs the following steps:
    1. Gets the repository root path using git
    2. Appends the workspace path
    3. Sets the current path to the target location
    4. Removes the calculator solution directory

.EXAMPLE
    .\Remove-DotnetSlnForCalculator.ps1
    
    Removes the calculator-xunit-testing solution directory.

.EXAMPLE
    .\Remove-DotnetSlnForCalculator.ps1 -Force
    
    Removes the calculator-xunit-testing solution directory without confirmation.

.NOTES
    File Name      : Remove-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : Git must be installed and the script must be run from within a git repository
    Version        : 1.0

#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Function to display colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Function to get folder size
function Get-FolderSize {
    param(
        [string]$Path
    )
    
    if (Test-Path $Path) {
        $size = (Get-ChildItem -Path $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
        return [Math]::Round($size / 1MB, 2)
    }
    return 0
}

# Store the original location
$originalLocation = Get-Location

try {
    Write-ColorOutput "`n=== Calculator Solution Cleanup Script ===" "Cyan"
    Write-ColorOutput "This script will remove the calculator-xunit-testing solution directory.`n" "Yellow"
    
    # Step 1: Get the repository root path
    Write-ColorOutput "[Step 1/4] Getting repository root path..." "Gray"
    
    $repoRoot = git rev-parse --show-toplevel 2>$null
    
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($repoRoot)) {
        throw "Error: Not in a git repository or git is not installed."
    }
    
    # Convert forward slashes to backslashes for Windows
    $repoRoot = $repoRoot -replace '/', '\'
    Write-ColorOutput "Repository root: $repoRoot" "Green"
    
    # Step 2: Append the workspace path
    Write-ColorOutput "`n[Step 2/4] Constructing workspace path..." "Gray"
    
    $workspacePath = Join-Path -Path $repoRoot -ChildPath "programming\dotnet\csharp\workspace"
    Write-ColorOutput "Workspace path: $workspacePath" "Green"
    
    # Step 3: Set the current path to the target
    Write-ColorOutput "`n[Step 3/4] Navigating to workspace..." "Gray"
    
    if (-not (Test-Path $workspacePath)) {
        throw "Error: Workspace path does not exist: $workspacePath"
    }
    
    Set-Location -Path $workspacePath
    Write-ColorOutput "Current location: $(Get-Location)" "Green"
    
    # Step 4: Remove the calculator solution directory
    Write-ColorOutput "`n[Step 4/4] Removing calculator solution directory..." "Gray"
    
    $solutionPath = Join-Path -Path $workspacePath -ChildPath "calculator-xunit-testing"
    
    if (-not (Test-Path $solutionPath)) {
        Write-ColorOutput "`nWarning: Calculator solution directory does not exist." "Yellow"
        Write-ColorOutput "Path checked: $solutionPath" "Yellow"
        Write-ColorOutput "`nNothing to remove. Exiting." "Cyan"
        return
    }
    
    # Get folder size before removal
    $folderSize = Get-FolderSize -Path $solutionPath
    Write-ColorOutput "Found calculator solution directory ($folderSize MB)" "Green"
    
    # Confirm removal unless -Force is specified
    if (-not $Force) {
        Write-ColorOutput "`nAre you sure you want to remove the calculator solution?" "Yellow"
        Write-ColorOutput "Path: $solutionPath" "Yellow"
        Write-ColorOutput "Size: $folderSize MB`n" "Yellow"
        
        $confirmation = Read-Host "Type 'yes' to confirm removal"
        
        if ($confirmation -ne 'yes') {
            Write-ColorOutput "`nRemoval cancelled by user." "Cyan"
            return
        }
    }
    
    # Remove the directory
    Write-ColorOutput "`nRemoving directory..." "Gray"
    Remove-Item -Path $solutionPath -Recurse -Force -ErrorAction Stop
    
    Write-ColorOutput "`n=== Cleanup Complete ===" "Green"
    Write-ColorOutput "Successfully removed calculator solution directory." "Green"
    Write-ColorOutput "Freed up $folderSize MB of disk space.`n" "Green"
    
} catch {
    Write-ColorOutput "`n=== Error ===" "Red"
    Write-ColorOutput "An error occurred: $($_.Exception.Message)" "Red"
    Write-ColorOutput "`nCleanup failed. Please check the error and try again.`n" "Red"
    exit 1
    
} finally {
    # Always return to original location
    Set-Location -Path $originalLocation
}

#end Remove-DotnetSlnForCalculator
