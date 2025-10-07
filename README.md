# Project Gengo

Welcome to **Project Gengo** - a comprehensive multi-language, multi-technology demonstration and learning repository focused on DevOps, GitOps, Infrastructure as Code (IaC), and modern software development practices.

## 🎯 Repository Overview

Project Gengo is a polyglot learning and demonstration repository that showcases:

- **DevOps & GitOps Practices**: CI/CD workflows, pipelines, and automation
- **Infrastructure as Code**: Azure deployments using Bicep, ARM templates, and Terraform
- **Multi-Language Development**: Examples in Python, TypeScript, JavaScript, C++, C#, Go, Java, and more
- **Security Best Practices**: CodeQL analysis, Dependabot, security scanning, and GHAS (GitHub Advanced Security)
- **Cloud Platform Integration**: Azure DevOps and GitHub Actions workflows

## 📂 Repository Structure

```
project-gengo/
├── .github/                    # GitHub configuration and workflows
│   ├── workflows/              # GitHub Actions workflows (15+ workflows)
│   ├── copilot-instructions.md # GitHub Copilot guidelines
│   └── scripts/                # Helper scripts for automation
├── .azure-pipelines/           # Azure DevOps pipeline definitions
├── cicd/                       # CI/CD related configurations
├── gitops/                     # GitOps workflows and documentation
│   ├── completed/              # Completed workflow examples
│   ├── workspace/              # Active workspace for workflows
│   └── *.md                    # PRDs and documentation
├── iac/                        # Infrastructure as Code
│   ├── bicep/                  # Azure Bicep templates (22 files)
│   ├── arm/                    # ARM templates
│   └── terraform/              # Terraform configurations
├── programming/                # Multi-language code examples
│   ├── python/                 # Python projects and examples
│   ├── typescript-html-css/    # TypeScript web applications
│   ├── javascript-html-css/    # JavaScript applications
│   ├── cpp/                    # C++ projects
│   ├── dotnet/                 # .NET/C# applications
│   ├── go/                     # Go language examples
│   ├── java/                   # Java applications
│   └── node/                   # Node.js projects
├── scripting/                  # Shell and automation scripts
│   ├── powershell/             # PowerShell scripts
│   ├── bash/                   # Bash scripts
│   └── azure-cli/              # Azure CLI scripts
├── databases/                  # Database examples
│   ├── kql/                    # Kusto Query Language
│   └── rdbms/                  # Relational database examples
├── ghas/                       # GitHub Advanced Security templates
├── mlops/                      # Machine Learning operations
└── prompt-engineering/         # AI prompt engineering examples
```

## 🛠️ Technology Stack

### Programming Languages (89 files)

- **Python**: 19 files - Flask APIs, data processing, automation
- **TypeScript**: 20 files - Modern web applications with type safety
- **JavaScript**: 21 files - Web development and browser-based apps
- **C++**: 10 files - System programming and performance-critical code
- **C#/.NET**: 12 files - Enterprise applications and services
- **C**: 4 files - Low-level system programming
- **Go**: 2 files - Modern microservices
- **Java**: 1 file - Enterprise applications

### Infrastructure & DevOps

- **Bicep Templates**: 22 Azure infrastructure templates
- **GitHub Actions**: 15+ workflow files for CI/CD
- **Azure DevOps**: Pipeline configurations
- **Docker**: Container configurations
- **CMake**: Build system for C/C++ projects

### Key Projects & Examples

#### 1. **GitOps Workflows & Pipelines**
   - Location: `gitops/`
   - Features: Azure deployment workflows, CodeQL analysis, dependency management
   - Documentation: `prd-workflows-and-pipelines.md`

#### 2. **Calculator Applications**
   - TypeScript/JavaScript: `programming/javascript-html-css/workspace/calculator/`
   - .NET/C#: `programming/dotnet/csharp/completed/src/calculon/`
   - Node.js: `programming/node/completed/calculator/`
   - Features: Multi-language support (German, Hindi, Japanese)

#### 3. **Inventory Management System (C++)**
   - Location: `programming/cpp/completed/inventory-management-system/`
   - Features: CMake build system, object-oriented design

#### 4. **Todo API (Python Flask)**
   - Location: `todo_api/` and `programming/python/workspace/todo_api/`
   - Features: RESTful API, Python Flask framework

#### 5. **Country Quiz (.NET/C#)**
   - Location: `programming/dotnet/csharp/completed/src/CountryQuiz/`
   - Features: xUnit testing, multiple implementations

## 🚀 Getting Started

### Prerequisites

- **Git**: For version control
- **Python 3.x**: For Python projects
- **Node.js & npm**: For JavaScript/TypeScript projects
- **.NET SDK**: For C# projects
- **CMake**: For C/C++ projects
- **Azure CLI**: For Azure deployments
- **PowerShell**: For automation scripts
- **Visual Studio Code**: Recommended IDE

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ms-mfg-community/project-gengo.git
   cd project-gengo
   ```

2. **Explore project areas:**
   ```bash
   # For Python projects
   cd programming/python/workspace/todo_api
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt

   # For TypeScript/JavaScript projects
   cd programming/javascript-html-css/workspace/calculator
   npm install
   npm run build

   # For C++ projects
   cd programming/cpp/completed/inventory-management-system
   mkdir build && cd build
   cmake ..
   make
   ```

3. **Review GitHub Actions workflows:**
   - Navigate to `.github/workflows/` to see CI/CD examples
   - Check `gitops/prd-workflows-and-pipelines.md` for workflow documentation

## 🔒 Security

This repository implements multiple security measures:

- **CodeQL Analysis**: Automated code scanning for vulnerabilities
- **Dependabot**: Automated dependency updates
- **Secret Scanning**: Prevention of credential exposure
- **Security Policy**: See [SECURITY.md](SECURITY.md) for vulnerability reporting

### Security Features

- Multiple CodeQL workflows for different languages
- GHAS (GitHub Advanced Security) integration
- Automated dependabot alerts and triage
- TFSec for Terraform security scanning
- Dependency review automation

## 📚 Documentation

### Product Requirements Documents (PRDs)

- **Workflows & Pipelines**: `gitops/prd-workflows-and-pipelines.md`
- **Calculator Development**: `programming/javascript-html-css/prd-calculator-development.md`
- **Master CI/CD**: `gitops/workspace/workflow-templates/prd-master-ci-cd-dotnet-appservices.md`

### Onboarding & Guides

- **Workflow Setup**: `gitops/workspace/workflow-templates/setup/onboarding-guide.md`
- **GitHub Copilot Instructions**: `.github/copilot-instructions.md`
- **CodeQL Queries**: `gitops/codeql-queries.md`

## 🤝 Contributing

This repository follows best practices for code quality and consistency:

1. **Code Style**: Follow language-specific style guides (see `.github/copilot-instructions.md`)
2. **Testing**: Write tests for all major functionality
3. **Documentation**: Update relevant documentation with changes
4. **Commit Messages**: Use conventional commit format: `type(scope): description`
5. **Pull Requests**: Ensure all CI checks pass before merging

### Development Workflow

- Branch naming: `feature/`, `bugfix/`, `docs/`
- All code changes require PR review
- Automated testing via GitHub Actions
- CodeQL security scanning on all PRs

## 🌍 Multi-Language Support

Project Gengo demonstrates internationalization with examples in:

- **English**: Primary documentation
- **German**: Code comments and documentation
- **Hindi**: Calculator UI and documentation
- **Japanese**: Application strings and comments

## 📋 Key Workflows

### GitHub Actions Workflows (`.github/workflows/`)

- `codeql.yml` - Code security analysis
- `01-level-workflow.yml` - Basic CI/CD demonstration
- `03-gaw-level-pipeline.yml` - Advanced pipeline example
- `gaw-iac-azure-deployment.yml` - Azure infrastructure deployment
- `auto-triage-dependabot-alerts.yml` - Automated dependency management
- `dependency-review.yml` - Dependency scanning

### Azure DevOps Pipelines (`.azure-pipelines/`)

- `01-azp-level-pipeline.yml` - Cross-platform CI/CD

## 🏗️ Infrastructure as Code

### Azure Bicep Examples

- Azure Monitor Private Link Scope (AMPLS)
- Storage Account deployments
- Container Registry configurations
- Deployment stack management

### Deployment Prerequisites

1. Azure subscription with appropriate permissions
2. Azure CLI and Bicep extension installed
3. GitHub environments configured (dev, prd)
4. Azure App Registration for OIDC authentication

## 📊 Project Statistics

- **Total Programming Files**: 89
- **Workflow Files**: 15+ GitHub Actions, 3+ Azure Pipelines
- **IaC Templates**: 22 Bicep files
- **Languages**: 8+ programming languages
- **Security Workflows**: 5+ automated security scans

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright (c) 2024 Preston K. Parsard

## 🔗 Additional Resources

- [GitHub Advanced Security Documentation](https://docs.github.com/en/code-security)
- [Azure Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [CodeQL Documentation](https://codeql.github.com/docs/)

## ❓ Support

For security vulnerabilities, please refer to [SECURITY.md](SECURITY.md).

For questions or issues:
- Open a GitHub issue
- Review existing documentation in `/gitops/` and `/programming/` directories
- Check workflow examples in `.github/workflows/`

---

**Note**: This is a learning and demonstration repository. Projects may be in various states of completion. Check individual project README files for specific setup instructions.
