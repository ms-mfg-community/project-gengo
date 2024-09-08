targetScope = 'subscription'

// Import parameters from the parameters file
param hubRgp string // hub resource group 
param spokeRgp string // spoke resource 
param location string
param hubNetwork object 
param spokeNetwork object

resource hubRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: hubRgp
  location: location
}

// Define the hub resource group and resources module
@description('Deploy the hub resource group and resources')
module hubnet 'modules/hub-network.bicep' = {
  name: 'hub-net'
  scope: hubRg
  params: {
    region: location
    hub: hubNetwork
  }
}

// Add a module to deploy the spoke resource group
// module spk 'spokeResources.bicep' = {
//   name: 'deploySpokeResourceGroup'
//   scope: resourceGroup
//   params: {
// 	spk: spokeNetwork
//   }
// }

// Output the hub object if needed
output hubObject object = hubnet.outputs.hubObject

