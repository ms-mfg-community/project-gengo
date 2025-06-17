@description('The name of the container registry')
param containerRegistryName string

@description('The location for the container registry')
param location string = resourceGroup().location

@description('Random suffix for resource names')
param randomResourceSuffix string

@description('Container registry SKU')
param skuName string = 'Basic'

@description('Enable admin user for the registry')
param adminUserEnabled bool = true

// Container registry resource
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: '${containerRegistryName}${randomResourceSuffix}'
  location: location
  sku: {
    name: skuName
  }
  properties: {
    adminUserEnabled: adminUserEnabled
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Disabled'
    policies: {
      quarantinePolicy: {
        status: 'Disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'Disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'Disabled'
      }
    }
    encryption: {
      status: 'Disabled'
    }
    dataEndpointEnabled: false
    networkRuleBypassOptions: 'AzureServices'
  }
  tags: {
    Environment: 'Development'
    Project: 'GitOps-Workflows'
    CreatedBy: 'Bicep'
  }
}

// Outputs
output containerRegistryName string = containerRegistry.name
output containerRegistryId string = containerRegistry.id
output loginServer string = containerRegistry.properties.loginServer
