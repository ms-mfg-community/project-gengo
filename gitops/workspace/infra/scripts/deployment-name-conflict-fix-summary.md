# Fix Summary: Azure Deployment Name Conflict Resolution

## Issue Description
Azure Bicep deployment was failing with error:
```
DeploymentActive: The deployment with resource id '/subscriptions/.../resourceGroups/rgp-8f714633/providers/Microsoft.Resources/deployments/userAssignedIdentityDeployment' cannot be saved, because this would overwrite an existing deployment which is still active.
```

## Root Cause
Hardcoded deployment names in Bicep modules caused conflicts when:
- Multiple deployments ran concurrently
- Previous deployments were still active/pending
- Rapid successive deployments were triggered

## Solution Applied

### 1. Main Template Changes (`gitops/workspace/infra/main.bicep`)
- Added `deploymentId` parameter to receive unique identifier from workflow
- Updated all module deployment names to use format: `moduleName-${deploymentId}`

### 2. Module Updates
Updated modules with nested deployments:
- `modules/umi.bicep`: userAssignedIdentityDeployment → userAssignedIdentityDeployment-${deploymentId}
- `modules/ais.bicep`: componentDeployment → componentDeployment-${deploymentId}
- `modules/law.bicep`: workspaceDeployment → workspaceDeployment-${deploymentId}

### 3. Workflow Updates (`.github/workflows/gaw-iac-azure-deployment.yml`)
- Fixed variable reference: `randomResourceSuffix` → `rndSuffix`
- Added `deploymentId` parameter to both what-if and deployment commands
- Uses existing random suffix: `deploymentId="${{ env.deployRndSuffix }}"`

## Technical Implementation

### Before (Problematic)
```bicep
module userAssignedIdentity 'modules/umi.bicep' = {
  name: 'userAssignedIdentityDeployment'  // ❌ Hardcoded, causes conflicts
  // ...
}
```

### After (Fixed)
```bicep
module userAssignedIdentity 'modules/umi.bicep' = {
  name: 'userAssignedIdentityDeployment-${deploymentId}'  // ✅ Unique per run
  params: {
    deploymentId: deploymentId  // Pass to child modules
    // ...
  }
}
```

## Benefits
- **Prevents Conflicts**: Each deployment gets unique names
- **Concurrent Safe**: Multiple deployments can run simultaneously
- **Minimal Changes**: Surgical fix without affecting functionality
- **Uses Existing Infrastructure**: Leverages workflow's random suffix generation
- **Future Proof**: Prevents similar issues with other modules

## Files Modified
1. `gitops/workspace/infra/main.bicep`
2. `gitops/workspace/infra/modules/umi.bicep`
3. `gitops/workspace/infra/modules/ais.bicep`
4. `gitops/workspace/infra/modules/law.bicep`
5. `.github/workflows/gaw-iac-azure-deployment.yml`

## Testing Status
- ✅ Bicep syntax validation (local test patterns)
- ✅ YAML workflow syntax validation
- ✅ Deployment name uniqueness logic confirmed
- 🟡 End-to-end deployment testing pending (requires Azure environment)

## Example Deployment Names
With `deploymentId = "8f714633"`:
- `userAssignedIdentityDeployment-8f714633`
- `applicationInsightsDeployment-8f714633`
- `logAnalyticsWorkspaceDeployment-8f714633`

This ensures each deployment run has completely unique names, eliminating the "DeploymentActive" error.