# Azure Deployment Workflow

## Overview

This section documents the Azure deployment workflow implementation that automates the deployment of Azure infrastructure using GitHub Actions, Bicep templates, and Azure deployment stacks.

### Prerequisites

1. **Azure Environment Setup**
   - Azure subscription with appropriate permissions
   - Azure app registration configured for OIDC authentication
   - Two GitHub environments: `dev` and `prd`
   - `prd` environment configured for manual approval

2. **GitHub CLI Setup**
   - GitHub CLI installed and authenticated
   - Repository access permissions

### Directory Structure

```text
gitops/workspace/
├── .github/workflows/
│   └── gaw-iac-azure-deployment.yml
├── infra/
│   ├── main.bicep
│   ├── main.bicepparam
│   └── modules/
│       ├── acr.bicep
│       └── sta.bicep
├── setup-github-secrets.ps1
└── README.md
```

### Infrastructure Components

The Bicep templates deploy the following Azure resources:

1. **Resource Group** (`gaw-iac-azure-deployment`)
   - Location: East US 2
   - Contains all deployed resources

2. **Storage Account** (`1sta-{randomSuffix}`)
   - SKU: Standard_LRS
   - Kind: StorageV2
   - TLS 1.2 minimum
   - HTTPS traffic only

3. **Container Registry** (`acr-{randomSuffix}`)
   - SKU: Basic
   - Public network access enabled
   - Admin user disabled

### Setup Instructions

#### Step 1: Generate Random Resource Suffix

```powershell
$randomResourceSuffix = (New-Guid).ToString().Substring(0,8)
Write-Host "Random Resource Suffix: $randomResourceSuffix"
```

#### Step 2: Configure GitHub Secrets and Variables

Run the setup script to configure GitHub secrets and variables:

```powershell
.\setup-github-secrets.ps1
```

Or manually configure using GitHub CLI:

**Secrets:**
```bash
gh secret set AZURE_SUBSCRIPTION_ID --body "<YOUR_AZURE_SUBSCRIPTION_ID>"
gh secret set AZURE_CLIENT_ID --body "<YOUR_AZURE_CLIENT_ID>"
gh secret set AZURE_TENANT_ID --body "<YOUR_AZURE_TENANT_ID>"
```

**Variables:**
```bash
gh variable set resourceGroupName --body "gaw-iac-azure-deployment"
gh variable set location --body "eastus2"
gh variable set randomResourceSuffix --body "<GENERATED_SUFFIX>"
gh variable set storageAccountName --body "1sta<GENERATED_SUFFIX>"
gh variable set containerRegistryName --body "acr<GENERATED_SUFFIX>"
```

#### Step 3: Configure GitHub Environments

1. **Create environments:**
   - `dev` environment (no restrictions)
   - `prd` environment (manual approval required)

2. **Configure `prd` environment:**
   - Required reviewers: 1
   - Wait timer: 0 minutes
   - Deployment branches: main
   - Deployment protection rules: None

### Workflow Features

#### Workflow Modes

- **plan-only**: Display deployment plan without deploying
- **plan-and-deploy**: Show plan and deploy if approved
- **deploy-only**: Deploy without showing plan

#### Stack Actions

- **deploy**: Create or update the deployment stack
- **rollback**: Delete the deployment stack

#### Jobs

1. **Plan Job** (`dev` environment)
   - Authenticates to Azure using OIDC
   - Displays deployment plan using `az deployment sub what-if`
   - Runs for all workflow modes except `deploy-only`

2. **Deploy Job** (`prd` environment)
   - Requires manual approval
   - Deploys or rolls back using Azure deployment stacks
   - Runs for `plan-and-deploy` and `deploy-only` modes

### Workflow Configuration

The Azure deployment workflow (`gaw-iac-azure-deployment.yml`) supports multiple execution modes:

#### Workflow Inputs

| Input | Description | Default | Options |
|-------|-------------|---------|---------|
| `resourceGroupName` | Azure resource group name | `gaw-iac-azure-deployment` | - |
| `location` | Azure region | `eastus2` | - |
| `randomResourceSuffix` | Random suffix for resource names | - (required) | - |
| `storageAccountName` | Storage account name | - (required) | - |
| `containerRegistryName` | Container registry name | - (required) | - |
| `bicepFile` | Path to Bicep template | `gitops/workspace/infra/main.bicep` | - |
| `bicepParametersFile` | Path to Bicep parameters | `gitops/workspace/infra/main.bicepparam` | - |
| `workflowMode` | Execution mode | `plan-only` | `plan-only`, `plan-and-deploy`, `deploy-only` |
| `stackAction` | Deployment action | `deploy` | `deploy`, `rollback` |
| `deploymentStackName` | Deployment stack name | `gaw-iac-azure-deployment` | - |

#### Execution Modes

1. **Plan-Only Mode** (`plan-only`)
   - Runs only the planning phase
   - Performs what-if analysis
   - Shows deployment preview without making changes
   - Uses `dev` environment

2. **Plan-and-Deploy Mode** (`plan-and-deploy`)
   - Runs both planning and deployment phases
   - Shows what-if analysis first
   - Deploys resources after approval
   - Uses both `dev` and `prd` environments

3. **Deploy-Only Mode** (`deploy-only`)
   - Skips planning phase
   - Deploys resources directly
   - Uses `prd` environment only

#### Configuration Steps

1. **Configure GitHub Secrets**

   Run the setup script to configure required secrets:

   ```powershell
   .\infra\scripts\setup-github-secrets.ps1
   ```

2. **Required Secrets**
   
   - `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
   - `AZURE_CLIENT_ID`: App registration client ID
   - `AZURE_TENANT_ID`: Azure AD tenant ID

3. **GitHub Variables**
   
   The setup script automatically configures:
   
   - `RESOURCE_GROUP_NAME`: Resource group name
   - `LOCATION`: Azure region
   - `RANDOM_RESOURCE_SUFFIX`: Random suffix for resources
   - `STORAGE_ACCOUNT_NAME`: Storage account name
   - `CONTAINER_REGISTRY_NAME`: Container registry name

### Usage Examples

#### Example 1: Planning Only

```yaml
# Workflow inputs:
resourceGroupName: gaw-iac-azure-deployment
location: eastus2
randomResourceSuffix: a1b2c3d4
storageAccountName: 1staa1b2c3d4
containerRegistryName: acra1b2c3d4
workflowMode: plan-only
stackAction: deploy
```

#### Example 2: Full Deployment

```yaml
# Workflow inputs:
resourceGroupName: gaw-iac-azure-deployment
location: eastus2
randomResourceSuffix: a1b2c3d4
storageAccountName: 1staa1b2c3d4
containerRegistryName: acra1b2c3d4
workflowMode: plan-and-deploy
stackAction: deploy
```

#### Example 3: Rollback

```yaml
# Workflow inputs:
workflowMode: deploy-only
stackAction: rollback
deploymentStackName: gaw-iac-azure-deployment
```

### Bicep Template Structure

#### Main Template (`main.bicep`)

- **Target Scope**: Subscription
- **Resources**: Resource Group, Storage Account, Container Registry
- **Modules**: Separate modules for each resource type

#### Storage Account Module (`modules/sta.bicep`)

- **Features**:
  - Standard_LRS SKU
  - TLS 1.2 minimum
  - HTTPS traffic only
  - Blob encryption enabled
  - 7-day retention policy

#### Container Registry Module (`modules/acr.bicep`)

- **Features**:
  - Basic SKU
  - Admin user disabled
  - Public network access enabled
  - Azure AD authentication enabled
  - 7-day retention policy (disabled by default)

### Security Configuration

#### OIDC Authentication

The workflow uses OpenID Connect (OIDC) for secure authentication with Azure:

- No stored credentials in GitHub
- Token-based authentication
- Scope-limited permissions

#### Deployment Stacks

Azure Deployment Stacks provide:

- **Resource Management**: Centralized resource lifecycle management
- **Rollback Capability**: Easy rollback to previous deployment state
- **Dependency Tracking**: Automatic resource dependency management
- **Policy Enforcement**: Consistent policy application across resources

### Troubleshooting

#### Common Issues

1. **Authentication Failures**
   - Verify Azure app registration configuration
   - Check OIDC federated credentials
   - Ensure correct tenant and subscription IDs

2. **Resource Naming Conflicts**
   - Storage account names must be globally unique
   - Container registry names must be globally unique
   - Use the random suffix to avoid conflicts

3. **Permission Issues**
   - Ensure service principal has Contributor role on subscription
   - Verify User Access Administrator role for deployment stacks

4. **Bicep Validation Errors**
   - Run validation script: `.\infra\scripts\validate-bicep.ps1`
   - Check parameter compatibility
   - Verify resource naming conventions

#### Validation Script

Use the validation script to check Bicep templates before deployment:

```powershell
.\infra\scripts\validate-bicep.ps1 -BicepFile "infra\main.bicep" -ParametersFile "infra\main.bicepparam"
```

### Best Practices

1. **Resource Naming**
   - Use consistent naming conventions
   - Include environment and project identifiers
   - Use random suffixes for globally unique resources

2. **Environment Management**
   - Use `dev` environment for planning
   - Use `prd` environment for deployment
   - Configure appropriate approval workflows

3. **Security**
   - Use OIDC authentication
   - Minimize required permissions
   - Regular rotation of credentials

4. **Monitoring**
   - Enable Azure Monitor integration
   - Configure log retention policies
   - Set up alerting for deployment failures

### Advanced Configuration

#### Custom Parameters

Override default parameters by modifying `main.bicepparam`:

```bicep
using 'main.bicep'

param resourceGroupName = 'my-custom-rg'
param storageAccountSku = 'Standard_GRS'
param containerRegistrySku = 'Standard'
```

#### Additional Resources

Extend the deployment by adding new modules:

1. Create new Bicep module in `modules/` directory
2. Reference module in `main.bicep`
3. Add parameters to `main.bicepparam`
4. Update workflow inputs if needed
