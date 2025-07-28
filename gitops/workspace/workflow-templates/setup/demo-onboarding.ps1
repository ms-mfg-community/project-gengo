# .NET CI/CD Onboarding Demo Script
# This script demonstrates the complete workflow for onboarding a new .NET project

param(
    [Parameter(Mandatory = $false)]
    [string]$DemoRepo = "demo-dotnet-app",
    
    [Parameter(Mandatory = $false)]
    [string]$DemoOwner = "your-github-username",
    
    [Parameter(Mandatory = $false)]
    [switch]$ShowExamples
)

# Color output functions
function Write-Demo { param([string]$Message) Write-Host "🎬 $Message" -ForegroundColor Magenta }
function Write-Step { param([string]$Message) Write-Host "📝 $Message" -ForegroundColor Cyan }
function Write-Code { param([string]$Message) Write-Host "💻 $Message" -ForegroundColor Yellow }
function Write-Success { param([string]$Message) Write-Host "✅ $Message" -ForegroundColor Green }
function Write-Info { param([string]$Message) Write-Host "ℹ️  $Message" -ForegroundColor Blue }

function Show-OnboardingDemo {
    Write-Demo "Welcome to the .NET CI/CD Onboarding Demo!"
    Write-Host ""
    
    Write-Step "Step 1: Prerequisites Check"
    Write-Code "gh auth status"
    Write-Code "git --version"
    Write-Code "az --version"
    Write-Info "Ensure all tools are installed and authenticated"
    Write-Host ""
    
    Write-Step "Step 2: Environment Setup"
    Write-Code "cp .env.template .env"
    Write-Code "# Edit .env with your Azure and GitHub details"
    Write-Info "Fill in Azure service principal credentials and resource names"
    Write-Host ""
    
    Write-Step "Step 3: Repository Preparation"
    Write-Code "git init"
    Write-Code "git remote add origin https://github.com/$DemoOwner/$DemoRepo.git"
    Write-Info "Initialize your .NET project repository"
    Write-Host ""
    
    Write-Step "Step 4: Automated Setup"
    Write-Code ".\setup\complete-setup.ps1 -Owner `"$DemoOwner`" -Repo `"$DemoRepo`""
    Write-Info "This will configure:"
    Write-Host "  • GitHub environments (dev, qa, prod)"
    Write-Host "  • Repository and environment secrets"
    Write-Host "  • Branch protection rules"
    Write-Host "  • Workflow files"
    Write-Host ""
    
    Write-Step "Step 5: Manual Configuration"
    Write-Code "# Add publish profiles to environment secrets"
    Write-Code "gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<profile_xml>`" --env dev"
    Write-Code "gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<profile_xml>`" --env qa"
    Write-Code "gh secret set AZURE_WEBAPP_PUBLISH_PROFILE --body `"<profile_xml>`" --env prod"
    Write-Info "Configure reviewers in GitHub UI for qa and prod environments"
    Write-Host ""
    
    Write-Step "Step 6: First Deployment Test"
    Write-Code "git add ."
    Write-Code "git commit -m `"feat: initial CI/CD setup`""
    Write-Code "git push origin main"
    Write-Info "This will trigger your first workflow run"
    Write-Host ""
    
    Write-Success "Setup Complete! Your .NET CI/CD pipeline is ready to use."
    Write-Host ""
    
    Write-Info "Next steps:"
    Write-Host "• Monitor workflows: https://github.com/$DemoOwner/$DemoRepo/actions"
    Write-Host "• Review environments: https://github.com/$DemoOwner/$DemoRepo/settings/environments"
    Write-Host "• Customize workflows using GitHub Copilot"
    Write-Host ""
}

function Show-CopilotPrompts {
    Write-Demo "GitHub Copilot Integration Examples"
    Write-Host ""
    
    Write-Step "Prompt 1: Initial Setup Help"
    Write-Code @"
I need to set up a .NET CI/CD pipeline using GitHub Actions. Please help me:

1. Review my workflow configuration for best practices
2. Customize deployment steps for my Azure App Service
3. Add environment-specific application settings
4. Configure monitoring and alerting

Project Details:
- Framework: .NET 6/7/8
- Target: Azure App Service
- Environments: dev, qa, prod
- Repository: $DemoOwner/$DemoRepo
"@
    Write-Host ""
    
    Write-Step "Prompt 2: Workflow Customization"
    Write-Code @"
Help me customize my .NET deployment workflow:

1. Add SonarQube code quality checks
2. Include Entity Framework database migrations
3. Configure blue-green deployment for production
4. Add Slack notifications for deployment status

Current workflow: .github/workflows/ci-cd-dotnet.yaml
Target environment: Azure App Service
"@
    Write-Host ""
    
    Write-Step "Prompt 3: Troubleshooting"
    Write-Code @"
My .NET CI/CD pipeline is failing. Please help me troubleshoot:

1. Analyze the workflow error logs
2. Check Azure App Service configuration
3. Verify secrets and variables are set correctly
4. Suggest fixes for common deployment issues

Error message: [paste your error here]
Workflow run: [paste workflow URL here]
Environment: [development/qa/production]
"@
    Write-Host ""
    
    Write-Step "Prompt 4: Advanced Features"
    Write-Code @"
I want to add advanced features to my .NET CI/CD pipeline:

1. Multi-stage deployments with smoke tests
2. Automatic rollback on health check failures
3. Performance testing integration
4. Security scanning with CodeQL

Current setup: GitHub Actions + Azure App Service
Application: .NET 6 web API with Entity Framework
"@
    Write-Host ""
}

function Show-FileStructure {
    Write-Demo "Project Structure After Setup"
    Write-Host ""
    
    Write-Code @"
your-dotnet-project/
├── .github/
│   └── workflows/
│       ├── ci-cd-dotnet.yaml          # Main CI/CD workflow
│       └── deploy-child.yaml          # Reusable deployment workflow
├── src/                               # Your .NET application
│   ├── YourApp.csproj
│   ├── Program.cs
│   └── Controllers/
├── tests/                             # Unit and integration tests
│   └── YourApp.Tests.csproj
├── .env                               # Environment variables (not committed)
├── .gitignore                         # Git ignore rules
├── README.md                          # Project documentation
└── appsettings.json                   # Application configuration
"@
    Write-Host ""
}

function Show-WorkflowExamples {
    Write-Demo "Workflow Customization Examples"
    Write-Host ""
    
    Write-Step "Example 1: Add Code Quality Checks"
    Write-Code @"
# Add this to your workflow after the build step
- name: Run Code Analysis
  uses: github/super-linter@v4
  env:
    DEFAULT_BRANCH: main
    GITHUB_TOKEN: `${{ secrets.GITHUB_TOKEN }}
    VALIDATE_CSHARP: true
    VALIDATE_DOCKERFILE: true
"@
    Write-Host ""
    
    Write-Step "Example 2: Database Migrations"
    Write-Code @"
# Add this before deployment
- name: Run Database Migrations
  run: |
    dotnet ef database update --project src/YourApp.csproj
  env:
    ConnectionStrings__DefaultConnection: `${{ secrets.DATABASE_CONNECTION_STRING }}
"@
    Write-Host ""
    
    Write-Step "Example 3: Smoke Tests"
    Write-Code @"
# Add this after deployment
- name: Run Smoke Tests
  run: |
    # Wait for app to be ready
    Start-Sleep -Seconds 30
    
    # Test health endpoint
    `$response = Invoke-RestMethod -Uri "https://`${{ vars.AZURE_WEBAPP_NAME }}.azurewebsites.net/health"
    if (`$response.status -ne "Healthy") {
      throw "Health check failed"
    }
"@
    Write-Host ""
}

function Show-BestPractices {
    Write-Demo "Best Practices for .NET CI/CD"
    Write-Host ""
    
    Write-Step "Security Best Practices"
    Write-Host "• Use GitHub secrets for sensitive data"
    Write-Host "• Implement least-privilege service principals"
    Write-Host "• Enable branch protection rules"
    Write-Host "• Regular secret rotation"
    Write-Host "• Audit deployment logs"
    Write-Host ""
    
    Write-Step "Performance Optimization"
    Write-Host "• Cache NuGet packages"
    Write-Host "• Use multi-stage builds"
    Write-Host "• Parallel test execution"
    Write-Host "• Optimize Docker images"
    Write-Host "• Monitor build times"
    Write-Host ""
    
    Write-Step "Reliability Guidelines"
    Write-Host "• Implement proper error handling"
    Write-Host "• Add retry logic for deployments"
    Write-Host "• Use health checks"
    Write-Host "• Set up monitoring and alerting"
    Write-Host "• Plan for rollback scenarios"
    Write-Host ""
    
    Write-Step "Development Workflow"
    Write-Host "• Use feature branches"
    Write-Host "• Require code reviews"
    Write-Host "• Automate testing"
    Write-Host "• Environment parity"
    Write-Host "• Continuous integration"
    Write-Host ""
}

function Show-TroubleshootingGuide {
    Write-Demo "Common Issues and Solutions"
    Write-Host ""
    
    Write-Step "Issue 1: GitHub CLI Authentication"
    Write-Code "gh auth login --web"
    Write-Code "gh auth status"
    Write-Info "Ensure you have repo, admin:org, and workflow scopes"
    Write-Host ""
    
    Write-Step "Issue 2: Azure Authentication"
    Write-Code "az login --service-principal -u `$CLIENT_ID -p `$CLIENT_SECRET --tenant `$TENANT_ID"
    Write-Code "az account show"
    Write-Info "Verify service principal has Contributor role"
    Write-Host ""
    
    Write-Step "Issue 3: Workflow Syntax Errors"
    Write-Info "Use VS Code with GitHub Actions extension"
    Write-Code "# GitHub Copilot prompt:"
    Write-Code "# 'Check my workflow syntax for errors and suggest fixes'"
    Write-Host ""
    
    Write-Step "Issue 4: Deployment Failures"
    Write-Info "Check Azure App Service logs:"
    Write-Code "az webapp log tail --name `$WEBAPP_NAME --resource-group `$RESOURCE_GROUP"
    Write-Code "# Or use GitHub Copilot to analyze error logs"
    Write-Host ""
}

# Main execution
if ($ShowExamples) {
    Show-OnboardingDemo
    Show-CopilotPrompts
    Show-FileStructure
    Show-WorkflowExamples
    Show-BestPractices
    Show-TroubleshootingGuide
} else {
    Write-Demo "This is a demonstration script for .NET CI/CD onboarding"
    Write-Host ""
    Write-Info "Usage:"
    Write-Code ".\demo-onboarding.ps1 -ShowExamples"
    Write-Host ""
    Write-Info "Or run individual sections:"
    Write-Code ".\demo-onboarding.ps1 -DemoRepo 'your-repo' -DemoOwner 'your-username'"
    Write-Host ""
    Write-Info "For actual setup, use:"
    Write-Code ".\setup\complete-setup.ps1 -Owner 'your-username' -Repo 'your-repo'"
    Write-Host ""
}

# end script
