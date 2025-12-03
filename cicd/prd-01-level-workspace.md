# 1. Product Requirements Document (PRD): Repository Contents Workflow

## 1.1 Document Information

- **Version:** 1.0
- **Author:** GitHub Copilot
- **Date:** December 3, 2025
- **Status:** Draft

## 1.2 Executive Summary

This document defines the requirements for a GitHub Actions workflow that automates repository content listing and workflow metadata reporting. The workflow provides visibility into repository structure and demonstrates best practices for CI/CD automation, multiple trigger types, and cross-platform scripting.

## 1.3 Problem Statement

Development teams need an automated, repeatable way to:

- List and audit repository contents for documentation and compliance purposes
- Understand workflow trigger contexts and branch information
- Generate structured reports that can be stored as build artifacts
- Support both Linux-native tools (tree) and cross-platform scripting (PowerShell)

Manual execution of these tasks is time-consuming, error-prone, and does not provide the auditability required for modern DevOps practices.

## 1.4 Goals and Objectives

- Automate repository content listing using multiple approaches (tree command, PowerShell)
- Provide comprehensive workflow metadata reporting for traceability
- Support multiple trigger mechanisms (push, pull request, schedule, manual)
- Generate structured output suitable for artifact storage and review
- Demonstrate cross-platform scripting best practices
- Enable scheduled auditing of repository contents

## 1.5 Scope

### 1.5.1 In Scope

- GitHub Actions workflow YAML definition
- Multiple workflow triggers (push, PR, schedule, manual)
- Repository content listing using Linux tree command
- Directory-specific content listing using PowerShell
- Workflow metadata reporting (branch, event, actor, repository)
- Job dependencies and sequencing
- Color-coded console output for improved readability
- Path filtering to prevent recursive workflow triggers

### 1.5.2 Out of Scope

- Artifact upload and download (covered in separate workflows)
- File content analysis or modification
- Security scanning or compliance checking
- Integration with external systems
- Deployment or release management
- Advanced artifact retention policies

## 1.6 User Stories / Use Cases

- As a DevOps engineer, I want to automatically list repository contents so I can audit the project structure
- As a developer, I want to see workflow trigger information so I can understand what initiated the workflow
- As a team lead, I want to schedule daily repository audits so I can track structural changes over time
- As a contributor, I want to manually trigger the workflow to verify repository contents on demand
- As a compliance officer, I want structured reports of repository contents for audit purposes

## 1.7 Functional Requirements

| Requirement ID | Description |
|---|---|
| FR-1 | The workflow shall trigger on push events to the main branch |
| FR-2 | The workflow shall exclude changes in the .github directory from push triggers |
| FR-3 | The workflow shall trigger on pull requests targeting the main branch |
| FR-4 | The workflow shall run on a schedule (daily at midnight UTC) |
| FR-5 | The workflow shall support manual triggering via workflow_dispatch |
| FR-6 | The workflow shall display event name, branch, repository, and actor information |
| FR-7 | The workflow shall check out repository code using actions/checkout@v4 |
| FR-8 | The workflow shall install and use the tree command for directory visualization |
| FR-9 | The workflow shall display repository structure up to 3 levels deep with file sizes |
| FR-10 | The workflow shall use PowerShell to list contents of the src directory |
| FR-11 | The workflow shall differentiate between directories and files with color coding |
| FR-12 | The workflow shall display file sizes in kilobytes for PowerShell output |
| FR-13 | The workflow shall handle cases where the src directory does not exist |
| FR-14 | The workflow shall include a second job for retrieving workflow values |
| FR-15 | The second job shall depend on the first job's completion |
| FR-16 | The workflow shall display branch information including ref names and default branch |

## 1.8 Non-Functional Requirements

- **Performance:** The workflow shall complete within 5 minutes under normal conditions
- **Portability:** The workflow shall run on GitHub-hosted ubuntu-latest runners
- **Usability:** Console output shall be clear, structured, and color-coded for readability
- **Reliability:** The workflow shall handle missing directories gracefully without failing
- **Maintainability:** The workflow YAML shall be well-commented and follow best practices
- **Auditability:** All output shall include appropriate metadata for traceability

## 1.9 Assumptions and Dependencies

- The repository uses GitHub Actions for CI/CD
- GitHub-hosted ubuntu-latest runners are available
- PowerShell Core (pwsh) is available on ubuntu-latest runners
- The tree command can be installed via apt-get
- Users have appropriate permissions to trigger workflows
- The repository structure may or may not include a src directory

## 1.10 Success Criteria / KPIs

- All workflow steps complete successfully without errors
- Repository contents are displayed in a structured, readable format
- Workflow metadata is accurate and complete
- The workflow runs successfully on all defined triggers
- PowerShell scripts handle both existing and missing directories correctly
- Job dependencies execute in the correct sequence

## 1.11 Milestones & Timeline

1. **Workflow Definition** - Complete
   - YAML structure created
   - Trigger configurations defined
   - Job structure established

2. **Content Listing Implementation** - Complete
   - Tree command integration
   - PowerShell directory listing
   - Color-coded output

3. **Metadata Reporting** - Complete
   - Event information display
   - Branch information retrieval
   - Repository context reporting

4. **Testing and Validation** - Complete
   - Multiple trigger types tested
   - Job sequencing verified
   - Error handling validated

## 1.12 Implementation Guidance

### 1.12.1 Workflow Structure

The workflow consists of two jobs:

1. **list-contents**: Lists repository contents using multiple approaches
2. **retrieve-values**: Retrieves and displays workflow metadata

### 1.12.2 Trigger Configuration

```yaml
on:
  push:
    branches: [main]
    paths-ignore: ['.github/**']
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * *'
  workflow_dispatch:
```

### 1.12.3 Content Listing Approaches

**Tree Command:**
- 3-level depth limit
- Human-readable file sizes
- Directories listed first
- Color-coded output

**PowerShell:**
- Recursive directory traversal
- Conditional directory checking
- Indented hierarchical display
- Color-coded file vs directory distinction
- File size display in KB

### 1.12.4 Job Dependencies

The `retrieve-values` job depends on `list-contents` completion:

```yaml
needs: list-contents
```

### 1.12.5 Metadata Captured

**Event Information:**
- Workflow trigger type
- Branch name
- Repository full name
- Triggering actor

**Branch Information:**
- Current branch name
- Full reference path
- PR head and base references
- Default branch name

## 1.13 Technical Specifications

### 1.13.1 Runner Configuration

- **Platform:** ubuntu-latest
- **Shell Options:** bash (default), pwsh (PowerShell steps)

### 1.13.2 Required Actions

- `actions/checkout@v4` - Repository checkout

### 1.13.3 Required Packages

- `tree` - Directory visualization (installed via apt-get)

### 1.13.4 GitHub Context Variables Used

- `github.event_name` - Trigger type
- `github.ref_name` - Branch name
- `github.ref` - Full reference
- `github.repository` - Repository full name
- `github.actor` - User who triggered the workflow
- `github.head_ref` - PR head reference
- `github.base_ref` - PR base reference
- `github.event.repository.default_branch` - Default branch

## 1.14 Testing Requirements

- Verify workflow triggers on push to main branch
- Confirm .github path filtering prevents recursive triggers
- Test pull request triggering
- Validate scheduled execution (observe cron behavior)
- Test manual workflow dispatch
- Verify tree command output formatting
- Test PowerShell script with existing src directory
- Test PowerShell script with missing src directory
- Verify job sequencing (retrieve-values waits for list-contents)
- Validate all metadata values are correctly displayed

## 1.15 Usage Instructions

### 1.15.1 Manual Execution

1. Navigate to the repository on GitHub
2. Go to Actions tab
3. Select "01-level-workflow" from the workflow list
4. Click "Run workflow"
5. Select the branch (default: main)
6. Click "Run workflow" button

### 1.15.2 Viewing Results

1. Click on the workflow run from the Actions list
2. Expand "List Repository Contents" job
3. Review each step's output
4. Expand "Retrieve Workflow Values" job
5. Review branch and event information

### 1.15.3 Scheduled Execution

The workflow runs automatically at midnight UTC daily. Check the Actions tab for scheduled run history.

## 1.16 Key Takeaways

- Multiple trigger types provide flexibility for different use cases
- Path filtering prevents infinite workflow loops
- Cross-platform scripting (bash + PowerShell) demonstrates versatility
- Job dependencies enable sequential processing
- Structured output aids in auditing and documentation
- Color-coded output improves readability and user experience

## 1.17 Future Enhancements

- Add artifact upload for repository content reports
- Implement file count and size statistics
- Add support for multiple directory listings
- Create comparison reports between workflow runs
- Integrate with repository documentation generation
- Add notification system for significant structural changes

## 1.18 Related Documentation

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Context](https://docs.github.com/en/actions/learn-github-actions/contexts)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Tree Command Manual](https://linux.die.net/man/1/tree)
- [PowerShell Get-ChildItem](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)

## 1.19 Questions for Review

- Should artifact upload be added for long-term storage of reports?
- Are additional directories beyond src needed for listing?
- Should the scheduled frequency be configurable?
- Is additional metadata needed for compliance requirements?
- Should notifications be sent on workflow completion?

## 1.20 Approval and Sign-off

| Role | Name | Date | Signature |
|---|---|---|---|
| Product Owner | | | |
| Tech Lead | | | |
| DevOps Engineer | | | |
| QA Lead | | | |
