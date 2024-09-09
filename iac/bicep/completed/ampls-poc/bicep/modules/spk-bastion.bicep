param region string
param spkSntId string
param tags object
param basName string
param basAlloc string
param pubIpId string
param instances int
param spkVnetIdVal string
param sku string

var ipConfigName = 'ipconfig1'
// Create an Azure Bastion resource 
resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: basName
  location: region
  tags: tags
  sku: {
	name: sku
  }
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
          privateIPAllocationMethod: basAlloc
          publicIPAddress: {
            id: pubIpId
          }
          subnet: {
            id: spkSntId
          }
        }
      }
    ]
    networkAcls: {
      ipRules: [
        {
          addressPrefix: '0.0.0.0/0'
        }
      ]
    }
    scaleUnits: instances
    virualNetwork: {
        id: spkVnetIdVal
    }
    zones: [ 1,2,3 ]
 }
}