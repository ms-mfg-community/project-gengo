# Requirements
\n\nRun in Cloud Shell
\n\nAzure subscription with OpenAI access\n\nIf running in the Azure Cloud Shell, choose the Bash shell. The Azure CLI and Azure Developer CLI are included in the Cloud Shell.
\n\nRun locally
\n\nYou can run the web app locally after running the deployment script:\n\n[Azure Developer CLI (azd)](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)\n\n[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)\n\nAzure subscription with OpenAI access
\n\nEnvironment Variables

The `.env` file is created by the _azdeploy.sh_ script. The AI model endpoint, API key, and model name are added during the deployment of the resources.
\n\nAzure resource deployment

The provided `azdeploy.sh` creates the required resources in Azure:
\n\nChange the two variables at the top of the script to match your needs, don't change anything else.\n\nThe script:\n\nDeploys the _gpt-4o_ model using AZD.\n\nCreates Azure Container Registry service\n\nUses ACR tasks to build and deploy the Dockerfile image to ACR\n\nCreates the App Service Plan\n\nCreates the App Service Web App\n\nConfigures the web app for container image in ACR\n\nConfigures the web app environment variables\n\nThe script will provide the App Service endpoint

The script provides two deployment options: 1. Full deployment; and 2. Redeploy the image only. Option 2 is only for post-deployment when you want to experiment with changes in the application.

> Note: You can run the script in PowerShell, or Bash, using the `bash azdeploy.sh` command, this command also let's you run the script in Bash without having to make it an executable.
\n\nLocal development
\n\nProvision AI model to Azure

You can run the run the project locally and only provision the AI model following these steps:
\n\n**Initialize environment** (choose a descriptive name):

   ```bash
   azd env new gpt-realtime-lab --confirm
   # or: azd env new your-name-gpt-experiment --confirm
   ```

   **Important**: This name becomes part of your Azure resource names!
   The `--confirm` flag sets this as your default environment without prompting.
\n\n**Set your resource group**:

   ```bash
   azd env set AZURE_RESOURCE_GROUP "rg-your-name-gpt"
   ```
\n\n**Login and provision AI resources**:

   ```bash
   az login
   azd provision
   ```

   > **Important**: Do NOT run `azd deploy` - the app is not configured in the AZD templates.

If you only provisioned the model using the `azd provision` method you MUST create a `.env` file in the root of the directory with the following entries:

```
AZURE_VOICE_LIVE_ENDPOINT=""
AZURE_VOICE_LIVE_API_KEY=""
VOICE_LIVE_MODEL=""
VOICE_LIVE_VOICE="en-US-JennyNeural"
VOICE_LIVE_INSTRUCTIONS="You are a helpful AI assistant with a focus on world history. Respond naturally and conversationally. Keep your responses concise but engaging."
VOICE_LIVE_VERBOSE="" #Suppresses excessive logging to the terminal if running locally
```

Notes:
\n\nThe endpoint is the endpoint for the model and it should only include `https://<proj-name>.cognitiveservices.azure.com`.\n\nThe API key is the key for the model.\n\nThe model is the model name used during deployment.\n\nYou can retrieve these values from the AI Foundry portal.
\n\nRunning the project locally

The project was was created and managed using **uv**, but it is not required to run.

If you have **uv** installed:
\n\nRun `uv venv` to create the environment\n\nRun `uv sync` to add packages\n\nAlias created for web app: `uv run web` to start the `flask_app.py` script.\n\nrequirements.txt file created with `uv pip compile pyproject.toml -o requirements.txt`

If you don't have **uv** installed:
\n\nCreate environment: `python -m venv .venv`\n\nActivate environment: `.\.venv\Scripts\Activate.ps1`\n\nInstall dependencies: `pip install -r requirements.txt`\n\nRun application (from project root): `python .\src\real_time_voice\flask_app.py`
\n
