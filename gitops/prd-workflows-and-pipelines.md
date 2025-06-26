# 1. Product Requirements Document (PRD): Workflows and Pipelines

## 1.1 Document Information

- **Version:** 2.2
- **Author(s):** GitHub Copilot
- **Date:** January 10, 2025
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
3. Create a new Azure app registration with the name of `ghc-scenario-id-39` in the tenant `54d665dd-30f1-45c5-a8d5-d6ffcdb518f9` and retrieve the following details:
   - **Client ID**
   - **Tenant ID**
   - **Client Secret**
4. Configure the Azure app registration with two federated credentials for GitHub Actions as the identity provider (`id39-dev` and `id39-prd`):
   - For the GitHub organization use: `ms-mfg-community`.
   - Specify the repository name as `project-gengo`.
   - Set the audience to `api://AzureADTokenExchange`.
   - Use the `environment` for the entity type based on selection `dev`|`prd`.
5. Add the following secrets to the repository:
   - `AZURE_SUBSCRIPTION_ID`: The Azure subscription ID where resources will be deployed.
   - `AZURE_CLIENT_ID`: The Client ID from the Azure app registration.
   - `AZURE_TENANT_ID`: The Tenant ID from the Azure app registration.
6. At the end of the GitHub Copilot summary, add a next step recommendation to manually update these secret values.
7. Also remind the user as a next step to set permissions for the Azure app registration to the deployment scope of the Azure subscription where resources will be deployed, (i.e.) `az role assignment create --assignee-object-id <object-id> --assignee-principal-type ServicePrincipal --role Contributor --scope /subscriptions/<subscription-id> --verbose`
8. Finally, add as a next step that the following error may be encountered during deployment: "ERROR: the following arguments are required: --action-on-unmanage/--aou". Use this as a demonstration opportunity for creating and assigning an issue to GitHub Copilot to fix the issue in the workflow file using a pull request.

### 1.12.2 Basic Workflow Setup

1. Ensure the repository has a `.github/workflows` directory.
2. Create a new GitHub Actions workflow file in the `.github/workflows` directory.
3. Name the workflow file `01-level-workflow.yml`.
4. Trigger the workflow manually from the main branch using the workflow_dispatch event.
5. The workflow runs on an Ubuntu GitHub-hosted runner.
6. The workflow displays the event and branch name.
7. The repository is checked out.
8. A PowerShell script lists all repository contents and saves the output to the artifacts folder.
9. A Python script (getDirectoryContents.py) in the .github/workflows/src folder lists repository contents and saves the output.
10. Both outputs are uploaded as build artifacts.
11. A new job retrieves workflow metadata (branch, job ID) and displays it.
12. The workflow creates a downloads folder if needed.
13. The workflow downloads the previously uploaded artifact and displays its contents using PowerShell.
14. Copy the `01-level-workflow.yml` file to a new file named `01-level-pipeline.yml` in the directory `$(git rev-parse --show-toplevel)/.azure-pipelines`.
15. Convert the new `01-level-pipeline.yml` file to an Azure DevOps pipeline format by replacing GitHub Actions syntax with Azure DevOps YAML syntax.
16. Do not include the `$(Build.StartTime)` in any of the output for this pipeline since this information will already be set in the Azure DevOps Pipeline UI anyway.

#### 1.12.2.1 Manual Steps

1. Manually import the GitHub repository: `https://github.com/ms-mfg-community/project-gengo.git` into the ADO project: `ado-pipeline-demos` using the ADO repository name of `project-gengo-ci` and select the `01-level-pipeline.yml` file into a new Azure DevOps pipeline, also named `project-gengo-ci` for the project.
2. Manually run the Azure DevOps pipeline to verify it works as expected.
3. (Cleanup pipeline) Remove the `01-level-pipeline.yml` file from the repository root level `$(git rev-parse --show-toplevel)/.azure-pipelines` directory to reset this exercise.
4. (Cleanup workflow) Remove the `01-level-workflow.yml` file from the `$(git rev-parse --show-toplevel)/.github/workflows` directory to reset this exercise.
5. (Cleanup ADO pipeline) Remove the Azure DevOps pipeline created in step 17 from the Azure DevOps project to reset this exercise.
6. (Cleanup ADO repo) Remove the Azure DevOps repository created in step 17 from the Azure DevOps project to reset this exercise.

### 1.12.3 Azure Deployment Workflow

1. In the repository path `$(git rev-parse --show-toplevel)/gitops/workspace`, create the following directory and file structure using PowerShell:
   NOTE: Only create the directory structure exactly as it appears below if it does not already exist. If the files already exist, do not overwrite them.

   ```powershell
   \---infra
       |   main.bicep
       |   main.bicepparam
       |
       \---modules
               acr.bicep # Azure Container Registry module
               sta.bicep # Azure Storage Account module
               asp.bicep # Azure App Service Plan module
               app.bicep # Azure App Service module
               ais.bicep # Azure Application Insights module
               kvt.bicep # Azure Key Vault module
               law.bicep # Azure Log Analytics Workspace module
       \---scripts
           |   setup-github-secrets-and-vars.ps1
           |   validate-bicep.ps1
   ```

2. The PowerShell script with the name `setup-github-secrets-and-vars.ps1` in step 1 above:
   - Will be used to set up the required GitHub secrets and variables for the Azure deployment workflow.
   - Will use the `gh` CLI command to set the secrets and variables interactively.
3. Add the following GitHub Actions workflow secrets and variables to the repository level using the gh CLI command using a PowerShell script named `setup-github-secrets-and-vars.ps1`. I will authenticate interactively when prompted.
   - `AZURE_SUBSCRIPTION_ID`: The Azure subscription ID where resources will be deployed.
   - `AZURE_CLIENT_ID`: The Client ID from the Azure app registration.
   - `AZURE_TENANT_ID`: The Tenant ID from the Azure app registration.
   - `ACTIONS_STEP_DEBUG`: Set to enable debug logging for GitHub Actions steps.
4. Ensure the repository has a `.github/workflows` directory.
5. Create a new GitHub Actions workflow file in the `.github/workflows` directory.
6. Name the workflow file `gaw-iac-azure-deployment.yml` and name the workflow `gaw-iac-azure-deployment`.
7. Use a manual trigger event for the workflow.
8. Assign an Ubuntu GitHub-hosted runner for the workflow.

#### 1.12.3.1 Workflow Inputs

1. In the `gaw-iac-azure-deployment.yml` workflow file, define the inputs for the workflow using the `workflow_dispatch` event.
2. The inputs will be used to configure the Azure deployment parameters dynamically.
3. In the workflow_dispatch section, define the following inputs:

- `resourceGroupName`: The name of the Azure resource group with a default value of `gaw-iac-azure-deployment`.
- `location`: The Azure region for resources with allowed values (`eastus2`, `westus2`, `centralus`, `eastus`, `westus`) and default value of `eastus2`.
- `bicepFile`: The path to the Bicep file for the deployment, specified as `gitops/workspace/infra/main.bicep`.
- `bicepParametersFile`: The path to the Bicep parameters file as `gitops/workspace/infra/main.bicepparam`.
- `workflowMode`: The mode of the workflow with allowed values of (`plan-only`, `plan-and-deploy`, `deploy-only`). Use `plan-only` as the default value.
- `stackAction`: The action to perform on the deployment stack (`deploy`, `rollback`) with a default value of `deploy`.
- `deploymentStackPrefix`: The name of the deployment stack to use which will be set to `stack` in the workflow inputs.

#### 1.12.3.2 Resource Naming Strategy

1. The workflow level env: variables used as resource prefixes will be defined as follows:
  
```yaml
env:
  AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
  AZURE_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

1. The random resource suffix will be generated using a plan job output variable defined as:

```yaml
outputs:
  rndSuffix: ${{ steps.rnd.outputs.rndSuffix }}
steps:
  - name: Set Output Variables
    id: rnd
    run: |
      echo "rndSuffix=$(echo $RANDOM | md5sum | head -c 8)" >> $GITHUB_OUTPUT
```

1. The full resource names will be constructed dynamically within the plan job using the generated suffix. Example:

```yaml
az deployment sub what-if \
  --name "gaw-deployment-${{ steps.rnd.outputs.randomResourceSuffix }}" \
  --location "${{ github.event.inputs.location }}" \
  --template-file "${{ github.event.inputs.bicepFile }}" \
  --parameters resourceGroupName="${{ env.rgprefix }}-${{ steps.rnd.outputs.rndSuffix }}" \
                location="${{ github.event.inputs.location }}" \
                storageAccountName="${{ env.storagePrefix }}${{ steps.rnd.outputs.rndSuffix }}" \
                containerRegistryName="${{ env.containerRegistryPrefix }}${{ steps.rnd.outputs.rndSuffix }}" \
                appServicePlanName="${{ env.appServicePlanPrefix }}-${{ steps.rnd.outputs.rndSuffix }}" \
                appServiceName="${{ env.appServicePrefix }}-${{ steps.rnd.outputs.rndSuffix }}" \
                appInsightsPrefix="${{ env.appInsightsPrefix }}-${{ steps.rnd.outputs.rndSuffix }}" \
                keyVaultName="${{ env.keyVaultPrefix }}-${{ steps.rnd.outputs.rndSuffix }}" \
                lawName="${{ env.lawPrefix }}-${{ steps.rnd.outputs.rndSuffix }}"
```

1. And in the deploy job, the same pattern is used with job output references, 

```yaml
az stack sub create \
--name "${{ github.event.inputs.deploymentStackPrefix }}-${{ env.deployRndSuffix }}" \
--location "${{ github.event.inputs.location }}" \
--template-file "${{ github.event.inputs.bicepFile }}" \
--parameters resourceGroupName="${{ env.rgprefix }}-${{ env.deployRndSuffix }}" \
        location="${{ github.event.inputs.location }}" \
        storageAccountName="${{ env.storagePrefix }}${{ env.deployRndSuffix }}" \
        containerRegistryName="${{ env.containerRegistryPrefix }}${{ env.deployRndSuffix }}" \
        appServicePlanName="${{ env.appServicePlanPrefix }}-${{ env.deployRndSuffix }}" \
        appServiceName="${{ env.appServicePrefix }}-${{ env.deployRndSuffix }}" \
        appInsightsPrefix="${{ env.appInsightsPrefix }}-${{ env.deployRndSuffix }}" \
        keyVaultName="${{ env.keyVaultPrefix }}-${{ env.deployRndSuffix }}" \
        lawName="${{ env.lawPrefix }}-${{ env.deployRndSuffix }}" \
--deny-settings-mode none \
--action-on-unmanage deleteAll \
--yes
```

#### 1.12.3.3 Jobs

1. In the `gaw-iac-azure-deployment.yml` workflow file, define two jobs: `plan` and `deploy`.
1. The `plan` job will be associated with the `dev` environment and will perform the planning phase of the deployment.
1. The `deploy` job will be associated with the `prd` environment and will perform the actual deployment of the Azure resources.
1. In the first job - `plan`, associate it with the `dev` environment and authenticate Azure using OIDC.
1. The first action will be to check out the repository code.
1. Then next action will be to set up Azure CLI with the Bicep extension.
1. After the bicep extension is set up, the workflow authenticates to Azure using the OIDC token and the Azure CLI.
1. The workflow Azure CLI bicep deployment command will use the what-if parameter to display a plan for deploying Azure resources using the Azure CLI with a bicep configuration.
1. Reference any required parameters from the workflow inputs defined in section 1.12.3.1, such as `resourceGroupName`, `location`, `bicepFile`, `bicepParametersFile`, `workflowMode`, and `deploymentStackName`.
1. The next job `deploy` will be associated with the `prd` environment and deploys the Azure resources using the Azure CLI with the bicep configuration and includes a rollback option as a separate action.
1. Continue to reference the same inputs defined for this workflow as in the `plan` job as required.
1. The same action sequences for repository checkout and authentication to Azure are used in the `deploy` job as well.
1. After the checkout action in the workflow, use the following install sequence for the azure cli and the bicep extension:

```yaml
- name: Set up Azure CLI with Bicep Extension
  run: |
    - name: Set up Azure CLI with Bicep Extension
      echo "Setting up Azure CLI and Bicep extension..."
      az upgrade --yes
      # Install and setup Bicep extension
      az bicep install
    
      # Verify installation  
      echo "Azure CLI version:"
      az --version
      echo "Bicep version:"
      az bicep version
```

### 1.12.4 Bicep Configuration

1. In the repository path `$(git rev-parse --show-toplevel)/gitops/workspace`, create the following directory and file structure using PowerShell:
   NOTE: Only create the directory structure exactly as it appears in **section 1.12.3, step 1** if it does not already exist. If the files already exist, do not overwrite them.

2. Add the code in `main.bicep` to perform a subscription scoped deployment. All parameter values in the `main.bicepparam` will be set to either an empty string or object, because the parameters will be dynamically set in the workflow inputs defined in **section 1.12.3, step 1**.

_NOTE: For these Azure resources, reference the `WAF-aligned` examples of [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/indexes/bicep/bicep-resource-modules/) and include sensible defaults and enforce any implicit dependencies, for example; storage account logging or app service monitoring. Also include the latest known stable semantic version at this site, i.e. 0.11.2 used in the azure verified modules version format for each resource_

   - The resource group should include Azure resources based on the modules defined below.
   - Use the `sta.bicep` module for the storage account based on the `Microsoft.Storage/storageAccounts` resource type.
   - Use the `acr.bicep` module for the container registry based on the `Microsoft.ContainerRegistry/registries` resource type.
   - Use the `asp.bicep` module for the Azure App Service Plan based on the `Microsoft.Web/serverfarms` resource type.
   - Use the `app.bicep` module for the Azure App Service based on the `Microsoft.Web/sites` resource type.
   - Use the `kvt.bicep` module for the Azure Key Vault based on the `Microsoft.KeyVault/vaults` resource type. Since the key vault `diagnosticSettings`
   - Use the `law.bicep` module for the Log Analytics workspace based on the `Microsoft.OperationalInsights/workspaces` resource type. Eforce any dependencies for the Log Analytics workspace to ensure it is created before the Key Vault, App Service Plan and App Service so it's resource id can be referenced in the Key Vault, App Service Plan and App Service modules as necessary.

3. Add the code in `main.bicep` to deploy a storage account using the `sta.bicep` module.
4. Add the container registry using the `acr.bicep` module. The code should include parameters for resource names, locations, and other configurations.
5. Add the code in `main.bicepparam` to define the appropriate parameters based on sensible defaults and recommendations of Azure Verified Modules referenced in step 2 above.
6. Ensure that all resources will use their appropriate stable API versions as hardcoded values.

#### 1.12.4.1 Bicep Deployment Modes

1. If the workflowMode is either `plan-only` or `plan-and-deploy`, add the azure cli code for the deployment in the plan job and use the `--what-if` parameter to display a plan for deploying the Azure resources.
1. Use the file and folder structure provided above in **section 1.12.3, step 1**, at the path `$(git rev-parse --show-toplevel)/gitops/workspace` to organize the Bicep files and parameters.
1. For the deploy job, if the stackAction is `deploy` deploy the resources using the Bicep files and parameters defined in the previous steps. Ensure that the deployment uses the value: `deploymentStackName` and leverage the `az stack sub create` command, with the `--deny-settings-mode` parameter set to `deny` to ensure that the deployment stack is created with the appropriate deny settings for the resources being deployed and the `--action-on-unmanage` parameter set to `deleteAll` to ensure that unmanaged resources are deleted if they are not part of the deployment stack.

```bash
1. If the stackAction is `rollback`, rollback the deployment using the most recent `deploymentStackName` parameter.
1. Populate the `validate-bicep.ps1` script to validate the Bicep files before deployment. This script should use the Azure CLI command `az bicep build` to ensure the Bicep files are valid and can be deployed.

```powershell
# Change to the parent directory (infra directory) to ensure relative paths work correctly
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$infraDir = Split-Path -Parent $scriptDir
Set-Location $infraDir
# Validate Bicep files
Write-Host "Validating Bicep files..."
az bicep build --file main.bicep
if ($LASTEXITCODE -eq 0) {
    Write-Host "Bicep validation successful!" -ForegroundColor Green
} else {
    Write-Host "Bicep validation failed!" -ForegroundColor Red
    exit 1
}
```

_NOTE: The storageAccountName and the containerRegistryName parameters will not contain dashes, i.e. `-` to comply with the required naming conventions for Azure resources. Only lowercase numbers and letters are allowed in the storage account and container registry names. The resource names will be suffixed with a random string to avoid conflicts in shared environments._

```bicep

### 1.12.5 Cleanup Procedures

1. (Optional for resources cleanup) Remove the resources created by the Bicep deployment, you can use the Azure CLI command `az group delete --name $resourceGroupName --yes --no-wait` to delete the resource group and all its resources.
1. (Optional for files and folders cleanup) Remove the files and folders created in the `$(git rev-parse --show-toplevel)/gitops/workspace` directory, including the `infra` folder. You can use the PowerShell command `Remove-Item -Path "$(git rev-parse --show-toplevel)/gitops/workspace/infra" -Recurse -Force` to delete the entire infra directory.
1. (Optional for workflow cleanup) Finally, remove the `gaw-iac-azure-deployment.yml` workflow file from the `.github/workflows` directory to reset this exercise.

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
