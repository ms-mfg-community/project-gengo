# Azure DevOps Pipeline 

## Convert from GitHub Actions Workflow

1. Make a copy of the github action workflow file at: $(git rev-parse --show-toplevel) + "/.github/workflows/01-gaw-level-workflow.yml" and place it at $(git rev-parse --show-toplevel) + "/.azure-pipelines" with the new name: "01-azp-level-pipeline.yml"
2. Convert this new file to an equivalent Azure pipeline yaml file so that it can be executed in Azure DevOps pipelines.

## Manually add it to an ADO project pipeline

1. Add this pipeline to the autocloudarc-mcaps ADO org and project named ado-pipeline-demos
2. Run this pipeline in Azure DevOps and view the results, ensuring that it executes without errors