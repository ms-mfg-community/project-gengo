// Reference the main Bicep file
using 'main.bicep'

// Define the parameters for the resource groups
param resourceGroupNames array = [
  'ampls-hub-rgp'
  'ampls-spk-rgp'
]
param location string = 'eastus2'
