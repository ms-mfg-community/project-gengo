# Enterprise Database ID: 292708
# Prompt user for GitHub token
Write-Host "Please enter your GitHub Personal Access Token:"
$GITHUB_TOKEN = Read-Host -MaskInput # Use classic token authentication

# Verify token was provided
if ([string]::IsNullOrEmpty($GITHUB_TOKEN)) {
  throw "Error: GitHub token is required."
}

# Define the GraphQL query and variables
$GraphQLQuery = @{
  query = @"
  query(`$slug: String!) {
    enterprise(slug: `$slug) {
      slug
      databaseId
    }
  }
"@
  variables = @{
    slug = "ghms-mfg-us-app-inno"
  }
}

# Convert the query to JSON
$Body = $GraphQLQuery | ConvertTo-Json -Depth 10 -Compress

# Enable detailed error information
$ErrorActionPreference = 'Stop'

try {
    # Make the HTTP POST request
    $Response = Invoke-RestMethod -Uri "https://api.github.com/graphql" `
      -Method Post `
      -Headers @{
        Authorization = "Bearer $GITHUB_TOKEN"
        "Content-Type" = "application/json"
      } `
      -Body $Body

    # Check for errors in the response
    if ($Response.errors) {
        Write-Host "GraphQL Error:" -ForegroundColor Red
        $Response.errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    }

    # Check if enterprise data exists
    if ($null -eq $Response.data.enterprise) {
        Write-Host "No enterprise found with slug 'ghms-mfg-us-app-inno'" -ForegroundColor Yellow
        Write-Host "Check if the enterprise slug is correct or if you have sufficient permissions" -ForegroundColor Yellow
        
        # Try listing available enterprises to help debug
        Write-Host "Trying to list available enterprises..." -ForegroundColor Cyan
        $ListQuery = @{
          query = @"
          query {
            viewer {
              login
              enterprises(first: 10) {
                nodes {
                  slug
                  name
                }
              }
            }
          }
"@
        }
        
        $ListBody = $ListQuery | ConvertTo-Json -Depth 10 -Compress
        $ListResponse = Invoke-RestMethod -Uri "https://api.github.com/graphql" `
          -Method Post `
          -Headers @{
            Authorization = "Bearer $GITHUB_TOKEN"
            "Content-Type" = "application/json"
          } `
          -Body $ListBody
          
        if ($ListResponse.data.viewer.enterprises.nodes.Count -gt 0) {
            Write-Host "Available enterprises:" -ForegroundColor Cyan
            $ListResponse.data.viewer.enterprises.nodes | ForEach-Object {
                Write-Host "- Slug: $($_.slug), Name: $($_.name)" -ForegroundColor Cyan
            }
        } else {
            Write-Host "No enterprises found or you don't have permissions to view enterprises" -ForegroundColor Yellow
        }
    } else {
        # Output the full response for debugging
        Write-Host "Full Response:" -ForegroundColor Green
        $Response | ConvertTo-Json -Depth 10
        
        # Extract and display the database ID specifically
        if ($Response.data.enterprise.databaseId) {
            Write-Host "Enterprise Database ID: $($Response.data.enterprise.databaseId)" -ForegroundColor Green
        } else {
            Write-Host "Database ID not found in the response" -ForegroundColor Yellow
        }
    }
} catch {
    Write-Host "Error occurred: $_" -ForegroundColor Red
    Write-Host "Exception details: $($_.Exception)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $responseStream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($responseStream)
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response body: $responseBody" -ForegroundColor Red
    }
}