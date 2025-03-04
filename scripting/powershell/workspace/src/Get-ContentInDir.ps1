# This script lists all the files and directories in the specified directory.
# It can be used to quickly view the contents of a directory.



# Specify the directory path (change this to the desired directory)
$directoryPath = $(git rev-parse --show-toplevel) # Get the top-level directory of the Git repository

# Get the contents of the specified directory
$contents = Get-ChildItem -Path $directoryPath -Recurse -File | Select-Object Name, FullName, Length, LastWriteTime

