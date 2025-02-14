$services = Get-Service | Select-Object -First 10
foreach ($service in $services) 
{
    Write-Host "Service Name: $($service.Name)"
    Write-Host "Display Name: $($service.DisplayName)"
    if ($service.Status -eq 'Running') 
    {
        Write-Host "Status: $($service.Status)"
    } # end if
    else 
    {
        Write-Host "Status: $($service.Status)"
    } # end if
    Write-Host "Status: $($service.Status)"
    Write-Host "-----------------------------------"
    if ($service.Status -eq 'Running') 
    {
        Write-Host "The service is running."
    } # end if
    else 
    {
        Write-Host "The service is not running."
    } # end if
} # end foreach