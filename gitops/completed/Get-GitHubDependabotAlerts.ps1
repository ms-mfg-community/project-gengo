# This script queries the GitHub GraphQL API to retrieve Dependabot alerts for a specific repository.
# Create a GitHub personal access token (classic) with the following scopes:
<#
user
public_repo
repo
repo_deployment
repo:status
read:repo_hook
read:org
read:public_key
read:gpg_key

This will be used as the bearer token for authentication.
#>
# Set the GitHub token as an environment variable before running this script: $env:GITHUB_TOKEN = "your_github_token_here"
$response = (curl -H "Authorization: bearer $env:GITHUB_TOKEN" -X POST https://api.github.com/graphql -d '{"query":"query { repository(owner:\"ms-mfg-community\", name:\"project-gengo\") { vulnerabilityAlerts(first:100) { nodes { id createdAt securityVulnerability { package { name } severity } } } } }"}' | ConvertFrom-Json)
$response.data.repository.vulnerabilityAlerts.nodes | Format-Table -AutoSize