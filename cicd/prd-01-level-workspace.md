# 1. Product Requirements Document (PRD): Repository Contents Workflow
\n\n1.1 Document Information
\n\n**Version:** 1.0\n\n**Author:** GitHub Copilot\n\n**Date:** December 3, 2025\n\n**Status:** Draft
\n\n1.2 Executive Summary

This document defines the requirements for a GitHub Actions workflow that automates repository content listing and workflow metadata reporting. The workflow provides visibility into repository structure and demonstrates best practices for CI/CD automation, multiple trigger types, and cross-platform scripting.
\n\n1.3 Problem Statement

Development teams need an automated, repeatable way to:
\n\nList and audit repository contents for documentation and compliance purposes\n\nUnderstand workflow trigger contexts and branch information\n\nGenerate structured reports that can be stored as build artifacts\n\nSupport both Linux-native tools (tree) and cross-platform scripting (PowerShell)

Manual execution of these tasks is time-consuming, error-prone, and does not provide the auditability required for modern DevOps practices.
\n\n1.4 Goals and Objectives
\n\nAutomate repository content listing using multiple approaches (tree command, PowerShell)\n\nProvide comprehensive workflow metadata reporting for traceability\n\nSupport multiple trigger mechanisms (push, pull request, schedule, manual)\n\nGenerate structured output suitable for artifact storage and review\n\nDemonstrate cross-platform scripting best practices\n\nEnable scheduled auditing of repository contents
\n\n1.5 Scope
\n\n1.5.1 In Scope
\n\nGitHub Actions workflow YAML definition\n\nMultiple workflow triggers (push, PR, schedule, manual)\n\nRepository content listing using Linux tree command\n\nDirectory-specific content listing using PowerShell\n\nWorkflow metadata reporting (branch, event, actor, repository)\n\nJob dependencies and sequencing\n\nColor-coded console output for improved readability\n\nPath filtering to prevent recursive workflow triggers
\n\n1.5.2 Out of Scope
\n\nArtifact upload and download (covered in separate workflows)\n\nFile content analysis or modification\n\nSecurity scanning or compliance checking\n\nIntegration with external systems\n\nDeployment or release management\n\nAdvanced artifact retention policies
\n\n1.6 User Stories / Use Cases
\n\nAs a DevOps engineer, I want to automatically list repository contents so I can audit the project structure\n\nAs a developer, I want to see workflow trigger information so I can understand what initiated the workflow\n\nAs a team lead, I want to schedule daily repository audits so I can track structural changes over time\n\nAs a contributor, I want to manually trigger the workflow to verify repository contents on demand\n\nAs a compliance officer, I want structured reports of repository contents for audit purposes
\n\n1.7 Functional Requirements

| Requirement ID | Description                                                                          |
| -------------- | ------------------------------------------------------------------------------------ |
| FR-1           | The workflow shall trigger on push events to the main branch                         |
| FR-2           | The workflow shall exclude changes in the .github directory from push triggers       |
| FR-3           | The workflow shall trigger on pull requests targeting the main branch                |
| FR-4           | The workflow shall run on a schedule (daily at midnight UTC)                         |
| FR-5           | The workflow shall support manual triggering via workflow_dispatch                   |
| FR-6           | The workflow shall display event name, branch, repository, and actor information     |
| FR-7           | The workflow shall check out repository code using actions/checkout@v4               |
| FR-8           | The workflow shall install and use the tree command for directory visualization      |
| FR-9           | The workflow shall display repository structure up to 3 levels deep with file sizes  |
| FR-10          | The workflow shall use PowerShell to list contents of the src directory              |
| FR-11          | The workflow shall differentiate between directories and files with color coding     |
| FR-12          | The workflow shall display file sizes in kilobytes for PowerShell output             |
| FR-13          | The workflow shall handle cases where the src directory does not exist               |
| FR-14          | The workflow shall include a second job for retrieving workflow values               |
| FR-15          | The second job shall depend on the first job's completion                            |
| FR-16          | The workflow shall display branch information including ref names and default branch |
\n\n1.8 Non-Functional Requirements
\n\n**Performance:** The workflow shall complete within 5 minutes under normal conditions\n\n**Portability:** The workflow shall run on GitHub-hosted ubuntu-latest runners\n\n**Usability:** Console output shall be clear, structured, and color-coded for readability\n\n**Reliability:** The workflow shall handle missing directories gracefully without failing\n\n**Maintainability:** The workflow YAML shall be well-commented and follow best practices\n\n**Auditability:** All output shall include appropriate metadata for traceability
\n\n1.9 Assumptions and Dependencies
\n\nThe repository uses GitHub Actions for CI/CD\n\nGitHub-hosted ubuntu-latest runners are available\n\nPowerShell Core (pwsh) is available on ubuntu-latest runners\n\nThe tree command can be installed via apt-get\n\nUsers have appropriate permissions to trigger workflows\n\nThe repository structure may or may not include a src directory
\n\n1.10 Success Criteria / KPIs
\n\nAll workflow steps complete successfully without errors\n\nRepository contents are displayed in a structured, readable format\n\nWorkflow metadata is accurate and complete\n\nThe workflow runs successfully on all defined triggers\n\nPowerShell scripts handle both existing and missing directories correctly\n\nJob dependencies execute in the correct sequence
\n\n1.11 Milestones & Timeline
\n\n**Workflow Definition** - Complete\n\nYAML structure created\n\nTrigger configurations defined\n\nJob structure established
\n\n**Content Listing Implementation** - Complete\n\nTree command integration\n\nPowerShell directory listing\n\nColor-coded output
\n\n**Metadata Reporting** - Complete\n\nEvent information display\n\nBranch information retrieval\n\nRepository context reporting
\n\n**Testing and Validation** - Complete\n\nMultiple trigger types tested\n\nJob sequencing verified\n\nError handling validated
\n\n1.12 Implementation Guidance
\n\n1.12.1 Workflow Structure

The workflow consists of two jobs:
\n\n**list-contents**: Lists repository contents using multiple approaches\n\n**retrieve-values**: Retrieves and displays workflow metadata
\n\n1.12.2 Trigger Configuration

```yaml
on:
  push:
    branches: [main]
    paths-ignore: [".github/**"]
  pull_request:
    branches: [main]
  schedule:\n\ncron: "0 0 * * *"
  workflow_dispatch:
```
\n\n1.12.3 Content Listing Approaches

**Tree Command:**
\n\n3-level depth limit\n\nHuman-readable file sizes\n\nDirectories listed first\n\nColor-coded output

**PowerShell:**
\n\nRecursive directory traversal\n\nConditional directory checking\n\nIndented hierarchical display\n\nColor-coded file vs directory distinction\n\nFile size display in KB
\n\n1.12.4 Job Dependencies

The `retrieve-values` job depends on `list-contents` completion:

```yaml
needs: list-contents
```
\n\n1.12.5 Metadata Captured

**Event Information:**
\n\nWorkflow trigger type\n\nBranch name\n\nRepository full name\n\nTriggering actor

**Branch Information:**
\n\nCurrent branch name\n\nFull reference path\n\nPR head and base references\n\nDefault branch name
\n\n1.13 Technical Specifications
\n\n1.13.1 Runner Configuration
\n\n**Platform:** ubuntu-latest\n\n**Shell Options:** bash (default), pwsh (PowerShell steps)
\n\n1.13.2 Required Actions
\n\n`actions/checkout@v4` - Repository checkout
\n\n1.13.3 Required Packages
\n\n`tree` - Directory visualization (installed via apt-get)
\n\n1.13.4 GitHub Context Variables Used
\n\n`github.event_name` - Trigger type\n\n`github.ref_name` - Branch name\n\n`github.ref` - Full reference\n\n`github.repository` - Repository full name\n\n`github.actor` - User who triggered the workflow\n\n`github.head_ref` - PR head reference\n\n`github.base_ref` - PR base reference\n\n`github.event.repository.default_branch` - Default branch
\n\n1.14 Testing Requirements
\n\nVerify workflow triggers on push to main branch\n\nConfirm .github path filtering prevents recursive triggers\n\nTest pull request triggering\n\nValidate scheduled execution (observe cron behavior)\n\nTest manual workflow dispatch\n\nVerify tree command output formatting\n\nTest PowerShell script with existing src directory\n\nTest PowerShell script with missing src directory\n\nVerify job sequencing (retrieve-values waits for list-contents)\n\nValidate all metadata values are correctly displayed
\n\n1.15 Usage Instructions
\n\n1.15.1 Manual Execution
\n\nNavigate to the repository on GitHub\n\nGo to Actions tab\n\nSelect "01-level-workflow" from the workflow list\n\nClick "Run workflow"\n\nSelect the branch (default: main)\n\nClick "Run workflow" button
\n\n1.15.2 Viewing Results
\n\nClick on the workflow run from the Actions list\n\nExpand "List Repository Contents" job\n\nReview each step's output\n\nExpand "Retrieve Workflow Values" job\n\nReview branch and event information
\n\n1.15.3 Scheduled Execution

The workflow runs automatically at midnight UTC daily. Check the Actions tab for scheduled run history.
\n\n1.16 Key Takeaways
\n\nMultiple trigger types provide flexibility for different use cases\n\nPath filtering prevents infinite workflow loops\n\nCross-platform scripting (bash + PowerShell) demonstrates versatility\n\nJob dependencies enable sequential processing\n\nStructured output aids in auditing and documentation\n\nColor-coded output improves readability and user experience
\n\n1.17 Future Enhancements
\n\nAdd artifact upload for repository content reports\n\nImplement file count and size statistics\n\nAdd support for multiple directory listings\n\nCreate comparison reports between workflow runs\n\nIntegrate with repository documentation generation\n\nAdd notification system for significant structural changes
\n\n1.18 Related Documentation
\n\n[GitHub Actions Documentation](https://docs.github.com/en/actions)\n\n[GitHub Actions Context](https://docs.github.com/en/actions/learn-github-actions/contexts)\n\n[Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)\n\n[Tree Command Manual](https://linux.die.net/man/1/tree)\n\n[PowerShell Get-ChildItem](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)
\n\n1.19 Questions for Review
\n\nShould artifact upload be added for long-term storage of reports?\n\nAre additional directories beyond src needed for listing?\n\nShould the scheduled frequency be configurable?\n\nIs additional metadata needed for compliance requirements?\n\nShould notifications be sent on workflow completion?
\n\n1.20 Approval and Sign-off

| Role            | Name | Date | Signature |
| --------------- | ---- | ---- | --------- |
| Product Owner   |      |      |           |
| Tech Lead       |      |      |           |
| DevOps Engineer |      |      |           |
| QA Lead         |      |      |           |
\n
