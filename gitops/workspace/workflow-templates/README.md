# .NET CI/CD Workflow Templates

🚀 **Streamlined .NET developer onboarding with GitHub Actions, VS Code, and GitHub Copilot**

This repository contains reusable workflow templates, automation scripts, and comprehensive documentation to set up a complete CI/CD pipeline for .NET applications in under 10 minutes.

\n\n📋 Quick Start

\n\nOne-Command Setup

```

powershell
\n\nClone or download this repository, then run:

.\setup\complete-setup.ps1 -Owner "your-github-username" -Repo "your-repo-name"

```

text
text

\n\nPrerequisites

\n\n**GitHub CLI** (`gh`) installed and authenticated
\n\n**Git** installed and configured
\n\n**Azure CLI** (`az`) installed and authenticated (optional)
\n\n**Azure subscription** with appropriate permissions
\n\n**VS Code** with GitHub Copilot extension (recommended)

\n\n🗂️ Repository Structure

```

text

workflow-templates/

├── 📄 README.md                           # This file

├── 📋 prd-master-ci-cd-dotnet-appservices.md  # Product Requirements Document

├── 🔧 .env.template                       # Environment configuration template

├── 📝 .gitignore                          # Git ignore rules

├── 📁 setup/                              # Automation scripts

│   ├── 🔧 complete-setup.ps1              # Complete onboarding automation

│   ├── 🔧 setup-github-environment.ps1    # GitHub environment setup (Windows)

│   ├── 🔧 setup-github-environment.sh     # GitHub environment setup (Linux/macOS)

│   └── 📖 onboarding-guide.md             # Detailed onboarding guide

├── 📁 workflow-templates/                 # Workflow files

│   └── 🔄 master-ci-cd-dotnet-appservices-commented.yaml

└── 📁 references/                         # Reference implementations

    ├── 🔄 master-ci-cd-dotnet-appservices.yaml

    └── 🔄 deploy-child.yaml

```

text
text

\n\n🎯 What This Solution Provides

\n\n✅ Automated Setup

\n\n**GitHub environments** (dev, qa, prod) with protection rules
\n\n**Secrets and variables** configuration via GitHub CLI
\n\n**Branch protection** rules for main branch
\n\n**Workflow files** copied to your repository
\n\n**Git configuration** with proper .gitignore

\n\n✅ Comprehensive Workflows

\n\n**Multi-environment deployments** with approval gates
\n\n**Reusable workflow templates** for consistency
\n\n**Azure App Service** deployment automation
\n\n**Build, test, and deploy** stages with error handling

\n\n✅ Developer Experience

\n\n**VS Code + GitHub Copilot** integration prompts
\n\n**Extensive documentation** with troubleshooting guides
\n\n**Cross-platform support** (Windows, macOS, Linux)
\n\n**Customizable templates** for different project needs

\n\n🚀 Getting Started

\n\nStep 1: Prerequisites Setup

## Install GitHub CLI

```

powershell
\n\nWindows

winget install GitHub.cli

\n\nmacOS

brew install gh

\n\nLinux - see <https://cli.github.com/>

```

text
text

## Authenticate GitHub CLI

```

bash

gh auth login

```

text
text

## Create Azure Service Principal

```

bash

az ad sp create-for-rbac --name "github-actions-{your-project}" --role contributor

```

text
text

\n\nStep 2: Environment Configuration

\n\n**Copy environment template:**

```

powershell

Copy-Item .env.template .env

```

text
text

\n\n**Edit .env file** with your values:
\n\nAzure service principal credentials
\n\nAzure Web App names for each environment
\n\nGitHub repository information

\n\nStep 3: Run Complete Setup

```

powershell
\n\nComplete automated setup

.\setup\complete-setup.ps1 -Owner "your-org" -Repo "your-repo"

\n\nOr run individual components

.\setup\setup-github-environment.ps1 -Owner "your-org" -Repo "your-repo"

```

text
text

\n\nStep 4: Manual Steps

\n\n**Add publish profiles** to environment secrets:

```

bash

gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat profile.xml)" --env dev

```

text
text

\n\n**Configure reviewers** for qa and prod environments in GitHub UI

\n\n**Test the workflow** by pushing code or creating a pull request

\n\n🔧 Configuration Details

\n\nGitHub Environments

| Environment | Auto-Deploy | Reviewers | Wait Time | Branch Policy |

| ----------- | ----------- | --------- | --------- | ------------- |

| **dev** | ✅ | None | None | Any branch |

| **qa** | ❌ | 1 | None | main only |

| **prod** | ❌ | 2 | 5 minutes | main only |

\n\nRequired Secrets

## Repository Level

\n\n`AZURE_CLIENT_ID`
\n\n`AZURE_CLIENT_SECRET`
\n\n`AZURE_TENANT_ID`
\n\n`AZURE_SUBSCRIPTION_ID`

## Environment Level

\n\n`AZURE_WEBAPP_PUBLISH_PROFILE`

\n\nRequired Variables

## Environment Level

\n\n`AZURE_WEBAPP_NAME`
\n\n`AZURE_RESOURCE_GROUP`
\n\n`DEPLOYMENT_SLOT`

\n\n🤖 GitHub Copilot Integration

\n\nSetup Prompts

```

text

I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

\n\nReview my workflow configuration for best practices
\n\nCustomize deployment steps for my Azure App Service
\n\nAdd environment-specific application settings
\n\nConfigure monitoring and alerting

Project: .NET 6 web application

Target: Azure App Service

Environments: dev, qa, prod

```

text
text

\n\nCustomization Prompts

```

text

Help me customize my .NET deployment workflow:

\n\nAdd SonarQube code quality checks
\n\nInclude database migration steps
\n\nConfigure blue-green deployment for production
\n\nAdd Slack notifications for deployment status

Current workflow: .github/workflows/ci-cd-dotnet.yaml

```

text
text

\n\nTroubleshooting Prompts

```

text

My .NET CI/CD pipeline is failing. Please help me:

\n\nAnalyze the workflow error logs
\n\nCheck Azure App Service configuration
\n\nVerify secrets and variables
\n\nSuggest fixes for deployment issues

Error: [paste error message here]

Workflow: [paste workflow URL here]

```

text
text

\n\n📚 Documentation

\n\nCore Documents

\n\n**[Product Requirements Document](prd-master-ci-cd-dotnet-appservices.md)** - Complete solution overview
\n\n**[Onboarding Guide](setup/onboarding-guide.md)** - Step-by-step setup instructions
\n\n**[Workflow Templates](workflow-templates/)** - Commented workflow files

\n\nAdditional Resources

\n\n**[GitHub Actions Documentation](https://docs.github.com/en/actions)**
\n\n**[Azure App Service Deployment](https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions)**
\n\n**[GitHub CLI Manual](https://cli.github.com/manual/)**

\n\n🛠️ Customization Examples

\n\nAdding Custom Build Steps

```

yaml
\n\nname: Code Quality Analysis

  uses: sonarqube-quality-gate-action@master

  env:

    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

```

text
text

\n\nEnvironment-Specific Configuration

```

yaml
\n\nname: Update App Settings

  run: |

    # Replace connection strings per environment

    if [ "${{ github.event.inputs.environment }}" = "prod" ]; then

      echo "Using production settings"

    fi

```

text
text

\n\nCustom Notifications

```

yaml
\n\nname: Notify Deployment Status

  if: always()

  uses: 8398a7/action-slack@v3

  with:

    status: ${{ job.status }}

    channel: "#deployments"

  env:

    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}

```

text
text

\n\n🔍 Monitoring and Troubleshooting

\n\nWorkflow Monitoring

Access your workflows and environments:

\n\n**GitHub Actions:** `https://github.com/{owner}/{repo}/actions`
\n\n**Environments:** `https://github.com/{owner}/{repo}/settings/environments`
\n\n**Secrets:** `https://github.com/{owner}/{repo}/settings/secrets`

\n\nCommon Issues

## 1. Authentication Errors

```

powershell
\n\nRe-authenticate GitHub CLI

gh auth login --web

gh auth status

```

text
text

## 2. Azure Connection Issues

```

bash
\n\nTest service principal

az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

```

text
text

## 3. Workflow Syntax Errors

\n\nUse VS Code GitHub Actions extension
\n\nCheck workflow logs for detailed errors
\n\nUse GitHub Copilot for syntax help

\n\nGetting Help

## Use GitHub Copilot

```

text

I'm having issues with my .NET CI/CD pipeline:

Error: [paste error message]

Workflow: [paste workflow file]

Environment: [development/qa/production]

Please help me:
\n\nAnalyze the error
\n\nSuggest fixes
\n\nProvide best practices

```

text
text

\n\n🎯 Success Criteria

Your setup is complete when you can:

\n\n✅ **Trigger workflows** manually or via code push
\n\n✅ **Deploy to dev** automatically on code changes
\n\n✅ **Deploy to qa/prod** with proper approvals
\n\n✅ **Monitor deployments** in GitHub and Azure
\n\n✅ **Customize workflows** using GitHub Copilot

\n\n🔄 Deployment Process

\n\nDevelopment Environment

\n\n**Trigger:** Push to any branch
\n\n**Process:** Build → Test → Deploy
\n\n**Approval:** None required
\n\n**Rollback:** Automatic on failure

\n\nQA Environment

\n\n**Trigger:** Manual or push to main
\n\n**Process:** Build → Test → Review → Deploy
\n\n**Approval:** 1 reviewer required
\n\n**Rollback:** Manual process

\n\nProduction Environment

\n\n**Trigger:** Manual from main branch only
\n\n**Process:** Build → Test → Wait → Review → Deploy
\n\n**Approval:** 2 reviewers + 5-minute wait
\n\n**Rollback:** Manual with approval

\n\n🤝 Contributing

Help improve this solution:

\n\n**Report issues** with setup or workflows
\n\n**Suggest enhancements** for automation scripts
\n\n**Share customizations** that work for your projects
\n\n**Update documentation** based on your experience

\n\nDevelopment Setup

```

powershell
\n\nClone the repository

git clone <https://github.com/your-org/workflow-templates.git>

cd workflow-templates

\n\nTest the setup scripts

.\setup\complete-setup.ps1 -Owner "test-org" -Repo "test-repo" -DryRun

```

text
text

\n\n📊 Performance Metrics

Expected performance after setup:

\n\n**Setup Time:** < 10 minutes
\n\n**First Deployment:** < 5 minutes
\n\n**Subsequent Deployments:** < 3 minutes
\n\n**Error Rate:** < 5% for properly configured projects

\n\n🔐 Security Best Practices

\n\n**Secrets Management:** Use GitHub secrets, never commit credentials
\n\n**Environment Protection:** Implement proper approval workflows
\n\n**Branch Protection:** Require reviews for main branch
\n\n**Access Control:** Use least-privilege service principals
\n\n**Audit Logging:** Monitor all deployment activities

\n\n📞 Support

For support and questions:

\n\n**Check troubleshooting guides** in documentation
\n\n**Use GitHub Copilot** for contextual help
\n\n**Create repository issues** for bugs or feature requests
\n\n**Contact your DevOps team** for organization-specific guidance

\n\n🎉 What's Next?

After successful setup:

\n\n**Customize workflows** for your specific needs
\n\n**Add monitoring and alerting** for production environments
\n\n**Implement advanced deployment strategies** (blue-green, canary)
\n\n**Integrate with additional tools** (SonarQube, monitoring, etc.)
\n\n**Share your experience** with the development community

---

## Made with ❤️ for .NET developers

_This solution is designed to work seamlessly with GitHub Copilot. Use the provided prompts throughout your development process for the best experience._

\n
