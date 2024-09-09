param region string
param basSntId string
param tags object
param basName string
param pubIpId string
param spkVnetIdVal string
param sku string

var ipConfigName = 'IpConf'
// Create an Azure Bastion resource 
resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: basName
  location: region
  tags: tags
  properties: {
	ipConfigurations: [
      {
        name: ipConfigName
        properties: {
          subnet: {
            id: basSntId
          }
          publicIPAddress: {
            id: pubIpId
          }
        }
      }
    ]
 }
}