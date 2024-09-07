targetScope = 'subscription'

// Import parameters from the parameters file
param hubRgp string // hub resource group 
param spokeRgp string // spoke resource 
param location string
param hubNetwork object 
param spokeNetwork object

@description('Deploy the hub resource group and resources')
module hub 'modules/hubResources.bicep' = {
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


