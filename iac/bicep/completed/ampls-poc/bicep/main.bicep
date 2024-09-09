targetScope = 'subscription'

// Import parameters from the parameters file
param resourceGroups array // ['ampls-hub-rgp', 'ampls-spk-rgp']
param location string
param hubNetwork object 
param spokeNetwork object
param hubNsgName string
param spkNsgName string
param tagDefaults object
param lawProperties object

var rules = loadJsonContent('./variables.json', 'nsgRules')
var adNics = loadJsonContent('./variables.json', 'vmNicsAdSubnet')
var svNics = loadJsonContent('./variables.json', 'vmNicsSvSubnet')
var vms = loadJsonContent('./variables.json', 'vms')

resource hubRg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
    name: resourceGroups[0] // 'ampls-hub-rgp'
    location: location
    tags: tagDefaults
}

var uniqueName = uniqueString(subscription().subscriptionId, utcNow())
var shortString = substring(uniqueName, 0, 8)
var lawName = 'law-${shortString}-01'

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
    pubAlloc: 'Static'
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

@description('Deploy a log analytics workspace')
module law 'modules/hub-law.bicep' = {
    name: 'hub-law'
    scope: hubRg
    params: {
        workspaceName: lawName
        region: location
        lawProps: lawProperties
        tags: tagDefaults
    }
}


// task-item: deploy domain controller
// resource virtualMachine1 'Microsoft.Compute/virtualMachines@2023-07-01' = {
//   name: vms[0].vmName
//   location: primaryLocation
//   properties: {
//     availabilitySet: {
//       id: availabilitySet.id A race condition occurs with looping for this id property and throws an error. See bug 1316
//     }
//     hardwareProfile: {
//       vmSize: vms[0].vmSize
//     }
//     osProfile: {
//       adminUsername: userName use parameter value
//       adminPassword: pw use parameter value
//       computerName: vms[0].vmName
//       windowsConfiguration: {
//         provisionVMAgent: vms[0].windowsConfig.provisionVMAgent
//         enableAutomaticUpdates: vms[0].windowsConfig.enableAutoUpgrades
//       }
//     }
//     storageProfile: {
//       osDisk: {
//         name: vms[0].diskOs.osDiskName
//         caching: vms[0].diskOs.caching
//         createOption: vms[0].diskOs.createOption
//         diskSizeGB: vms[0].diskOs.diskSizeGB
//         managedDisk: {
//           storageAccountType: vms[0].diskOs.diskType
//         }
//       }
//       imageReference: {
//         publisher: vms[0].image.publisher
//         offer: vms[0].image.offer
//         sku: vms[0].image.sku
//         version: vms[0].image.version
//       }
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: interfacesAdSub1.id
//           properties: {
//             primary: true
//             deleteOption: 'Delete'
//           }
//         }
//       ]
//     }
//   }
// }

// task-item: deploy jump server 
// task-item: deploy domain controller
// resource virtualMachine1 'Microsoft.Compute/virtualMachines@2023-07-01' = {
//   name: vms[0].vmName
//   location: primaryLocation
//   properties: {
//     availabilitySet: {
//       id: availabilitySet.id A race condition occurs with looping for this id property and throws an error. See bug 1316
//     }
//     hardwareProfile: {
//       vmSize: vms[0].vmSize
//     }
//     osProfile: {
//       adminUsername: userName use parameter value
//       adminPassword: pw use parameter value
//       computerName: vms[0].vmName
//       windowsConfiguration: {
//         provisionVMAgent: vms[0].windowsConfig.provisionVMAgent
//         enableAutomaticUpdates: vms[0].windowsConfig.enableAutoUpgrades
//       }
//     }
//     storageProfile: {
//       osDisk: {
//         name: vms[0].diskOs.osDiskName
//         caching: vms[0].diskOs.caching
//         createOption: vms[0].diskOs.createOption
//         diskSizeGB: vms[0].diskOs.diskSizeGB
//         managedDisk: {
//           storageAccountType: vms[0].diskOs.diskType
//         }
//       }
//       imageReference: {
//         publisher: vms[0].image.publisher
//         offer: vms[0].image.offer
//         sku: vms[0].image.sku
//         version: vms[0].image.version
//       }
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: interfacesAdSub1.id
//           properties: {
//             primary: true
//             deleteOption: 'Delete'
//           }
//         }
//       ]
//     }
//   }
// }



output hubNetProperties object = hubnet.outputs.hubInfo
output spkNetProperties object = spknet.outputs.spkInfo


