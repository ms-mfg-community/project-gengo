---
description: "Create, update, or review Azure IaC in Terraform using Azure Verified Modules (AVM)."

name: "azure-verified-modules-terraform"

tools:
  [
    "changes",

    "search/codebase",

    "edit/editFiles",

    "extensions",

    "fetch",

    "githubRepo",

    "new",

    "openSimpleBrowser",

    "problems",

    "runCommands",

    "runTasks",

    "runTests",

    "search",

    "search/searchResults",

    "runCommands/terminalLastCommand",

    "runCommands/terminalSelection",

    "testFailure",

    "usages",

    "vscodeAPI",
  ]
---

\n\nAzure AVM Terraform mode

Use Azure Verified Modules for Terraform to enforce Azure best practices via pre-built modules.

\n\nDiscover modules

\n\nTerraform Registry: search "avm" + resource, filter by Partner tag.
\n\nAVM Index: `https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/`

\n\nUsage

\n\n**Examples**: Copy example, replace `source = "../../"` with `source = "Azure/avm-res-{service}-{resource}/azurerm"`, add `version`, set `enable_telemetry`.
\n\n**Custom**: Copy Provision Instructions, set inputs, pin `version`.

\n\nVersioning

\n\nEndpoint: `https://registry.terraform.io/v1/modules/Azure/{module}/azurerm/versions`

\n\nSources

\n\nRegistry: `https://registry.terraform.io/modules/Azure/{module}/azurerm/latest`
\n\nGitHub: `https://github.com/Azure/terraform-azurerm-avm-res-{service}-{resource}`

\n\nNaming conventions

\n\nResource: Azure/avm-res-{service}-{resource}/azurerm
\n\nPattern: Azure/avm-ptn-{pattern}/azurerm
\n\nUtility: Azure/avm-utl-{utility}/azurerm

\n\nBest practices

\n\nPin module and provider versions
\n\nStart with official examples
\n\nReview inputs and outputs
\n\nEnable telemetry
\n\nUse AVM utility modules
\n\nFollow AzureRM provider requirements
\n\nAlways run `terraform fmt` and `terraform validate` after making changes
\n\nUse `azure_get_deployment_best_practices` tool for deployment guidance
\n\nUse `microsoft.docs.mcp` tool to look up Azure service-specific guidance

\n\nCustom Instructions for GitHub Copilot Agents

**IMPORTANT**: When GitHub Copilot Agent or GitHub Copilot Coding Agent is working on this repository, the following local unit tests MUST be executed to comply with PR checks. Failure to run these tests will cause PR validation failures:

```bash

./avm pre-commit

./avm tflint

./avm pr-check

```text
These commands must be run before any pull request is created or updated to ensure compliance with the Azure Verified Modules standards and prevent CI/CD pipeline failures.

More details on the AVM process can be found in the [Azure Verified Modules Contribution documentation](https://azure.github.io/Azure-Verified-Modules/contributing/terraform/testing/).

\n
