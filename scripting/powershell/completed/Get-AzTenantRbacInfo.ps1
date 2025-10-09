# Script to retrieve RBAC information from all subscriptions in an Azure tenant
# Requires Az PowerShell modules to be installed

# Check if Az module is installed
if (-not (Get-Module -ListAvailable -Name Az.Accounts))
{
    Write-Error "Az PowerShell module is not installed. Please install it using: Install-Module -Name Az -AllowClobber"
    Exit 1
} # end if

# Prompt user for Azure tenant ID
$TenantId = Read-Host -Prompt "Enter Azure Tenant ID"

# Validate tenant ID format (simple validation for GUID format)
if (-not ($TenantId -match '^[a-fA-F0-9]{8}-([a-fA-F0-9]{4}-){3}[a-fA-F0-9]{12}$'))
{
    Write-Warning "The tenant ID doesn't appear to be in the correct format. It should be a GUID."
    $Confirmation = Read-Host -Prompt "Do you want to continue anyway? (Y/N)"
    
    if ($Confirmation.ToUpper() -ne "Y")
    {
        Write-Host "Operation cancelled by user."
        Exit
    } # end if
} # end if

try
{
    # Connect to Azure with the specified tenant ID
    Write-Host "Connecting to Azure tenant: $TenantId" -ForegroundColor Cyan
    Connect-AzAccount -TenantId $TenantId -ErrorAction Stop
    
    # Get all subscriptions in the tenant
    Write-Host "Retrieving subscriptions..." -ForegroundColor Cyan
    $Subscriptions = Get-AzSubscription -TenantId $TenantId -ErrorAction Stop
    
    # Initialize results array
    $Results = @()
    
    # Process each subscription
    foreach ($Subscription in $Subscriptions)
    {
        Write-Host "Processing subscription: $($Subscription.Name) ($($Subscription.Id))" -ForegroundColor Green
        
        # Set the current subscription context
        Set-AzContext -Subscription $Subscription.Id -ErrorAction Stop | Out-Null
        
        # Get role assignments for the subscription
        $RoleAssignments = Get-AzRoleAssignment -ErrorAction SilentlyContinue
        
        if ($RoleAssignments)
        {
            foreach ($RoleAssignment in $RoleAssignments)
            {
                # Create a custom object with the required information
                $RoleInfo = [PSCustomObject]@{
                    SubscriptionName = $Subscription.Name
                    SubscriptionId = $Subscription.Id
                    RoleDefinitionName = $RoleAssignment.RoleDefinitionName
                    Scope = $RoleAssignment.Scope
                    DisplayName = $RoleAssignment.DisplayName
                    SignInName = $RoleAssignment.SignInName
                    ObjectType = $RoleAssignment.ObjectType
                }
                
                # Add to results
                $Results += $RoleInfo
            } # end foreach
        }
        else
        {
            Write-Warning "No role assignments found in subscription: $($Subscription.Name)"
            
            # Add empty entry to show subscription without role assignments
            $RoleInfo = [PSCustomObject]@{
                SubscriptionName = $Subscription.Name
                SubscriptionId = $Subscription.Id
                RoleDefinitionName = "No roles found"
                Scope = "N/A"
                DisplayName = "N/A"
                SignInName = "N/A"
                ObjectType = "N/A"
            }
            
            $Results += $RoleInfo
        } # end if
    } # end foreach
    
    # Display results in table format
    Write-Host "`nRole Assignment Information:" -ForegroundColor Cyan
    $Results | Format-Table -Property SubscriptionName, RoleDefinitionName, Scope, DisplayName, SignInName -AutoSize -Wrap
    
    # Optionally export to CSV
    $ExportCsv = Read-Host -Prompt "Export results to CSV? (Y/N)"
    if ($ExportCsv.ToUpper() -eq "Y")
    {
        $CsvPath = Join-Path -Path $pwd -ChildPath "AzureRBACInfo_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
        $Results | Export-Csv -Path $CsvPath -NoTypeInformation
        Write-Host "Results exported to: $CsvPath" -ForegroundColor Green
    } # end if
}
catch
{
    Write-Error "An error occurred: $_"
    Write-Error $_.Exception.Message
    Write-Error $_.ScriptStackTrace
}
finally
{
    # Disconnect from Azure account
    Write-Host "Disconnecting from Azure..." -ForegroundColor Cyan
    Disconnect-AzAccount -ErrorAction SilentlyContinue
} # end try/catch/finally