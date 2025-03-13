# Get-CurrentDirectory.ps1
# This script lists the contents of the current directory

# Get the current directory
$currentDirectory = Get-Location

# List the contents of the current directory
$dirContent = Get-ChildItem -Path $currentDirectory

# Extract the filename property from the directory contents
$filenames = $dirContent | Select-Object -ExpandProperty Name

# Output the filenames
$filenames | ForEach-Object { Write-Host $_ }

# Sort the filenames alphabetically
$sortedFilenames = $filenames | Sort-Object
# Output the sorted filenames
$sortedFilenames | ForEach-Object { Write-Host $_ }
