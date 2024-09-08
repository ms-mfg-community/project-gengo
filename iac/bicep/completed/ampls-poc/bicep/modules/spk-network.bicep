param region string
param spk object
param hub object
param tags object
param nsgIdSpk string
param hubVnetIdVal string

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
                addressPrefix: spk.subnetAddressPrefixBastion
            }
        }
    ]
  }
}

resource vnetPeerings 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: 'peerSpkWithHub'
  parent: spkVnet
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnetIdVal
    }
  }
}


// Show output of hub object 
output spkInfo object = spk