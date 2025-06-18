@description('The name of the container registry')
param containerRegistryName string

@description('The location for the container registry')
param location string

@description('The SKU name for the container registry')
param skuName string = 'Basic'

@description('Tags to apply to the container registry')
param tags object = {}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  tags: tags  
  sku: {
    name: skuName
  }
  properties: {
    adminUserEnabled: false
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
    publicNetworkAccess: 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    zoneRedundancy: 'Disabled'
  }
}

output containerRegistryId string = containerRegistry.id
output containerRegistryName string = containerRegistry.name
output loginServer string = containerRegistry.properties.loginServer
