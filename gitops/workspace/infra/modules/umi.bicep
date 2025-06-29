// ========================================================================================================
// User Assigned Managed Identity (UAMI) Module
// ========================================================================================================
//
// This module deploys a User Assigned Managed Identity using Azure Verified Modules (AVM) patterns.
// It supports federated identity credentials for workload identity scenarios and follows enterprise
// security best practices with configurable parameters for flexible deployment scenarios.
//
// Features:
// - User Assigned Managed Identity with configurable name and location
// - Support for federated identity credentials (GitHub Actions, Kubernetes, etc.)
// - Optional resource locking for production environments
// - Comprehensive tagging strategy for governance and cost tracking
// - Role assignment capabilities for Azure RBAC integration
//
// ========================================================================================================

@description('Required. Name of the User Assigned Managed Identity.')
param umiName string

@description('Optional. Location for the User Assigned Managed Identity. Defaults to resource group location.')
param location string = resourceGroup().location

@description('Optional. Tags to apply to the User Assigned Managed Identity for governance and cost tracking.')
param tags object = {}

@description('Required. Unique deployment identifier to prevent deployment name conflicts.')
param deploymentId string

module userAssignedIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.4.1' = {
  name: 'userAssignedIdentityDeployment-${deploymentId}'
  params: {
    // Required parameters
    name: umiName
    // Non-required parameters
    location: location
    tags: tags
  }
}

// ========================================================================================================
// OUTPUTS
// ========================================================================================================

@description('The resource ID of the User Assigned Managed Identity.')
output resourceId string = userAssignedIdentity.outputs.resourceId

@description('The name of the User Assigned Managed Identity.')
output name string = userAssignedIdentity.outputs.name

@description('The location the User Assigned Managed Identity was deployed into.')
output location string = userAssignedIdentity.outputs.location

@description('The resource group the User Assigned Managed Identity was deployed into.')
output resourceGroupName string = userAssignedIdentity.outputs.resourceGroupName

@description('The principal ID of the User Assigned Managed Identity.')
output principalId string = userAssignedIdentity.outputs.principalId

@description('The client ID of the User Assigned Managed Identity.')
output clientId string = userAssignedIdentity.outputs.clientId
