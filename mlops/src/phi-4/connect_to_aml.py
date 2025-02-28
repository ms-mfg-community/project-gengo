from azureml.core import Workspace

# Connect to the workspace
ws = Workspace.from_config(path="config.json")
print("Workspace connected:", ws.name)
