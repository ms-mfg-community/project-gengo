# Azure DevOps Pipeline 

## Convert from GitHub Actions Workflow

1. Make a copy of the github action workflow file at: $(git rev-parse --show-toplevel) + "/.github/workflows/01-gaw-level-workflow.yml" and place it at $(git rev-parse --show-toplevel) + "/.azure-pipelines" with the new name: "01-azp-level-pipeline.yml"
2. Convert this new file to an equivalent Azure pipeline yaml file so that it can be executed in Azure DevOps pipelines.

## Python

1. Add a python script in a new folder named "src" at $(git rev-parse --show-toplevel) + "/.azure-pipelines". The python filename will be getDirectoryContents.py
2. This script should display the entire repository contents recursively from the top level
3. Add a task to invoke the script from the pipeline

## Add a job

1. Add a job to the pipeline named "retrieve-values"
2. Use the "ubuntu-latest" agent
3. Add a step named "get-current-branch"
4. For this step, display the current branch name and the runner job id

## Manually add it to an ADO project pipeline

1. Add this pipeline to the autocloudarc-mcaps ADO org and project named ado-pipeline-demos
2. Run this pipeline in Azure DevOps and view the results, ensuring that it executes without errors
3. For authentication when importing this repository from GitHub, use the PAT: fleet-github-integration-pat