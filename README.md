# Project Gengo

A comprehensive learning and demonstration repository for modern software development practices, featuring multi-language programming examples, CI/CD pipelines, infrastructure as code, and GitHub Copilot workflows.

## Overview

Project Gengo is a polyglot workspace designed to showcase best practices across the software development lifecycle. It includes examples for programming languages, DevOps automation, security analysis, database management, and AI-assisted development workflows.

## Repository Structure

### Programming Languages

- **`programming/`** - Multi-language code examples and projects
  - `c/` - C programming examples
  - `cpp/` - C++ projects with CMake configuration
  - `dotnet/` - .NET applications
  - `go/` - Go language examples
  - `java/` - Java projects
  - `javascript-html-css/` - Frontend web development
  - `node/` - Node.js applications
  - `python/` - Python scripts and projects
  - `typescript-html-css/` - TypeScript web applications

### DevOps & CI/CD

- **`cicd/`** - Continuous Integration and Deployment examples
- **`gitops/`** - GitOps workflows and documentation
  - Product requirements documents (PRDs)
  - GitHub Actions workflows
  - Azure DevOps pipelines
- **`.github/workflows/`** - GitHub Actions automation
- **`.azure-pipelines/`** - Azure DevOps pipeline definitions

### Infrastructure as Code

- **`iac/`** - Infrastructure automation
  - `arm/` - Azure Resource Manager templates
  - `bicep/` - Azure Bicep modules
  - `terraform/` - Terraform configurations

### Configuration Management

- **`cm/`** - Configuration management tools
  - `ansible/` - Ansible playbooks
  - `devbox/` - Development environment configurations

### Security & Analysis

- **`ghas/`** - GitHub Advanced Security workflows
  - CodeQL analysis scripts
  - Security analysis documentation
- **`codeql-db/`** - CodeQL database artifacts
- **`secrets-exclusion/`** - Secret scanning demonstrations
- **`secrets-inclusion/`** - Security testing examples

### Databases

- **`databases/`** - Database management examples
  - `kql/` - Kusto Query Language
  - `rdbms/` - Relational database scripts (PostgreSQL, Azure SQL)

### Features & Demos

- **`features/`** - Feature demonstrations
  - `code-completion/` - GitHub Copilot code completion examples
- **`custom-hackathon/`** - Hackathon demonstration projects
- **`mlops/`** - Machine Learning Operations examples

### Utilities & Scripts

- **`scripting/`** - Automation scripts
  - `azure-cli/` - Azure CLI examples
  - `bash/` - Shell scripts
  - `powershell/` - PowerShell automation
- **`cli/`** - Command-line interface tools
- **`lib/`** - Shared libraries

### Documentation

- **`.github/copilot-instructions.md`** - GitHub Copilot custom instructions
- **`.github/agents/`** - AI agent configurations
- **`prompt-engineering/`** - Prompt engineering examples
- **`SECURITY.md`** - Security policies
- **`LICENSE`** - MIT License

## Getting Started

### Prerequisites

Depending on the technology you want to explore:

- **Programming Languages**: Relevant compilers/runtimes (gcc, g++, Python, Node.js, .NET SDK, Go, JDK)
- **Azure**: Azure CLI, Azure subscription
- **DevOps**: Git, GitHub CLI, Azure DevOps CLI
- **IaC**: Terraform, Bicep CLI
- **Database**: PostgreSQL client, Azure Data Studio, sqlcmd
- **Build Tools**: CMake (for C/C++ projects)

### Quick Start

1. **Clone the repository**:

   ```pwsh
   git clone https://github.com/ms-mfg-community/project-gengo.git
   cd project-gengo
   ```

2. **Explore specific areas**:

   ```pwsh
   # Programming examples
   cd programming/python/workspace
   
   # CI/CD workflows
   cd gitops/workspace
   
   # Infrastructure as Code
   cd iac/bicep
   ```

3. **Build C++ projects**:

   ```pwsh
   mkdir build
   cd build
   cmake ..
   cmake --build .
   ```

4. **Python projects** (use virtual environments):

   ```pwsh
   python -m venv dev
   dev\Scripts\activate
   pip install -r requirements.txt
   ```

## GitHub Copilot Integration

This repository includes comprehensive GitHub Copilot instructions in `.github/copilot-instructions.md` that define:

- Coding standards and style guides
- Language-specific best practices
- Testing guidelines
- Documentation requirements
- Commit message format
- Security and error handling practices

### Custom Agents

- `.github/agents/readme-creator.agent.md` - Documentation specialist agent
- Additional agents for specialized tasks

## Key Features

- **Multi-Language Support**: Examples across 10+ programming languages
- **CI/CD Pipelines**: GitHub Actions and Azure DevOps workflows
- **Security Integration**: CodeQL analysis and secret scanning
- **IaC Templates**: Bicep, Terraform, and ARM templates
- **Database Examples**: SQL scripts for PostgreSQL and Azure SQL
- **AI-Assisted Development**: GitHub Copilot custom instructions and workflows

## Project Standards

### Commit Message Format

Use the **Topic Subtopic Activity** pattern:

```text
topic(subtopic): activity
```

Examples:

- `github(instructions): expand guideline details`
- `feat(auth): add login functionality`
- `fix(ui): correct button alignment`

### Coding Guidelines

- Prefer simple solutions
- Avoid code duplication
- Write environment-aware code (dev, test, prod)
- Keep files under 100-200 lines
- Write tests for major functionality
- Follow language-specific style guides (see `.github/copilot-instructions.md`)

## Project Documentation

- **Copilot Instructions**: [.github/copilot-instructions.md](.github/copilot-instructions.md)
- **Security Policy**: [SECURITY.md](SECURITY.md)
- **GitOps PRDs**: `gitops/prd-*.md`
- **Database Docs**: `databases/rdbms/*.md`

## Contributing

1. Follow the coding standards defined in `.github/copilot-instructions.md`
2. Use the specified commit message format
3. Write tests for new functionality
4. Update documentation as needed
5. Ensure all CI checks pass before submitting PRs

## Testing

Various testing frameworks are used depending on the language:

- **.NET**: xUnit
- **Java**: JUnit
- **TypeScript**: Vitest
- **Python**: pytest
- **Go**: Testify
- **Node.js**: Jest
- **C**: Unity
- **C++**: Google Test

## CI/CD Workflows

The repository includes example workflows for:

- Repository content listing and artifact management
- CodeQL security analysis
- Multi-language builds
- Azure resource deployment
- Dependabot automation

See `gitops/workspace/` and `.github/workflows/` for examples.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright (c) 2024 Preston K. Parsard

## Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Azure DevOps](https://azure.microsoft.com/en-us/products/devops/)
- [CodeQL](https://codeql.github.com/)
- [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)

## Contact

For questions or feedback about this repository, please open an issue.
