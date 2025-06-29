# 1. Product Requirements Document (PRD): Workflows and Pipelines

## 1.1 Document Information

- **Version:** 2.6
- **Author(s):** Preston K. Parsard
- **Date:** June 29, 2025
- **Status:** Complete

## 1.2 Executive Summary

This document defines the requirements for a comprehensive GitHub Actions workflow solution that automates Azure infrastructure deployment using Infrastructure as Code (IaC) with Bicep templates. The solution demonstrates best practices in CI/CD automation, secure OIDC authentication, multi-environment deployments with approval workflows, deployment stack management, and Azure resource provisioning within a modern DevOps environment. The workflow supports dynamic input parameters, what-if analysis for planning, and rollback capabilities for operational resilience.

## 1.3 Problem Statement

Teams need a reliable, repeatable, and auditable way to:

- Deploy Azure infrastructure using Infrastructure as Code practices with proper planning and validation
- Implement secure authentication using OIDC without storing long-lived secrets in repositories
- Support multi-environment deployments with proper approval workflows and environment protection
- Manage deployment stacks with rollback capabilities for operational resilience
- Provide what-if analysis for infrastructure changes before deployment
- Handle dynamic input parameters for flexible deployment scenarios
- Ensure resource naming conflicts are avoided through systematic approaches

Manual infrastructure deployment processes are error-prone, lack consistency, do not scale for modern DevOps practices, and fail to provide the security posture and auditability required for enterprise production environments.

## 1.4 Goals and Objectives

- Implement secure Azure infrastructure deployment using Bicep IaC with OIDC authentication
- Support multi-environment workflows with dev/prd environment segregation and approval processes
- Provide deployment stack management with rollback capabilities for operational resilience
- Enable what-if analysis for infrastructure planning and change validation
- Support dynamic workflow inputs for flexible deployment scenarios
- Demonstrate best practices in Azure resource provisioning and management
- Ensure proper resource naming strategies to avoid conflicts in shared environments
- Provide comprehensive deployment validation and error handling

## 1.5 Scope

### 1.5.1 In Scope

- GitHub Actions workflow for Azure infrastructure deployment (`gaw-iac-azure-deployment.yml`)
- Bicep Infrastructure as Code templates for Azure resource provisioning
- OIDC authentication for secure Azure access without long-lived secrets
- Multi-environment deployment workflows with dev/prd environment segregation
- Environment-specific approval processes and protection rules for production deployments
- Azure deployment stack management with rollback capabilities
- What-if analysis for deployment planning and change validation
- Dynamic workflow input parameters for flexible deployment scenarios
- Storage account and container registry provisioning as foundational Azure resources
- PowerShell scripts for secret management and Bicep validation
- Resource naming strategies with random suffixes to avoid conflicts
- Cleanup and rollback procedures for environments and resources

### 1.5.2 Out of Scope

- Production workload deployment beyond foundational infrastructure provisioning
- Integration with external systems beyond GitHub and Azure
- Advanced artifact retention policies beyond basic GitHub capabilities
- Custom security policies beyond OIDC and environment protection rules
- Complex multi-cloud or hybrid scenarios
- Advanced monitoring and alerting beyond basic workflow reporting
- Repository content listing and artifact management (moved to separate workflows)
- Azure DevOps pipeline conversion (considered legacy)

## 1.6 User Stories / Use Cases

- As a cloud engineer, I want to deploy Azure infrastructure using Bicep IaC with proper authentication so that I can provision resources securely
- As a DevOps engineer, I want to perform what-if analysis before deployment so that I can validate changes and avoid unintended consequences
- As a security administrator, I want to use OIDC authentication to avoid storing long-lived secrets in repositories
- As a deployment manager, I want to separate dev and production environments with approval workflows to ensure proper change control
- As an operations engineer, I want to manage deployment stacks with rollback capabilities to handle deployment failures gracefully
- As a compliance officer, I want auditable deployment processes with clear approval trails for regulatory requirements
- As a developer, I want to use dynamic input parameters to customize deployments for different scenarios
- As a team lead, I want to avoid resource naming conflicts through systematic naming strategies
- As a platform engineer, I want to provision foundational Azure resources (storage accounts, container registries) for application workloads

## 1.7 Functional Requirements

| Requirement ID | Description |
|---|---|
| FR-1 | The workflow shall support manual triggering with dynamic input parameters |
| FR-2 | The workflow shall use GitHub-hosted Ubuntu runners for consistency |
| FR-3 | The workflow shall authenticate to Azure using OIDC federated credentials |
| FR-4 | The workflow shall support multi-environment deployments (dev/prd) |
| FR-5 | The prd environment shall require manual approval before deployment |
| FR-6 | The workflow shall perform what-if analysis for deployment planning |
| FR-7 | The workflow shall deploy Azure infrastructure using Bicep IaC templates |
| FR-8 | The workflow shall support deployment stack management with rollback capabilities |
| FR-9 | The workflow shall deploy Azure storage accounts with configurable SKUs |
| FR-10 | The workflow shall deploy Azure container registries with configurable SKUs |
| FR-11 | The workflow shall use random resource suffixes to avoid naming conflicts |
| FR-12 | The workflow shall support three execution modes: plan-only, plan-and-deploy, deploy-only |
| FR-13 | The workflow shall support both deploy and rollback stack actions |
| FR-14 | The workflow shall validate Bicep templates before deployment |
| FR-15 | The workflow shall display deployment results and resource information |
| FR-16 | The solution shall include PowerShell scripts for secret management |
| FR-17 | The solution shall include PowerShell scripts for Bicep validation |
| FR-18 | The workflow shall handle errors gracefully with clear error messages |
| FR-19 | The workflow shall support subscription-scoped deployments |
| FR-20 | The workflow shall tag all resources with deployment metadata |
| FR-21 | The workflow shall deploy Azure Key Vault for secure secrets management |
| FR-22 | The workflow shall deploy Log Analytics Workspace for centralized logging |
| FR-23 | The workflow shall deploy Application Insights for application monitoring |
| FR-24 | The workflow shall support imperative App Service deployment to avoid auto-created resources |
| FR-25 | The workflow shall implement hybrid deployment approach (declarative + imperative) |
| FR-26 | The workflow shall perform explicit cleanup of imperatively deployed resources during rollback |
| FR-27 | The workflow shall support modular Bicep architecture with dedicated modules for each service |
| FR-28 | The workflow shall generate unique random suffixes for resource naming to prevent conflicts |
| FR-29 | The workflow shall support Azure CLI and Bicep extension setup automation |
| FR-30 | The workflow shall provide comprehensive audit trails for all deployment operations |

## 1.8 Non-Functional Requirements

- **Security:** Must use OIDC authentication to avoid storing long-lived secrets in repositories
- **Portability:** Must run on GitHub-hosted Ubuntu runners with consistent execution environments
- **Usability:** Workflow inputs and outputs must be clear and well-documented with comprehensive parameter descriptions
- **Auditability:** All deployment actions, metadata, and approval processes must be accessible and traceable after workflow completion
- **Extensibility:** The workflow should be easy to extend for additional Azure resources or deployment scenarios
- **Reliability:** Workflows must handle errors gracefully and provide clear error messages with rollback capabilities
- **Compliance:** Must support approval workflows and environment protection rules for production deployments
- **Scalability:** Resource naming must support multiple concurrent deployments without conflicts using systematic approaches
- **Performance:** What-if analysis and deployments should complete within reasonable timeframes
- **Maintainability:** Bicep templates and PowerShell scripts should follow best practices and be well-documented

## 1.9 Assumptions and Dependencies

- The repository uses GitHub Actions as the primary CI/CD platform
- PowerShell and Azure CLI are available on the GitHub-hosted Ubuntu runner
- Users have permission to trigger workflows and access workflow results
- Azure subscription and tenant are available for infrastructure deployment
- GitHub environments (dev/prd) are configured with appropriate protection rules
- Azure App Registration is configured with federated credentials for OIDC authentication
- Azure CLI and Bicep extension are available and up-to-date on the runner
- Users have appropriate Azure permissions for resource deployment and deployment stack management
- Bicep templates follow Azure Resource Manager best practices
- Resource naming follows organizational conventions and conflict avoidance strategies

## 1.10 Success Criteria / KPIs

- All workflow steps complete successfully without errors across all execution modes
- What-if analysis provides accurate deployment planning information
- Azure infrastructure is deployed successfully using Bicep IaC templates
- OIDC authentication works seamlessly without storing secrets in the repository
- Multi-environment workflows enforce proper approval processes for production deployments
- Deployment stacks are managed correctly with rollback capabilities functioning as expected
- Resource naming strategies successfully prevent conflicts in shared environments
- PowerShell scripts for secret management and Bicep validation execute without errors
- All Azure resources are properly tagged with deployment metadata
- Cleanup and rollback procedures successfully remove all created resources
- Workflow documentation is complete, accurate, and easy to follow

## 1.11 Milestones & Timeline

- **Phase 1: Foundation Setup** - Complete
  - GitHub environments (dev/prd) configured with protection rules
  - Azure App Registration created with federated credentials
  - OIDC authentication configured and tested
  - Repository secrets and variables configured
- **Phase 2: Workflow Development** - Complete
  - GitHub Actions workflow created with dynamic input parameters
  - Multi-environment deployment logic implemented
  - What-if analysis functionality added
  - Deployment stack management with rollback capabilities
- **Phase 3: Infrastructure as Code** - Complete
  - Bicep templates created for subscription-scoped deployments
  - Storage account and container registry modules developed
  - Resource naming strategies implemented
  - Deployment validation and error handling
- **Phase 4: Support Scripts and Documentation** - Complete
  - PowerShell scripts for secret management created
  - Bicep validation scripts implemented
  - Comprehensive PRD documentation updated
  - Usage instructions and troubleshooting guides finalized

## 1.12 Usage Instructions (Demonstration Sequence)

### 1.12.1 Prerequisites

1. Create two GitHub environments in the `project-gengo` repository named `dev` and `prd`.
2. Configure the 'prd' environment for manual approval with the following settings:
   - **Required reviewers:** 1
   - **Wait timer:** 0 minutes
   - **Deployment branches:** main
   - **Deployment protection rules:** None
3. Create a new Azure app registration with the name starting with of `ghc-*` in the tenant ending with `*9` and retrieve the following details:
   - **Client ID**
   - **Tenant ID**
   - **Client Secret**
4. Configure the Azure app registration with two federated credentials for GitHub Actions as the identity provider (`*-dev` and `*-prd`):
   - For the GitHub organization use: `ms-mfg-community`.
   - Specify the repository name as `project-gengo`.
   - Set the audience to `api://AzureADTokenExchange`.
   - Use the `environment` for the entity type based on selection `dev`|`prd`.
   - For the application deployment, we will also add another federated credential for the `ghc-workshop-intake` repository of the same organization and specify the `main` branch as the entity type and a credential name that ends with this pattern: `*-gh-workshop-intake`.
   -_NOTE: To make this demo simpler and quicker we will re-use the same Azure app registration for both the infrastructure deployment environments as well as the application deployment which will originate from a separate GitHub repository which simulates that it it independently developed and managed by a different team. We realize this deviates from best practices but is adequate for demonstration purposes. In practice, you would create separate app registrations for each environment to ensure proper isolation and security._
5. Add the following secrets to the repository:
   - `AZURE_SUBSCRIPTION_ID`: The Azure subscription ID where resources will be deployed.
   - `AZURE_CLIENT_ID`: The Client ID from the Azure app registration.
   - `AZURE_TENANT_ID`: The Tenant ID from the Azure app registration.
   - `SPN_OBJECT_ID`: The Object ID of the Azure app registration (service principal) required for role assignments at Azure Container Registry scope.
6. At the end of the GitHub Copilot summary, add a next step recommendation to manually update these secret values.
7. Also remind the user as a next step to set permissions for the Azure app registration to the deployment scope of the Azure subscription where resources will be deployed, (i.e.) `az role assignment create --assignee-object-id <object-id> --assignee-principal-type ServicePrincipal --role Contributor --scope /subscriptions/<subscription-id> --verbose`
8. Additionally, assign the `User Access Administrator` role to the enterprise application (service principal) at the subscription scope to enable it to assign the AcrPull role to the App Service's User Assigned Managed Identity for container registry access, (i.e.) `az role assignment create --assignee-object-id <object-id> --assignee-principal-type ServicePrincipal --role "User Access Administrator" --scope /subscriptions/<subscription-id> --verbose`
9. Finally, add as a next step that the following error may be encountered during deployment: "ERROR: the following arguments are required: --action-on-unmanage/--aou". Use this as a demonstration opportunity for creating and assigning an issue to GitHub Copilot to fix the issue in the workflow file using a pull request.

### 1.12.2 Basic Workflow Setup

Create a foundational GitHub Actions workflow demonstrating repository analysis and artifact management capabilities:

#### 1.12.2.1 Workflow File Creation

1. **Directory Structure**: Ensure the repository has a `.github/workflows` directory structure
2. **Workflow File**: Create a new GitHub Actions workflow file named `01-level-workflow.yml` in the `.github/workflows` directory
3. **Trigger Configuration**: Configure the workflow for manual triggering from the main branch using the `workflow_dispatch` event
4. **Runner Environment**: Configure the workflow to run on GitHub-hosted Ubuntu runner for consistency

#### 1.12.2.2 Repository Analysis Implementation

Create workflow steps that implement comprehensive repository content analysis:

1. **Event and Branch Display**: Add a step to display the triggering event and current branch name
2. **Repository Checkout**: Configure repository checkout using the standard actions/checkout action
3. **PowerShell Content Analysis**: Implement a PowerShell script that recursively lists all repository contents and saves output to an artifacts folder
4. **Python Content Analysis**: Create a Python script (name it `getDirectoryContents.py`) in the `.github/workflows/src` folder that lists repository contents and saves the output
5. **Artifact Upload**: Configure both analysis outputs to be uploaded as build artifacts using actions/upload-artifact

#### 1.12.2.3 Metadata and Artifact Management

Implement advanced workflow capabilities for metadata reporting and artifact handling:

1. **Metadata Job**: Create a separate job that retrieves and displays workflow metadata including branch name and job ID
2. **Downloads Folder**: Add a step to create a downloads folder if it doesn't already exist
3. **Artifact Download**: Configure the workflow to download previously uploaded artifacts using actions/download-artifact
4. **Content Display**: Implement a PowerShell step to display the contents of downloaded artifacts for verification

#### 1.12.2.4 Azure DevOps Pipeline Conversion

Demonstrate cross-platform CI/CD conversion capabilities:

1. **Pipeline Directory**: Create a `.azure-pipelines` directory in the repository root using `$(git rev-parse --show-toplevel)/.azure-pipelines`
2. **File Duplication**: Copy the `01-level-workflow.yml` file to a new file named `01-level-pipeline.yml` in the Azure DevOps pipeline directory
3. **Syntax Conversion**: Convert the GitHub Actions syntax to Azure DevOps YAML syntax, replacing:
   - GitHub Actions specific triggers with Azure DevOps triggers
   - GitHub-hosted runners with Azure DevOps agent pools
   - GitHub Actions marketplace actions with Azure DevOps tasks
   - GitHub environment variables with Azure DevOps variables
4. **Build Time Exclusion**: Ensure the pipeline doesn't include `$(Build.StartTime)` in outputs since this information is available in the Azure DevOps Pipeline UI

#### 1.12.2.5 Manual Integration and Cleanup Procedures

**Azure DevOps Integration**:

1. **Repository Import**: Manually import the GitHub repository `https://github.com/ms-mfg-community/project-gengo.git` into the Azure DevOps project `ado-pipeline-demos`
2. **Repository Naming**: Use the ADO repository name `project-gengo-ci` for the imported repository
3. **Pipeline Creation**: Select the `01-level-pipeline.yml` file to create a new Azure DevOps pipeline named `project-gengo-ci`
4. **Pipeline Execution**: Manually execute the Azure DevOps pipeline to verify functionality and cross-platform compatibility

**Environment Reset Procedures**:

1. **Pipeline Cleanup**: Remove the `01-level-pipeline.yml` file from the repository root `.azure-pipelines` directory using git commands
2. **Workflow Cleanup**: Remove the `01-level-workflow.yml` file from the `.github/workflows` directory to reset the exercise
3. **Azure DevOps Pipeline Cleanup**: Remove the Azure DevOps pipeline created in the integration step from the Azure DevOps project
4. **Azure DevOps Repository Cleanup**: Remove the Azure DevOps repository created during integration from the Azure DevOps project

These procedures ensure complete environment cleanup and enable repeatable demonstrations of the CI/CD conversion capabilities.

### 1.12.3 Azure Deployment Workflow Architecture

The GitHub Actions workflow (`gaw-iac-azure-deployment.yml`) implements a comprehensive Azure infrastructure deployment solution with the following architectural design:

#### 1.12.3.1 Infrastructure Directory Structure

Create the following enterprise-grade directory structure in `$(git rev-parse --show-toplevel)/gitops/workspace`:

**Infrastructure Root Directory (`infra/`):**

- `main.bicep`: Main subscription-scoped Bicep template
- `main.bicepparam`: Environment-specific parameter definitions
- `README.md`: Infrastructure documentation and usage guide

**Modules Subdirectory (`modules/`):**

- `acr.bicep`: Azure Container Registry with security configurations
- `ais.bicep`: Application Insights with Log Analytics integration
- `kvt.bicep`: Key Vault with access policies and diagnostics
- `law.bicep`: Log Analytics Workspace with retention policies
- `sta.bicep`: Storage Account with security and encryption

**Scripts Subdirectory (`scripts/`):**

- `setup-github-secrets.ps1`: GitHub secrets configuration automation
- `validate-bicep.ps1`: Bicep template validation and linting

**NOTE**: This structure follows Azure Verified Modules patterns and enterprise infrastructure best practices. Only create files if they don't already exist to preserve existing configurations.

#### 1.12.3.2 Workflow Security and Authentication Architecture

The workflow implements enterprise-grade security with the following components:

**OIDC Authentication Configuration:**

- **Purpose**: Eliminates long-lived secrets in repositories using federated identity
- **Implementation**: Azure App Registration with GitHub federated credentials
- **Scope**: Environment-specific credentials (dev/prd) for secure multi-environment deployment
- **Permissions**: Subscription-level Contributor role for infrastructure deployment

**Environment Protection Strategy:**

- **Development Environment (`dev`)**: Planning and validation with automatic approval
- **Production Environment (`prd`)**: Deployment with mandatory manual approval gates
- **Security Model**: Least-privilege access with role-based permissions
- **Audit Trail**: Complete approval and deployment history for compliance

#### 1.12.3.3 Workflow Input Parameters and Configuration

Create a `workflow_dispatch` trigger with comprehensive input validation for flexible deployment scenarios. Include the following inputs with appropriate types, descriptions, and default values:

1. **location**: Choice input for Azure region selection
   - Include options: eastus2, westus2, centralus, eastus, westus
   - Set default to 'eastus2'
   - Add description explaining impact on latency, compliance, and cost

2. **bicepFile**: String input for Bicep template path
   - Set default to 'gitops/workspace/infra/main.bicep'
   - Description should indicate this is the main infrastructure definition

3. **bicepParametersFile**: String input for parameters file path
   - Set default to 'gitops/workspace/infra/main.bicepparam'
   - Description should indicate environment-specific values

4. **workflowMode**: Choice input for execution mode
   - Include options: plan-only, plan-and-deploy
   - Set default to 'plan-only'
   - Description should explain plan-only for preview, plan-and-deploy for execution

5. **stackAction**: Choice input for deployment action
   - Include options: deploy, rollback
   - Set default to 'deploy'
   - Description should explain deploy for new resources, rollback for reverting

6. **deploymentStackPrefix**: String input for stack naming
   - Set default to 'stack'
   - Description should explain use for stack naming and identification

#### 1.12.3.4 Resource Naming Strategy and Conflict Prevention

**Dynamic Resource Naming Architecture:**

Configure environment variables at the workflow level for consistent resource prefixes:

1. **Azure Authentication Variables** (configured as repository secrets):
   - AZURE_SUBSCRIPTION_ID: Target Azure subscription
   - AZURE_CLIENT_ID: Service principal client ID
   - AZURE_TENANT_ID: Azure AD tenant ID

2. **Resource Naming Prefixes** (ensures consistent naming across all resources):
   - rgprefix: 'rgp' (Resource Group prefix)
   - storagePrefix: '1sta' (Storage Account prefix - must start with letter)
   - containerRegistryPrefix: 'acr' (Azure Container Registry prefix)
   - appServicePlanPrefix: 'asp' (App Service Plan prefix)
   - appServicePrefix: 'app' (App Service prefix)
   - keyVaultPrefix: 'kvt' (Key Vault prefix)
   - lawPrefix: 'law' (Log Analytics Workspace prefix)
   - appInsightsPrefix: 'ais' (Application Insights prefix)
   - umiPrefix: 'umi' (User Assigned Managed Identity prefix)

**Random Suffix Generation:**

In the plan job, create a step that generates a unique random suffix for resource naming:

- Use job outputs to make the suffix available to other jobs
- Generate 8-character alphanumeric string using: `echo $RANDOM | md5sum | head -c 8`
- Store the result in GitHub outputs using the variable name 'rndSuffix'

**Resource Name Construction:**

For the what-if analysis in the plan job, construct Azure CLI deployment command with dynamic parameters:

- Use `az deployment sub what-if` command
- Include deployment name with random suffix
- Pass Bicep file and parameters file from workflow inputs
- Dynamically construct resource names using environment prefixes and random suffix
- Include all resource parameters: resourceGroupName, location, storageAccountName, containerRegistryName, appInsightsName, keyVaultName, lawName

For the deployment in the deploy job, use similar pattern with Azure Deployment Stacks:

- Use `az stack sub create` command
- Include stack name with deployment prefix and random suffix
- Use same parameter construction pattern as plan job
- Add deployment stack specific parameters: --deny-settings-mode none, --action-on-unmanage deleteAll, --yes

#### 1.12.3.5 Two-Stage Job Architecture

**Planning Job (`plan`):**

- **Environment**: Development (`dev`) with automatic approval
- **Purpose**: Infrastructure validation and what-if analysis
- **Capabilities**:
  - Repository checkout and Azure CLI setup with Bicep extension
  - OIDC authentication for secure Azure access
  - Bicep template validation using custom PowerShell scripts
  - Comprehensive what-if analysis showing planned changes
  - Resource naming strategy implementation
  - Deployment summary and resource inventory

**Deployment Job (`deploy`):**

- **Environment**: Production (`prd`) with manual approval gates
- **Dependencies**: Successful completion of planning job
- **Execution Conditions**: Only when `workflowMode` is `plan-and-deploy`
- **Capabilities**:
  - Azure Deployment Stack creation and management
  - Declarative infrastructure deployment using Bicep templates
  - Imperative App Service deployment to prevent auto-created resources
  - Post-deployment cleanup of orphaned Application Insights resources
  - Rollback capabilities using deployment stack history
  - Comprehensive deployment results and resource validation

#### 1.12.3.6 GitHub Secrets and Variables Configuration

Use the automated PowerShell script `setup-github-secrets.ps1` for secure configuration. The script should configure the following repository-level secrets for OIDC authentication:

1. **AZURE_SUBSCRIPTION_ID**: Target Azure subscription for resource deployment
2. **AZURE_CLIENT_ID**: Service principal client ID from App Registration  
3. **AZURE_TENANT_ID**: Azure AD tenant ID for authentication context

Additionally, configure optional debugging variables:

- **ACTIONS_STEP_DEBUG**: Enable detailed logging for GitHub Actions troubleshooting

#### 1.12.3.7 Azure CLI and Bicep Extension Setup

The workflow ensures consistent tooling across all job executions through standardized setup procedures:

**Azure CLI and Bicep Extension Configuration:**

Create a workflow step that implements comprehensive Azure CLI and Bicep setup with the following requirements:

1. **Output Status Message**: Display "Setting up Azure CLI and Bicep extension..." for audit trail
2. **Azure CLI Upgrade**: Execute `az upgrade --yes` to ensure latest version for reliability
3. **Bicep Extension Installation**: Execute `az bicep install` for template compilation capabilities
4. **Version Verification**: Display Azure CLI version using `az --version` for troubleshooting
5. **Bicep Version Verification**: Display Bicep version using `az bicep version` for compatibility validation

This standardized setup ensures compatibility, security, and reliability across all deployment operations while providing clear audit trails for troubleshooting and compliance requirements.

#### 1.12.3.1 Workflow Input Configuration

**Workflow Dispatch Trigger Setup:**

Create a comprehensive workflow dispatch configuration in the `gaw-iac-azure-deployment.yml` workflow file with dynamic input parameters for flexible deployment scenarios:

**Required Input Parameters:**

Configure the following inputs with appropriate data types, validation, and descriptive help text:

- **resourceGroupName**: String input with default value `gaw-iac-azure-deployment` for Azure resource group naming
- **location**: Choice input with Azure region options (eastus2, westus2, centralus, eastus, westus) and default value `eastus2` for deployment location selection
- **bicepFile**: String input with default path `gitops/workspace/infra/main.bicep` for Bicep template specification
- **bicepParametersFile**: String input with default path `gitops/workspace/infra/main.bicepparam` for environment-specific parameter values
- **workflowMode**: Choice input with options (plan-only, plan-and-deploy, deploy-only) and default value `plan-only` for execution mode control
- **stackAction**: Choice input with options (deploy, rollback) and default value `deploy` for deployment action specification
- **deploymentStackPrefix**: String input with default value `stack` for deployment stack naming and identification

Each input should include comprehensive descriptions explaining the purpose, impact, and expected values to guide users in making appropriate selections.

#### 1.12.3.2 Resource Naming Strategy

**Workflow Environment Variables Configuration:**

Configure environment variables at the workflow level to ensure consistent resource prefixes across all deployment operations:

**Azure Authentication Variables** (configured as repository secrets):

- AZURE_SUBSCRIPTION_ID referencing the target Azure subscription
- AZURE_CLIENT_ID referencing the service principal client ID  
- AZURE_TENANT_ID referencing the Azure AD tenant ID

**Resource Naming Prefixes** (ensures consistent naming across all resources):

- rgprefix: 'rgp' for Resource Group prefix
- storagePrefix: '1sta' for Storage Account prefix (must start with letter)
- containerRegistryPrefix: 'acr' for Azure Container Registry prefix
- appServicePlanPrefix: 'asp' for App Service Plan prefix
- appServicePrefix: 'app' for App Service prefix
- keyVaultPrefix: 'kvt' for Key Vault prefix
- lawPrefix: 'law' for Log Analytics Workspace prefix
- appInsightsPrefix: 'ais' for Application Insights prefix

**Random Suffix Generation Strategy:**

Create a plan job output variable that generates unique resource identifiers:

Create a job output named 'rndSuffix' and implement a step with ID 'rnd' that:

- Generates an 8-character random string using: echo $RANDOM | md5sum | head -c 8
- Outputs the result to GitHub outputs using the rndSuffix variable name

**Dynamic Resource Name Construction:**

Implement resource name construction within the plan job using the generated suffix through Bicep parameter integration:

Implement an Azure CLI what-if deployment command that:

- Uses `az deployment sub what-if` with deployment name including the random suffix
- References the location from workflow inputs
- Uses the bicepFile and bicepParametersFile from workflow inputs
- Constructs all resource name parameters dynamically using environment prefixes and random suffix
- Includes parameters for: resourceGroupName, location, storageAccountName, containerRegistryName, appInsightsName, keyVaultName, lawName

**Deployment Job Resource Naming:**

Implement the same naming pattern in the deploy job using job output references for Azure Deployment Stacks:

Implement an Azure CLI deployment stack command that:

- Uses `az stack sub create` with stack name including deployment prefix and random suffix
- References location and template files from workflow inputs
- Uses the same parameter construction pattern as the plan job
- Includes deployment stack parameters: --deny-settings-mode none, --action-on-unmanage deleteAll, --yes

#### 1.12.3.3 Jobs Architecture and Workflow Security

The workflow implements a two-job architecture with environment-based security controls:

##### 1.12.3.3.1 Plan Job (Development Environment)

1. **Environment**: Associated with the `dev` environment for safe validation
2. **Runner**: Uses GitHub-hosted Ubuntu runner (`ubuntu-latest`)
3. **Permissions**:
   - `id-token: write` for Azure OIDC authentication
   - `contents: read` for repository access
4. **Purpose**: Performs infrastructure planning and validation without making changes

**Key Steps**:

- Generate unique random suffix for resource naming consistency
- Checkout repository code for Bicep template access
- Authenticate with Azure using OpenID Connect (OIDC) for secure, keyless authentication
- Set up Azure CLI with Bicep extension for infrastructure management
- Perform Bicep template validation using `az bicep build`
- Execute what-if analysis using `az deployment sub what-if` for change preview
- Output random suffix for use in subsequent deployment job

##### 1.12.3.3.2 Deploy Job (Production Environment)

1. **Environment**: Associated with the `prd` environment with manual approval requirements
2. **Dependency**: Requires successful completion of the plan job
3. **Conditional Execution**: Only runs when `workflowMode` is `plan-and-deploy`
4. **Runner**: Uses GitHub-hosted Ubuntu runner (`ubuntu-latest`)

**Key Steps**:

- Retrieve random suffix from plan job outputs for resource naming consistency
- Checkout repository code and authenticate with Azure using OIDC
- Set up Azure CLI with Bicep extension
- Execute deployment using Azure Deployment Stacks (`az stack sub create`)
- Implement cleanup procedures for orphaned Application Insights resources
- Deploy App Service using imperative approach to avoid auto-created resources and unwanted resource dependencies

**Imperative App Service Deployment Rationale**:

Azure App Service creation through declarative infrastructure as code (Bicep/ARM templates) automatically provisions additional monitoring resources that can conflict with existing infrastructure design. When App Service is deployed declaratively through Bicep templates, Azure automatically creates:

1. **Default Application Insights Instance**: Named `<app-service-name>-insights` with auto-generated configuration
2. **Additional Resource Group**: May create a separate monitoring resource group with a specific naming pattern that includes the Application Insights resource name and systematic prefix/suffix conventions
3. **Default Log Analytics Workspace**: Provisions a workspace if none is explicitly linked

These auto-created resources pose several architectural challenges:

- **Resource Naming Conflicts**: The auto-generated `<app-service-name>-insights` naming pattern may conflict with existing Application Insights instances
- **Unmanaged Dependencies**: Auto-created resources exist outside the managed deployment stack, complicating lifecycle management
- **Cost Management Issues**: Additional resource groups and workspaces can lead to unexpected charges and billing complexity
- **Governance Violations**: Auto-created resources may not comply with organizational naming conventions and tagging policies

The imperative deployment approach using Azure CLI commands (`az appservice plan create` and `az webapp create`) provides precise control over resource creation and dependencies. This method allows explicit linking to existing Application Insights and Log Analytics Workspace instances while preventing unwanted auto-provisioning.

**Reference**: Based on Azure App Service monitoring architecture patterns documented in [Azure App Service documentation](https://docs.microsoft.com/en-us/azure/app-service/overview-monitoring) and [Application Insights integration patterns](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview).

##### 1.12.3.5.3 Azure CLI and Bicep Extension Setup

Configure both jobs with standardized Azure CLI and Bicep extension setup:

Create a step that:

1. Outputs a status message: "Setting up Azure CLI and Bicep extension..."
2. Upgrades Azure CLI to latest version using: `az upgrade --yes`
3. Installs Bicep CLI extension using: `az bicep install`
4. Verifies installation by displaying Azure CLI version: `az --version`
5. Verifies installation by displaying Bicep version: `az bicep version`

##### 1.12.3.3.4 Security Implementation

**OpenID Connect (OIDC) Authentication**:

- Uses app registration: `ghc-scenario-id-39`
- Eliminates long-lived secrets through federated identity
- Requires specific Azure permissions for subscription-level deployments

**Environment Protection Rules**:

- **dev environment**: Allows immediate execution for planning operations
- **prd environment**: Requires manual approval with the following settings:
  - Required reviewers: 1
  - Wait timer: 0 minutes
  - Deployment branches: main
  - Deployment protection rules: None

**Deployment Stack Security**:

- Uses `--deny-settings-mode none` for flexible resource management
- Implements `--action-on-unmanage deleteAll` for comprehensive cleanup
- Provides rollback capabilities through deployment stack history

### 1.12.4 Bicep Configuration

The Bicep infrastructure configuration is designed with a modular, secure, and maintainable approach using Azure verified modules patterns and enterprise-grade commenting.

#### 1.12.4.1 Infrastructure Architecture

The solution implements a subscription-scoped deployment that creates a complete Azure infrastructure stack with the following components:

1. **Resource Group**: Container for all infrastructure resources
2. **Storage Account**: General-purpose storage for applications and data (`modules/sta.bicep`)
3. **Container Registry**: Private Docker image registry (`modules/acr.bicep`)
4. **Key Vault**: Secure storage for secrets, keys, and certificates (`modules/kvt.bicep`)
5. **Log Analytics Workspace**: Centralized logging and monitoring (`modules/law.bicep`)
6. **Application Insights**: Application performance monitoring (`modules/ais.bicep`)
7. **User Assigned Managed Identity**: Secure identity for Azure resource access (`modules/umi.bicep`)
8. **App Service Plan & App Service**: Web application hosting with Linux OS and Node.js 22 LTS runtime (deployed imperatively via Azure CLI to prevent auto-created monitoring resources)

#### 1.12.4.2 Directory Structure

Create a standardized Bicep configuration structure in the path `gitops/workspace/infra/` with the following organization:

**Root Level Files:**

- `main.bicep`: Main subscription-scoped template
- `main.bicepparam`: Parameter file for environment values  
- `README.md`: Infrastructure documentation

**Modules Directory (`modules/`):**

- `sta.bicep`: Storage Account module
- `acr.bicep`: Azure Container Registry module
- `kvt.bicep`: Key Vault module
- `law.bicep`: Log Analytics Workspace module
- `ais.bicep`: Application Insights module
- `umi.bicep`: User Assigned Managed Identity module

**Scripts Directory (`scripts/`):**

- `validate-bicep.ps1`: Bicep template validation
- `setup-github-secrets.ps1`: GitHub secrets configuration

#### 1.12.4.3 Main Template Configuration

The `main.bicep` template serves as the orchestrator for all infrastructure components:

**Target Scope**: Subscription level to enable resource group creation
**Parameters**: All resource names, location, and tagging strategy
**Modules**: Deploys each Azure service using dedicated modules
**Outputs**: Returns resource IDs and connection strings for application integration

Key features:

- Subscription-scoped deployment for resource group management
- Modular architecture promoting reusability and maintainability
- Comprehensive parameter validation and documentation
- Resource dependency management through proper module ordering
- Standardized tagging strategy for governance and cost tracking

#### 1.12.4.4 Module Architecture and Dependencies

**Storage Account Module (`sta.bicep`)**:

- Implements secure blob storage with encryption at rest
- Configures network access rules and threat protection
- Provides diagnostic settings for monitoring and auditing
- Outputs: Storage account ID, name, and endpoints

**Container Registry Module (`acr.bicep`)**:

- Deploys private Docker image registry with admin access
- Implements zone redundancy for high availability
- Configures security policies and network access
- Outputs: Registry ID, name, and login server URL

**Key Vault Module (`kvt.bicep`)**:

- Creates secure storage for secrets, keys, and certificates
- Implements RBAC-based access policies
- Configures diagnostic settings with Storage Account dependency
- Outputs: Key Vault ID, name, and URI

**Log Analytics Workspace Module (`law.bicep`)**:

- Establishes centralized logging and monitoring capabilities
- Configures data retention policies and pricing tier
- Provides foundation for other monitoring services
- Outputs: Workspace ID and name for service integration

**Application Insights Module (`ais.bicep`)**:

- Implements application performance monitoring
- Links to Log Analytics Workspace for data correlation
- Configures diagnostic export to Storage Account
- Outputs: Component ID for application integration

**User Assigned Managed Identity Module (`umi.bicep`)**:

- Creates secure identity for Azure resource authentication
- Supports federated identity credentials for workload identity scenarios
- Enables keyless authentication to Azure services
- Outputs: Principal ID and Client ID for service integration

**App Service Deployment Strategy**:

App Service resources (App Service Plan and App Service) are intentionally deployed using imperative Azure CLI commands rather than declarative Bicep modules. This approach prevents Azure's automatic provisioning of monitoring resources that conflict with the managed infrastructure design.

**App Service Configuration Specifications:**

- **App Service Plan**: Configured with Linux operating system (`--is-linux` flag) for modern container and runtime support
- **App Service Runtime**: Uses Node.js latest LTS version (`NODE:22-lts`) for optimal performance and security updates
- **Integration**: Explicit linking to existing Application Insights and Log Analytics Workspace instances
- **Deployment Method**: Azure CLI commands (`az appservice plan create` and `az webapp create`) for precise control

When App Service is deployed declaratively through Bicep templates, Azure automatically creates:

- Application Insights instance with auto-generated naming (`<app-service-name>-insights`)
- Default Log Analytics Workspace if none is explicitly specified
- Additional monitoring resource group (`DefaultResourceGroup-<region>`) in some scenarios

These auto-created resources create management challenges including naming conflicts, unmanaged resource dependencies, and governance policy violations. The imperative deployment approach using `az appservice plan create` and `az webapp create` commands provides explicit control over resource creation and allows proper integration with the existing Application Insights and Log Analytics Workspace instances defined in the Bicep modules.

This hybrid approach (declarative for infrastructure foundation, imperative for compute resources) ensures clean resource lifecycle management while maintaining the benefits of Infrastructure as Code for the core platform services.

#### 1.12.4.5 Resource Dependencies and Deployment Order

The modules are deployed in a specific order to satisfy dependencies:

**Declarative Infrastructure (Bicep Deployment Stack)**:

1. **Storage Account** (Independent) - Foundation for diagnostic data
2. **Container Registry** (Independent) - For containerized applications
3. **Log Analytics Workspace** (Storage Account dependency) - Centralized logging
4. **Key Vault** (Storage Account dependency) - Secure secret storage
5. **Application Insights** (Log Analytics + Storage dependencies) - Monitoring integration
6. **User Assigned Managed Identity** (Independent) - Secure identity for Azure resource access

**Imperative Compute Resources (Azure CLI Commands)**:

1. **App Service Plan** (Resource Group dependency) - Compute hosting foundation with Linux OS
2. **App Service** (App Service Plan + Application Insights dependencies) - Web application hosting with Node.js 22 LTS runtime
3. **User Assigned Managed Identity Assignment** (App Service + UMI dependencies) - Secure identity integration for Azure resource access
4. **AcrPull Role Assignment** (UMI dependency) - Container registry access permissions for the managed identity

**User Assigned Managed Identity Integration Instructions:**

Implement the following steps after App Service creation to enable secure Azure resource access:

1. **Identity Assignment**: Assign the User Assigned Managed Identity to the App Service using Azure CLI webapp identity assignment
   - Use the User Assigned Managed Identity resource ID constructed with environment variable naming pattern
   - Target the App Service by name using the established naming convention
   - Specify the resource group scope for proper resource association

2. **Role Assignment Configuration**: Assign AcrPull role to the User Assigned Managed Identity for container registry access
   - Retrieve the principal ID of the User Assigned Managed Identity using Azure CLI identity show command
   - Execute role assignment creation targeting the Azure Container Registry scope using the established naming convention
   - Use AcrPull role for Azure Container Registry pull permissions
   - Specify ServicePrincipal as the assignee principal type for managed identity integration

3. **Service Principal Authorization for Role Assignment**: Grant the service principal User Access Administrator role at subscription scope
   - **Rationale**: The service principal (Azure App Registration) requires elevated permissions to assign roles to other identities
   - **Security Scope**: Assign the User Access Administrator role at the subscription scope to enable role assignments across all resources
   - **Implementation**: Grant User Access Administrator role to the service principal at the subscription scope using Azure CLI role assignment
   - **Timing**: Execute this step before attempting to assign AcrPull role to the User Assigned Managed Identity
   - **Principal Type**: Specify ServicePrincipal as the assignee principal type for the App Registration object ID
   - **Security Justification**: This enables the service principal to delegate container registry access to the User Assigned Managed Identity for automated deployments

This hybrid deployment approach ensures that foundational infrastructure is managed declaratively through deployment stacks while compute resources are deployed imperatively to prevent Azure's automatic creation of conflicting monitoring resources.

#### 1.12.4.6 Parameter Strategy

**Dynamic Parameters** (set by workflow):

- Resource names with unique suffixes
- Location for regional deployment
- Environment-specific configurations

**Static Parameters** (defined in template):

- API versions for stability
- Default configurations following Azure best practices
- Security settings and policies

**Parameter File Usage:**

Create a `main.bicepparam` file that provides environment-specific values following this pattern:

- Use the 'using' declaration to reference 'main.bicep'
- Set resourceGroupName parameter as empty string (will be set dynamically by workflow)
- Set location parameter with default region 'eastus2'  
- Set storageAccountName parameter as empty string (will be set dynamically with unique suffix)
- Set containerRegistryName parameter as empty string (will be set dynamically with unique suffix)
- Follow same pattern for all additional parameters (keyVaultName, lawName, appInsightsName)
  
_NOTE: For this implementation, the bicepparam file is being used as a placeholder since it is bypassed by the required parameters in the github actions az cli deployment commands. However, it's placed here as a convenience for when it is needed, though it may be argued that this violates the YAGNI principle: YAGNI = You Ain't Gonna Need It._

#### 1.12.4.7 Security and Compliance Features

- **Encryption**: All resources use encryption at rest and in transit
- **Network Security**: Configurable network access rules and private endpoints
- **Access Control**: RBAC-based permissions and managed identities
- **Monitoring**: Comprehensive diagnostic settings for all resources
- **Compliance**: Azure Policy-ready configurations and audit trails

#### 1.12.4.8 Validation and Testing

**Bicep Validation Script Implementation:**

Create a PowerShell script (`validate-bicep.ps1`) that validates Bicep templates before deployment:

- Use the Azure CLI command `az bicep build --file main.bicep` to validate templates
- Check the exit code ($LASTEXITCODE) to determine success or failure
- Display "Bicep validation successful!" message in Green color for success
- Display "Bicep validation failed!" message in Red color and exit with code 1 for failure

**Deployment Mode Instructions:**

Configure deployment modes to support different execution patterns:

- **Plan-Only Mode**: Implement using `--what-if` parameter for preview without making changes
- **Plan-and-Deploy Mode**: Execute full deployment after completing the planning phase  
- **Rollback Mode**: Implement reversion to previous deployment using deployment stack history. This mode must be used in conjunction with the plan-and-deploy mode to ensure the deployment stack exists for rollback operations.

### 1.12.5 Cleanup Procedures

Implement comprehensive cleanup procedures for complete environment reset and resource management:

#### 1.12.5.1 Imperative Resource Cleanup

**App Service and App Service Plan Cleanup** (Required for rollback operations):

Since App Service Plan and App Service resources are deployed imperatively using Azure CLI commands (not through the Bicep deployment stack), they require explicit cleanup during rollback operations. Create a cleanup procedure that removes these compute resources separately:

**Implementation Instructions:**

1. **Status Output**: Display informational message "Cleaning up App Service and App Service Plan resources..." for audit trail and troubleshooting
2. **App Service Deletion**:
   - Output deletion message with specific resource name using the pattern "Deleting App Service: ${{ env.appServicePrefix }}-${{ env.deployRndSuffix }}"
   - Implement Azure CLI webapp deletion command that targets the App Service by name and resource group using the established environment variable naming pattern
3. **App Service Plan Deletion**:
   - Output deletion message with specific resource name using the pattern "Deleting App Service Plan: ${{ env.appServicePlanPrefix }}-${{ env.deployRndSuffix }}"
   - Implement Azure CLI App Service Plan deletion command that targets the plan by name and resource group using the established environment variable naming pattern
4. **Completion Confirmation**: Display success message "Rollback completed successfully. Resources have been deleted." for operation verification

**Critical Implementation Notes:**

- **Deletion Order**: Always delete App Service before App Service Plan to avoid dependency conflicts
- **Resource Independence**: These resources must be deleted separately since they exist outside the deployment stack lifecycle
- **Error Handling**: Include appropriate error handling for cases where resources may not exist or deletion fails. The following ERROR may appear during a rollback operation and can be safely ignored as a false-positive, where the deployment may have to be manually deleted from the portal:

```bash
Run echo "Rolling back deployment..."
##[debug]/usr/bin/bash -e /home/runner/work/_temp/a820ff60-fe13-4d5e-9365-dbe19bd7aafc.sh
Rolling back deployment...
Most recent deployment stack found: stack-6a78b0f0
Rolling back deployment stack: stack-6a78b0f0
ERROR: (DeploymentStackDeleteResourcesFailed) One or more resources could not be deleted. Correlation id: '<guid>'.
Code: DeploymentStackDeleteResourcesFailed
Message: One or more resources could not be deleted. Correlation id: '<guid>'.
Exception Details:(DeploymentStackDeleteResourcesFailed) An error occurred while deleting resources. These resources are still present in the stack but can be deleted manually. Please see the FailedResources property for specific error information. Deletion failures that are known limitations are documented here: https://aka.ms/DeploymentStacksKnownLimitations
Code: DeploymentStackDeleteResourcesFailed
Message: An error occurred while deleting resources. These resources are still present in the stack but can be deleted manually. Please see the FailedResources property for specific error information. Deletion failures that are known limitations are documented here: https://aka.ms/DeploymentStacksKnownLimitations
```

- **Naming Consistency**: Use the same environment variable pattern for resource names as used during deployment
- **Audit Trail**: Provide clear logging for each deletion step to support troubleshooting and compliance requirements

This cleanup procedure ensures complete removal of imperative resources during rollback operations while maintaining consistency with the overall deployment naming strategy.

#### 1.12.5.2 Azure Resource Cleanup

**Resource Group Deletion** (Optional for complete infrastructure reset):

Create a cleanup procedure that removes all Azure resources deployed by the Bicep templates:

1. **Azure CLI Command**: Use `az group delete --name $resourceGroupName --yes --no-wait` to delete the resource group and all contained resources
2. **Confirmation**: Include the `--yes` flag for unattended execution without confirmation prompts
3. **Asynchronous Execution**: Use `--no-wait` flag to avoid blocking the cleanup process on resource deletion completion
4. **Validation**: Optionally verify resource group deletion using `az group exists --name $resourceGroupName` command

#### 1.12.5.3 File and Directory Cleanup

**Infrastructure Directory Removal** (Optional for workspace reset):

Create a PowerShell-based cleanup procedure for local development environment reset:

1. **Directory Path**: Target the `$(git rev-parse --show-toplevel)/gitops/workspace/infra` directory for complete removal
2. **PowerShell Command**: Use `Remove-Item -Path "$(git rev-parse --show-toplevel)/gitops/workspace/infra" -Recurse -Force` for comprehensive directory deletion
3. **Recursive Deletion**: Include `-Recurse` parameter to remove all subdirectories and files
4. **Force Override**: Include `-Force` parameter to override read-only attributes and confirmation prompts

#### 1.12.5.4 Workflow File Cleanup

**GitHub Actions Workflow Removal** (Final cleanup step):

Implement workflow file cleanup for complete exercise reset:

1. **Workflow File**: Remove the `gaw-iac-azure-deployment.yml` file from the `.github/workflows` directory
2. **Git Operations**: Use standard git commands (`git rm` or file system operations) to remove the workflow file
3. **Repository Reset**: Ensure the repository returns to its original state before the exercise
4. **Verification**: Confirm workflow removal by checking the GitHub Actions tab for absence of the removed workflow

#### 1.12.5.5 Security Cleanup

**GitHub Secrets Management** (Optional for security reset):

Consider cleanup of configured GitHub secrets if environment reset is required:

1. **Repository Secrets**: Review and optionally remove Azure authentication secrets (AZURE_SUBSCRIPTION_ID, AZURE_CLIENT_ID, AZURE_TENANT_ID)
2. **Environment Variables**: Clear any debugging variables like ACTIONS_STEP_DEBUG if configured
3. **Access Permissions**: Review and revoke Azure App Registration permissions if no longer needed
4. **Federated Credentials**: Consider removing GitHub federated credentials from Azure App Registration for complete security cleanup

These comprehensive cleanup procedures ensure complete environment reset, security hygiene, and preparation for repeated demonstrations or exercises.

## 1.13 Key Takeaways

- **Azure-First Approach**: The solution focuses specifically on Azure infrastructure deployment using modern DevOps practices
- **Infrastructure as Code Excellence**: Bicep templates provide declarative, version-controlled infrastructure with subscription-scoped deployment capabilities
- **Security-First Design**: OIDC authentication eliminates long-lived secrets, implementing enterprise-grade security standards
- **Environment-Based Workflow**: Clear separation between dev (planning) and prd (deployment) environments with robust approval workflows
- **Deployment Stack Management**: Advanced Azure deployment stack features enable comprehensive lifecycle management and rollback capabilities
- **What-If Analysis**: Comprehensive planning phase with what-if analysis prevents deployment surprises and validates changes
- **Dynamic Configuration**: Flexible input parameters support various deployment scenarios without code modifications
- **Resource Naming Strategy**: Systematic approach to resource naming prevents conflicts in shared environments
- **Modular Architecture**: Bicep modules for storage accounts and container registries demonstrate scalable IaC patterns
- **Operational Excellence**: Built-in error handling, validation, and rollback procedures ensure reliable operations
- **Compliance Ready**: Approval workflows and audit trails support enterprise compliance requirements
- **Extensible Foundation**: Modular design enables easy extension for additional Azure resources and deployment scenarios

## 1.14 Questions or Feedback from Attendees

- **Azure Resource Expansion**: Should the solution include additional Azure resources such as:
  - Virtual Networks and subnets for network isolation
  - Azure Key Vault for secrets management
  - Application Gateway or Load Balancer for traffic management
  - Azure Monitor and Log Analytics for observability
- **Multi-Subscription Support**: Is there a need to support deployments across multiple Azure subscriptions?
- **Advanced Deployment Patterns**: Should the solution include support for:
  - Blue-green deployments
  - Canary releases with traffic splitting
  - Rolling updates with health checks
- **Integration Requirements**: Are there requirements to integrate with:
  - Azure DevOps for hybrid CI/CD scenarios
  - Terraform for multi-cloud IaC management
  - External configuration management systems
- **Compliance and Governance**: Should the solution include:
  - Azure Policy integration for governance
  - Compliance scanning and reporting
  - Cost management and budgeting controls
- **Monitoring and Alerting**: Should deployment workflows include:
  - Integration with Azure Monitor for deployment metrics
  - Notification systems (Teams, Slack, email) for deployment status
  - Performance monitoring and health checks post-deployment

## 1.15 Questions for Attendees

- **Deployment Frequency**: What is the expected frequency of infrastructure deployments?
  - Daily development updates
  - Weekly staging deployments  
  - Monthly production releases
- **Error Handling**: Are there specific error handling and recovery requirements such as:
  - Automatic retry mechanisms for transient failures
  - Integration with incident management systems
  - Automated rollback triggers based on health checks
- **Performance Requirements**: Are there specific performance benchmarks for deployment operations:
  - Maximum acceptable deployment time
  - What-if analysis execution time limits
  - Resource provisioning SLA requirements
- **Multi-Environment Strategy**: Beyond dev/prd, are additional environments needed:
  - Staging/UAT environments for testing
  - Load testing environments
  - Disaster recovery environments in alternate regions
- **Approval Workflows**: Are there additional approval requirements such as:
  - Multiple approval levels for production deployments
  - Specialized approvers for different resource types
  - Emergency deployment procedures with different approval paths
- **Testing Integration**: Should the deployment workflow include:
  - Automated infrastructure validation tests
  - Security scanning of deployed resources
  - Compliance verification checks
- **Backup and Recovery**: Are there requirements for:
  - Infrastructure state backup procedures
  - Disaster recovery testing
  - Point-in-time recovery capabilities
- **Production Readiness Criteria**: What are the key criteria for production readiness:
  - Security review and penetration testing
  - Performance validation under load
  - Compliance with organizational policies
  - What else would be required to consider the deployment production-ready in your organization?

## 1.16 Call to Action

### Immediate Actions

- **Review and Test**: Execute the complete workflow sequence to validate functionality
- **Security Configuration**: Configure Azure App Registration with federated credentials for OIDC authentication
- **Environment Setup**: Create GitHub environments (dev/prd) with appropriate protection rules
- **Permission Configuration**: Assign Azure permissions to the App Registration service principal for deployment scope
- **Validation Testing**: Run what-if analysis to validate Bicep templates and deployment plans

### Next Steps

- **Production Readiness**: Conduct security review and penetration testing before production use
- **Team Training**: Provide training sessions for development and operations teams on workflow usage
- **Monitoring Setup**: Implement comprehensive monitoring and alerting for deployment workflows
- **Documentation Review**: Ensure all team members understand deployment procedures and approval workflows
- **Feedback Collection**: Gather feedback from initial usage and iterate on improvements

### Long-term Enhancements

- **Extended Resource Coverage**: Add additional Azure resources based on application requirements
- **Advanced Deployment Patterns**: Implement blue-green deployments, canary releases, and rolling updates
- **Integration Expansion**: Integrate with additional Azure services and DevOps toolchain components
- **Process Optimization**: Continuously optimize deployment processes based on usage metrics and feedback
- **Compliance Enhancement**: Add compliance scanning, policy validation, and governance controls
- **Multi-Region Support**: Extend to support multi-region deployments and disaster recovery scenarios
