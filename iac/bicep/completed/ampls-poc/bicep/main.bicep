targetScope = 'subscription'

// Import parameters from the parameters file
param resourceGroups array
param location string
param hubNetwork object 
param spokeNetwork object
param nsgs object

resource rgp 'Microsoft.Resources/resourceGroups@2024-03-01' = [for rg in resourceGroups: {
    name: rg
    location: location
}]

// Define the hub resource group and resources module
@description('Deploy the hub resource group and resources')
module hubnet 'modules/hub-network.bicep' = {
  name: 'hub-net'
  scope: resourceGroups[0] // hubRg
  params: {
    region: location
    hub: hubNetwork
  }
}

// Output the hub object if needed
output hubObject object = hubnet.outputs.hubObject


