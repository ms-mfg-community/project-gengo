$services = Get-Service
foreach ($service in $services) 
{
    Write-Host "Service Name: $($service.Name)"
    Write-Host "Display Name: $($service.DisplayName)"
    Write-Host "Status: $($service.Status)"
    Write-Host "-----------------------------------"
    if ($service.Status -eq 'Running') 
    {
        Write-Host "The service is running."
    }
    else 
    {
        Write-Host "The service is not running."
    }
} # end foreach 