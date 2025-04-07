# Get-CurrentDirectory.ps1
# This script lists the contents of the current directory

# Get the current directory
$currentDirectory = Get-Location

# List the contents of the current directory
$dirContent = Get-ChildItem -Path $currentDirectory

# Extract the filename property from the directory contents
# $filenames = $dirContent | Select-Object -ExpandProperty Name
$filenames = $dirContent | ForEach-Object { $_.Name }

# Output the filenames
$filenames | ForEach-Object { Write-Host $_ }

# Sort the filenames in descending order
$sortedFilenames = $filenames | Sort-Object -Descending
# Output the sorted filenames
$sortedFilenames | ForEach-Object { Write-Host $_ }

# PR demo
