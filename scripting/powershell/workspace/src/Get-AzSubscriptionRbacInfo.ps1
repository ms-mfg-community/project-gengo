# Prompt for tenant id
$tenantId = Read-Host -Prompt "Enter the tenant ID (or press Enter to use the default tenant ID)"

# Login first (if needed)
Connect-AzAccount -Tenant $tenantId -Verbose

# Get subscriptions
$subscriptions = Get-AzSubscription

foreach ($subscription in $subscriptions) {
    Write-Host "Subscription: $($subscription.Name) ($($subscription.Id))" -ForegroundColor Green
    
    Set-AzContext -SubscriptionId $subscription.Id

    # List RBAC assignments
    Get-AzRoleAssignment | Format-Table DisplayName, RoleDefinitionName, Scope -AutoSize
    
    Write-Host "-----------------------------------------------"
}
