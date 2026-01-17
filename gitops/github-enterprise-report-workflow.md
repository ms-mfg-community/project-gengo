# GitHub Enterprise Information Report Workflow

This GitHub Action workflow automatically collects and formats comprehensive GitHub Enterprise information into a CSV report for easy analysis.

\n\nFeatures

\n\nData Collection

\n\n**Organizational Data**: Basic org info, creation dates, repository counts, followers
\n\n**Repository Information**: All repos with metadata, statistics, and configuration
\n\n**Security Features**: GitHub Advanced Security (GHAS) status and configuration
\n\n**Licensing Details**: License information for each repository
\n\n**Security Alerts**:
\n\nCode Scanning alerts (total, open, fixed, dismissed)
\n\nSecret Scanning alerts (total, open, resolved)
\n\nDependabot alerts (total, open, fixed, dismissed)

\n\nReport Format

\n\n**CSV Output**: Easy to import into Excel, Google Sheets, or data analysis tools
\n\n**Metadata File**: JSON file with collection timestamp and summary information
\n\n**Comprehensive Columns**: 50+ data points per repository

\n\nUsage

\n\nManual Trigger

\n\nGo to the Actions tab in your repository
\n\nSelect "GitHub Enterprise Information Report"
\n\nClick "Run workflow"
\n\nFill in the required parameters:
\n\n**Organization**: GitHub organization name to analyze
\n\n**Include Private Repos**: Whether to include private repositories (default: true)
\n\n**Include Security Alerts**: Whether to collect security alerts (requires admin access, default: true)

\n\nScheduled Execution

The workflow is configured to run automatically every Sunday at 2 AM UTC. You can modify the schedule in the workflow file:

```

yaml
schedule:
\n\ncron: "0 2 * * 0" # Weekly on Sundays at 2 AM UTC

```

text
text

\n\nPrerequisites

\n\nRequired Permissions

The workflow requires a GitHub token with the following permissions:

\n\n`contents: read`
\n\n`security-events: read` (for security alerts)
\n\n`actions: read`
\n\n`checks: read`
\n\n`deployments: read`
\n\n`issues: read`
\n\n`packages: read`
\n\n`pull-requests: read`
\n\n`repository-projects: read`
\n\n`statuses: read`

\n\nGitHub Token Setup

The workflow uses `${{ secrets.GITHUB_TOKEN }}` which is automatically provided by GitHub Actions. For organization-level access, you may need to:

\n\nCreate a Personal Access Token (PAT) with appropriate permissions
\n\nAdd it as a repository secret named `GITHUB_TOKEN`
\n\nEnsure the token has access to the target organization

\n\nOutput Files

\n\nCSV Report

The main output file contains comprehensive data with columns including:

\n\nOrganization Data

\n\n`org_name`, `org_login`, `org_id`
\n\n`org_created_at`, `org_updated_at`
\n\n`org_public_repos`, `org_private_repos`
\n\n`org_followers`, `org_following`

\n\nRepository Information

\n\n`repo_name`, `repo_full_name`, `repo_id`
\n\n`repo_private`, `repo_fork`, `repo_archived`
\n\n`repo_created_at`, `repo_updated_at`, `repo_pushed_at`
\n\n`repo_size`, `repo_stargazers_count`, `repo_watchers_count`
\n\n`repo_language`, `repo_default_branch`, `repo_topics`

\n\nSecurity & Licensing

\n\n`repo_license_key`, `repo_license_name`
\n\n`ghas_security_and_analysis`, `ghas_has_vulnerability_alerts`
\n\n`code_scanning_total_alerts`, `code_scanning_open_alerts`
\n\n`secret_scanning_total_alerts`, `secret_scanning_open_alerts`
\n\n`dependabot_total_alerts`, `dependabot_open_alerts`

\n\nMetadata File

JSON file containing:

\n\nOrganization summary information
\n\nCollection timestamp
\n\nTotal repository count
\n\nWorkflow execution details

\n\nCustomization

\n\nModifying Data Collection

To add or modify collected data points, edit the `collect_github_data.py` script within the workflow file. Key areas to customize:

\n\n**Additional API Endpoints**: Add new GitHub API calls in the collector methods
\n\n**Data Processing**: Modify the data transformation logic
\n\n**Output Format**: Change the CSV structure or add additional output formats

\n\nFiltering Options

You can modify the workflow to add filtering options:

\n\nRepository size limits
\n\nLanguage-specific filtering
\n\nDate range filtering
\n\nSecurity alert severity filtering

\n\nOutput Formats

The workflow can be extended to support additional output formats:

\n\nJSON export
\n\nExcel files with multiple sheets
\n\nDatabase insertion
\n\nAPI posting to external systems

\n\nTroubleshooting

\n\nCommon Issues

\n\nPermission Errors

\n\nEnsure the GitHub token has sufficient permissions
\n\nFor organization-level access, the token owner must be an organization member
\n\nSecurity alerts require admin or security manager permissions

\n\nRate Limiting

\n\nThe GitHub API has rate limits (5000 requests/hour for authenticated requests)
\n\nLarge organizations may hit rate limits
\n\nConsider adding delays or implementing exponential backoff

\n\nMissing Data

\n\nSome repositories may not have security features enabled
\n\nPrivate repositories require appropriate access permissions
\n\nArchived repositories may have limited data availability

\n\nError Handling

The script includes error handling for:

\n\nAPI request failures
\n\nMissing permissions
\n\nRate limiting
\n\nInvalid organization names

\n\nSecurity Considerations

\n\nToken Security

\n\nNever commit GitHub tokens to the repository
\n\nUse GitHub Secrets for token storage
\n\nRegularly rotate access tokens
\n\nUse the principle of least privilege

\n\nData Sensitivity

\n\nThe report may contain sensitive information about private repositories
\n\nConsider data retention policies for generated reports
\n\nImplement appropriate access controls for report artifacts

\n\nExamples

\n\nSample CSV Output

```

csv

org_name,repo_name,repo_private,repo_language,code_scanning_total_alerts,secret_scanning_total_alerts

MyOrg,web-app,false,JavaScript,5,2

MyOrg,api-service,true,Python,12,0

MyOrg,mobile-app,false,Swift,3,1

```

text
text

\n\nSample Metadata

```

json
{
  "organization": {
    "name": "MyOrg",

    "login": "myorg",

    "public_repos": 25,

    "total_private_repos": 15
  },

  "collection_timestamp": "2024-01-15T10:30:00Z",

  "total_repositories": 40
}

```

text
text

\n\nContributing

To improve this workflow:

\n\nFork the repository
\n\nCreate a feature branch
\n\nMake your changes to the workflow file
\n\nTest with your organization
\n\nSubmit a pull request

\n\nLicense

This workflow is provided under the same license as the repository it's contained in.

\n
