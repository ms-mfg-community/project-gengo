# Product Requirements Document (PRD): .NET CI/CD Onboarding Automation

## Document Information

- **Version:** 1.0
- **Author(s):** GitHub Copilot
- **Date:** July 11, 2025
- **Status:** Draft

## Executive Summary

This document defines the requirements for an automated .NET developer onboarding solution that streamlines CI/CD setup using reusable GitHub Actions workflows, VS Code, and GitHub Copilot. The solution minimizes manual configuration steps by automating the setup of secrets, variables, environments, and branch protection rules through GitHub CLI integration.

## Problem Statement

.NET developers currently face significant manual overhead when setting up CI/CD environments for new projects. The onboarding process requires manual configuration of:

- GitHub secrets and variables at repository and environment levels
- GitHub environments (dev, qa, prod) with appropriate protection rules
- Branch protection rules and deployment workflows
- Environment-specific configurations and access controls

This manual process is error-prone, time-consuming, and inconsistent across teams.

## Goals and Objectives

- **Primary Goal:** Reduce .NET developer onboarding time from hours to minutes
- **Secondary Goals:**
  - Automate GitHub environment and secret configuration
  - Provide Copilot-friendly templates and prompts
  - Ensure consistent CI/CD setup across projects
  - Enable self-service onboarding through VS Code and GitHub Copilot

## Scope

### In Scope
- Automated setup of GitHub environments (dev, qa, prod)
- GitHub CLI scripts for secrets and variables configuration
- Branch protection rules automation
- VS Code + GitHub Copilot integration prompts
- Reusable workflow templates with comprehensive documentation
- Environment file (.env) templates with placeholder values
- Developer onboarding documentation and best practices

### Out of Scope
- Azure resource provisioning (handled by existing workflows)
- Application code generation
- Database schema management
- Third-party tool integrations beyond GitHub ecosystem

## User Stories

### Primary Users: .NET Developers

**US-1:** As a .NET developer, I want to set up a complete CI/CD pipeline in under 10 minutes using VS Code and GitHub Copilot prompts.

**US-2:** As a .NET developer, I want GitHub environments and secrets to be automatically configured based on my project requirements.

**US-3:** As a .NET developer, I want to customize deployment workflows without understanding complex GitHub Actions syntax.

### Secondary Users: DevOps Engineers

**US-4:** As a DevOps engineer, I want to provide standardized CI/CD templates that developers can easily adopt and customize.

**US-5:** As a DevOps engineer, I want to ensure consistent security and deployment practices across all .NET projects.

## Solution Architecture

### Core Components

1. **Master Workflow (`master-ci-cd-dotnet-appservices.yaml`)**
   - Orchestrates multi-environment deployments
   - Handles build, test, and deployment stages
   - Supports manual and automated triggers

2. **Child Workflow (`deploy-child.yaml`)**
   - Reusable deployment template
   - Environment-specific configurations
   - Azure App Service deployment logic

3. **Automation Scripts**
   - GitHub CLI scripts for environment setup
   - PowerShell scripts for Windows compatibility
   - Bash scripts for cross-platform support

4. **Configuration Management**
   - Environment file templates
   - Secret and variable definitions
   - Branch protection rule configurations

### Integration Points

- **VS Code Extensions:** GitHub Copilot, GitHub Actions, PowerShell
- **GitHub CLI:** Environment management, secret configuration
- **Azure CLI:** Resource verification and deployment
- **GitHub Actions:** Workflow orchestration and execution

## Technical Requirements

### Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-1 | Automated GitHub environment creation (dev, qa, prod) | High |
| FR-2 | GitHub CLI script for secrets/variables configuration | High |
| FR-3 | Branch protection rules automation | High |
| FR-4 | VS Code + Copilot integration prompts | High |
| FR-5 | Environment file (.env) template generation | Medium |
| FR-6 | Workflow validation and testing automation | Medium |
| FR-7 | Cross-platform script compatibility (Windows/Linux) | Medium |
| FR-8 | Git ignore configuration for sensitive files | High |

### Non-Functional Requirements

- **Performance:** Setup completion within 10 minutes
- **Usability:** Single-command execution for complete setup
- **Security:** Automatic .env file exclusion from version control
- **Maintainability:** Clear documentation and commented code
- **Extensibility:** Easy customization for different project types

## Implementation Details

### File Structure
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

### Required Secrets and Variables

#### Repository-Level Secrets
- `AZURE_CLIENT_ID`: Azure service principal client ID
- `AZURE_CLIENT_SECRET`: Azure service principal secret
- `AZURE_TENANT_ID`: Azure tenant ID
- `AZURE_SUBSCRIPTION_ID`: Azure subscription ID

#### Environment-Level Variables
- `AZURE_WEBAPP_NAME`: Target Azure Web App name
- `AZURE_RESOURCE_GROUP`: Target resource group
- `DEPLOYMENT_SLOT`: Deployment slot name (staging/production)

#### Environment-Level Secrets
- `AZURE_WEBAPP_PUBLISH_PROFILE`: App Service publish profile

### GitHub Environments Configuration

#### Development Environment
- **Name:** `dev`
- **Protection Rules:** None (automatic deployment)
- **Deployment Branch:** `develop`

#### QA Environment
- **Name:** `qa`
- **Protection Rules:** Require review from 1 reviewer
- **Deployment Branch:** `main`

#### Production Environment
- **Name:** `prod`
- **Protection Rules:** Require review from 2 reviewers
- **Wait Timer:** 5 minutes
- **Deployment Branch:** `main` only

## Copilot Integration Prompts

### Setup Prompt Template
```
I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

1. Create GitHub environments for dev, qa, and prod with appropriate protection rules
2. Configure the required secrets and variables based on my Azure subscription
3. Set up branch protection rules for main and develop branches
4. Generate an environment file with placeholder values

Project Details:
- Framework: .NET 6/7/8
- Target: Azure App Service
- Environments: dev, qa, prod
- Repository: [REPO_NAME]
```

### Workflow Customization Prompt
```
I want to customize the .NET deployment workflow for my project. Please help me:

1. Modify the master workflow to include additional testing stages
2. Add custom environment variables for my specific requirements
3. Configure different deployment strategies per environment
4. Set up notifications for deployment status

Current workflow: master-ci-cd-dotnet-appservices.yaml
Customization needs: [SPECIFIC_REQUIREMENTS]
```

## Success Criteria

### Quantitative Metrics
- **Setup Time:** < 10 minutes from start to first successful deployment
- **Error Rate:** < 5% setup failures due to automation issues
- **Adoption Rate:** 80% of new .NET projects use automated setup within 3 months

### Qualitative Metrics
- Developer satisfaction with onboarding experience
- Reduction in DevOps support tickets related to CI/CD setup
- Consistency of deployment configurations across projects

## Implementation Timeline

### Phase 1: Core Automation (Week 1-2)
- Create GitHub CLI scripts for environment setup
- Develop PowerShell and Bash setup scripts
- Generate environment file templates

### Phase 2: Documentation and Integration (Week 3)
- Create comprehensive onboarding documentation
- Develop VS Code + Copilot integration prompts
- Test cross-platform compatibility

### Phase 3: Validation and Refinement (Week 4)
- Conduct user acceptance testing with development teams
- Refine automation scripts based on feedback
- Finalize documentation and best practices

## Best Practices and Recommendations

### For Developers
1. **Use VS Code with GitHub Copilot** for optimal integration experience
2. **Review generated scripts** before execution, especially for production environments
3. **Customize environment variables** to match your specific Azure resources
4. **Test in development environment** before promoting to QA/production

### For DevOps Engineers
1. **Maintain template repositories** with latest workflow versions
2. **Implement proper secret rotation** policies
3. **Monitor deployment success rates** and optimize accordingly
4. **Provide training** on Copilot-assisted workflow customization

### Security Considerations
1. **Never commit .env files** to version control
2. **Use least-privilege access** for service principals
3. **Implement proper approval workflows** for production deployments
4. **Regular security audits** of GitHub environments and secrets

## Troubleshooting Guide

### Common Issues and Solutions

#### GitHub CLI Authentication
**Problem:** `gh auth login` fails or shows permission errors
**Solution:** Use personal access token with appropriate scopes (repo, admin:org, admin:public_key)

#### Environment Setup Failures
**Problem:** Environment creation fails with API errors
**Solution:** Verify repository permissions and GitHub CLI authentication

#### Workflow Validation Errors
**Problem:** Workflow syntax errors after customization
**Solution:** Use GitHub Actions validator or VS Code extension for syntax checking

#### Azure Authentication Issues
**Problem:** Azure service principal authentication failures
**Solution:** Verify service principal permissions and secret expiration dates

## Appendices

### Appendix A: Required GitHub CLI Commands
```bash
# Create environments
gh api repos/{owner}/{repo}/environments/{environment_name} --method PUT

# Set environment secrets
gh secret set {SECRET_NAME} --body "{SECRET_VALUE}" --env {ENVIRONMENT}

# Configure branch protection
gh api repos/{owner}/{repo}/branches/{branch}/protection --method PUT
```

### Appendix B: Azure Service Principal Setup
```bash
# Create service principal
az ad sp create-for-rbac --name "github-actions-{project-name}" --role contributor

# Assign additional roles if needed
az role assignment create --assignee {client-id} --role "Website Contributor"
```

### Appendix C: Environment File Template
```bash
# Azure Configuration
AZURE_CLIENT_ID=your-client-id-here
AZURE_CLIENT_SECRET=your-client-secret-here
AZURE_TENANT_ID=your-tenant-id-here
AZURE_SUBSCRIPTION_ID=your-subscription-id-here

# Application Configuration
AZURE_WEBAPP_NAME_DEV=your-webapp-dev
AZURE_WEBAPP_NAME_QA=your-webapp-qa
AZURE_WEBAPP_NAME_PROD=your-webapp-prod
AZURE_RESOURCE_GROUP=your-resource-group
```

## Questions and Feedback

For questions or feedback regarding this PRD, please:
1. Create an issue in the repository
2. Contact the DevOps team
3. Use GitHub Discussions for community input

## Call to Action

1. **Review this PRD** and provide feedback on requirements and implementation approach
2. **Test the automation scripts** in a development environment
3. **Customize the workflows** for your specific project needs
4. **Share learnings** with the development community to improve the onboarding experience
