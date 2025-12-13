---
agent: agent
description: Translate a basic workflow at "$(git rev-parse --show-toplevel)\.github\workflows\01-level-workflow.yml" from GitHub Actions to Azure DevOps Pipelines 
name: translate-workflow-to-pipeline
tools: ['azuredevops/*', 'github/*']
model: Claude Haiku 4.5 (copilot)
---

# Context
To simplify the migration from GitHub Actions to Azure DevOps Pipelines, we need to convert existing GitHub workflow files into Azure DevOps pipeline YAML files.

# Intent
As a developer responsible for maintaining CI/CD processes, I want to automate the translation of GitHub workflow files into Azure DevOps pipeline YAML files. This will help streamline our migration process and ensure consistency between the two systems.

# Specific Request
Translate the basic workflow at: "$(git rev-parse --show-toplevel)\.github\workflows\01-level-workflow.yml" to an equivalent azure devops pipeline YAML and save it in the directory "$(git rev-parse --show-toplevel)\.azure-pipelines\01-level-pipeline.yml".

# Guidelines
- Ensure that all GitHub Actions specific syntax and features are appropriately mapped to their Azure DevOps counterparts.
- Maintain the logical structure and flow of the original workflow in the translated pipeline.
- Validate the generated Azure DevOps pipeline YAML for correctness and completeness.
- If there are any features in the GitHub workflow that do not have a direct equivalent in Azure DevOps, provide a comment in the generated YAML indicating this.
- Preserve any environment variables, secrets, and other configurations as much as possible.  
- If the 01-level-pipeline.yml file already exists, overwrite it with the new translation.

# Caveats
- Some GitHub Actions may not have direct equivalents in Azure DevOps; in such cases, provide alternative solutions or workarounds.
- Ensure that any third-party actions used in the GitHub workflow are either replaced with native Azure DevOps tasks or documented for manual implementation.
- Pay attention to differences in syntax, especially for conditionals, loops, and job dependencies.
- When displaying the default branch in Azure DevOps pipelines, do not attempt to display the default branch, since in Azure DevOps, we would have to fetch it via the Azure DevOps REST API or set it as a pipeline variable manually beforehand, which is outside the scope of this simple translation task.