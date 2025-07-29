# CodeQL Analysis for Python - Production Requirements Document

## Overview

This document outlines the requirements for creating a PowerShell script that automates CodeQL analysis for Python codebases. The script will enable security scanning of Python code to identify potential vulnerabilities, specifically focused on detecting weakened or disabled Cross-Site Request Forgery (CSRF) protection.

## Background

CodeQL is GitHub's semantic code analysis engine used to discover vulnerabilities across a codebase. By automating the process of running CodeQL analysis and submitting results to GitHub, we can integrate security scanning into our development workflow, helping to identify and remediate security issues earlier.

## Purpose

The purpose of this script is to:

1. Create a CodeQL database from Python source code  
2. Run security analysis queries against the database
3. Generate a SARIF (Static Analysis Results Interchange Format) report
4. Upload the results to GitHub for review in the Security tab

## Requirements

### Functional Requirements

1. The script must be able to:
   - Show available languages for CodeQL analysis
   - Create a CodeQL database for Python code
   - Analyze the database using standard Python security queries
   - Generate results in SARIF format
   - Upload results to GitHub repositories

2. The script must use proper authentication via GitHub tokens for secure uploading of results.

3. The script must support running in CI/CD environments as well as locally by developers.

### Technical Requirements

1. **Dependencies**:
   - CodeQL CLI must be installed and accessible from the PATH
   - Git must be installed and accessible from the PATH
   - GitHub authentication token with appropriate permissions

2. **Output**:
   - SARIF file containing analysis results
   - Terminal output showing execution progress and status

3. **Performance**:
   - Should use multi-threading for analysis to improve performance

## User Stories

1. As a security engineer, I want to run automated CodeQL analysis on Python code so that I can identify potential security vulnerabilities.
2. As a developer, I want to check my code for CSRF vulnerabilities before submission so that I can fix issues early.
3. As a DevOps engineer, I want to integrate CodeQL scanning into the CI/CD pipeline so that security scanning becomes a standard part of the deployment process.

## Prompts for Script Generation

To generate the required PowerShell script, use the following prompts:

### Prompt 1: Basic Script Structure

```
Create a PowerShell script named New-CodeQLAnalysisForPython.ps1 that will use the CodeQL CLI to analyze Python code for security vulnerabilities. Include a reference comment linking to GitHub's documentation about the CodeQL CLI.
Place the script in the current repository at the path: "$(git rev-parse --show-toplevel)/ghas/workspace"
```

### Prompt 2: Showing Available Languages

```
Add a command to the PowerShell script that will display all available languages for CodeQL analysis using the 'codeql resolve languages' command with better JSON formatting for easier reading.
```

### Prompt 3: Database Creation

```
Add a command to create a CodeQL database for Python code. The database should be named 'codeql-dbs' and should use the git repository root as the source directory. Use the --language parameter to specify Python as the target language.
```

### Prompt 4: Database Analysis

```
Add a command to analyze the created database using standard Python security queries. The command should:
- Download queries from the codeql/python-queries package
- Output results in the latest SARIF format
- Use multiple threads (4) for better performance
- Categorize the results as 'python'
- Save the output to a file named 'python-results.sarif'
```

### Prompt 5: Results Upload

```
Add a command to upload the SARIF results to GitHub. The command should:
- Use a GitHub token stored in the GITHUB_TOKEN environment variable
- Pass the token securely through stdin rather than as a command line parameter
- Specify the repository as 'ms-mfg-community/project-gengo'
- Target the 'main' branch
- Use the current git commit hash
- Reference the generated SARIF file
```

## Expected Output

Skipped to test and evaluate the ability of agent mode to properly generate the code without an explicit example.


## Token Requirements

The GitHub Personal Access Token (PAT) used for uploading results needs the following permissions:

- For public repositories: `public_repo` scope
- For private repositories: `repo` scope (includes `repo:status`, `repo_deployment`, and `security_events`)

## Security Considerations

1. Never commit GitHub tokens to source control
2. Use environment variables or secure storage for tokens
3. Rotate tokens regularly (90 days recommended)
4. Follow the principle of least privilege when creating tokens

## Implementation Timeline

1. Development and Testing: 2 days
2. Documentation: 1 day
3. Integration with CI/CD: 1 day
4. Security Review: 1 day

## Success Criteria

1. Script successfully creates a CodeQL database
2. Analysis runs and generates a valid SARIF file
3. Results are successfully uploaded to GitHub
4. Security vulnerabilities are visible in GitHub Security tab

## References

1. [CodeQL CLI Documentation](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/about-the-codeql-cli)
2. [SARIF Specification](https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html)
3. [GitHub Security Documentation](https://docs.github.com/en/code-security)