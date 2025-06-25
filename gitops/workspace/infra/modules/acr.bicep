// Azure Container Registry Module
// Based on Azure Verified Modules patterns
// Resource Type: Microsoft.ContainerRegistry/registries

@description('The name of the container registry')
param containerRegistryName string

@description('The location for the container registry')
param location string = resourceGroup().location

@description('Container registry SKU')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param skuName string = 'Basic'

@description('Enable admin user for the container registry')
param adminUserEnabled bool = false

@description('Enable public network access')
param publicNetworkAccess bool = true

@description('Enable zone redundancy (Premium SKU only)')
param zoneRedundancy bool = false

@description('Tags to apply to the container registry')
param tags object = {}

// Container Registry Resource
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
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
    }
    encryption: {
      status: 'disabled'
    }
    dataEndpointEnabled: false
    publicNetworkAccess: publicNetworkAccess ? 'Enabled' : 'Disabled'
    networkRuleBypassOptions: 'AzureServices'
    zoneRedundancy: (skuName == 'Premium' && zoneRedundancy) ? 'Enabled' : 'Disabled'
  }
}

// Outputs
output containerRegistryName string = containerRegistry.name
output containerRegistryId string = containerRegistry.id
output loginServer string = containerRegistry.properties.loginServer
output adminUserEnabled bool = containerRegistry.properties.adminUserEnabled
