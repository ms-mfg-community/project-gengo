# Project Gengo

<div align="left">

<!-- Badges: update workflow names/paths if different -->
<a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue" /></a>
<a href=".github/workflows/codeql.yml"><img alt="CodeQL" src="https://github.com/ms-mfg-community/project-gengo/actions/workflows/codeql.yml/badge.svg" /></a>
<a href=".github/workflows/build.yml"><img alt="Build" src="https://github.com/ms-mfg-community/project-gengo/actions/workflows/build.yml/badge.svg" /></a>
<a href="SECURITY.md"><img alt="Security Policy" src="https://img.shields.io/badge/security-policy-green" /></a>

</div>

A practical, multi-language workspace for demos, experiments, and CI/CD automation. It includes examples across security (CodeQL), infrastructure-as-code (Bicep/Terraform), data, and assorted programming languages. This repo prioritizes simple solutions, clear structure, and reproducible workflows.

## Overview

- **CI/CD & Workflows:** GitHub Actions and Azure DevOps examples under `gitops/` and `ghas/`.
- **Security:** CodeQL workflows, database, and results in `codeql-db/`, `ghas/`, and `codeql-results.sarif`.
- **Infrastructure:** Bicep/Terraform/ARM under `iac/` and archived GitOps infra in `archive/gitops-workspace-infra/`.
- **Programming:** Language workspaces in `programming/` (C, C++, .NET, Go, Java, Python, Node, TS, React, etc.).
- **Data & SQL:** `databases/` with KQL, PostgreSQL, and Azure SQL materials.
- **Scripts:** PowerShell/Bash/Azure CLI helpers in `scripting/`.
- **Docs & Prompts:** Prompts and PRDs in `prompt-engineering/`, `gitops/`, `ghas/`, and `cicd/`.

See `SECURITY.md` for security guidance and `LICENSE` for licensing.

## Quick Start

1. Clone the repo.
2. Open in VS Code.
3. Explore a feature or language folder (e.g., `programming/python`, `ghas/`, `iac/bicep`).

### Prerequisites

- Windows, macOS, or Linux
- VS Code with recommended extensions (GitHub Copilot, Azure Tools, CodeQL if using security scenarios)
- Language toolchains as needed (e.g., MSVC or GCC for C/C++, .NET SDK, Python 3.11+)

## Common Workflows

### CodeQL

- Guidance and templates: `ghas/`
- Results example: `codeql-results.sarif`
- Queries and notes: `gitops/codeql-queries.md`, `gitops/code-ql-cpp.md`

### Infrastructure (Bicep/Terraform)

- Bicep examples: `iac/bicep/`
- Archived GitOps infra: `archive/gitops-workspace-infra/` with `main.bicep` and `main.bicepparam`

### Programming Examples

- C/C++: `programming/c/`, `programming/cpp/` with VS Code tasks; CMake at repo root (`CMakeLists.txt`)
- .NET: `programming/dotnet/`
- Python: `programming/python/`, with `todo_api/requirements.txt`
- Java/Go/Node/TS: respective folders under `programming/`

## Usage

- Navigate to a folder's `README.md` or prompts to follow local instructions.
- Many folders include runnable samples, scripts, or PRDs.

### Example: Run C++ build task (Windows, VS Code)

Use the preconfigured tasks to build the active file or project:

```text
Terminal > Run Task > "C/C++: g++.exe build active file"
Terminal > Run Task > "C/C++: cl.exe build active file"
```

### Example: Python

If a folder includes `requirements.txt` (e.g., `todo_api/`):

```powershell
python -m venv dev
dev\Scripts\activate
pip install -r requirements.txt
```

## Repository Structure

- `ghas/`: CodeQL guidance, templates, workspace
- `gitops/`: Workflows, pipelines, prompts, PRDs
- `iac/`: ARM, Bicep, Terraform
- `programming/`: Language-specific examples
- `databases/`: KQL, PostgreSQL, Azure SQL
- `scripting/`: PowerShell, Bash, Azure CLI
- `archive/`: Historical or reference content (e.g., GitOps infra)
- `build/`: CMake build outputs
- `lib/`: Libraries (e.g., `calculator.library/`)
- `IntellisenseRepro/`: .NET sample
- `mlops/`: ML workflows
- `content-*`: Inclusion/exclusion examples

## Contributing

- Keep changes focused and small.
- Prefer simple solutions and avoid duplication.
- Follow repository coding style and testing guidelines.
- Propose updates via pull requests with clear descriptions.

See `github-gui/prompts.txt` and PRD examples like `gitops/prd-workflows-and-pipelines.md` for inspiration.

## Security

- Review `SECURITY.md` for reporting and best practices.
- Never commit secrets; use environment variables and `.env.example` patterns.

## License

See `LICENSE` for details.

## Helpful Links (Relative)

- Docs & PRDs: `gitops/prd-workflows-and-pipelines.md`, `ghas/prd-codeql-analysis-for-python.md`
- Templates: `ghas/templates/`, `gitops/templates/`
- Prompts: `prompt-engineering/prompt-engineering.txt`, `github-gui/prompts.txt`

## Badges

- License: points to `LICENSE` (MIT)
- CodeQL: GitHub Actions badge from `.github/workflows/codeql.yml`
- Build: GitHub Actions badge from `.github/workflows/build.yml`
- Security Policy: links to `SECURITY.md`

Note: If your workflow filenames differ, update the badge links accordingly (e.g., `ci.yml`, `codeql-analysis.yml`).
