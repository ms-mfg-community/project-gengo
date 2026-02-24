<#
.SYNOPSIS
    Enumerates and displays files and directories in the current directory.

.DESCRIPTION
    This script retrieves all items (files and directories) in the current directory
    and displays their properties including name, full path, size (for files),
    and last modification time.

.EXAMPLE
    .\Get-DirectoryContent.ps1
    
    Displays all files and directories in the current directory with detailed information.

.NOTES
    File Name      : Get-DirectoryContent.ps1
    Author         : GitHub Copilot
    Prerequisite   : PowerShell 5.1 or higher
    Version        : 1.0
    
    Requirements:
    - Read access to the current directory
    
    Change Log:
    - Version 1.0: Initial creation

#>

# Get all items in the current directory
$currentPath = Get-Location
Write-Host "Enumerating contents of: $currentPath" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$contents = Get-ChildItem -Path $currentPath

foreach ($item in $contents)
{
    Write-Host "Name: $($item.Name)"
    Write-Host "Full Name: $($item.FullName)"
    
    if ($item.PSIsContainer)
    {
        Write-Host "Type: Directory"
    }
    else
    {
        Write-Host "Type: File"
        Write-Host "Size: $($item.Length) bytes"
    } # end if
    
    Write-Host "Last Modified: $($item.LastWriteTime)"
    Write-Host "-----------------------------"
} # end foreach

Write-Host ""
Write-Host "Total Items: $($contents.Count)" -ForegroundColor Green