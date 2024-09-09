param region string
param lawProps object
param tags object

resource symbolicname 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: lawProps.name
  location: region
  tags: tags
  etag: '*'
  properties: {
    publicNetworkAccessForIngestion: lawProps.publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: lawProps.publicNetworkAccessForQuery
    retentionInDays: lawProps.retentionInDays
    sku: {
      name: lawProps.skuName
    }
  }
}


