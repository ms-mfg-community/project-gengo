# Azure IaC Deployment Workflow

This directory contains a comprehensive Azure Infrastructure-as-Code (IaC) solution using Bicep templates and GitHub Actions workflows.

## Directory Structure

```
gitops/workspace/infra/
├── main.bicep                     # Main Bicep template (subscription-scoped)
├── main.bicepparam               # Parameter file for main template
├── modules/                      # Bicep modules
│   ├── acr.bicep                # Azure Container Registry
│   ├── app.bicep                # Azure App Service
│   ├── asp.bicep                # Azure App Service Plan
│   ├── kvt.bicep                # Azure Key Vault
│   └── sta.bicep                # Azure Storage Account
└── scripts/                     # Utility scripts
    ├── setup-github-secrets.ps1 # Script to configure GitHub secrets
    └── validate-bicep.ps1       # Script to validate Bicep files
```

## Prerequisites

1. **Azure Subscription**: An active Azure subscription with appropriate permissions
2. **Azure App Registration**: Create an app registration for OIDC authentication
3. **GitHub Repository**: The repository where this workflow will run
4. **GitHub CLI**: Installed and authenticated for secret management

## Setup Instructions

### 1. Create Azure App Registration

```powershell
# Create an app registration
az ad app create --display-name "gaw-iac-azure-deployment"

# Get the application ID
$appId = (az ad app list --display-name "gaw-iac-azure-deployment" --query "[0].appId" -o tsv)

# Create a service principal
az ad sp create --id $appId

# Get the object ID
$objectId = (az ad sp list --display-name "gaw-iac-azure-deployment" --query "[0].id" -o tsv)

# Assign Contributor role to the service principal
az role assignment create --role Contributor --assignee $objectId --scope "/subscriptions/$(az account show --query id -o tsv)"
```

### 2. Configure OIDC Federation

```powershell
# Configure OIDC federation for the GitHub repository
az ad app federated-credential create \
    --id $appId \
    --parameters '{
        "name": "GitHubActions",
        "issuer": "https://token.actions.githubusercontent.com",
        "subject": "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:ref:refs/heads/main",
        "audiences": ["api://AzureADTokenExchange"]
    }'
```

### 3. Set Up GitHub Secrets

Run the setup script to configure GitHub secrets:

```powershell
# Navigate to the scripts directory
cd gitops/workspace/infra/scripts

# Run the setup script
./setup-github-secrets.ps1
```

The script will prompt you for:
- GitHub repository (format: username/repo-name)
- Azure Subscription ID
- Azure Client ID (App Registration ID)
- Azure Tenant ID

### 4. GitHub Environments

Create two GitHub environments in your repository:
- `dev` - For the plan job
- `prd` - For the deploy job (configure with protection rules)

## Workflow Features

### Inputs
- **Resource Group Name**: Target resource group
- **Location**: Azure region for deployment
- **Random Resource Suffix**: Suffix for unique resource naming
- **Storage Account Name**: Storage account name prefix
- **Container Registry Name**: ACR name prefix
- **Bicep File Path**: Path to main Bicep template
- **Bicep Parameters File**: Path to parameters file
- **Workflow Mode**: 
  - `plan-only`: Run what-if analysis only
  - `plan-and-deploy`: Run plan then deploy
  - `deploy-only`: Deploy without planning
- **Stack Action**: 
  - `deploy`: Deploy resources
  - `rollback`: Rollback deployment
- **Deployment Stack Name**: Name for the deployment

### Jobs

#### Plan Job (`dev` environment)
- Validates Bicep files
- Runs Azure what-if analysis
- Displays planned changes
- Runs when mode is `plan-only` or `plan-and-deploy`

#### Deploy Job (`prd` environment)
- Deploys resources to Azure
- Supports rollback operations
- Lists deployed resources
- Runs when mode is `plan-and-deploy` or `deploy-only`

## Usage

1. Navigate to GitHub Actions in your repository
2. Select the "gaw-iac-azure-deployment" workflow
3. Click "Run workflow"
4. Fill in the required parameters
5. Click "Run workflow" to start

## Validation

Before running the workflow, validate your Bicep files locally:

```powershell
# Navigate to the scripts directory
cd gitops/workspace/infra/scripts

# Run validation
./validate-bicep.ps1
```

## Deployed Resources

The workflow deploys the following Azure resources:
- Resource Group
- Storage Account
- Azure Container Registry
- App Service Plan
- App Service
- Key Vault

All resources follow naming conventions with the specified suffix for uniqueness.

## Troubleshooting

### Common Issues

1. **OIDC Authentication Errors**
   - Verify app registration is configured correctly
   - Check federated credentials subject matches your repository
   - Ensure service principal has appropriate permissions

2. **Bicep Validation Errors**
   - Run local validation using the provided script
   - Check parameter file format and values
   - Verify all required parameters are provided

3. **Resource Naming Conflicts**
   - Use a unique random suffix
   - Ensure storage account names are globally unique
   - Check that ACR names follow naming conventions

4. **GitHub Secrets**
   - Verify all required secrets are set
   - Check secret names match the workflow requirements
   - Ensure secrets contain correct values

### Debug Steps

1. Check the workflow logs in GitHub Actions
2. Validate Bicep files locally
3. Test Azure CLI authentication manually
4. Verify GitHub environments are configured
5. Check Azure permissions for the service principal

## Security Considerations

- Use OIDC authentication instead of service principal secrets
- Configure environment protection rules for production
- Review and approve deployments before execution
- Use least privilege principle for Azure permissions
- Regularly rotate credentials and review access

## Contributing

When making changes to this workflow:
1. Test changes in a separate branch first
2. Validate Bicep files before committing
3. Update documentation as needed
4. Follow the established naming conventions
5. Ensure backward compatibility
