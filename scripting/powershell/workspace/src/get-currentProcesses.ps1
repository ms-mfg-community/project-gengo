# This script is currently empty.
Get-Process | ForEach-Object {
    Write-Output $_.ProcessName
} # end ForEach

