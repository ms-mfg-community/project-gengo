# .NET CI/CD Workflow Templates

🚀 **Streamlined .NET developer onboarding with GitHub Actions, VS Code, and GitHub Copilot**

This repository contains reusable workflow templates, automation scripts, and comprehensive documentation to set up a complete CI/CD pipeline for .NET applications in under 10 minutes.

## 📋 Quick Start

### One-Command Setup

```powershell
# Clone or download this repository, then run:
.\setup\complete-setup.ps1 -Owner "your-github-username" -Repo "your-repo-name"
```

### Prerequisites

- **GitHub CLI** (`gh`) installed and authenticated
- **Git** installed and configured
- **Azure CLI** (`az`) installed and authenticated (optional)
- **Azure subscription** with appropriate permissions
- **VS Code** with GitHub Copilot extension (recommended)

## 🗂️ Repository Structure

```
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

## 🎯 What This Solution Provides

### ✅ Automated Setup
- **GitHub environments** (dev, qa, prod) with protection rules
- **Secrets and variables** configuration via GitHub CLI
- **Branch protection** rules for main branch
- **Workflow files** copied to your repository
- **Git configuration** with proper .gitignore

### ✅ Comprehensive Workflows
- **Multi-environment deployments** with approval gates
- **Reusable workflow templates** for consistency
- **Azure App Service** deployment automation
- **Build, test, and deploy** stages with error handling

### ✅ Developer Experience
- **VS Code + GitHub Copilot** integration prompts
- **Extensive documentation** with troubleshooting guides
- **Cross-platform support** (Windows, macOS, Linux)
- **Customizable templates** for different project needs

## 🚀 Getting Started

### Step 1: Prerequisites Setup

**Install GitHub CLI:**
```powershell
# Windows
winget install GitHub.cli

# macOS
brew install gh

# Linux - see https://cli.github.com/
```

**Authenticate GitHub CLI:**
```bash
gh auth login
```

**Create Azure Service Principal:**
```bash
az ad sp create-for-rbac --name "github-actions-{your-project}" --role contributor
```

### Step 2: Environment Configuration

1. **Copy environment template:**
   ```powershell
   Copy-Item .env.template .env
   ```

2. **Edit .env file** with your values:
   - Azure service principal credentials
   - Azure Web App names for each environment
   - GitHub repository information

### Step 3: Run Complete Setup

```powershell
# Complete automated setup
.\setup\complete-setup.ps1 -Owner "your-org" -Repo "your-repo"

# Or run individual components
.\setup\setup-github-environment.ps1 -Owner "your-org" -Repo "your-repo"
```

### Step 4: Manual Steps

1. **Add publish profiles** to environment secrets:
   ```bash
   gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat profile.xml)" --env dev
   ```

2. **Configure reviewers** for qa and prod environments in GitHub UI

3. **Test the workflow** by pushing code or creating a pull request

## 🔧 Configuration Details

### GitHub Environments

| Environment | Auto-Deploy | Reviewers | Wait Time | Branch Policy |
|-------------|-------------|-----------|-----------|---------------|
| **dev**     | ✅          | None      | None      | Any branch    |
| **qa**      | ❌          | 1         | None      | main only     |
| **prod**    | ❌          | 2         | 5 minutes | main only     |

### Required Secrets

**Repository Level:**
- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

**Environment Level:**
- `AZURE_WEBAPP_PUBLISH_PROFILE`

### Required Variables

**Environment Level:**
- `AZURE_WEBAPP_NAME`
- `AZURE_RESOURCE_GROUP`
- `DEPLOYMENT_SLOT`

## 🤖 GitHub Copilot Integration

### Setup Prompts

```
I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

1. Review my workflow configuration for best practices
2. Customize deployment steps for my Azure App Service
3. Add environment-specific application settings
4. Configure monitoring and alerting

Project: .NET 6 web application
Target: Azure App Service
Environments: dev, qa, prod
```

### Customization Prompts

```
Help me customize my .NET deployment workflow:

1. Add SonarQube code quality checks
2. Include database migration steps
3. Configure blue-green deployment for production
4. Add Slack notifications for deployment status

Current workflow: .github/workflows/ci-cd-dotnet.yaml
```

### Troubleshooting Prompts

```
My .NET CI/CD pipeline is failing. Please help me:

1. Analyze the workflow error logs
2. Check Azure App Service configuration
3. Verify secrets and variables
4. Suggest fixes for deployment issues

Error: [paste error message here]
Workflow: [paste workflow URL here]
```

## 📚 Documentation

### Core Documents
- **[Product Requirements Document](prd-master-ci-cd-dotnet-appservices.md)** - Complete solution overview
- **[Onboarding Guide](setup/onboarding-guide.md)** - Step-by-step setup instructions
- **[Workflow Templates](workflow-templates/)** - Commented workflow files

### Additional Resources
- **[GitHub Actions Documentation](https://docs.github.com/en/actions)**
- **[Azure App Service Deployment](https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions)**
- **[GitHub CLI Manual](https://cli.github.com/manual/)**

## 🛠️ Customization Examples

### Adding Custom Build Steps

```yaml
- name: Code Quality Analysis
  uses: sonarqube-quality-gate-action@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Environment-Specific Configuration

```yaml
- name: Update App Settings
  run: |
    # Replace connection strings per environment
    if [ "${{ github.event.inputs.environment }}" = "prod" ]; then
      echo "Using production settings"
    fi
```

### Custom Notifications

```yaml
- name: Notify Deployment Status
  if: always()
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    channel: '#deployments'
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

## 🔍 Monitoring and Troubleshooting

### Workflow Monitoring

Access your workflows and environments:
- **GitHub Actions:** `https://github.com/{owner}/{repo}/actions`
- **Environments:** `https://github.com/{owner}/{repo}/settings/environments`
- **Secrets:** `https://github.com/{owner}/{repo}/settings/secrets`

### Common Issues

**1. Authentication Errors**
```powershell
# Re-authenticate GitHub CLI
gh auth login --web
gh auth status
```

**2. Azure Connection Issues**
```bash
# Test service principal
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
```

**3. Workflow Syntax Errors**
- Use VS Code GitHub Actions extension
- Check workflow logs for detailed errors
- Use GitHub Copilot for syntax help

### Getting Help

**Use GitHub Copilot:**
```
I'm having issues with my .NET CI/CD pipeline:

Error: [paste error message]
Workflow: [paste workflow file]
Environment: [development/qa/production]

Please help me:
1. Analyze the error
2. Suggest fixes
3. Provide best practices
```

## 🎯 Success Criteria

Your setup is complete when you can:

1. ✅ **Trigger workflows** manually or via code push
2. ✅ **Deploy to dev** automatically on code changes
3. ✅ **Deploy to qa/prod** with proper approvals
4. ✅ **Monitor deployments** in GitHub and Azure
5. ✅ **Customize workflows** using GitHub Copilot

## 🔄 Deployment Process

### Development Environment
1. **Trigger:** Push to any branch
2. **Process:** Build → Test → Deploy
3. **Approval:** None required
4. **Rollback:** Automatic on failure

### QA Environment
1. **Trigger:** Manual or push to main
2. **Process:** Build → Test → Review → Deploy
3. **Approval:** 1 reviewer required
4. **Rollback:** Manual process

### Production Environment
1. **Trigger:** Manual from main branch only
2. **Process:** Build → Test → Wait → Review → Deploy
3. **Approval:** 2 reviewers + 5-minute wait
4. **Rollback:** Manual with approval

## 🤝 Contributing

Help improve this solution:

1. **Report issues** with setup or workflows
2. **Suggest enhancements** for automation scripts
3. **Share customizations** that work for your projects
4. **Update documentation** based on your experience

### Development Setup

```powershell
# Clone the repository
git clone https://github.com/your-org/workflow-templates.git
cd workflow-templates

# Test the setup scripts
.\setup\complete-setup.ps1 -Owner "test-org" -Repo "test-repo" -DryRun
```

## 📊 Performance Metrics

Expected performance after setup:

- **Setup Time:** < 10 minutes
- **First Deployment:** < 5 minutes
- **Subsequent Deployments:** < 3 minutes
- **Error Rate:** < 5% for properly configured projects

## 🔐 Security Best Practices

- **Secrets Management:** Use GitHub secrets, never commit credentials
- **Environment Protection:** Implement proper approval workflows
- **Branch Protection:** Require reviews for main branch
- **Access Control:** Use least-privilege service principals
- **Audit Logging:** Monitor all deployment activities

## 📞 Support

For support and questions:

1. **Check troubleshooting guides** in documentation
2. **Use GitHub Copilot** for contextual help
3. **Create repository issues** for bugs or feature requests
4. **Contact your DevOps team** for organization-specific guidance

## 🎉 What's Next?

After successful setup:

1. **Customize workflows** for your specific needs
2. **Add monitoring and alerting** for production environments
3. **Implement advanced deployment strategies** (blue-green, canary)
4. **Integrate with additional tools** (SonarQube, monitoring, etc.)
5. **Share your experience** with the development community

---

**Made with ❤️ for .NET developers**

*This solution is designed to work seamlessly with GitHub Copilot. Use the provided prompts throughout your development process for the best experience.*
