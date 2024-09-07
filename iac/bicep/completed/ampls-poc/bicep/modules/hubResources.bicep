targetScope = 'resourceGroup'

param hub object

resource hubResourceGroup 'Microsoft.Resources/resourceGroups@2023-09-01' = {
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
                addressPrefix: hub.subnetAddressPrefixServers
            }
        }
    ]
  }
}

// Output the hub object
output hubObject object = {
  name: hub.vnetName
  location: resourceGroup().location
  addressSpace: hub.properties.addressSpace
  subnets: hub.properties.subnets
}