// Azure Infrastructure as Code - Main Bicep Template
// Subscription-scoped deployment for Azure resources
// Author: GitHub Copilot
// Date: June 25, 2025

targetScope = 'subscription'

// Parameters
@description('The name of the resource group to create')
param resourceGroupName string

@description('The location for the resource group and resources')
param location string = 'eastus2'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the container registry')
param containerRegistryName string

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The name of the App Service')
param appServiceName string 

@description('The name of the Key Vault')
param keyVaultName string

@description('Tags to apply to all resources')
param tags object = {
  Environment: 'Development'
  Project: 'GitOps-Azure-Workflow'
  ManagedBy: 'Bicep-IaC'
  DeployedBy: 'GitHub-Actions'
  CreatedDate: utcNow('yyyy-MM-dd')
}


// Create Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Deploy Storage Account using module
module storageAccount 'modules/sta.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: storageAccountName
    location: location
    tags: tags
  }
}

// Deploy Container Registry using module
module containerRegistry 'modules/acr.bicep' = {
  name: 'containerRegistryDeployment'
  scope: resourceGroup
  params: {
    containerRegistryName: containerRegistryName
    location: location
    tags: tags
  }
}

// Deploy App Service Plan using module
module appServicePlan 'modules/asp.bicep' = {
  name: 'appServicePlanDeployment'
  scope: resourceGroup
  params: {
    appServicePlanName: appServicePlanName
    location: location
    tags: tags
  }
}

// Deploy App Service using module
module appService 'modules/app.bicep' = {
  name: 'appServiceDeployment'
  scope: resourceGroup
  params: {
    appServiceName: appServiceName
    appServicePlanId: appServicePlan.outputs.appServicePlanId
    location: location
    tags: tags
  }
}

// Deploy Key Vault using module
module keyVault 'modules/kvt.bicep' = {
  name: 'keyVaultDeployment'
  scope: resourceGroup
  params: {
    keyVaultName: keyVaultName
    location: location
    storageAccountId: storageAccount.outputs.storageAccountId
    tags: tags
  }
}

// Outputs
output resourceGroupName string = resourceGroup.name
output resourceGroupId string = resourceGroup.id
output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageAccountId
output containerRegistryName string = containerRegistry.outputs.containerRegistryName
output containerRegistryId string = containerRegistry.outputs.containerRegistryId
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
output appServicePlanName string = appServicePlan.outputs.appServicePlanName
output appServicePlanId string = appServicePlan.outputs.appServicePlanId
output appServiceName string = appService.outputs.appServiceName
output appServiceId string = appService.outputs.appServiceId
output appServiceDefaultHostName string = appService.outputs.defaultHostName
output keyVaultName string = keyVault.outputs.keyVaultName
output keyVaultId string = keyVault.outputs.keyVaultId
output keyVaultUri string = keyVault.outputs.vaultUri
