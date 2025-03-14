targetScope = 'resourceGroup'

@description('Azure region for all resources')
param location string


@description('Name for the Network Security Group')
param nsgName string


// Deploy the GitHub Actions NSG using the existing module
module actionsNsg 'modules/actions-nsg-deployment.bicep' = {
  name: 'actionsNsgDeployment'
  params: {
    location: location
    nsgName: nsgName
  }
}

// Output the NSG resource ID for reference
output nsgId string = actionsNsg.outputs.nsgId
output nsgName string = nsgName
