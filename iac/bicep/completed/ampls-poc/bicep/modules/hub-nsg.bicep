param 


// Deploy an nsg resource 
resource hubNsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: hub.nsgName
  location: region
  properties: {
	securityRules: [
	  {
		name: 'AllowVnetInbound'
		properties: {
		  priority: 100
		  direction: 'Inbound'
		  access: 'Allow'
		  protocol: 'Tcp'
		  sourcePortRange: '*'
		  destinationPortRange: '80'
		  sourceAddressPrefix: 'VirtualNetwork'
		  destinationAddressPrefix: '*'
		}
	  }
	  {
		name: 'AllowVnetOutbound'
		properties: {
		  priority: 200
		  direction: 'Outbound'
		  access: 'Allow'
		  protocol: 'Tcp'
		  sourcePortRange: '*'
		  destinationPortRange: '80'
		  sourceAddressPrefix: '*'
		  destinationAddressPrefix: 'VirtualNetwork'
		}
	  }
	]
  }
}