targetScope = 'resourceGroup'

@description('Azure region for all resources')
param location string = resourceGroup().location

@description('Name for the Network Security Group')
param nsgName string = 'github-actions-nsg'

@description('Name for the network settings resource')
param networkSettingsName string = 'default-network-settings'

@description('Name of the virtual network')
param vnetName string = 'github-actions-vnet'

@description('Address prefix for the virtual network')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Name of the subnet')
param subnetName string = 'default'

@description('Address prefix for the subnet')
param subnetAddressPrefix string = '10.0.0.0/24'

// Deploy the GitHub Actions NSG using the existing module
module actionsNsg 'modules/actions-nsg-deployment.bicep' = {
  name: 'actionsNsgDeployment'
  params: {
    location: location
    nsgName: nsgName
  }
}

// Create the network settings resource
resource networkSettings 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: vnetName
  location: location
  tags: {
    displayName: networkSettingsName
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: actionsNsg.outputs.nsgId
          }
        }
      }
    ]
  }
}

// Output the NSG resource ID for reference
output nsgId string = actionsNsg.outputs.nsgId
output nsgName string = nsgName
output vnetId string = networkSettings.id
output vnetName string = vnetName
