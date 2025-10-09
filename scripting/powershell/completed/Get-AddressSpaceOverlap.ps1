# Import the required namespace
using namespace System.Net

# This script checks for overlapping address spaces in a list of subnets.
# Note: This requires the IPNetwork2 module to be installed

# Check if IPNetwork2 module is installed, and install if needed
if (-not (Get-Module -ListAvailable -Name IPNetwork)) {
    Write-Output "IPNetwork module not found. Installing..."
    try {
        Install-Module -Name IPNetwork -Scope CurrentUser -Force
        Write-Output "IPNetwork module installed successfully."
    } catch {
        Write-Error "Failed to install IPNetwork module. $_"
        exit 1
    }
} # end if

# Import the module
Import-Module IPNetwork -ErrorAction Stop

# Example to quickly test for overlap
try {
    $subnet1 = [IPNetwork.IPNetwork]::Parse("10.0.0.0/16")
    $subnet2 = [IPNetwork.IPNetwork]::Parse("10.0.1.0/24")

    # The correct method is likely Overlaps, not Overlap
    $overlap = $subnet1.Contains($subnet2) -or $subnet2.Contains($subnet1)

    if ($overlap) {
        Write-Output "Subnets overlap!"
    } # end if
    else {
        Write-Output "No overlap detected."
    } # end else
} catch {
    Write-Error "Error processing subnets: $_"
} # end try/catch