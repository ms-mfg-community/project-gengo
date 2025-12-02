# Project Gengo

A comprehensive learning and demonstration workspace for GitHub Copilot, featuring multi-language development examples, DevOps automation, and infrastructure as code implementations.

## Overview

Project Gengo serves as a centralized repository for exploring GitHub Copilot capabilities across various programming languages, frameworks, and DevOps tools. This workspace includes practical examples, workflows, and best practices for AI-assisted development.

## Features

- **Multi-Language Programming Examples**: C, C++, C#, Go, Java, JavaScript, Node.js, Python, and TypeScript
- **Infrastructure as Code**: Bicep, Terraform, and ARM templates for Azure deployments
- **CI/CD Workflows**: GitHub Actions and Azure DevOps pipeline configurations
- **Security Integration**: GitHub Advanced Security (GHAS) and CodeQL analysis examples
- **Database Development**: PostgreSQL, Azure SQL, and KQL query examples
- **Configuration Management**: Ansible playbooks and DevBox configurations
- **MLOps Demonstrations**: Machine learning operations and workflows

## Project Structure

```text
project-gengo/
├── cicd/                   # CI/CD workflows and pipeline demonstrations
├── programming/            # Multi-language code examples
│   ├── c/                 # C programming examples
│   ├── cpp/               # C++ programming examples
│   ├── dotnet/            # .NET applications
│   ├── go/                # Go programming examples
│   ├── java/              # Java applications
│   ├── javascript-html-css/  # Frontend web development
│   ├── node/              # Node.js applications
│   ├── python/            # Python scripts and projects
│   └── typescript-html-css/  # TypeScript frontend examples
├── iac/                   # Infrastructure as Code
│   ├── bicep/            # Azure Bicep templates
│   ├── terraform/        # Terraform configurations
│   └── arm/              # ARM templates
├── gitops/               # GitOps workflows and best practices
├── ghas/                 # GitHub Advanced Security examples
├── databases/            # Database scripts and queries
│   ├── rdbms/           # Relational database examples
│   └── kql/             # Kusto Query Language examples
├── scripting/            # Utility scripts
│   ├── powershell/      # PowerShell automation scripts
│   ├── bash/            # Bash shell scripts
│   └── azure-cli/       # Azure CLI examples
├── mlops/                # Machine Learning operations
└── cm/                   # Configuration management
    ├── ansible/         # Ansible playbooks
    └── devbox/          # Development environment configs
```

## Getting Started

### Prerequisites

- Git
- GitHub account with Copilot access
- Development tools for your target language (compilers, runtimes, SDKs)
- Azure CLI (for Azure-related examples)
- Docker (optional, for containerized examples)

### Clone the Repository

```powershell
git clone https://github.com/ms-mfg-community/project-gengo.git
cd project-gengo
```

### Explore Examples

Navigate to the specific directory for the technology you want to explore:

```powershell
# For Python examples
cd programming/python

# For CI/CD workflows
cd cicd/workspace

# For Infrastructure as Code
cd iac/bicep
```

## Usage

Each subdirectory contains its own `prompts.txt` or README with specific instructions and examples. Follow the guidelines in [`.github/copilot-instructions.md`](.github/copilot-instructions.md) for consistent development practices.

### Working with GitHub Copilot

This repository is optimized for GitHub Copilot usage:

1. **Custom Instructions**: Review `.github/copilot-instructions.md` for project-specific guidelines
2. **Agent Modes**: Utilize custom agent modes in `.github/agents/` for specialized tasks
3. **Code Style**: Follow language-specific style guides documented in copilot instructions
4. **Testing**: Write tests alongside feature development using recommended frameworks

### Language-Specific Setup

#### Python

```powershell
# Create virtual environment
python -m venv dev
dev\Scripts\activate
pip install -r requirements.txt
```

#### C/C++

```powershell
# Build using CMake
cmake -B build
cmake --build build
```

#### Node.js/TypeScript

```powershell
npm install
npm run build
npm test
```

## CI/CD Integration

The repository includes examples for:

- **GitHub Actions**: Workflow files in `.github/workflows/`
- **Azure DevOps**: Pipeline definitions in `cicd/workspace/`
- **CodeQL Analysis**: Security scanning configurations

## Security

- Security policies are documented in [`SECURITY.md`](SECURITY.md)
- CodeQL analysis results are stored in `codeql-results.sarif`
- Sensitive data exclusion patterns are configured in `secrets-exclusion/`

## Contributing

Contributions are welcome! Please:

1. Review the coding guidelines in `.github/copilot-instructions.md`
2. Follow the commit message format: `topic(subtopic): activity`
3. Write tests for new functionality
4. Ensure all CI checks pass
5. Submit a pull request with a clear description

## Development Workflow

1. Create a feature branch: `git checkout -b feature/your-feature-name`
2. Make changes following project guidelines
3. Test your changes thoroughly
4. Commit with descriptive messages
5. Push and create a pull request

## Testing

Testing frameworks vary by language:

- **.NET**: xUnit
- **Python**: pytest
- **TypeScript**: Vitest
- **Java**: JUnit
- **Go**: Testify
- **C++**: Google Test

Run tests from their respective directories following language-specific instructions.

## Documentation

- **Project Guidelines**: `.github/copilot-instructions.md`
- **Product Requirements**: PRD documents in feature directories
- **API Documentation**: Generated in respective language folders
- **Workflow Documentation**: In `gitops/` directory

## Tools and Technologies

- **Version Control**: Git, GitHub
- **CI/CD**: GitHub Actions, Azure DevOps
- **Cloud Platform**: Microsoft Azure
- **IaC Tools**: Bicep, Terraform, ARM templates
- **Containerization**: Docker
- **Security**: GitHub Advanced Security, CodeQL
- **Configuration Management**: Ansible
- **Databases**: PostgreSQL, Azure SQL, SQLite

## Related Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Azure DevOps Documentation](https://learn.microsoft.com/en-us/azure/devops/)
- [GitHub Advanced Security](https://docs.github.com/en/code-security)
- [Vibe Coding Approach](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)

## License

See [`LICENSE`](LICENSE) file for details.

## Support

For questions or issues:

- Open an issue in this repository
- Review existing documentation in subdirectories
- Check `prompts.txt` files for specific guidance

---

**Note**: This is a learning and demonstration repository. Examples may not be production-ready and should be adapted for your specific use cases.
