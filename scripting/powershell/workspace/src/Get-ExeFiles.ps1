# This script recursively enumerates all folders, subfolders, and files from the current directory,
# filtering to search for and display all files with the *.exe extension.
# It then creates a custom class to save the output of the script and exports these results to a CSV file.
# Finally, it imports the CSV file, sorts the results by file name in descending order, and displays them in a formatted table.

# Recursively enumerate all folders, subfolders, and files from the current directory,
# filtering to search for and display all files with the *.exe extension.
Get-ChildItem -Path $PWD -Recurse -File -Filter "*.exe" | ForEach-Object {
    Write-Output $_.FullName
} # end ForEach 

# Create a custom class to save the output of the script
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

# Import the CSV file, sort the results by file name in descending order, and display them in a formatted table.
Import-Csv -Path "exe_files.csv" | Sort-Object -Property Files -Descending | Format-Table -AutoSize