# Create a function to list folders in a directory
# List only extensions that end in *.txt


function List-Directories {
    param(
        [string]$Path,
        [switch]$Recurse,
        [switch]$IncludeFiles
    ) # end param
    if ($Recurse) {
        if ($IncludeFiles) 
        {
            Get-ChildItem -Path $Path -Recurse -Filter *.txt
        } # end if
        else 
        {
            Get-ChildItem -Path $Path -Directory -Recurse
        } # end else
    } 
    else 
    {
        if ($IncludeFiles) {
            Get-ChildItem -Path $Path -Filter *.txt
        } else {
            Get-ChildItem -Path $Path -Directory
        }
    }
}

if ($args.Length -eq 0) 
{
    Write-Host "Usage: List-Directories -Path <path> [-Recurse] [-IncludeFiles]"
    exit
} # end if

Set-Location -Path 'C:\Users\user\Documents'

# Change directory to 'C:\Users\user\Documents'



