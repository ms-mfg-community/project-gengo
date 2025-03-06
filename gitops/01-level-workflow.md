Create a GitHub Actions workflow named "01-level-workflow" that meets the following criteria:

- Triggers on:
  - Push events to the `main` branch, excluding changes in the `.github` directory.
  - Pull request events targeting the `main` branch.
  - Scheduled to run every 24 hours at midnight.
  - Manual trigger via `workflow_dispatch`.

- Contains a single job named "Build" that:
  - Runs on the latest Ubuntu runner.
  - Prints messages indicating the event that triggered the job and the branch name.
  - Checks out the repository using `actions/checkout@v4`.
  - Lists the repository contents using the `tree` command.
  - Lists the contents of the `src` directory recursively using PowerShell.

Ensure the workflow follows best practices and includes clear inline comments explaining each step.

- In the .github\workflows\01-level-workflow.yml file:
  - Change the job name from "Build" to "list-contents"
  - Add a second job named "retrieve-values"
  - Add a single step to this job to show the current branch