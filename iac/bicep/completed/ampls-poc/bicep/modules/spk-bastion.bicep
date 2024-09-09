param region string
param spkVntId string
param spkSntId string
param tags object
param basName string

// Create an Azure Bastion resource 
resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: basName
  location: region
  properties: {
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