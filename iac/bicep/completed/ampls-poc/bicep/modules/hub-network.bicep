param region string
param hub object
param tags object

// Deploy a virtual network in the hub resource group
resource hubVnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: hub.vnetName
  location: region
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
          hub.vnetAddressPrefix
      ]
    }
    dhcpOptions: {
	  dnsServers: [
		hub.dnsServer
	  ]
	}
    subnets: [
        {
            name: hub.subnetName.ase
            properties: {
		        addressPrefix: hub.subnetAddressPrefixAseV3
		    }
        }
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
  location: region
  addressSpace: hub.properties.addressSpace
  subnets: hub.properties.subnets
}