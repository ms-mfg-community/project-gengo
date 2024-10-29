# por01. [] General to specific
# Create a function to list folders in a directory
function List-Directories {
    param(
        [string]$Path
    )
    Get-ChildItem -Path $Path -Directory
}
# Using this same function, add the ability to perform a recursive listing
function List-Directories {
    param(
        [string]$Path,
        [switch]$Recurse
    )
    if ($Recurse) {
        Get-ChildItem -Path $Path -Directory -Recurse
    } else {
        Get-ChildItem -Path $Path -Directory
    }
}
# Include files also
function List-Directories {
    param(
        [string]$Path,
        [switch]$Recurse,
        [switch]$IncludeFiles
    )
    if ($Recurse) {
        if ($IncludeFiles) {
            Get-ChildItem -Path $Path -Recurse
        } else {
            Get-ChildItem -Path $Path -Directory -Recurse
        }
    } else {
        if ($IncludeFiles) {
            Get-ChildItem -Path $Path
        } else {
            Get-ChildItem -Path $Path -Directory
        }
    }
}