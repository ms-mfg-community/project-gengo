targetScope = 'resourceGroup'

param hub object

resource hubRgp 'Microsoft.Resources/resourceGroups@2023-09-01' = {
  name: hubRgp
  location: resourceGroup().location
}

// Deploy a virtual network in the hub resource group
resource hubVnet 'Microsoft.Network/virtualNetworks@2023-01-01' = {
  name: hubNetwork.vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
          hubNetwork.vnetAddressPrefix
      ]
    }
    subnets: [
        {
            name: hubNetwork.subnetName.ase
            properties: {
		        addressPrefix: hubNetwork.subnetAddressPrefixAseV3
		    }
        },
        {
            name: hubNetwork.subnetName.srv
            properties: {
                addressPrefix: subnet.subnetAddressPrefixServers
            }
        }
    ]
  }
}

// Output the hub object
output hubObject object = {
  name: hubVnet.name
  location: hubVnet.location
  addressSpace: hubVnet.properties.addressSpace
  subnets: hubVnet.properties.subnets
}