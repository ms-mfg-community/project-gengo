targetScope = 'subscription'

// Import parameters from the parameters file
param resourceGroups array // ['ampls-hub-rgp', 'ampls-spk-rgp']
param location string
param hubNetwork object 
param spokeNetwork object
param hubNsgName string
param spkNsgName string
param tagDefaults object

var rules = loadJsonContent('./variables.json', 'nsgRules')
var adNics = loadJsonContent('./variables.json', 'vmNicsAdSubnet')
var svNics = loadJsonContent('./variables.json', 'vmNicsSvSubnet')
var vms = loadJsonContent('./variables.json', 'vms')

resource hubRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
    name: resourceGroups[0] // 'ampls-hub-rgp'
    location: location
    tags: tagDefaults
}

@description('Deploy the hub nsg')
module hubnsg 'modules/hub-nsg.bicep' = {
  name: 'hub-nsg'
  scope: hubRg
  params: {
	nsgName: hubNsgName
    region: location
    tags: tagDefaults
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
    tags: tagDefaults
    nsgIdHub: hubnsg.outputs.nsgId
  }
}

resource spokeRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
	name: resourceGroups[1] // 'ampls-spk-rgp'
	location: location
}

@description('Deploy the spoke nsg')
module spknsg 'modules/spk-nsg.bicep' = {
  name: 'spk-nsg'
  scope: spokeRg
  params: {
	nsgName: spkNsgName
    region: location
    tags: tagDefaults
  }
}

// Define the spoke resource group and resources module
@description('Deploy the spoke resource group and resources')
module spknet 'modules/spk-network.bicep' = {
  name: 'spk-net'
  scope: spokeRg
  params: {
    region: location
    spk: spokeNetwork
    hub: hubNetwork
    tags: tagDefaults
    nsgIdSpk: spknsg.outputs.spkNsgId
    hubVnetIdVal: hubnet.outputs.hubVnetId
  }
}

var basPubIpName = 'bas-2139-pip'
// Define a public ip address
@description('Deploy the public ip address')
module baspubip 'modules/bas-public-ip.bicep' = {
  name: 'spk-pub-ip'
  scope: spokeRg
  params: {
	region: location
	tags: tagDefaults
	pubIpName: basPubIpName
    pubAlloc: 'Dynamic'
    sku: 'Standard'
  }
}

// Define the bastion host resource module
@description('Deploy the bastion host')
module spkbastion 'modules/spk-bastion.bicep' = {
  name: 'spk-bastion'
  scope: spokeRg
  params: {
	region: location
    basSntId: spknet.outputs.basSubnetId
    tags: tagDefaults
    basName: 'spk-bas'
    pubIpId: baspubip.outputs.pubIpId
    spkVnetIdVal: spknet.outputs.spkVnetId
    sku: 'Standard'
  }
}

output hubNetProperties object = hubnet.outputs.hubInfo
output spkNetProperties object = spknet.outputs.spkInfo


