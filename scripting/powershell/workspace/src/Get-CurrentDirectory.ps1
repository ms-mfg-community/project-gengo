# Get-CurrentDirectory.ps1
# This script lists the contents of the current directory

# Get the current directory
$currentDirectory = Get-Location

# List the contents of the current directory
Get-ChildItem -Path $currentDirectory