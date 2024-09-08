targetScope = 'subscription'

// Import parameters from the parameters file
param resourceGroups array // ['ampls-hub-rgp', 'ampls-spk-rgp']
param location string
param hubNetwork object 
param spokeNetwork object
param hubNsgName string
param spkNsgName string

resource hubRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
    name: resourceGroups[0] // 'ampls-hub-rgp'
    location: location
}

@description('Deploy the hub nsg')
module hubnsg 'modules/hub-nsg.bicep' = {
  name: 'hub-nsg'
  scope: hubRg
  params: {
	nsgName: hubNsgName
    region: location
  }
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

resource spokeRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
	name: resourceGroups[1] // 'ampls-spk-rgp'
	location: location
}

@description('Deploy the spoke nsg')
module spknsg 'modules/spk-nsg.bicep' = {
  name: 'spk-nsg'
  scope: hubRg
  params: {
	nsgName: hubNsgName
    region: location
  }
}


// Output the hub object if needed
output hubObject object = hubnet.outputs.hubObject


