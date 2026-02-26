# Project Gengo

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub Actions](https://github.com/ms-mfg-community/project-gengo/actions/workflows/codeql.yml/badge.svg)](https://github.com/ms-mfg-community/project-gengo/actions)

A comprehensive, multi-technology learning repository that demonstrates best practices across programming languages, frameworks, cloud platforms, and DevOps — with a focus on [GitHub Copilot](https://github.com/features/copilot) productivity.

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Programming Languages](#programming-languages)
- [Infrastructure as Code](#infrastructure-as-code)
- [CI/CD Pipelines](#cicd-pipelines)
- [Security](#security)
- [Databases](#databases)
- [Scripting](#scripting)
- [GitHub Copilot Features](#github-copilot-features)
- [Getting Started](#getting-started)
- [Running Tests](#running-tests)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

Project Gengo is a polyglot learning environment designed to help developers adopt GitHub Copilot and modern software engineering best practices. The repository covers a broad technology landscape — from calculator implementations in eight languages to full CI/CD pipelines, IaC templates, and custom GitHub Copilot agents.

**Key goals:**

- Demonstrate GitHub Copilot usage across languages and tooling
- Provide reusable patterns for CI/CD, IaC, and security automation
- Serve as a hands-on reference for multi-language software development
- Showcase GitHub Advanced Security (GHAS) features in practice

---

## Repository Structure

```text
project-gengo/
├── .azure/              # Azure DevOps pipeline definitions
├── .github/
│   ├── agents/          # Custom GitHub Copilot agents
│   ├── instructions/    # Copilot custom instructions
│   ├── prompts/         # Reusable prompt files
│   ├── skills/          # Custom Copilot skills
│   └── workflows/       # GitHub Actions workflows
├── cicd/                # CI/CD pipeline examples and PRDs
├── databases/           # Database examples (KQL, RDBMS)
├── docs/                # Project documentation
├── ghas/                # GitHub Advanced Security examples
├── iac/                 # Infrastructure as Code (Bicep, ARM, Terraform)
├── mlops/               # Machine learning operations examples
├── programming/         # Multi-language implementations
│   ├── c/
│   ├── cpp/
│   ├── dotnet/          # C# / .NET projects
│   ├── go/
│   ├── java/
│   ├── javascript-html-css/
│   ├── node/
│   ├── python/
│   ├── typescript-html-css/
│   └── typescript-react/
├── prompt-engineering/  # Prompt engineering examples
├── scripting/           # Scripting examples (PowerShell, Bash, Azure CLI)
└── TESTING.md           # Testing guide
```

---

## Programming Languages

Each language area contains `workspace/` (starter projects), `completed/` (reference solutions), and associated guide documents.

| Language | Location | Frameworks / Tools | Test Framework |
|----------|----------|--------------------|---------------|
| C | `programming/c/` | CMake | — |
| C++ | `programming/cpp/` | CMake | Google Test |
| C# / .NET | `programming/dotnet/csharp/` | ASP.NET Core, xUnit | xUnit |
| Go | `programming/go/` | Standard library | testify |
| Java | `programming/java/` | Maven | JUnit 5 |
| JavaScript / HTML / CSS | `programming/javascript-html-css/` | Vanilla JS | — |
| Node.js | `programming/node/` | Node.js, React | Jest |
| Python | `programming/python/` | Flask, FastAPI | pytest |
| TypeScript / HTML / CSS | `programming/typescript-html-css/` | Webpack | Vitest |
| TypeScript / React | `programming/typescript-react/` | React, Vite | Jest |

---

## Infrastructure as Code

Reusable IaC templates for Azure resource provisioning are located in `iac/`:

| Technology | Location | Description |
|------------|----------|-------------|
| Azure Bicep | `iac/bicep/` | Modular Bicep templates for Azure resources |
| ARM Templates | `iac/arm/` | Azure Resource Manager JSON templates |
| Terraform | `iac/terraform/` | HashiCorp Terraform configurations for Azure |

See `docs/prd-azure-pipeline.md` for deployment pipeline patterns.

---

## CI/CD Pipelines

GitHub Actions workflows live in `.github/workflows/` and Azure DevOps pipeline definitions live in `.azure/`.

| Workflow | File | Purpose |
|----------|------|---------|
| CodeQL Analysis | `codeql.yml` | Static analysis for security vulnerabilities |
| CodeQL (C++) | `code-ql-cpp.yml` | C++ specific CodeQL scanning |
| Dependency Review | `dependency-review.yml` | Validates dependency changes on PRs |
| Level 01 Workflow | `01-level-workflow.yml` | Entry-level pipeline example |
| IAC Azure Deployment | `gaw-iac-azure-deployment.yml` | Deploys IaC templates to Azure |
| TFSec | `tfsec.yml` | Terraform security scanning |
| GHAS Dependabot Triage | `ghas-auto-triage-dependabot-alerts.yml` | Auto-triage Dependabot alerts |

For pipeline design patterns and PRDs, see `cicd/`.

---

## Security

This repository demonstrates GitHub Advanced Security (GHAS) features:

- **CodeQL**: Static analysis for C, C++, C#, Java, Python, JavaScript, and TypeScript
- **Dependabot**: Automated dependency updates and vulnerability alerts (see `.github/dependabot.yml`)
- **Dependency Review**: Enforces safe dependency changes on pull requests
- **Secret Scanning**: Detects accidentally committed credentials
- **TFSec**: Terraform security scanning

See [SECURITY.md](SECURITY.md) for the vulnerability reporting policy.

For detailed GHAS examples and templates, see `ghas/`.

---

## Databases

Database examples are located in `databases/`:

| Type | Location | Description |
|------|----------|-------------|
| KQL | `databases/kql/` | Kusto Query Language examples for Azure Monitor / Log Analytics |
| RDBMS | `databases/rdbms/` | Relational database examples (SQL Server / Azure SQL) |

---

## Scripting

Scripting examples are in `scripting/`:

| Technology | Location | Description |
|------------|----------|-------------|
| PowerShell | `scripting/powershell/` | Automation scripts following PSScriptAnalyzer conventions |
| Bash | `scripting/bash/` | Shell scripts for Linux/macOS |
| Azure CLI | `scripting/azure-cli/` | Azure resource management with `az` CLI |

---

## GitHub Copilot Features

Project Gengo is a showcase for GitHub Copilot productivity features.

### Custom Agents

Pre-built custom agents are in `.github/agents/`:

| Agent | File | Specialization |
|-------|------|----------------|
| SW Developer | `sw-developer.agent.md` | Feature implementation, refactoring |
| SW Tester / QA | `sw-tester.agent.md` | Test generation, edge case analysis |
| DevOps Engineer | `devops-engineer.agent.md` | CI/CD pipelines, IaC |
| Security Engineer | `security-engineer.agent.md` | Vulnerability review, security best practices |
| DBA | `dba.agent.md` | Query optimization, schema design |
| Architect | `architect.agent.md` | System design, architectural patterns |
| Project Manager | `project-manager.agent.md` | User stories, sprint planning |
| Data Scientist | `data-scientist.agent.md` | Data analysis, ML pipelines |
| MS SQL DBA | `ms-sql-dba.agent.md` | Microsoft SQL Server expertise |
| Readme Creator | `readme-creator.agent.md` | README and documentation generation |

See `.github/agents/README.md` for usage examples and an agent capability matrix.

### Custom Instructions

`.github/copilot-instructions.md` contains project-wide Copilot instructions covering coding standards for all supported languages, CI/CD conventions, IaC patterns, and documentation requirements.

### Prompt Files

Reusable `.prompt.md` files in `.github/prompts/` allow you to invoke common tasks directly from GitHub Copilot Chat using the `/` command.

### Quick Start Guide

See [`docs/quickstart.md`](docs/quickstart.md) for step-by-step instructions on setting up and using custom agents, instructions, and prompts.

---

## Getting Started

### Prerequisites

Install the tools for the languages you plan to work with:

| Language | Required Tool | Minimum Version |
|----------|--------------|-----------------|
| C / C++ | CMake + compiler | CMake 3.20+ |
| C# / .NET | .NET SDK | 8.0+ |
| Go | Go | 1.21+ |
| Java | JDK + Maven | Java 11+ |
| JavaScript / TypeScript | Node.js + npm | Node.js 20+ |
| Python | Python | 3.8+ |

### Clone the Repository

**HTTPS:**

```bash
git clone https://github.com/ms-mfg-community/project-gengo.git
cd project-gengo
```

**SSH:**

```bash
git clone git@github.com:ms-mfg-community/project-gengo.git
cd project-gengo
```

### Explore an Example

Each language folder contains a `workspace/` directory for guided exercises and a `completed/` directory with reference implementations. For example, to explore the Python calculator:

```bash
cd programming/python/completed/src/calculator
python -m pytest test_calculator.py -v
```

---

## Running Tests

The repository includes a unified test runner script that executes all language test suites:

**Linux / macOS:**

```bash
./run-all-tests.sh
```

**Windows (PowerShell):**

```powershell
.\Run-AllTests.ps1
```

| Language | Framework | Total Tests |
|----------|-----------|------------|
| Python | pytest | 80 |
| C# / .NET | xUnit | 103 |
| Node.js / TypeScript | Jest | 20 |
| Go | testify | 5 |

For detailed per-language test instructions, coverage options, and CI integration examples, see [TESTING.md](TESTING.md).

---

## Contributing

Contributions are welcome. When adding new content:

1. Follow the language-specific coding standards in `.github/copilot-instructions.md`
2. Place work-in-progress examples in the appropriate `workspace/` directory
3. Place completed reference implementations in `completed/`
4. Add or update tests and ensure all existing tests continue to pass
5. Update relevant documentation
6. Open a pull request with a clear description following the PR template

---

## License

This project is licensed under the [MIT License](LICENSE).

Copyright © 2024 Preston K. Parsard
