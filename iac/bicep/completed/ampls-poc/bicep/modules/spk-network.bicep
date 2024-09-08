param region string
param spk object
param hub object
param tags object
param nsgIdSpk string

// Deploy a virtual network in the spoke resource group
resource spkVnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: spk.vnetName
  location: region
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
          spk.vnetAddressPrefix
      ]
    }
    dhcpOptions: {
	  dnsServers: [
		hub.dnsServer
	  ]
	}
    subnets: [
        {
            name: spk.subnetName.spk
            properties: {
		        addressPrefix: spk.subnetAddressPrefixSpk
                networkSecurityGroup: {
		            id: nsgIdSpk
		        }
			}
		}
        {
            name: spk.subnetName.bas
            properties: {
                addressPrefix: hub.subnetAddressPrefixBastion
            }
        }
    ]
  }
}

// Show output of hub object 
output spkInfo object = spk