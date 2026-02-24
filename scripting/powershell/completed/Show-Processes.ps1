# This script lists all the processes running on the local machine.
# It displays the list of processes in a formatted table with auto-sizing columns.
# Additionally, it checks if the process named "code" (Visual Studio Code) is running.
# If it is running, the script outputs "Code is running." Otherwise, it outputs "Code is not running...".

# Get a list of all the processes running on the local machine
$processes = Get-Process

# Display the list of processes in a formatted table with auto-sizing columns
$processes | Format-Table -AutoSize

# Check if the process named "code" (Visual Studio Code) is running
if ($processes.ProcessName -contains "code") {
    Write-Host "Code is running."
} else {
    Write-Host "Code is not running..."
}