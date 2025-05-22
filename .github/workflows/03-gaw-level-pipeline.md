# Azure DevOps Pipeline

## Upgrade from GitHub Actions Workflow 01 to 03

1. Create a new github action workflow file at $(git rev-parse --show-toplevel) + "/.github/workflows" with the new name: "03-gaw-level-pipeline.yml"

## Trigger

1. Configure this workflow to for a manual trigger from the main branch

## GitHub Hosted Runner

1. Create a job named "list-contents".
2. Use "ubuntu-latest" as the GitHub hosted runner.
3. Display the event that triggered the job
4. Display the current branch name

## Check out the repository

1. Check out the repository

## List contents with powershell inline

1. Create a new top level folder in the repository named "artifacts".
2. List the contents of the repo recursively from the top-level using an inline powershell script and save the results in the new repository folder "artifacts" with the filename "list-contents.txt"

## List contents with python script file

1. Add a python script in a new folder named "src" at $(git rev-parse --show-toplevel) + "/.github/workflows". The python filename will be getDirectoryContents.py
2. This script should also display the entire repository contents recursively from the top level
3. Add a task to invoke the script from the pipeline

## Upload artifacts

1. Add a step to upload the results as artifacts of the previous list-contents step from the top level artifacts folder.

## Add a job

1. Add a job to the pipeline named "retrieve-values"
2. Use the "ubuntu-latest" agent

## List workflow metadata

1. Add a step named "get-current-branch"
2. For this step, display the current branch name and the runner job id

## Download artifacts

1. Add a step named "download-artifact"
2. Download the artifact that was previously uploaded in the list-contents job

## Show artifact

1. Use an inline powershell script to display the artifact contents

## Run the github action workflow manually

1. Run the workflow using the workflow_dispatch method in github.com