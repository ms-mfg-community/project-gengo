# GitHub Enterprise Information Report Workflow

This GitHub Action workflow automatically collects and formats comprehensive GitHub Enterprise information into a CSV report for easy analysis.

## Features

### Data Collection
- **Organizational Data**: Basic org info, creation dates, repository counts, followers
- **Repository Information**: All repos with metadata, statistics, and configuration
- **Security Features**: GitHub Advanced Security (GHAS) status and configuration
- **Licensing Details**: License information for each repository
- **Security Alerts**: 
  - Code Scanning alerts (total, open, fixed, dismissed)
  - Secret Scanning alerts (total, open, resolved)
  - Dependabot alerts (total, open, fixed, dismissed)

### Report Format
- **CSV Output**: Easy to import into Excel, Google Sheets, or data analysis tools
- **Metadata File**: JSON file with collection timestamp and summary information
- **Comprehensive Columns**: 50+ data points per repository

## Usage

### Manual Trigger
1. Go to the Actions tab in your repository
2. Select "GitHub Enterprise Information Report"
3. Click "Run workflow"
4. Fill in the required parameters:
   - **Organization**: GitHub organization name to analyze
   - **Include Private Repos**: Whether to include private repositories (default: true)
   - **Include Security Alerts**: Whether to collect security alerts (requires admin access, default: true)

### Scheduled Execution
The workflow is configured to run automatically every Sunday at 2 AM UTC. You can modify the schedule in the workflow file:

```yaml
schedule:
  - cron: '0 2 * * 0'  # Weekly on Sundays at 2 AM UTC
```

## Prerequisites

### Required Permissions
The workflow requires a GitHub token with the following permissions:
- `contents: read`
- `security-events: read` (for security alerts)
- `actions: read`
- `checks: read`
- `deployments: read`
- `issues: read`
- `packages: read`
- `pull-requests: read`
- `repository-projects: read`
- `statuses: read`

### GitHub Token Setup
The workflow uses `${{ secrets.GITHUB_TOKEN }}` which is automatically provided by GitHub Actions. For organization-level access, you may need to:

1. Create a Personal Access Token (PAT) with appropriate permissions
2. Add it as a repository secret named `GITHUB_TOKEN`
3. Ensure the token has access to the target organization

## Output Files

### CSV Report
The main output file contains comprehensive data with columns including:

#### Organization Data
- `org_name`, `org_login`, `org_id`
- `org_created_at`, `org_updated_at`
- `org_public_repos`, `org_private_repos`
- `org_followers`, `org_following`

#### Repository Information
- `repo_name`, `repo_full_name`, `repo_id`
- `repo_private`, `repo_fork`, `repo_archived`
- `repo_created_at`, `repo_updated_at`, `repo_pushed_at`
- `repo_size`, `repo_stargazers_count`, `repo_watchers_count`
- `repo_language`, `repo_default_branch`, `repo_topics`

#### Security & Licensing
- `repo_license_key`, `repo_license_name`
- `ghas_security_and_analysis`, `ghas_has_vulnerability_alerts`
- `code_scanning_total_alerts`, `code_scanning_open_alerts`
- `secret_scanning_total_alerts`, `secret_scanning_open_alerts`
- `dependabot_total_alerts`, `dependabot_open_alerts`

### Metadata File
JSON file containing:
- Organization summary information
- Collection timestamp
- Total repository count
- Workflow execution details

## Customization

### Modifying Data Collection
To add or modify collected data points, edit the `collect_github_data.py` script within the workflow file. Key areas to customize:

1. **Additional API Endpoints**: Add new GitHub API calls in the collector methods
2. **Data Processing**: Modify the data transformation logic
3. **Output Format**: Change the CSV structure or add additional output formats

### Filtering Options
You can modify the workflow to add filtering options:
- Repository size limits
- Language-specific filtering
- Date range filtering
- Security alert severity filtering

### Output Formats
The workflow can be extended to support additional output formats:
- JSON export
- Excel files with multiple sheets
- Database insertion
- API posting to external systems

## Troubleshooting

### Common Issues

#### Permission Errors
- Ensure the GitHub token has sufficient permissions
- For organization-level access, the token owner must be an organization member
- Security alerts require admin or security manager permissions

#### Rate Limiting
- The GitHub API has rate limits (5000 requests/hour for authenticated requests)
- Large organizations may hit rate limits
- Consider adding delays or implementing exponential backoff

#### Missing Data
- Some repositories may not have security features enabled
- Private repositories require appropriate access permissions
- Archived repositories may have limited data availability

### Error Handling
The script includes error handling for:
- API request failures
- Missing permissions
- Rate limiting
- Invalid organization names

## Security Considerations

### Token Security
- Never commit GitHub tokens to the repository
- Use GitHub Secrets for token storage
- Regularly rotate access tokens
- Use the principle of least privilege

### Data Sensitivity
- The report may contain sensitive information about private repositories
- Consider data retention policies for generated reports
- Implement appropriate access controls for report artifacts

## Examples

### Sample CSV Output
```csv
org_name,repo_name,repo_private,repo_language,code_scanning_total_alerts,secret_scanning_total_alerts
MyOrg,web-app,false,JavaScript,5,2
MyOrg,api-service,true,Python,12,0
MyOrg,mobile-app,false,Swift,3,1
```

### Sample Metadata
```json
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

## Contributing

To improve this workflow:
1. Fork the repository
2. Create a feature branch
3. Make your changes to the workflow file
4. Test with your organization
5. Submit a pull request

## License

This workflow is provided under the same license as the repository it's contained in.