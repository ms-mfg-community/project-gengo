# This script lists all the files and directories in the specified directory.
# It can be used to quickly view the contents of a directory.

# Specify the directory path (change this to the desired directory)
$directoryPath = "C:\path\to\directory"

# Get the contents of the specified directory
$contents = Get-ChildItem -Path $directoryPath

# Display the contents
$contents | Format-Table -AutoSize