# Requirements: Get GitHub Dependabot Alerts PowerShell Script

\n\nPurpose

Create a PowerShell script that queries the GitHub GraphQL API to retrieve Dependabot (vulnerability) alerts for a specified repository. The script should output the results in a readable table format.

\n\nFunctional Requirements

\n\nThe script must use the GitHub GraphQL API endpoint: `https://api.github.com/graphql`.
\n\nThe script must authenticate using a GitHub personal access token (PAT) provided via the `GITHUB_TOKEN` environment variable.
\n\nThe script must allow configuration of the organization and repository via variables (do not hardcode values).
\n\nThe script must query for up to 100 vulnerability alerts for the specified repository.
\n\nFor each alert, the script must retrieve:
\n\nAlert ID
\n\nCreation date
\n\nSecurity vulnerability details: package name and severity
\n\nThe script must output the results in a table format.
\n\nThe script must handle missing or invalid tokens gracefully and provide a clear error message.
\n\nThe script must handle API errors and display them to the user.
\n\nThe script must place the powershell file named Get-GitHubDependencyAlerts.ps1 in the path relative to this repository's root, which is 'project-gengo'. The relative path within this repo is: gitops\workspace

\n\nNon-Functional Requirements

\n\nThe script must follow the repository's PowerShell style guide:
\n\nUse PascalCase for variables and functions.
\n\nEnd control structures with comments (e.g., `#end if`).
\n\nPlace each opening bracket `{` on a new line for each scope.
\n\nInclude comments for non-trivial logic.
\n\nThe script must be under 100 lines of code.
\n\nThe script must not hardcode secrets or sensitive data.
\n\nThe script must be idempotent and safe to run multiple times.
\n\nThe script must be compatible with Windows PowerShell 5.1+ and PowerShell Core 7+.

\n\nExample Output

```

text

Id                                   CreatedAt            PackageName      Severity

--                                   ---------            -----------      --------

MDU6...                              2024-04-01T12:34Z    lodash          HIGH

MDU6...                              2024-03-15T09:21Z    minimist        MODERATE

```

text
text

\n\nUsage

\n\nSet your GitHub token in the environment:

`$env:GITHUB_TOKEN = "your_github_token_here"`
\n\nRun the script:

`./Get-GitHubDependabotAlerts.ps1`

\n\nReferences

\n\n[GitHub GraphQL API Docs](https://docs.github.com/en/graphql)
\n\n[GitHub Dependabot Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)

\n
