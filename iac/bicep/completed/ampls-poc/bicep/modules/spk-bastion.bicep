param region string
param spkSntId string
param tags object
param basName string
param basPrivAlloc string
param pubIpId string
param instances int

var ipConfigName = 'ipconfig1'
// Create an Azure Bastion resource 
resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: basName
  location: region
  properties: {
	disableCopyPaste: false
	dnsName: '${basName}-core.windows.net'
	enableFileCopy: true
	enableIpConnect: true
	enableKerberos: false 
	enableShareableLink: true
	enableTunneling: false 
	ipConfigurations: [
      {
        name: ipConfigName
        properties: {
          privateIPAllocationMethod: basPrivAlloc
          publicIPAddress: {
            id: pubIpId
          }
          subnet: {
            id: spkSntId
          }
        }
      }
    ]
	scaleUnits: instances
	publicIPAllocationMethod: basIpAllocMethod
	virtualNetwork: {
	  id: spkVntId
	}
	subnet: {
	  id: spkSntId
	}
  }
  tags: tags
}