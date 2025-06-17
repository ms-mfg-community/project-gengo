@description('The name of the container registry')
param containerRegistryName string

@description('The location/region where the container registry should be created')
param location string = resourceGroup().location

@description('Tier of your Azure Container Registry')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param skuName string = 'Basic'

@description('Enable admin user for the registry')
param adminUserEnabled bool = false

@description('Whether to allow public network access')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Whether to allow trusted Microsoft services to access the registry')
param networkRuleBypassOptions string = 'AzureServices'

@description('Tags to apply to the container registry')
param tags object = {}

// Container Registry Resource
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: containerRegistryName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
  properties: {
    adminUserEnabled: adminUserEnabled
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
      azureADAuthenticationAsArmPolicy: {
        status: 'enabled'
      }
      softDeletePolicy: {
        retentionDays: 7
        status: 'disabled'
      }
    }
    encryption: {
      status: 'disabled'
    }
    dataEndpointEnabled: false
    publicNetworkAccess: publicNetworkAccess
    networkRuleBypassOptions: networkRuleBypassOptions
    zoneRedundancy: 'Disabled'
    anonymousPullEnabled: false
  }
}

// Outputs
@description('The resource ID of the container registry')
output containerRegistryId string = containerRegistry.id

@description('The name of the container registry')
output containerRegistryName string = containerRegistry.name

@description('The login server of the container registry')
output loginServer string = containerRegistry.properties.loginServer

@description('The location of the container registry')
output location string = containerRegistry.location
