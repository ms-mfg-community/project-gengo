# Create Basic Workflow

## Overview

This document contains instructions for creating CI/CD workflows for Java Spring Framework applications using GitHub Actions and Azure DevOps.

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
cicd/workspace/src/pipeline-ado.yml

# Full path resolution
$repoRoot = git rev-parse --show-toplevel
Join-Path -Path $repoRoot -ChildPath "cicd/workspace/pipeline-ado.yml"
```

## Summary

This workflow demonstrates:

- Setting up Java and Spring Framework dependencies
- Using Maven for package management
- Converting GitHub Actions workflows to Azure DevOps pipelines
- Cross-platform CI/CD pipeline compatibility