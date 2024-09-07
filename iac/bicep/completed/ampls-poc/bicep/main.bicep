// Set the target scope to subscription
targetScope = 'subscription'

// Import parameters from the parameters file
param hubRgp string // hub resource group 
param spokeRgp string // spoke resource 
param location string
param hubNetwork object 
param spokeNetwork object

// Create the resource groups
resource resourceGroups 'Microsoft.Resources/resourceGroups@2023-07-01' = [for name in resourceGroupNames: {
  name: name
  location: location
}]

@description('Deploy the hub resource group and resources')
module hub 'hubResources.bicep' = {
  name: 'deployHubResourceGroup'
  scope: resourceGroup
  params: {
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


