# Project Gengo

Project Gengo is a polyglot learning and demo workspace that showcases modern software development practices across languages, CI/CD, security, infrastructure-as-code, and AI-assisted workflows.

## Overview

- Multi-language examples (C, C++, .NET, Go, Java, JavaScript/TypeScript, Python)
- CI/CD with GitHub Actions and Azure DevOps
- Security workflows with CodeQL and secret scanning
- Infrastructure as Code (ARM, Bicep, Terraform)
- Database scripts (PostgreSQL, KQL) and MLOps samples

## Repository Structure

- `programming/`: Language-specific workspaces and examples
- `cicd/`: CI/CD workflows, pipelines, and PRDs
- `.github/`: Actions workflows, agents, prompts, instructions
- `ghas/`: GitHub Advanced Security (CodeQL, SARIF results)
- `iac/`: Infrastructure-as-code (ARM, Bicep, Terraform)
- `databases/`: SQL, KQL, and data-related docs
- `features/`: Focused demos (e.g., Copilot code completion)
- `scripting/`: PowerShell, Bash, Azure CLI scripts
- `prompt-engineering/`: Prompts and usage docs
- `SECURITY.md`, `LICENSE`: Policies and license

## Getting Started

### Prerequisites

- Git and a GitHub account
- Recommended tooling based on interest:
  - Build tools: `cmake`, `gcc/g++`, `.NET SDK`, `node`, `python`
  - CI/CD: GitHub Actions (no local install), Azure DevOps (optional)
  - IaC: `az` CLI, `terraform`, `bicep`

### Clone

```pwsh
git clone https://github.com/ms-mfg-community/project-gengo.git
cd project-gengo
```

### C++ Build (example)

```pwsh
mkdir build
cd build
cmake ..
cmake --build .
```

### Python (virtual environment)

```pwsh
python -m venv dev
dev\Scripts\activate
pip install -r requirements.txt
```

## CI/CD Workflows

- GitHub Actions examples in `.github/workflows/`
- PRD for repository auditing workflow: `cicd/prd-01-level-workspace.md`
- Example Java/Maven workflow: `cicd/workspace/workflow-ghb.yml`
- Azure DevOps pipeline example: `cicd/workspace/pipeline-ado.yml`

## GitHub Copilot Integration

- Custom instructions: `.github/copilot-instructions.md`
- Agents (e.g., readme-creator): `.github/agents/`
- Prompts used in workflows: `.github/prompts/`

## Standards

### Commit Message Format

Use the Topic Subtopic Activity pattern:

```text
topic(subtopic): activity
```

Examples:

- `github(instructions): expand guideline details`
- `feat(auth): add login functionality`
- `fix(ui): correct button alignment`

### Coding Guidelines

- Prefer simple solutions and avoid duplication
- Write environment-aware code (dev, test, prod)
- Keep files under ~200 lines where practical
- Write tests for major functionality
- Follow language-specific style guides (see `.github/copilot-instructions.md`)

## Documentation

- Copilot Instructions: `.github/copilot-instructions.md`
- Security Policy: `SECURITY.md`
- GitOps PRDs: `gitops/prd-*.md`
- Database Docs: `databases/rdbms/*.md`

## Contributing

- Follow coding standards and commit message format above
- Add tests and update docs when introducing changes
- Ensure CI passes before submitting PRs

## License

This project is licensed under the MIT License. See `LICENSE` for details.

## Resources

- [GitHub Copilot](https://docs.github.com/en/copilot "GitHub Copilot Documentation")
- [GitHub Actions](https://docs.github.com/en/actions "GitHub Actions Documentation")
- [Azure DevOps Pipelines](https://learn.microsoft.com/azure/devops/pipelines/ "Azure DevOps Pipelines Documentation")
- [CodeQL](https://codeql.github.com/ "CodeQL Documentation")

