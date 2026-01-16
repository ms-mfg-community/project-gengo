# Azure DevOps Pipeline
\n\nUpgrade from GitHub Actions Workflow 01 to 03
\n\nCreate a new github action workflow file at $(git rev-parse --show-toplevel) + "/.github/workflows" with the new name: "03-gaw-level-pipeline.yml"
\n\nTrigger
\n\nConfigure this workflow to for a manual trigger from the main branch
\n\nGitHub Hosted Runner
\n\nCreate a job named "list-contents".\n\nUse "ubuntu-latest" as the GitHub hosted runner.\n\nDisplay the event that triggered the job\n\nDisplay the current branch name
\n\nCheck out the repository
\n\nCheck out the repository
\n\nList contents with powershell inline
\n\nCreate a new top level folder in the repository named "artifacts".\n\nList the contents of the repo recursively from the top-level using an inline powershell script and save the results in the new repository folder "artifacts" with the filename "list-contents.txt"
\n\nList contents with python script file
\n\nAdd a python script in a new folder named "src" at $(git rev-parse --show-toplevel) + "/.github/workflows". The python filename will be getDirectoryContents.py\n\nThis script should also display the entire repository contents recursively from the top level\n\nAdd a task to invoke the script from the pipeline
\n\nUpload artifacts
\n\nAdd a step to upload the results as artifacts of the previous list-contents step from the top level artifacts folder.
\n\nAdd a job
\n\nAdd a job to the pipeline named "retrieve-contents"\n\nUse the "ubuntu-latest" agent
\n\nList workflow metadata
\n\nAdd a step named "get-current-branch"\n\nFor this step, display the current branch name and the runner job id
\n\nCreate downloads folder
\n\nCreate a "downloads" folder at the repo top level if it doesn't already exist
\n\nDownload artifacts
\n\nAdd a step named "download-artifact"\n\nDownload the artifact that was previously uploaded in the list-contents job
\n\nShow artifact
\n\nUse an inline powershell script to display the artifact contents
\n\nRun the github action workflow manually
\n\nRun the workflow using the workflow_dispatch method in github.com
\n
