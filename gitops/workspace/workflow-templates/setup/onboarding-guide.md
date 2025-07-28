# .NET CI/CD Onboarding Guide

Welcome to the streamlined .NET CI/CD onboarding experience! This guide will help you set up a complete CI/CD pipeline for your .NET application in under 10 minutes using GitHub Actions, VS Code, and GitHub Copilot.

## 📋 Prerequisites

Before starting, ensure you have:

- **GitHub account** with repository access
- **VS Code** with GitHub Copilot extension
- **GitHub CLI** (gh) installed and authenticated
- **Azure subscription** with appropriate permissions
- **Azure CLI** installed (optional, for resource verification)

## 🚀 Quick Start

### Step 1: Install GitHub CLI

**Windows:**
```powershell
winget install GitHub.cli
```

**macOS:**
```bash
brew install gh
```

**Linux:**
```bash
# See https://cli.github.com/ for distribution-specific instructions
```

### Step 2: Authenticate GitHub CLI

```bash
gh auth login
```

Select the following options:
- **What account?** GitHub.com
- **What is your preferred protocol?** HTTPS
- **Authenticate Git with your GitHub credentials?** Yes
- **How would you like to authenticate?** Login with a web browser

### Step 3: Create Azure Service Principal

```bash
# Replace {project-name} with your actual project name
az ad sp create-for-rbac --name "github-actions-{project-name}" --role contributor --scopes /subscriptions/{subscription-id}
```

Save the output values:
- `clientId` → `AZURE_CLIENT_ID`
- `clientSecret` → `AZURE_CLIENT_SECRET`
- `tenantId` → `AZURE_TENANT_ID`
- `subscriptionId` → `AZURE_SUBSCRIPTION_ID`

### Step 4: Configure Environment Variables

1. **Copy the environment template:**
   ```bash
   cp .env.template .env
   ```

2. **Edit the .env file** with your actual values:
   ```bash
   # Use VS Code or your preferred editor
   code .env
   ```

3. **Fill in the required values:**
   - Azure service principal details (from Step 3)
   - Azure Web App names for each environment
   - Azure Resource Group names
   - GitHub repository information

### Step 5: Run the Setup Script

**Windows (PowerShell):**
```powershell
.\setup\setup-github-environment.ps1 -Owner "your-github-username" -Repo "your-repo-name"
```

**macOS/Linux (Bash):**
```bash
chmod +x setup/setup-github-environment.sh
./setup/setup-github-environment.sh --owner "your-github-username" --repo "your-repo-name"
```

### Step 6: Add Publish Profiles

Get your Azure Web App publish profiles and add them as environment secrets:

```bash
# For each environment (dev, qa, prod)
gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env dev
gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env qa
gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body "$(cat path/to/publish-profile.xml)" --env prod
```

### Step 7: Copy Workflow Files

1. **Copy the workflow files to your repository:**
   ```bash
   mkdir -p .github/workflows
   cp workflow-templates/master-ci-cd-dotnet-appservices-commented.yaml .github/workflows/
   cp workflow-templates/references/deploy-child.yaml .github/workflows/
   ```

2. **Rename the main workflow file:**
   ```bash
   mv .github/workflows/master-ci-cd-dotnet-appservices-commented.yaml .github/workflows/ci-cd-dotnet.yaml
   ```

## 🤖 Using GitHub Copilot

### Initial Setup Prompt

Use this prompt in VS Code with GitHub Copilot to get started:

```
I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

1. Review my current workflow configuration
2. Suggest improvements for my specific project needs
3. Help me customize environment variables
4. Explain the deployment process for each environment

Project Details:
- Framework: .NET 6/7/8
- Target: Azure App Service
- Environments: dev, qa, prod
- Repository: [YOUR_REPO_NAME]
```

### Workflow Customization Prompts

**For adding custom build steps:**
```
I want to add custom build steps to my .NET CI/CD workflow. Please help me:

1. Add code quality checks using SonarQube
2. Include database migration steps
3. Add integration tests that run against a test database
4. Configure different build configurations for each environment

Current workflow: .github/workflows/ci-cd-dotnet.yaml
```

**For environment-specific configuration:**
```
I need to customize my deployment workflow for different environments. Please help me:

1. Add environment-specific connection strings
2. Configure different application settings per environment
3. Set up blue-green deployment for production
4. Add approval gates for production deployments

Environments: dev (auto-deploy), qa (1 reviewer), prod (2 reviewers + 5min wait)
```

### Troubleshooting with Copilot

**For deployment issues:**
```
My .NET deployment to Azure App Service is failing. Please help me troubleshoot:

1. Analyze the GitHub Actions workflow logs
2. Check Azure App Service configuration
3. Verify secrets and variables are set correctly
4. Suggest fixes for common deployment issues

Error message: [PASTE_ERROR_MESSAGE_HERE]
Workflow run: [PASTE_WORKFLOW_RUN_URL]
```

## 📁 Project Structure

After setup, your project should have this structure:

```
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

## 🔧 Configuration Details

### GitHub Environments

The setup script creates three environments:

| Environment | Protection Rules | Deployment Branch |
|-------------|------------------|-------------------|
| **dev**     | None (auto-deploy) | Any branch |
| **qa**      | 1 reviewer required | main branch |
| **prod**    | 2 reviewers + 5min wait | main branch only |

### Secrets and Variables

**Repository-level secrets:**
- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

**Environment-level variables:**
- `AZURE_WEBAPP_NAME`
- `AZURE_RESOURCE_GROUP`
- `DEPLOYMENT_SLOT`

**Environment-level secrets:**
- `AZURE_WEBAPP_PUBLISH_PROFILE`

### Branch Protection

The main branch is protected with:
- 1 required reviewer
- Dismiss stale reviews
- Require code owner reviews
- No force pushes allowed

## 🎯 Deployment Process

### Automatic Deployment (dev)

1. **Trigger:** Push to any branch
2. **Process:** Build → Test → Deploy to dev environment
3. **No approval required**

### Manual Deployment (qa)

1. **Trigger:** Manual workflow dispatch or push to main
2. **Process:** Build → Test → Wait for 1 reviewer → Deploy to qa
3. **Approval required from 1 reviewer**

### Production Deployment (prod)

1. **Trigger:** Manual workflow dispatch from main branch
2. **Process:** Build → Test → Wait 5 minutes → Wait for 2 reviewers → Deploy to prod
3. **Approval required from 2 reviewers**

## 🛠️ Customization Options

### Adding Custom Build Steps

Use GitHub Copilot to add custom steps:

```yaml
# Example: Add SonarQube analysis
- name: SonarQube Analysis
  uses: sonarqube-quality-gate-action@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Environment-Specific Configuration

Add environment-specific appsettings:

```yaml
# Example: Replace connection strings per environment
- name: Update App Settings
  run: |
    sed -i 's/{{CONNECTION_STRING}}/${{ secrets.CONNECTION_STRING }}/g' appsettings.json
```

### Custom Deployment Strategies

Configure different deployment strategies:

```yaml
# Example: Blue-Green deployment for production
- name: Blue-Green Deployment
  if: github.ref == 'refs/heads/main'
  uses: azure/webapps-deploy@v2
  with:
    app-name: ${{ vars.AZURE_WEBAPP_NAME }}
    slot-name: staging
    publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
```

## 🔍 Monitoring and Troubleshooting

### Workflow Monitoring

Monitor your workflows at:
- **GitHub Actions:** `https://github.com/{owner}/{repo}/actions`
- **Environments:** `https://github.com/{owner}/{repo}/settings/environments`

### Common Issues and Solutions

**1. Authentication Errors**
```bash
# Re-authenticate GitHub CLI
gh auth login --web

# Verify authentication
gh auth status
```

**2. Azure Connection Issues**
```bash
# Test Azure service principal
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Verify permissions
az account show
```

**3. Workflow Syntax Errors**
- Use VS Code GitHub Actions extension for syntax validation
- Check workflow logs for detailed error messages
- Use GitHub Copilot to analyze and fix syntax issues

### Getting Help

**GitHub Copilot Prompts for Help:**

```
I'm having issues with my .NET CI/CD pipeline. Please help me:

1. Analyze the workflow error logs
2. Suggest fixes for the deployment failure
3. Help me optimize the build performance
4. Explain best practices for .NET deployments

Error details: [PASTE_ERROR_HERE]
Workflow file: .github/workflows/ci-cd-dotnet.yaml
```

## 📚 Additional Resources

### Documentation
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure App Service Deployment](https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions)
- [GitHub CLI Documentation](https://cli.github.com/manual/)

### Best Practices
- **Security:** Regularly rotate secrets and review permissions
- **Performance:** Use caching for NuGet packages and build artifacts
- **Reliability:** Implement proper error handling and retry logic
- **Monitoring:** Set up alerts for failed deployments

### Community
- **GitHub Community:** Join discussions about GitHub Actions
- **Stack Overflow:** Tag questions with `github-actions` and `azure-app-service`
- **Microsoft Learn:** Complete learning paths for Azure and GitHub integration

## 🎉 Success Criteria

Your onboarding is complete when you can:

1. ✅ **Trigger a workflow** manually or by pushing code
2. ✅ **See successful builds** in GitHub Actions
3. ✅ **Deploy to dev environment** automatically
4. ✅ **Deploy to qa/prod** with appropriate approvals
5. ✅ **Monitor deployments** through GitHub and Azure portals

## 🤝 Contributing

Help improve this onboarding experience:

1. **Report issues** with the setup process
2. **Suggest improvements** for the automation scripts
3. **Share customizations** that work well for your projects
4. **Update documentation** based on your experience

## 📞 Support

For support:
1. **Check the troubleshooting section** above
2. **Use GitHub Copilot** for specific technical questions
3. **Create an issue** in this repository
4. **Contact your DevOps team** for organization-specific help

---

**Happy coding! 🚀**

*This guide is designed to work with GitHub Copilot for the best experience. Use the provided prompts to get contextual help throughout your development process.*
