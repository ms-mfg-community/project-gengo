# 01-level-workflow

Create a GitHub Actions workflow named "01-level-workflow" at the path `.github/workflows/01-level-workflow.yml` that meets the following criteria:
\n\nTriggers on:\n\nPush events to the `main` branch, excluding changes in the `.github` directory.\n\nPull request events targeting the `main` branch.\n\nScheduled to run every 24 hours at midnight.\n\nManual trigger via `workflow_dispatch`.
\n\nContains a single job named "Build" that:\n\nRuns on the latest Ubuntu runner.\n\nPrints messages indicating the event that triggered the job and the branch name.\n\nChecks out the repository using `actions/checkout@v4`.\n\nLists the repository contents using the `tree` command.\n\nLists the contents of the `src` directory recursively using PowerShell.

Ensure the workflow follows best practices and includes clear inline comments explaining each step.
\n\nIn the .github\workflows\01-level-workflow.yml file:\n\nChange the job name from "Build" to "list-contents"\n\nAdd a second job named "retrieve-values"\n\nAdd a single step to this job to show the current branch
\n
