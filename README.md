# Project Gengo

A comprehensive, multi-technology learning and demonstration repository featuring practical examples, best practices, and hands-on implementations across multiple programming languages, frameworks, and cloud platforms.

**Authored by:** Preston K. Parsard

**License:** MIT

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Featured Projects](#featured-projects)
- [Programming Languages](#programming-languages)
- [Key Features](#key-features)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

---

## Overview

Project Gengo is a diverse, full-stack learning repository that demonstrates industry best practices across multiple technology domains. Whether you're exploring cloud infrastructure as code, building applications in different programming languages, implementing CI/CD workflows, or diving into AI/GenAI topics, this repository provides working examples and detailed documentation.

### Purpose

This repository serves as:

- **Learning Resource:** Examples and tutorials for various technologies and frameworks.
- **Demonstration Platform:** Proof-of-concept implementations for complex scenarios.
- **Best Practices Guide:** Code organization, testing patterns, and deployment strategies.
- **Reference Repository:** Custom instructions, configuration templates, and automation scripts.

---

## Repository Structure

### Core Technology Areas

```text
programming/          # Multi-language programming examples
├── c/                 # C language projects
├── cpp/               # C++ applications
├── dotnet/            # .NET/C# projects
├── go/                # Go applications
├── java/              # Java projects
├── javascript-html-css/    # JavaScript/Web development
├── node/              # Node.js applications
├── python/            # Python scripts and projects
└── typescript-react/       # React/TypeScript applications
```

### Specialized Domains

| Folder | Purpose |
|--------|---------|
| `genai/` | Generative AI and LLM demonstrations |
| `ghas/` | GitHub Advanced Security (CodeQL analysis) |
| `gitops/` | GitOps workflows and infrastructure |
| `iac/` | Infrastructure as Code (ARM, Bicep, Terraform) |
| `mlops/` | Machine Learning operations |
| `cicd/` | CI/CD pipeline patterns and workflows |
| `databases/` | Database examples (KQL, RDBMS) |
| `scripting/` | Cross-platform scripting (PowerShell, Bash, Azure CLI) |

### Configuration & Infrastructure

| Folder | Purpose |
|--------|---------|
| `.github/` | GitHub Actions workflows, custom agents, and instructions |
| `.azure/` | Azure DevOps configurations |
| `.devcontainer/` | Development container setup |
| `iac/` | Infrastructure deployment templates |
| `.vscode/` | VS Code settings and configurations |

---

## Quick Start

### Prerequisites

- Git
- Your preferred programming language runtime(s)
- VS Code (recommended) with extensions for your technology stack
- For cloud examples: Azure CLI, Azure Bicep CLI, or AWS CLI

### Clone the Repository

```bash
git clone https://github.com/ms-mfg-community/project-gengo.git
cd project-gengo
```

### Explore a Specific Technology

Navigate to your area of interest:

```bash
# Python examples
cd programming/python

# .NET/C# projects
cd programming/dotnet

# Infrastructure as Code
cd iac

# GenAI demonstrations
cd genai
```

Each folder contains its own documentation and examples.

---

## Featured Projects

### Calculator Application

A full-featured calculator demonstration across multiple frameworks:

- **Calculator.Core:** Core calculation engine.
- **calculator.tests:** Unit tests using xUnit.
- **CalculatorBlazor:** Blazor WebAssembly UI.
- **C++ Implementation:** CMake-based build.

Located in:

- `calculator/` - Main .NET console app.
- `Calculator.Core/` - Shared library.
- `calculator.tests/` - Test suite.
- `CalculatorBlazor/` - Web UI.
- `programming/cpp/` - C++ version.

### Infrastructure as Code

Complete examples for cloud infrastructure deployment:

- **Bicep:** Azure Resource Manager templates.
- **ARM Templates:** Native Azure deployments.
- **Terraform:** Multi-cloud infrastructure.
- **Azure DevOps Pipelines:** Deployment automation.

See: [.github/agents/](.github/agents/) and [iac/](iac/).

### GitHub Advanced Security

CodeQL analysis, security scanning, and vulnerability detection:

- Custom CodeQL queries.
- Security policy templates.
- Dependency analysis workflows.

See: [ghas/](ghas/).

### CI/CD & GitOps

Workflow automation and infrastructure management:

- GitHub Actions workflows.
- Azure DevOps pipelines.
- GitOps patterns with infrastructure sync.

See: [gitops/](gitops/) and [cicd/](cicd/).

---

## Programming Languages

The repository includes examples and projects in:

| Language | Folder | Notable Features |
|----------|--------|------------------|
| **C** | programming/c/ | Systems programming patterns |
| **C++** | programming/cpp/ | Modern C++17 with CMake |
| **.NET/C#** | programming/dotnet/ | Full-stack examples, Blazor |
| **Go** | programming/go/ | Concurrent patterns, CLI tools |
| **Java** | programming/java/ | Enterprise patterns, Maven builds |
| **JavaScript** | programming/javascript-html-css/ | Web fundamentals |
| **Node.js** | programming/node/ | Backend services, APIs |
| **Python** | programming/python/ | Data processing, automation, AI |
| **TypeScript** | programming/typescript-* | Type-safe web development |

---

## Key Features

### GitHub Copilot Integration

Custom instructions and agents for enhanced development:

- **Copilot Instructions:** Best practices for all project types.
- **Custom Agents:** Specialized assistants for different tasks:
  - README Creator
  - Code Reviewer
  - Debugging Tutor
  - Testing Automation
  - And more

See: [.github/copilot-instructions.md](.github/copilot-instructions.md).

### Testing & Quality

- Unit testing frameworks for multiple languages.
- Integration test patterns.
- CodeQL security analysis.
- Code coverage tracking.

### DevOps & Automation

- GitHub Actions workflows.
- Azure DevOps pipeline definitions.
- Infrastructure automation.
- Deployment strategies.

### Documentation

- Comprehensive inline code documentation.
- Markdown-linted documentation files.
- API documentation examples.
- Architecture decision records (ADRs).

---

## Getting Started

### For Beginners

1. Choose a technology that interests you.
2. Navigate to the corresponding folder in `programming/`.
3. Look for a `README.md` or `GETTING_STARTED.md` file.
4. Follow the setup instructions.

### For Advanced Users

1. Review the infrastructure templates in `iac/`.
2. Explore the CI/CD workflows in `.github/workflows/`.
3. Check the custom Copilot agents in `.github/agents/`.
4. Examine the best practices in `.github/instructions/`.

### For Cloud Practitioners

- **Azure Users:** See `iac/bicep/` and `.azure-pipelines/`.
- **Infrastructure Automation:** Review `iac/` for Terraform and ARM templates.
- **Security:** Check `ghas/` for security scanning examples.

### For AI/ML Developers

- **GenAI:** Explore `genai/` for LLM demonstrations.
- **MLOps:** See `mlops/` for machine learning workflows.

---

## Contributing

Contributions are welcome! Please follow these guidelines:

1. **Respect the Repository Structure:** Add code to appropriate language/domain folders.
2. **Follow Coding Standards:** Adhere to language-specific style guides (see `.github/copilot-instructions.md`).
3. **Write Tests:** Include unit tests for new functionality.
4. **Document Your Work:** Add meaningful comments and update relevant README files.
5. **Keep Files Focused:** Aim for 100-200 lines per file; refactor if exceeding this.
6. **Commit Messages:** Use the format: `topic(subtopic): description`.

For detailed contribution guidelines, see [SECURITY.md](SECURITY.md).

### Development Setup

- Use VS Code with the recommended extensions.
- Set up dev containers for consistent environments: `.devcontainer/`.
- Follow the custom Copilot instructions: `.github/copilot-instructions.md`.
- Use the appropriate testing framework for your language.

---

## Security

This repository follows security best practices including:

- Secrets scanning and exclusion patterns.
- Dependency vulnerability management with Dependabot.
- CodeQL static analysis.
- Branch protection rules.
- Required status checks for pull requests.

For security concerns, please refer to [SECURITY.md](SECURITY.md).

---

## Technology Stack Overview

### Cloud & Infrastructure

- **Azure:** Resource Manager, Bicep, Terraform.
- **Azure DevOps:** Pipelines, Repositories.
- **GitHub:** Actions, Advanced Security.
- **Infrastructure as Code:** Bicep, ARM, Terraform.

### Web & Frontend

- **Frameworks:** React, Blazor, Vue, Angular.
- **Languages:** TypeScript, JavaScript, C#.
- **Styling:** CSS, Tailwind, Bootstrap.

### Backend & Services

- **Runtimes:** .NET, Node.js, Go, Python, Java.
- **Patterns:** REST APIs, gRPC, microservices.
- **Databases:** SQL Server, PostgreSQL, SQLite.

### DevOps & Automation

- **CI/CD:** GitHub Actions, Azure Pipelines.
- **Scripting:** PowerShell, Bash, Python.
- **Configuration Management:** Ansible.

### AI & Machine Learning

- **Frameworks:** OpenAI, LangChain, Hugging Face.
- **Operations:** MLOps patterns, model deployment.
- **Analytics:** Data processing, analysis.

---

## Directory Quick Reference

```text
project-gengo/
├── programming/          # Multi-language examples
├── genai/               # AI/LLM demonstrations
├── ghas/                # Security & CodeQL
├── gitops/              # GitOps workflows
├── iac/                 # Infrastructure as Code
├── mlops/               # ML operations
├── cicd/                # CI/CD patterns
├── databases/           # Database examples
├── scripting/           # Cross-platform scripts
├── .github/             # GitHub configuration & workflows
├── .azure-pipelines/    # Azure DevOps pipelines
├── .devcontainer/       # Dev container setup
├── calculator*/         # Calculator app demonstrations
└── README.md            # This file
```

---

## Resources & Documentation

- [GitHub Copilot Custom Instructions](.github/copilot-instructions.md)
- [Security Policy](SECURITY.md)
- [MIT License](LICENSE)
- [GitHub Actions Workflows](.github/workflows/)
- [Infrastructure Templates](iac/)
- [Programming Examples](programming/)

---

## Support & Questions

For questions, issues, or suggestions:

1. Check existing documentation in relevant folders.
2. Review the [GitHub Discussions](https://github.com/ms-mfg-community/project-gengo/discussions).
3. Search for similar issues.
4. Create a new issue with detailed context.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Last Updated:** January 2026

**Repository:** [project-gengo](https://github.com/ms-mfg-community/project-gengo)

**Owner:** [ms-mfg-community](https://github.com/ms-mfg-community)


# Project Gengo

A comprehensive, multi-technology learning and demonstration repository featuring practical examples, best practices, and hands-on implementations across multiple programming languages, frameworks, and cloud platforms.

**Authored by:** Preston K. Parsard  
**License:** MIT

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Featured Projects](#featured-projects)
- [Programming Languages](#programming-languages)
- [Key Features](#key-features)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

---

## Overview

Project Gengo is a diverse, full-stack learning repository that demonstrates industry best practices across multiple technology domains. Whether you're exploring cloud infrastructure as code, building applications in different programming languages, implementing CI/CD workflows, or diving into AI/GenAI topics, this repository provides working examples and detailed documentation.

### Purpose

This repository serves as:

- **Learning Resource:** Examples and tutorials for various technologies and frameworks
- **Demonstration Platform:** Proof-of-concept implementations for complex scenarios
- **Best Practices Guide:** Code organization, testing patterns, and deployment strategies
- **Reference Repository:** Custom instructions, configuration templates, and automation scripts

---

## Repository Structure

### Core Technology Areas

```
programming/          # Multi-language programming examples
├── c/               # C language projects
├── cpp/             # C++ applications
├── dotnet/          # .NET/C# projects
├── go/              # Go applications
├── java/            # Java projects
├── javascript-html-css/    # JavaScript/Web development
├── node/            # Node.js applications
├── python/          # Python scripts and projects
├── typescript-html-css/    # TypeScript/Web development
└── typescript-react/       # React/TypeScript applications
```

### Specialized Domains

| Folder | Purpose |
|--------|---------|
| `genai/` | Generative AI and LLM demonstrations |
| `ghas/` | GitHub Advanced Security (CodeQL analysis) |
| `gitops/` | GitOps workflows and infrastructure |
| `iac/` | Infrastructure as Code (ARM, Bicep, Terraform) |
| `mlops/` | Machine Learning operations |
| `cicd/` | CI/CD pipeline patterns and workflows |
| `databases/` | Database examples (KQL, RDBMS) |
| `scripting/` | Cross-platform scripting (PowerShell, Bash, Azure CLI) |

### Configuration & Infrastructure

| Folder | Purpose |
|--------|---------|
| `.github/` | GitHub Actions workflows, custom agents, and instructions |
| `.azure/` | Azure DevOps configurations |
| `.devcontainer/` | Development container setup |
| `iac/` | Infrastructure deployment templates |
| `.vscode/` | VS Code settings and configurations |

---

## Quick Start

### Prerequisites

- Git
- Your preferred programming language runtime(s)
- VS Code (recommended) with extensions for your technology stack
- For cloud examples: Azure CLI, Azure bicep CLI, or AWS CLI

### Clone the Repository

```bash
git clone https://github.com/ms-mfg-community/project-gengo.git
cd project-gengo
```

### Explore a Specific Technology

Navigate to your area of interest:

```bash
# Python examples
cd programming/python

# .NET/C# projects
cd programming/dotnet

# Infrastructure as Code
cd iac

# GenAI demonstrations
cd genai
```

Each folder contains its own documentation and examples.

---

## Featured Projects

### Calculator Application

A full-featured calculator demonstration across multiple frameworks:

- **Calculator.Core:** Core calculation engine
- **calculator.tests:** Unit tests using xUnit
- **CalculatorBlazor:** Blazor WebAssembly UI
- **C++ Implementation:** CMake-based build

Located in:
- `calculator/` - Main .NET console app
- `Calculator.Core/` - Shared library
- `calculator.tests/` - Test suite
- `CalculatorBlazor/` - Web UI
- `programming/cpp/` - C++ version

### Infrastructure as Code

Complete examples for cloud infrastructure deployment:

- **Bicep:** Azure Resource Manager templates
- **ARM Templates:** Native Azure deployments
- **Terraform:** Multi-cloud infrastructure
- **Azure DevOps Pipelines:** Deployment automation

See: [`iac/`](iac/)

### GitHub Advanced Security

CodeQL analysis, security scanning, and vulnerability detection:

- Custom CodeQL queries
- Security policy templates
- Dependency analysis workflows

See: [`ghas/`](ghas/)

### CI/CD & GitOps

Workflow automation and infrastructure management:

- GitHub Actions workflows
- Azure DevOps pipelines
- GitOps patterns with infrastructure sync

See: [`gitops/`](gitops/) and [`cicd/`](cicd/)

---

## Programming Languages

The repository includes examples and projects in:

| Language | Folder | Notable Features |
|----------|--------|------------------|
| **C** | `programming/c/` | Systems programming patterns |
| **C++** | `programming/cpp/` | Modern C++17 with CMake |
| **.NET/C#** | `programming/dotnet/` | Full-stack examples, Blazor |
| **Go** | `programming/go/` | Concurrent patterns, CLI tools |
| **Java** | `programming/java/` | Enterprise patterns, Maven builds |
| **JavaScript** | `programming/javascript-html-css/` | Web fundamentals |
| **Node.js** | `programming/node/` | Backend services, APIs |
| **Python** | `programming/python/` | Data processing, automation, AI |
| **TypeScript** | `programming/typescript-*` | Type-safe web development |

---

## Key Features

### GitHub Copilot Integration

Custom instructions and agents for enhanced development:

- **Copilot Instructions:** Best practices for all project types
- **Custom Agents:** Specialized assistants for different tasks
  - README Creator
  - Code Reviewer
  - Debugging Tutor
  - Testing Automation
  - And more

See: [`.github/copilot-instructions.md`](.github/copilot-instructions.md)

### Testing & Quality

- Unit testing frameworks for multiple languages
- Integration test patterns
- CodeQL security analysis
- Code coverage tracking

### DevOps & Automation

- GitHub Actions workflows
- Azure DevOps pipeline definitions
- Infrastructure automation
- Deployment strategies

### Documentation

- Comprehensive inline code documentation
- Markdown-linted documentation files
- API documentation examples
- Architecture decision records (ADRs)

---

## Getting Started

### For Beginners

1. Choose a technology that interests you
2. Navigate to the corresponding folder in `programming/`
3. Look for a `README.md` or `GETTING_STARTED.md` file
4. Follow the setup instructions

### For Advanced Users

1. Review the infrastructure templates in `iac/`
2. Explore the CI/CD workflows in `.github/workflows/`
3. Check the custom Copilot agents in `.github/agents/`
4. Examine the best practices in `.github/instructions/`

### For Cloud Practitioners

- **Azure Users:** See `iac/bicep/` and `.azure-pipelines/`
- **Infrastructure Automation:** Review `iac/` for Terraform and ARM templates
- **Security:** Check `ghas/` for security scanning examples

### For AI/ML Developers

- **GenAI:** Explore `genai/` for LLM demonstrations
- **MLOps:** See `mlops/` for machine learning workflows

---

## Contributing

Contributions are welcome! Please follow these guidelines:

1. **Respect the Repository Structure:** Add code to appropriate language/domain folders
2. **Follow Coding Standards:** Adhere to language-specific style guides (see `.github/copilot-instructions.md`)
3. **Write Tests:** Include unit tests for new functionality
4. **Document Your Work:** Add meaningful comments and update relevant README files
5. **Keep Files Focused:** Aim for 100-200 lines per file; refactor if exceeding this
6. **Commit Messages:** Use the format: `topic(subtopic): description`

For detailed contribution guidelines, see [SECURITY.md](SECURITY.md).

### Development Setup

- Use VS Code with the recommended extensions
- Set up dev containers for consistent environments: `.devcontainer/`
- Follow the custom Copilot instructions: `.github/copilot-instructions.md`
- Use the appropriate testing framework for your language

---

## Security

This repository follows security best practices including:

- Secrets scanning and exclusion patterns
- Dependency vulnerability management with Dependabot
- CodeQL static analysis
- Branch protection rules
- Required status checks for pull requests

For security concerns, please refer to [SECURITY.md](SECURITY.md).

---

## Technology Stack Overview

### Cloud & Infrastructure

- **Azure:** Resource Manager, Bicep, Terraform
- **Azure DevOps:** Pipelines, Repositories
- **GitHub:** Actions, Advanced Security
- **Infrastructure as Code:** Bicep, ARM, Terraform

### Web & Frontend

- **Frameworks:** React, Blazor, Vue, Angular
- **Languages:** TypeScript, JavaScript, C#
- **Styling:** CSS, Tailwind, Bootstrap

### Backend & Services

- **Runtimes:** .NET, Node.js, Go, Python, Java
- **Patterns:** REST APIs, gRPC, microservices
- **Databases:** SQL Server, PostgreSQL, SQLite

### DevOps & Automation

- **CI/CD:** GitHub Actions, Azure Pipelines
- **Scripting:** PowerShell, Bash, Python
- **Configuration Management:** Ansible

### AI & Machine Learning

- **Frameworks:** OpenAI, LangChain, Hugging Face
- **Operations:** MLOps patterns, model deployment
- **Analytics:** Data processing, analysis

---

## Directory Quick Reference

```
project-gengo/
├── programming/          # Multi-language examples
├── genai/               # AI/LLM demonstrations
├── ghas/                # Security & CodeQL
├── gitops/              # GitOps workflows
├── iac/                 # Infrastructure as Code
├── mlops/               # ML operations
├── cicd/                # CI/CD patterns
├── databases/           # Database examples
├── scripting/           # Cross-platform scripts
├── .github/             # GitHub configuration & workflows
├── .azure-pipelines/    # Azure DevOps pipelines
├── .devcontainer/       # Dev container setup
├── calculator*/         # Calculator app demonstrations
└── README.md            # This file
```

---

## Resources & Documentation

- [GitHub Copilot Custom Instructions](.github/copilot-instructions.md)
- [Security Policy](SECURITY.md)
- [MIT License](LICENSE)
- [GitHub Actions Workflows](.github/workflows/)
- [Infrastructure Templates](iac/)
- [Programming Examples](programming/)

---

## Support & Questions

For questions, issues, or suggestions:

1. Check existing documentation in relevant folders
2. Review the [GitHub Discussions](https://github.com/ms-mfg-community/project-gengo/discussions)
3. Search for similar issues
4. Create a new issue with detailed context

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Last Updated:** January 2026  
**Repository:** [project-gengo](https://github.com/ms-mfg-community/project-gengo)  
**Owner:** [ms-mfg-community](https://github.com/ms-mfg-community)
