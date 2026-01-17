# CodeQL Analysis for Python - Production Requirements Document

\n\nOverview

This document outlines the requirements for creating a PowerShell script that automates CodeQL analysis for Python codebases. The script will enable security scanning of Python code to identify potential vulnerabilities, specifically focused on detecting weakened or disabled Cross-Site Request Forgery (CSRF) protection.

\n\nBackground

CodeQL is GitHub's semantic code analysis engine used to discover vulnerabilities across a codebase. By automating the process of running CodeQL analysis and submitting results to GitHub, we can integrate security scanning into our development workflow, helping to identify and remediate security issues earlier.

\n\nPurpose

The purpose of this script is to:

\n\nCreate a CodeQL database from Python source code
\n\nRun security analysis queries against the database
\n\nGenerate a SARIF (Static Analysis Results Interchange Format) report
\n\nUpload the results to GitHub for review in the Security tab

\n\nRequirements

\n\nFunctional Requirements

\n\nThe script must be able to:
\n\nShow available languages for CodeQL analysis
\n\nCreate a CodeQL database for Python code
\n\nAnalyze the database using standard Python security queries
\n\nGenerate results in SARIF format
\n\nUpload results to GitHub repositories

\n\nThe script must use proper authentication via GitHub tokens for secure uploading of results.

\n\nThe script must support running in CI/CD environments as well as locally by developers.

\n\nTechnical Requirements

\n\n**Dependencies**:
\n\nCodeQL CLI must be installed and accessible from the PATH
\n\nGit must be installed and accessible from the PATH
\n\nGitHub authentication token with appropriate permissions

\n\n**Output**:
\n\nSARIF file containing analysis results
\n\nTerminal output showing execution progress and status

\n\n**Performance**:
\n\nShould use multi-threading for analysis to improve performance

\n\nUser Stories

\n\nAs a security engineer, I want to run automated CodeQL analysis on Python code so that I can identify potential security vulnerabilities.
\n\nAs a developer, I want to check my code for CSRF vulnerabilities before submission so that I can fix issues early.
\n\nAs a DevOps engineer, I want to integrate CodeQL scanning into the CI/CD pipeline so that security scanning becomes a standard part of the deployment process.

\n\nPrompts for Script Generation

To generate the required PowerShell script, use the following prompts:

\n\nPrompt 1: Basic Script Structure

```

text

Create a PowerShell script named New-CodeQLAnalysisForPython.ps1 that will use the CodeQL CLI to analyze Python code for security vulnerabilities. Include a reference comment linking to GitHub's documentation about the CodeQL CLI.

Place the script in the current repository at the path: "$(git rev-parse --show-toplevel)/ghas/workspace"

```

text
text

\n\nPrompt 2: Showing Available Languages

```

text

Add a command to the PowerShell script that will display all available languages for CodeQL analysis using the 'codeql resolve languages' command with better JSON formatting for easier reading.

```

text
text

\n\nPrompt 3: Database Creation

```

text

Add a command to create a CodeQL database for Python code. The database should be named 'codeql-dbs' and should use the git repository root as the source directory. Use the --language parameter to specify Python as the target language.

```

text
text

\n\nPrompt 4: Database Analysis

```

text

Add a command to analyze the created database using standard Python security queries. The command should:
\n\nDownload queries from the codeql/python-queries package
\n\nOutput results in the latest SARIF format
\n\nUse multiple threads (4) for better performance
\n\nCategorize the results as 'python'
\n\nSave the output to a file named 'python-results.sarif'

```

text
text

\n\nPrompt 5: Results Upload

```

text

Add a command to upload the SARIF results to GitHub. The command should:
\n\nUse a GitHub token stored in the GITHUB_TOKEN environment variable
\n\nPass the token securely through stdin rather than as a command line parameter
\n\nSpecify the repository as 'ms-mfg-community/project-gengo'
\n\nTarget the 'main' branch
\n\nUse the current git commit hash
\n\nReference the generated SARIF file

```

text
text

\n\nExpected Output

Skipped to test and evaluate the ability of agent mode to properly generate the code without an explicit example.

\n\nToken Requirements

The GitHub Personal Access Token (PAT) used for uploading results needs the following permissions:

\n\nFor public repositories: `public_repo` scope
\n\nFor private repositories: `repo` scope (includes `repo:status`, `repo_deployment`, and `security_events`)

\n\nSecurity Considerations

\n\nNever commit GitHub tokens to source control
\n\nUse environment variables or secure storage for tokens
\n\nRotate tokens regularly (90 days recommended)
\n\nFollow the principle of least privilege when creating tokens

\n\nImplementation Timeline

\n\nDevelopment and Testing: 2 days
\n\nDocumentation: 1 day
\n\nIntegration with CI/CD: 1 day
\n\nSecurity Review: 1 day

\n\nSuccess Criteria

\n\nScript successfully creates a CodeQL database
\n\nAnalysis runs and generates a valid SARIF file
\n\nResults are successfully uploaded to GitHub
\n\nSecurity vulnerabilities are visible in GitHub Security tab

\n\nReferences

\n\n[CodeQL CLI Documentation](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/about-the-codeql-cli)
\n\n[SARIF Specification](https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html)
\n\n[GitHub Security Documentation](https://docs.github.com/en/code-security)

\n
