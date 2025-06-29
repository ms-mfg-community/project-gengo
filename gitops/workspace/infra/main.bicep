// ====================================================================================================
// AZURE INFRASTRUCTURE AS CODE - MAIN BICEP TEMPLATE
// ====================================================================================================
//
// PURPOSE:
//   This is the main Bicep template for deploying a complete Azure infrastructure stack.
//   It creates a resource group at the subscription level and deploys various Azure services
//   using modular Bicep templates for maintainability and reusability.
//
// ARCHITECTURE:
//   - Resource Group: Container for all resources
//   - Storage Account: General-purpose storage for applications and data
//   - Container Registry: Private Docker image registry for containerized applications
//   - Key Vault: Secure storage for secrets, keys, and certificates
//   - Log Analytics Workspace: Centralized logging and monitoring
//   - Application Insights: Application performance monitoring and analytics
//
// DEPLOYMENT SCOPE:
//   - Target Scope: Subscription level (can create resource groups)
//   - Resource Scope: All resources deployed within a single resource group
//
// DEPENDENCIES:
//   - Modular Bicep templates in the 'modules' folder
//   - Proper Azure permissions for subscription-level deployments
//   - Valid parameter values for resource naming and configuration
//
// AUTHOR: GitHub Copilot
// DATE: June 25, 2025
// VERSION: 1.0
// ====================================================================================================

// Set deployment scope to subscription level to enable resource group creation
targetScope = 'subscription'

// ====================================================================================================
// PARAMETERS SECTION
// ====================================================================================================
// Input parameters for configuring the infrastructure deployment
// These values are provided by the calling template or deployment script

@description('The name of the resource group to create - serves as container for all resources')
param resourceGroupName string

@description('The Azure region where resources will be deployed - affects latency, compliance, and cost')
param location string = 'eastus2'

@description('The name of the storage account - must be globally unique and 3-24 lowercase letters/numbers')
param storageAccountName string

@description('The name of the container registry - must be globally unique, 5-50 alphanumeric characters')
param containerRegistryName string

@description('The name of the Key Vault - must be globally unique, 3-24 characters, letters/numbers/hyphens')
param keyVaultName string

@description('The name of the Log Analytics Workspace - used for centralized logging and monitoring')
param lawName string

@description('The name of the Application Insights component - for application performance monitoring')
param appInsightsName string

@description('The name of the User Assigned Managed Identity - used for secure resource access')
param umiName string

@description('Unique deployment identifier - used to prevent deployment name conflicts and ensure unique resource deployment names')
param deploymentId string

@description('Tags to apply to all resources - provides metadata for governance and cost tracking')
param tags object = {
  Environment: 'Development'                    // Deployment environment (Dev/Test/Prod)
  Project: 'GitOps-Azure-Workflow'            // Project identifier for resource grouping
  ManagedBy: 'Bicep-IaC'                      // Infrastructure management method
  DeployedBy: 'GitHub-Actions'                // Deployment automation tool
  CreatedDate: utcNow('yyyy-MM-dd')           // Creation timestamp for audit trail
}

// ====================================================================================================
// RESOURCE GROUP DEPLOYMENT
// ====================================================================================================
// Create the resource group that will contain all other resources

// Create Resource Group at subscription scope
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// ====================================================================================================
// MODULAR RESOURCE DEPLOYMENTS
// ====================================================================================================
// Deploy individual Azure services using modular Bicep templates
// This approach promotes reusability, maintainability, and separation of concerns

// Deploy Storage Account using dedicated module
module storageAccount 'modules/sta.bicep' = {
  name: 'storageAccountDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    storageAccountName: storageAccountName  // Unique storage account name
    location: location                      // Azure region for deployment
    tags: tags                             // Resource tags for governance
  }
}

// Deploy Container Registry using dedicated module
// Azure Container Registry provides private Docker image storage and management
module containerRegistry 'modules/acr.bicep' = {
  name: 'containerRegistryDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    containerRegistryName: containerRegistryName  // Unique registry name
    location: location                             // Azure region for deployment
    tags: tags                                    // Resource tags for governance
  }
}

// Deploy Key Vault using dedicated module
// Azure Key Vault provides secure storage for secrets, keys, and certificates
module keyVault 'modules/kvt.bicep' = {
  name: 'keyVaultDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    keyVaultName: keyVaultName                    // Unique Key Vault name
    location: location                            // Azure region for deployment
    storageAccountId: storageAccount.outputs.storageAccountId  // Reference to storage for diagnostics
    tags: tags                                   // Resource tags for governance
  }
}

// Deploy Log Analytics Workspace using dedicated module
// Provides centralized logging and monitoring capabilities for all Azure resources
module logAnalyticsWorkspace 'modules/law.bicep' = {
  name: 'logAnalyticsWorkspaceDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    lawName: lawName                              // Unique workspace name
    location: location                            // Azure region for deployment
    tags: tags                                   // Resource tags for governance
    storageAccountId: storageAccount.outputs.storageAccountId  // Reference to storage for log export
    deploymentId: deploymentId                   // Unique deployment identifier
  }
}

// Deploy Application Insights using dedicated module
// Provides application performance monitoring and analytics capabilities
module applicationInsights 'modules/ais.bicep' = {
  name: 'applicationInsightsDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    appInsightsName: appInsightsName             // Unique Application Insights name
    location: location                           // Azure region for deployment
    tags: tags                                  // Resource tags for governance
    workspaceId: logAnalyticsWorkspace.outputs.workspaceId     // Link to Log Analytics workspace
    storageAccountId: storageAccount.outputs.storageAccountId  // Reference to storage for data export
    deploymentId: deploymentId                  // Unique deployment identifier
  }
}

// Deploy User Assigned Managed Identity using dedicated module
// Provides an identity for Azure resources to use when authenticating to Azure services
module userAssignedIdentity 'modules/umi.bicep' = {
  name: 'userAssignedIdentityDeployment-${deploymentId}'
  scope: resourceGroup
  params: {
    umiName: umiName        // Name based on resource group for consistency
    location: location                         // Azure region for deployment
    tags: tags                                // Resource tags for governance
    deploymentId: deploymentId               // Unique deployment identifier
  }
}

// ====================================================================================================
// OUTPUTS SECTION
// ====================================================================================================
// Return important resource information for use by calling templates or automation

// Resource Group outputs
output resourceGroupName string = resourceGroup.name  // Name for resource identification
output resourceGroupId string = resourceGroup.id     // Full Azure resource ID

// Storage Account outputs  
output storageAccountName string = storageAccount.outputs.storageAccountName  // Name for application configuration
output storageAccountId string = storageAccount.outputs.storageAccountId     // ID for resource references

// Container Registry outputs
output containerRegistryName string = containerRegistry.outputs.containerRegistryName      // Name for Docker operations
output containerRegistryId string = containerRegistry.outputs.containerRegistryId         // ID for resource references
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer        // URL for Docker login

// Application Insights outputs
output componentId string = applicationInsights.outputs.componentId                        // ID for application integration

// Key Vault outputs
output keyVaultName string = keyVault.outputs.keyVaultName                                // Name for secret operations
output keyVaultId string = keyVault.outputs.keyVaultId                                   // ID for resource references
output keyVaultUri string = keyVault.outputs.vaultUri                                    // URI for application access

// Log Analytics Workspace outputs
output lawWorkspaceId string = logAnalyticsWorkspace.outputs.workspaceId                 // ID for monitoring configuration
output lawWorkspaceName string = logAnalyticsWorkspace.outputs.workspaceName             // Name for workspace identification
