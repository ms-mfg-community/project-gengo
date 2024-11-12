# Create a powershell script to recursively enumerate all folders, subfolders and files from the current directory, while filtering to search for and display all files with the *.exe extension.

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
} # end foreach

# Code completion example. Type 'Export-Csv ...' and press 'Tab' to auto-complete the command.
Export-Csv -Path "exe_files.csv" -InputObject $exeFiles -NoTypeInformation

# Import the CSV file and display the contents sorted by reverse order based on the filename.
Import-Csv -Path "exe_files.csv" | Sort-Object -Property Files -Descending | Format-Table -AutoSize
