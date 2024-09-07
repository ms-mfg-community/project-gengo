targetScope = 'resourceGroup'

param hub object

resource hubRgp 'Microsoft.Resources/resourceGroups@2023-09-01' = {
  name: hubRgp
  location: resourceGroup().location
}

// Deploy a virtual network in the hub resource group
resource hubVnet 'Microsoft.Network/virtualNetworks@2023-01-01' = {
  name: hub.vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
          hub.vnetAddressPrefix
      ]
    }
    subnets: [
        {
            name: hub.subnetName.ase
            properties: {
		        addressPrefix: hub.subnetAddressPrefixAseV3
		    }
        },
        {
            name: hub.subnetName.srv
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