# Product Requirements Document (PRD): .NET CI/CD Onboarding Automation
\n\nDocument Information
\n\n**Version:** 1.0\n\n**Author(s):** GitHub Copilot\n\n**Date:** July 11, 2025\n\n**Status:** Draft
\n\nExecutive Summary

This document defines the requirements for an automated .NET developer onboarding solution that streamlines CI/CD setup using reusable GitHub Actions workflows, VS Code, and GitHub Copilot. The solution minimizes manual configuration steps by automating the setup of secrets, variables, environments, and branch protection rules through GitHub CLI integration.
\n\nProblem Statement

.NET developers currently face significant manual overhead when setting up CI/CD environments for new projects. The onboarding process requires manual configuration of:
\n\nGitHub secrets and variables at repository and environment levels\n\nGitHub environments (dev, qa, prod) with appropriate protection rules\n\nBranch protection rules and deployment workflows\n\nEnvironment-specific configurations and access controls

This manual process is error-prone, time-consuming, and inconsistent across teams.
\n\nGoals and Objectives
\n\n**Primary Goal:** Reduce .NET developer onboarding time from hours to minutes\n\n**Secondary Goals:**\n\nAutomate GitHub environment and secret configuration\n\nProvide Copilot-friendly templates and prompts\n\nEnsure consistent CI/CD setup across projects\n\nEnable self-service onboarding through VS Code and GitHub Copilot
\n\nScope
\n\nIn Scope
\n\nAutomated setup of GitHub environments (dev, qa, prod)\n\nGitHub CLI scripts for secrets and variables configuration\n\nBranch protection rules automation\n\nVS Code + GitHub Copilot integration prompts\n\nReusable workflow templates with comprehensive documentation\n\nEnvironment file (.env) templates with placeholder values\n\nDeveloper onboarding documentation and best practices
\n\nOut of Scope
\n\nAzure resource provisioning (handled by existing workflows)\n\nApplication code generation\n\nDatabase schema management\n\nThird-party tool integrations beyond GitHub ecosystem
\n\nUser Stories
\n\nPrimary Users: .NET Developers

**US-1:** As a .NET developer, I want to set up a complete CI/CD pipeline in under 10 minutes using VS Code and GitHub Copilot prompts.

**US-2:** As a .NET developer, I want GitHub environments and secrets to be automatically configured based on my project requirements.

**US-3:** As a .NET developer, I want to customize deployment workflows without understanding complex GitHub Actions syntax.
\n\nSecondary Users: DevOps Engineers

**US-4:** As a DevOps engineer, I want to provide standardized CI/CD templates that developers can easily adopt and customize.

**US-5:** As a DevOps engineer, I want to ensure consistent security and deployment practices across all .NET projects.
\n\nSolution Architecture
\n\nCore Components
\n\n**Master Workflow (`master-ci-cd-dotnet-appservices.yaml`)**\n\nOrchestrates multi-environment deployments\n\nHandles build, test, and deployment stages\n\nSupports manual and automated triggers
\n\n**Child Workflow (`deploy-child.yaml`)**\n\nReusable deployment template\n\nEnvironment-specific configurations\n\nAzure App Service deployment logic
\n\n**Automation Scripts**\n\nGitHub CLI scripts for environment setup\n\nPowerShell scripts for Windows compatibility\n\nBash scripts for cross-platform support
\n\n**Configuration Management**\n\nEnvironment file templates\n\nSecret and variable definitions\n\nBranch protection rule configurations
\n\nIntegration Points
\n\n**VS Code Extensions:** GitHub Copilot, GitHub Actions, PowerShell\n\n**GitHub CLI:** Environment management, secret configuration\n\n**Azure CLI:** Resource verification and deployment\n\n**GitHub Actions:** Workflow orchestration and execution
\n\nTechnical Requirements
\n\nFunctional Requirements

| ID   | Requirement                                           | Priority |
| ---- | ----------------------------------------------------- | -------- |
| FR-1 | Automated GitHub environment creation (dev, qa, prod) | High     |
| FR-2 | GitHub CLI script for secrets/variables configuration | High     |
| FR-3 | Branch protection rules automation                    | High     |
| FR-4 | VS Code + Copilot integration prompts                 | High     |
| FR-5 | Environment file (.env) template generation           | Medium   |
| FR-6 | Workflow validation and testing automation            | Medium   |
| FR-7 | Cross-platform script compatibility (Windows/Linux)   | Medium   |
| FR-8 | Git ignore configuration for sensitive files          | High     |
\n\nNon-Functional Requirements
\n\n**Performance:** Setup completion within 10 minutes\n\n**Usability:** Single-command execution for complete setup\n\n**Security:** Automatic .env file exclusion from version control\n\n**Maintainability:** Clear documentation and commented code\n\n**Extensibility:** Easy customization for different project types
\n\nImplementation Details
\n\nFile Structure

```
gitops/workspace/workflow-templates/
├── prd-master-ci-cd-dotnet-appservices.md
├── .env.template
├── .gitignore
├── setup/
│   ├── setup-github-environment.ps1
│   ├── setup-github-environment.sh
│   └── onboarding-guide.md
├── workflows/
│   ├── master-ci-cd-dotnet-appservices-commented.yaml
│   └── deploy-child-commented.yaml
└── references/
    ├── master-ci-cd-dotnet-appservices.yaml
    └── deploy-child.yaml
```
\n\nRequired Secrets and Variables
\n\nRepository-Level Secrets
\n\n`AZURE_CLIENT_ID`: Azure service principal client ID\n\n`AZURE_CLIENT_SECRET`: Azure service principal secret\n\n`AZURE_TENANT_ID`: Azure tenant ID\n\n`AZURE_SUBSCRIPTION_ID`: Azure subscription ID
\n\nEnvironment-Level Variables
\n\n`AZURE_WEBAPP_NAME`: Target Azure Web App name\n\n`AZURE_RESOURCE_GROUP`: Target resource group\n\n`DEPLOYMENT_SLOT`: Deployment slot name (staging/production)
\n\nEnvironment-Level Secrets
\n\n`AZURE_WEBAPP_PUBLISH_PROFILE`: App Service publish profile
\n\nGitHub Environments Configuration
\n\nDevelopment Environment
\n\n**Name:** `dev`\n\n**Protection Rules:** None (automatic deployment)\n\n**Deployment Branch:** `develop`
\n\nQA Environment
\n\n**Name:** `qa`\n\n**Protection Rules:** Require review from 1 reviewer\n\n**Deployment Branch:** `main`
\n\nProduction Environment
\n\n**Name:** `prod`\n\n**Protection Rules:** Require review from 2 reviewers\n\n**Wait Timer:** 5 minutes\n\n**Deployment Branch:** `main` only
\n\nCopilot Integration Prompts
\n\nSetup Prompt Template

```
I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:
\n\nCreate GitHub environments for dev, qa, and prod with appropriate protection rules\n\nConfigure the required secrets and variables based on my Azure subscription\n\nSet up branch protection rules for main and develop branches\n\nGenerate an environment file with placeholder values

Project Details:\n\nFramework: .NET 6/7/8\n\nTarget: Azure App Service\n\nEnvironments: dev, qa, prod\n\nRepository: [REPO_NAME]
```
\n\nWorkflow Customization Prompt

```
I want to customize the .NET deployment workflow for my project. Please help me:
\n\nModify the master workflow to include additional testing stages\n\nAdd custom environment variables for my specific requirements\n\nConfigure different deployment strategies per environment\n\nSet up notifications for deployment status

Current workflow: master-ci-cd-dotnet-appservices.yaml
Customization needs: [SPECIFIC_REQUIREMENTS]
```
\n\nSuccess Criteria
\n\nQuantitative Metrics
\n\n**Setup Time:** < 10 minutes from start to first successful deployment\n\n**Error Rate:** < 5% setup failures due to automation issues\n\n**Adoption Rate:** 80% of new .NET projects use automated setup within 3 months
\n\nQualitative Metrics
\n\nDeveloper satisfaction with onboarding experience\n\nReduction in DevOps support tickets related to CI/CD setup\n\nConsistency of deployment configurations across projects
\n\nImplementation Timeline
\n\nPhase 1: Core Automation (Week 1-2)
\n\nCreate GitHub CLI scripts for environment setup\n\nDevelop PowerShell and Bash setup scripts\n\nGenerate environment file templates
\n\nPhase 2: Documentation and Integration (Week 3)
\n\nCreate comprehensive onboarding documentation\n\nDevelop VS Code + Copilot integration prompts\n\nTest cross-platform compatibility
\n\nPhase 3: Validation and Refinement (Week 4)
\n\nConduct user acceptance testing with development teams\n\nRefine automation scripts based on feedback\n\nFinalize documentation and best practices
\n\nBest Practices and Recommendations
\n\nFor Developers
\n\n**Use VS Code with GitHub Copilot** for optimal integration experience\n\n**Review generated scripts** before execution, especially for production environments\n\n**Customize environment variables** to match your specific Azure resources\n\n**Test in development environment** before promoting to QA/production
\n\nFor DevOps Engineers
\n\n**Maintain template repositories** with latest workflow versions\n\n**Implement proper secret rotation** policies\n\n**Monitor deployment success rates** and optimize accordingly\n\n**Provide training** on Copilot-assisted workflow customization
\n\nSecurity Considerations
\n\n**Never commit .env files** to version control\n\n**Use least-privilege access** for service principals\n\n**Implement proper approval workflows** for production deployments\n\n**Regular security audits** of GitHub environments and secrets
\n\nTroubleshooting Guide
\n\nCommon Issues and Solutions
\n\nGitHub CLI Authentication

**Problem:** `gh auth login` fails or shows permission errors
**Solution:** Use personal access token with appropriate scopes (repo, admin:org, admin:public_key)
\n\nEnvironment Setup Failures

**Problem:** Environment creation fails with API errors
**Solution:** Verify repository permissions and GitHub CLI authentication
\n\nWorkflow Validation Errors

**Problem:** Workflow syntax errors after customization
**Solution:** Use GitHub Actions validator or VS Code extension for syntax checking
\n\nAzure Authentication Issues

**Problem:** Azure service principal authentication failures
**Solution:** Verify service principal permissions and secret expiration dates
\n\nAppendices
\n\nAppendix A: Required GitHub CLI Commands

```bash\n\nCreate environments
gh api repos/{owner}/{repo}/environments/{environment_name} --method PUT
\n\nSet environment secrets
gh secret set {SECRET_NAME} --body "{SECRET_VALUE}" --env {ENVIRONMENT}
\n\nConfigure branch protection
gh api repos/{owner}/{repo}/branches/{branch}/protection --method PUT
```
\n\nAppendix B: Azure Service Principal Setup

```bash\n\nCreate service principal
az ad sp create-for-rbac --name "github-actions-{project-name}" --role contributor
\n\nAssign additional roles if needed
az role assignment create --assignee {client-id} --role "Website Contributor"
```
\n\nAppendix C: Environment File Template

```bash\n\nAzure Configuration
AZURE_CLIENT_ID=your-client-id-here
AZURE_CLIENT_SECRET=your-client-secret-here
AZURE_TENANT_ID=your-tenant-id-here
AZURE_SUBSCRIPTION_ID=your-subscription-id-here
\n\nApplication Configuration
AZURE_WEBAPP_NAME_DEV=your-webapp-dev
AZURE_WEBAPP_NAME_QA=your-webapp-qa
AZURE_WEBAPP_NAME_PROD=your-webapp-prod
AZURE_RESOURCE_GROUP=your-resource-group
```
\n\nQuestions and Feedback

For questions or feedback regarding this PRD, please:
\n\nCreate an issue in the repository\n\nContact the DevOps team\n\nUse GitHub Discussions for community input
\n\nCall to Action
\n\n**Review this PRD** and provide feedback on requirements and implementation approach\n\n**Test the automation scripts** in a development environment\n\n**Customize the workflows** for your specific project needs\n\n**Share learnings** with the development community to improve the onboarding experience
\n
