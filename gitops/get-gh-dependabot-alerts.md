# Requirements: Get GitHub Dependabot Alerts PowerShell Script

## Purpose

Create a PowerShell script that queries the GitHub GraphQL API to retrieve Dependabot (vulnerability) alerts for a specified repository. The script should output the results in a readable table format.

## Functional Requirements

- The script must use the GitHub GraphQL API endpoint: `https://api.github.com/graphql`.
- The script must authenticate using a GitHub personal access token (PAT) provided via the `GITHUB_TOKEN` environment variable.
- The script must allow configuration of the organization and repository via variables (do not hardcode values).
- The script must query for up to 100 vulnerability alerts for the specified repository.
- For each alert, the script must retrieve:
  - Alert ID
  - Creation date
  - Security vulnerability details: package name and severity
- The script must output the results in a table format.
- The script must handle missing or invalid tokens gracefully and provide a clear error message.
- The script must handle API errors and display them to the user.
- The script must place the powershell file named Get-GitHubDependencyAlerts.ps1 in the path relative to this repository's root, which is 'project-gengo'. The relative path within this repo is: gitops\workspace

## Non-Functional Requirements

- The script must follow the repository's PowerShell style guide:
  - Use PascalCase for variables and functions.
  - End control structures with comments (e.g., `#end if`).
  - Place each opening bracket `{` on a new line for each scope.
  - Include comments for non-trivial logic.
- The script must be under 100 lines of code.
- The script must not hardcode secrets or sensitive data.
- The script must be idempotent and safe to run multiple times.
- The script must be compatible with Windows PowerShell 5.1+ and PowerShell Core 7+.

## Example Output

```text
Id                                   CreatedAt            PackageName      Severity
--                                   ---------            -----------      --------
MDU6...                              2024-04-01T12:34Z    lodash          HIGH
MDU6...                              2024-03-15T09:21Z    minimist        MODERATE
```

## Usage

1. Set your GitHub token in the environment:  
   `$env:GITHUB_TOKEN = "your_github_token_here"`
2. Run the script:  
   `./Get-GitHubDependabotAlerts.ps1`

## References

- [GitHub GraphQL API Docs](https://docs.github.com/en/graphql)
- [GitHub Dependabot Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)
