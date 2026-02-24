# .NET CI/CD Onboarding Guide

Welcome to the streamlined .NET CI/CD onboarding experience! This guide will help you set up a complete CI/CD pipeline for your .NET application in under 10 minutes using GitHub Actions, VS Code, and GitHub Copilot.

\n\n📋 Prerequisites

Before starting, ensure you have:

\n\n**GitHub account** with repository access
\n\n**VS Code** with GitHub Copilot extension
\n\n**GitHub CLI** (gh) installed and authenticated
\n\n**Azure subscription** with appropriate permissions
\n\n**Azure CLI** installed (optional, for resource verification)

\n\n🚀 Quick Start

\n\nStep 1: Install GitHub CLI

## Windows

```

powershell

winget install GitHub.cli

```

text
text

## macOS

```

bash

brew install gh

```

text
text

## Linux

```

bash
\n\nSee <https://cli.github.com/> for distribution-specific instructions

```

text
text

\n\nStep 2: Authenticate GitHub CLI

```

bash

gh auth login

```

text
text

Select the following options:

\n\n**What account?** GitHub.com
\n\n**What is your preferred protocol?** HTTPS
\n\n**Authenticate Git with your GitHub credentials?** Yes
\n\n**How would you like to authenticate?** Login with a web browser

\n\nStep 3: Create Azure Service Principal

```

bash
\n\nReplace {project-name} with your actual project name

az ad sp create-for-rbac --name "github-actions-{project-name}" --role contributor --scopes /subscriptions/{subscription-id}

```

text
text

Save the output values:

\n\n`clientId` → `AZURE_CLIENT_ID`
\n\n`clientSecret` → `AZURE_CLIENT_SECRET`
\n\n`tenantId` → `AZURE_TENANT_ID`
\n\n`subscriptionId` → `AZURE_SUBSCRIPTION_ID`

\n\nStep 4: Configure Environment Variables

\n\n**Copy the environment template:**

```

bash

cp .env.template .env

```

text
text

\n\n**Edit the .env file** with your actual values:

```

bash

## Use VS Code or your preferred editor

code .env

```

text
text

\n\n**Fill in the required values:**
\n\nAzure service principal details (from Step 3)
\n\nAzure Web App names for each environment
\n\nAzure Resource Group names
\n\nGitHub repository information

\n\nStep 5: Run the Setup Script

## Windows (PowerShell)

```

powershell

.\setup\setup-github-environment.ps1 -Owner "your-github-username" -Repo "your-repo-name"

```

text
text

## macOS/Linux (Bash)

```

bash

chmod +x setup/setup-github-environment.sh

./setup/setup-github-environment.sh --owner "your-github-username" --repo "your-repo-name"

```

text
text

\n\nStep 6: Add Publish Profiles

Get your Azure Web App publish profiles and add them as environment secrets:

```

bash
\n\nFor each environment (dev, qa, prod)

gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env dev

gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env qa

gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env prod

```

text
text

\n\nStep 7: Copy Workflow Files

\n\n**Copy the workflow files to your repository:**

```

bash

mkdir -p .github/workflows

cp workflow-templates/master-ci-cd-dotnet-appservices-commented.yaml .github/workflows/

cp workflow-templates/references/deploy-child.yaml .github/workflows/

```

text
text

\n\n**Rename the main workflow file:**

```

bash

mv .github/workflows/master-ci-cd-dotnet-appservices-commented.yaml .github/workflows/ci-cd-dotnet.yaml

```

text
text

\n\n🤖 Using GitHub Copilot

\n\nInitial Setup Prompt

Use this prompt in VS Code with GitHub Copilot to get started:

```

text

I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

\n\nReview my current workflow configuration
\n\nSuggest improvements for my specific project needs
\n\nHelp me customize environment variables
\n\nExplain the deployment process for each environment

Project Details:
\n\nFramework: .NET 6/7/8
\n\nTarget: Azure App Service
\n\nEnvironments: dev, qa, prod
\n\nRepository: [YOUR_REPO_NAME]

```

text
text

\n\nWorkflow Customization Prompts

## For adding custom build steps

```

text

I want to add custom build steps to my .NET CI/CD workflow. Please help me:

\n\nAdd code quality checks using SonarQube
\n\nInclude database migration steps
\n\nAdd integration tests that run against a test database
\n\nConfigure different build configurations for each environment

Current workflow: .github/workflows/ci-cd-dotnet.yaml

```

text
text

## For environment-specific configuration

```

text

I need to customize my deployment workflow for different environments. Please help me:

\n\nAdd environment-specific connection strings
\n\nConfigure different application settings per environment
\n\nSet up blue-green deployment for production
\n\nAdd approval gates for production deployments

Environments: dev (auto-deploy), qa (1 reviewer), prod (2 reviewers + 5min wait)

```

text
text

\n\nTroubleshooting with Copilot

## For deployment issues

```

text

My .NET deployment to Azure App Service is failing. Please help me troubleshoot:

\n\nAnalyze the GitHub Actions workflow logs
\n\nCheck Azure App Service configuration
\n\nVerify secrets and variables are set correctly
\n\nSuggest fixes for common deployment issues

Error message: [PASTE_ERROR_MESSAGE_HERE]

Workflow run: [PASTE_WORKFLOW_RUN_URL]

```

text
text

\n\n📁 Project Structure

After setup, your project should have this structure:

```

text

your-repo/

├── .github/

│   └── workflows/

│       ├── ci-cd-dotnet.yaml

│       └── deploy-child.yaml

├── .env                    # Your environment variables (not committed)

├── .gitignore             # Includes .env exclusion

├── src/                   # Your .NET application code

└── README.md              # This file

```

text
text

\n\n🔧 Configuration Details

\n\nGitHub Environments

The setup script creates three environments:

| Environment | Protection Rules | Deployment Branch |

| ----------- | ----------------------- | ----------------- |

| **dev** | None (auto-deploy) | Any branch |

| **qa** | 1 reviewer required | main branch |

| **prod** | 2 reviewers + 5min wait | main branch only |

\n\nSecrets and Variables

## Repository-level secrets

\n\n`AZURE_CLIENT_ID`
\n\n`AZURE_CLIENT_SECRET`
\n\n`AZURE_TENANT_ID`
\n\n`AZURE_SUBSCRIPTION_ID`

## Environment-level variables

\n\n`AZURE_WEBAPP_NAME`
\n\n`AZURE_RESOURCE_GROUP`
\n\n`DEPLOYMENT_SLOT`

## Environment-level secrets

\n\n`AZURE_WEBAPP_PUBLISH_PROFILE`

\n\nBranch Protection

The main branch is protected with:

\n\n1 required reviewer
\n\nDismiss stale reviews
\n\nRequire code owner reviews
\n\nNo force pushes allowed

\n\n🎯 Deployment Process

\n\nAutomatic Deployment (dev)

\n\n**Trigger:** Push to any branch
\n\n**Process:** Build → Test → Deploy to dev environment
\n\n**No approval required**

\n\nManual Deployment (qa)

\n\n**Trigger:** Manual workflow dispatch or push to main
\n\n**Process:** Build → Test → Wait for 1 reviewer → Deploy to qa
\n\n**Approval required from 1 reviewer**

\n\nProduction Deployment (prod)

\n\n**Trigger:** Manual workflow dispatch from main branch
\n\n**Process:** Build → Test → Wait 5 minutes → Wait for 2 reviewers → Deploy to prod
\n\n**Approval required from 2 reviewers**

\n\n🛠️ Customization Options

\n\nAdding Custom Build Steps

Use GitHub Copilot to add custom steps:

```

yaml
\n\nExample: Add SonarQube analysis
\n\nname: SonarQube Analysis

  uses: sonarqube-quality-gate-action@master

  env:

    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

```

text
text

\n\nEnvironment-Specific Configuration

Add environment-specific appsettings:

```

yaml
\n\nExample: Replace connection strings per environment
\n\nname: Update App Settings

  run: |

    sed -i 's/{{CONNECTION_STRING}}/${{ secrets.CONNECTION_STRING }}/g' appsettings.json

```

text
text

\n\nCustom Deployment Strategies

Configure different deployment strategies:

```

yaml
\n\nExample: Blue-Green deployment for production
\n\nname: Blue-Green Deployment

  if: github.ref == 'refs/heads/main'

  uses: azure/webapps-deploy@v2

  with:

    app-name: ${{ vars.AZURE_WEBAPP_NAME }}

    slot-name: staging

    publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}

```

text
text

\n\n🔍 Monitoring and Troubleshooting

\n\nWorkflow Monitoring

Monitor your workflows at:

\n\n**GitHub Actions:** `https://github.com/{owner}/{repo}/actions`
\n\n**Environments:** `https://github.com/{owner}/{repo}/settings/environments`

\n\nCommon Issues and Solutions

## 1. Authentication Errors

```

bash
\n\nRe-authenticate GitHub CLI

gh auth login --web

\n\nVerify authentication

gh auth status

```

text
text

## 2. Azure Connection Issues

```

bash
\n\nTest Azure service principal

az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

\n\nVerify permissions

az account show

```

text
text

## 3. Workflow Syntax Errors

\n\nUse VS Code GitHub Actions extension for syntax validation
\n\nCheck workflow logs for detailed error messages
\n\nUse GitHub Copilot to analyze and fix syntax issues

\n\nGetting Help

## GitHub Copilot Prompts for Help

```

text

I'm having issues with my .NET CI/CD pipeline. Please help me:

\n\nAnalyze the workflow error logs
\n\nSuggest fixes for the deployment failure
\n\nHelp me optimize the build performance
\n\nExplain best practices for .NET deployments

Error details: [PASTE_ERROR_HERE]

Workflow file: .github/workflows/ci-cd-dotnet.yaml

```

text
text

\n\n📚 Additional Resources

\n\nDocumentation

\n\n[GitHub Actions Documentation](https://docs.github.com/en/actions)
\n\n[Azure App Service Deployment](https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions)
\n\n[GitHub CLI Documentation](https://cli.github.com/manual/)

\n\nBest Practices

\n\n**Security:** Regularly rotate secrets and review permissions
\n\n**Performance:** Use caching for NuGet packages and build artifacts
\n\n**Reliability:** Implement proper error handling and retry logic
\n\n**Monitoring:** Set up alerts for failed deployments

\n\nCommunity

\n\n**GitHub Community:** Join discussions about GitHub Actions
\n\n**Stack Overflow:** Tag questions with `github-actions` and `azure-app-service`
\n\n**Microsoft Learn:** Complete learning paths for Azure and GitHub integration

\n\n🎉 Success Criteria

Your onboarding is complete when you can:

\n\n✅ **Trigger a workflow** manually or by pushing code
\n\n✅ **See successful builds** in GitHub Actions
\n\n✅ **Deploy to dev environment** automatically
\n\n✅ **Deploy to qa/prod** with appropriate approvals
\n\n✅ **Monitor deployments** through GitHub and Azure portals

\n\n🤝 Contributing

Help improve this onboarding experience:

\n\n**Report issues** with the setup process
\n\n**Suggest improvements** for the automation scripts
\n\n**Share customizations** that work well for your projects
\n\n**Update documentation** based on your experience

\n\n📞 Support

For support:

\n\n**Check the troubleshooting section** above
\n\n**Use GitHub Copilot** for specific technical questions
\n\n**Create an issue** in this repository
\n\n**Contact your DevOps team** for organization-specific help

---

## Happy coding! 🚀

_This guide is designed to work with GitHub Copilot for the best experience. Use the provided prompts to get contextual help throughout your development process._

\n
