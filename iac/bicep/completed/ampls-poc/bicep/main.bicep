// Set the target scope to subscription
targetScope = 'subscription'

// Import parameters from the parameters file
param resourceGroupNames array
param location string

// Create the resource groups
resource resourceGroups 'Microsoft.Resources/resourceGroups@2023-07-01' = [for name in resourceGroupNames: {
  name: name
  location: location
}]
