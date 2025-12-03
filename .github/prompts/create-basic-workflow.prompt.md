# Create Basic Workflow

## Overview

This document contains instructions for creating CI/CD workflows for Java Spring Framework applications using GitHub Actions and Azure DevOps, as well as repository content listing workflows.

## Path Resolution

All paths in this document are relative to the git repository root, which can be obtained using:

```pwsh
$repoRoot = git rev-parse --show-toplevel
```

## Task 1: GitHub Actions Workflow

**Status:** ✅ Completed

**Prompt:**

Create a yaml GitHub Actions workflow to install the requirements for java and the spring framework with the latest maven package version.

**Response:**

Sure! Here's a YAML code block for a GitHub Actions workflow that installs Java, Spring Framework, and the latest Maven package version.

**Output Location:**

```pwsh
# Relative path
cicd/workspace/workflow-ghb.yml

# Full path resolution
$repoRoot = git rev-parse --show-toplevel
Join-Path -Path $repoRoot -ChildPath "cicd/workspace/workflow-ghb.yml"
```

## Task 2: Azure DevOps Pipeline Conversion

**Status:** ✅ Completed

**Prompt:**

```text
/generate convert the GitHub Actions workflow file #file:'workflow-ghb.yml' to an equivalent Azure DevOps pipeline.
```

**Output Location:**

```pwsh
# Relative path
cicd/workspace/pipeline-ado.yml

# Full path resolution
$repoRoot = git rev-parse --show-toplevel
Join-Path -Path $repoRoot -ChildPath "cicd/workspace/pipeline-ado.yml"
```

## Task 3: Repository Contents Workflow

**Status:** ✅ Completed

**Prompt:**

Create a GitHub Actions workflow that automates repository content listing and workflow metadata reporting with the following requirements:
- Multiple trigger types (push, PR, schedule, manual)
- Repository content listing using tree command
- Directory-specific listing using PowerShell
- Workflow metadata reporting
- Job dependencies and sequencing

**Response:**

Created comprehensive workflow with two jobs: list-contents and retrieve-values.

**Output Location:**

```pwsh
# Relative path
.github/workflows/01-level-workflow.yml

# Full path resolution
$repoRoot = git rev-parse --show-toplevel
Join-Path -Path $repoRoot -ChildPath ".github/workflows/01-level-workflow.yml"
```

**PRD Location:**

```pwsh
# Relative path
cicd/prd-01-level-workspace.md

# Full path resolution
$repoRoot = git rev-parse --show-toplevel
Join-Path -Path $repoRoot -ChildPath "cicd/prd-01-level-workspace.md"
```

## Summary

This workflow demonstrates:

- Setting up Java and Spring Framework dependencies
- Using Maven for package management
- Converting GitHub Actions workflows to Azure DevOps pipelines
- Cross-platform CI/CD pipeline compatibility
- Repository content auditing and reporting
- Multiple workflow trigger mechanisms
- Cross-platform scripting (bash + PowerShell)
- Job dependencies and workflow orchestration
- Workflow metadata capture and reporting

## Related Documentation

- [Product Requirements Document - Repository Contents Workflow](../../../cicd/prd-01-level-workspace.md)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure DevOps Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/)
