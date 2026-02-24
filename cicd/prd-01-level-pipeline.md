# 1. Product Requirements Document (PRD): Repository Contents Pipeline (Azure DevOps)

## 1.1 Document Information

**Version:** 1.0
**Author:** GitHub Copilot
**Date:** January 28, 2026
**Status:** Draft

## 1.2 Executive Summary

This document defines the requirements for an Azure DevOps pipeline that automates repository content listing and pipeline metadata reporting. The pipeline provides visibility into repository structure and demonstrates best practices for CI/CD automation, multiple trigger types, and cross-platform scripting within Azure DevOps.

## 1.3 Problem Statement

Development teams need an automated, repeatable way to:

- List and audit repository contents for documentation and compliance purposes
- Understand pipeline trigger contexts and branch information
- Generate structured reports that can be stored as build artifacts
- Support cross-platform scripting (PowerShell) on Azure DevOps hosted agents

Manual execution of these tasks is time-consuming, error-prone, and does not provide the auditability required for modern DevOps practices.

## 1.4 Goals and Objectives

- Automate repository content listing using multiple approaches (tree command, PowerShell)
- Provide comprehensive pipeline metadata reporting for traceability
- Support multiple trigger mechanisms (push, pull request, schedule, manual)
- Generate structured output suitable for artifact storage and review
- Demonstrate cross-platform scripting best practices in Azure DevOps
- Enable scheduled auditing of repository contents

## 1.5 Scope

### 1.5.1 In Scope

- Azure DevOps pipeline YAML definition
- Multiple pipeline triggers (CI, PR, schedule)
- Repository content listing using Linux tree command
- Directory-specific content listing using PowerShell
- Pipeline metadata reporting (branch, build reason, requested by, repository)
- Job dependencies and sequencing
- Color-coded console output for improved readability
- Path filtering to prevent recursive pipeline triggers

### 1.5.2 Out of Scope

- Artifact upload and download (covered in separate pipelines)
- File content analysis or modification
- Security scanning or compliance checking
- Integration with external systems
- Deployment or release management
- Advanced artifact retention policies

## 1.6 User Stories / Use Cases

- As a DevOps engineer, I want to automatically list repository contents so I can audit the project structure
- As a developer, I want to see pipeline trigger information so I can understand what initiated the pipeline
- As a team lead, I want to schedule daily repository audits so I can track structural changes over time
- As a contributor, I want to manually trigger the pipeline to verify repository contents on demand
- As a compliance officer, I want structured reports of repository contents for audit purposes

## 1.7 Functional Requirements

| Requirement ID | Description |
| -------------- | ------------------------------------------------------------------------------------ |
| FR-1 | The pipeline shall trigger on push events to the main branch |
| FR-2 | The pipeline shall exclude changes in the .github directory from push triggers |
| FR-3 | The pipeline shall trigger on pull requests targeting the main branch |
| FR-4 | The pipeline shall run on a schedule (daily at midnight UTC) |
| FR-5 | The pipeline shall support manual triggering via Azure DevOps UI |
| FR-6 | The pipeline shall display build reason, branch, repository, and requested by information |
| FR-7 | The pipeline shall check out repository code using the checkout task |
| FR-8 | The pipeline shall use the tree command for directory visualization |
| FR-9 | The pipeline shall display repository structure up to 3 levels deep with file sizes |
| FR-10 | The pipeline shall use PowerShell to list repository contents |
| FR-11 | The pipeline shall differentiate between directories and files with color coding |
| FR-12 | The pipeline shall display file sizes in kilobytes for PowerShell output |
| FR-13 | The pipeline shall handle cases where directories do not exist |
| FR-14 | The pipeline shall include a second job for retrieving pipeline values |
| FR-15 | The second job shall depend on the first job's completion |
| FR-16 | The pipeline shall display branch information including source branch and commit |

## 1.8 Non-Functional Requirements

- **Performance:** The pipeline shall complete within 5 minutes under normal conditions
- **Portability:** The pipeline shall run on Azure DevOps hosted ubuntu-latest agents
- **Usability:** Console output shall be clear, structured, and color-coded for readability
- **Reliability:** The pipeline shall handle missing directories gracefully without failing
- **Maintainability:** The pipeline YAML shall be well-commented and follow best practices
- **Auditability:** All output shall include appropriate metadata for traceability

## 1.9 Assumptions and Dependencies

- The repository uses Azure DevOps Pipelines for CI/CD
- Azure DevOps hosted ubuntu-latest agents are available
- PowerShell Core (pwsh) is available on ubuntu-latest agents
- The tree command is available on ubuntu-latest agents
- Users have appropriate permissions to trigger pipelines
- The repository structure may or may not include specific directories

## 1.10 Success Criteria / KPIs

- All pipeline steps complete successfully without errors
- Repository contents are displayed in a structured, readable format
- Pipeline metadata is accurate and complete
- The pipeline runs successfully on all defined triggers
- PowerShell scripts handle both existing and missing directories correctly
- Job dependencies execute in the correct sequence

## 1.11 Milestones & Timeline

**Pipeline Definition** - Complete

- YAML structure created
- Trigger configurations defined
- Job structure established

**Content Listing Implementation** - Complete

- Tree command integration
- PowerShell directory listing
- Color-coded output

**Metadata Reporting** - Complete

- Build reason display
- Branch information retrieval
- Repository context reporting

**Testing and Validation** - Complete

- Multiple trigger types tested
- Job sequencing verified
- Error handling validated

## 1.12 Implementation Guidance

### 1.12.1 Pipeline Structure

The pipeline consists of two jobs:

- **ListContents**: Lists repository contents using multiple approaches
- **RetrieveValues**: Retrieves and displays pipeline metadata

### 1.12.2 Trigger Configuration

```yaml
trigger:
  branches:
    include:
      - main
    exclude:
      - .github/**
  paths:
    exclude:
      - .github/**

pr:
  branches:
    include:
      - main

schedules:
  - cron: "0 0 * * *"
    displayName: Daily midnight run
    branches:
      include:
        - main
    always: true
```

### 1.12.3 Content Listing Approaches

#### Tree Command

- 3-level depth limit
- Human-readable file sizes
- Directories listed first
- Fallback handling if tree unavailable

#### PowerShell

- Recursive directory traversal
- Conditional directory checking
- Indented hierarchical display
- Color-coded file vs directory distinction
- File size display in KB

### 1.12.4 Job Dependencies

The `RetrieveValues` job depends on `ListContents` completion:

```yaml
- job: RetrieveValues
  dependsOn: ListContents
```

### 1.12.5 Metadata Captured

#### Build Information

- Build Reason (CI, PR, Manual, Scheduled)
- Branch name
- Repository name
- Requested by (user who triggered)

#### Branch Information

- Source branch name
- Full source branch reference
- Source version (commit SHA)
- Build ID and number

## 1.13 Technical Specifications

### 1.13.1 Agent Configuration

- **Pool:** Azure DevOps hosted
- **VM Image:** ubuntu-latest
- **Shell:** PowerShell Core (pwsh)

### 1.13.2 Required Tasks

- `checkout: self` - Repository checkout
- `PowerShell@2` - PowerShell script execution

### 1.13.3 Azure DevOps Predefined Variables Used

- `$(Build.Reason)` - Trigger type (Manual, IndividualCI, PullRequest, Schedule)
- `$(Build.SourceBranchName)` - Branch name
- `$(Build.SourceBranch)` - Full reference
- `$(Build.Repository.Name)` - Repository name
- `$(Build.RequestedFor)` - User who triggered the pipeline
- `$(Build.SourceVersion)` - Commit SHA
- `$(Build.BuildId)` - Unique build identifier
- `$(Build.BuildNumber)` - Build number
- `$(Build.Repository.Uri)` - Repository URI

## 1.14 Testing Requirements

- Verify pipeline triggers on push to main branch
- Confirm .github path filtering prevents recursive triggers
- Test pull request triggering
- Validate scheduled execution (observe cron behavior)
- Test manual pipeline run
- Verify tree command output formatting
- Test PowerShell script with existing directories
- Test PowerShell script with missing directories
- Verify job sequencing (RetrieveValues waits for ListContents)
- Validate all metadata values are correctly displayed

## 1.15 Usage Instructions

### 1.15.1 Manual Execution

1. Navigate to the Azure DevOps project
2. Go to Pipelines section
3. Select "01-level-pipeline" from the pipeline list
4. Click "Run pipeline"
5. Select the branch (default: main)
6. Click "Run" button

### 1.15.2 Viewing Results

1. Click on the pipeline run from the Pipelines list
2. Expand "List Repository Contents" job
3. Review each task's output
4. Expand "Display Pipeline Metadata" job
5. Review branch and build information

### 1.15.3 Scheduled Execution

The pipeline runs automatically at midnight UTC daily. Check the Pipelines section for scheduled run history.

## 1.16 Key Takeaways

- Multiple trigger types provide flexibility for different use cases
- Path filtering prevents infinite pipeline loops
- PowerShell scripting demonstrates cross-platform versatility
- Job dependencies enable sequential processing
- Structured output aids in auditing and documentation
- Color-coded output improves readability and user experience

## 1.17 GitHub Actions vs Azure DevOps Comparisonhttps://github.com/MSFT-DEMOS/ghcp_compete.git

| Feature | GitHub Actions | Azure DevOps |
| ------- | -------------- | ------------ |
| Trigger on push | `on: push` | `trigger:` |
| Pull request trigger | `on: pull_request` | `pr:` |
| Scheduled runs | `on: schedule` with cron | `schedules:` with cron |
| Manual trigger | `workflow_dispatch` | Run pipeline button (always available) |
| Job dependencies | `needs:` | `dependsOn:` |
| Checkout | `actions/checkout@v4` | `checkout: self` |
| PowerShell task | `shell: pwsh` | `PowerShell@2` with `pwsh: true` |
| Branch context | `github.ref_name` | `$(Build.SourceBranchName)` |
| Trigger context | `github.event_name` | `$(Build.Reason)` |
| Actor/User | `github.actor` | `$(Build.RequestedFor)` |

## 1.18 Future Enhancements

- Add artifact upload for repository content reports
- Implement file count and size statistics
- Add support for multiple directory listings
- Create comparison reports between pipeline runs
- Integrate with repository documentation generation
- Add notification system for significant structural changes

## 1.19 Related Documentation

- [Azure Pipelines Documentation](https://docs.microsoft.com/en-us/azure/devops/pipelines/)
- [YAML Schema Reference](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema)
- [Predefined Variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables)
- [PowerShell Task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/powershell)
- [Triggers in Azure Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/build/triggers)

## 1.20 Questions for Review

- Should artifact upload be added for long-term storage of reports?
- Are additional directories beyond the root needed for listing?
- Should the scheduled frequency be configurable?
- Is additional metadata needed for compliance requirements?
- Should notifications be sent on pipeline completion?

## 1.21 Approval and Sign-off

| Role | Name | Date | Signature |
| --------------- | ---- | ---- | --------- |
| Product Owner | | | |
| Tech Lead | | | |
| DevOps Engineer | | | |
| QA Lead | | | |

## 1.22 Pipeline File Location

**Target File:** `.azure-pipelines/01-level-pipeline.yml`
