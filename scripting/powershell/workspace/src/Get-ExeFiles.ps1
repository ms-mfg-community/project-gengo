# This script recursively counts all folders, sub-folders and files from the current directory,
# filters to find and display all files with *.exe extension.
# It then creates a custom class to save the script's output and exports these results to a CSV file.
# Finally, it imports the CSV file, sorts the results in descending order by file name and displays them in a formatted table.

# Recursively count all folders, sub-folders and files from the current directory,
# filtering to find and display all files with *.exe extension.
Get-ChildItem -Path $PWD -Recurse -File -Filter "*.exe" | ForEach-Object {
    Write-Output $_.FullName
} # end ForEach 

# Create a custom class to save the script's output
class ExeFiles {
    [string[]] $Files
}

# Create an object instance of this class and export these results to a CSV file.
$exeFiles = [ExeFiles]::new()

foreach ($file in $exeFiles) 
{
    $exeFiles.Files += $file
}

Export-Csv -Path "exe_files.csv" -InputObject $exeFiles -NoTypeInformation

# Import the CSV file, sort the results in descending order by file name and display them in a formatted table.
Import-Csv -Path "exe_files.csv" | Sort-Object -Property FileName -Descending | Format-Table