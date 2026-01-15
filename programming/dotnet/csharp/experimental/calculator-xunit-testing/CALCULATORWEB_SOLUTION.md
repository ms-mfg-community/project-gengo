# CalculatorWeb.sln - Consolidated Solution

## Overview

? **Successfully created** `CalculatorWeb.sln` - a consolidated solution combining Calculator.Core and CalculatorBlazor projects into a single, unified solution for easier management and deployment.

**Location:** `programming\dotnet\csharp\experimental\calculator-xunit-testing\CalculatorWeb.sln`

## Solution Contents

### Projects Included

```
CalculatorWeb.sln
??? Calculator.Core (Class Library)
?   ??? Calculator.Core.csproj
?       ??? CalculatorEngine.cs (Public API)
?       ??? Namespace: Calculator.Core
?
??? CalculatorBlazor (Blazor Web Application)
    ??? CalculatorBlazor.csproj
        ??? Components/Calculator.razor (Interactive UI)
        ??? Pages/Index.razor (Home page)
        ??? Shared/MainLayout.razor (Layout)
        ??? Namespace: Calculator.Blazor
```

## Build Status

? **Build Succeeded** (2.6s)

```
Calculator.Core net8.0     ? Calculator.Core\bin\Debug\net8.0\Calculator.Core.dll
CalculatorBlazor net8.0    ? CalculatorBlazor\bin\Debug\net8.0\CalculatorBlazor.dll
```

## Solution Structure

### Dependency Graph

```
????????????????????????????????????????
?      CalculatorWeb.sln               ?
????????????????????????????????????????
               ?
        ???????????????
        ?             ?
        ?             ?
   ???????????  ??????????????
   ? Calc    ?  ? Calculator ?
   ? .Core   ???? Blazor     ?
   ? (Lib)   ?  ? (WebApp)   ?
   ???????????  ??????????????
   - Add        - UI
   - Subtract   - Forms
   - Multiply   - Results
   - Divide
   - Modulo
   - Exponent
```

## Quick Commands

### Build the Solution
```powershell
cd C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\experimental\calculator-xunit-testing

dotnet build CalculatorWeb.sln
```

### Run the Blazor Application
```powershell
dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj
```

Then open: **https://localhost:7264** or **http://localhost:5073**

### Clean Build
```powershell
dotnet clean CalculatorWeb.sln
dotnet build CalculatorWeb.sln
```

### List All Projects
```powershell
dotnet sln CalculatorWeb.sln list
```

Expected Output:
```
Project(s)
----------
Calculator.Core\Calculator.Core.csproj
CalculatorBlazor\CalculatorBlazor.csproj
```

## Architecture

### Calculator.Core (Shared Library)
- **Purpose:** Core arithmetic operations library
- **Type:** Class Library (.NET 8.0)
- **Public API:** `Calculator.Core.CalculatorEngine`
- **Operations:** Add, Subtract, Multiply, Divide, Modulo, Exponent
- **Dependencies:** None (pure logic)

### CalculatorBlazor (Web Application)
- **Purpose:** Interactive web-based calculator interface
- **Type:** Blazor Server Application (.NET 8.0)
- **Runtime Ports:** 
  - HTTPS: 7264
  - HTTP: 5073
- **Dependencies:** Calculator.Core
- **Features:**
  - Real-time calculation
  - Bootstrap UI
  - Error handling
  - Result display

## Configuration

### Solution Platforms
- Debug|Any CPU
- Release|Any CPU

### Projects Configuration
Both projects configured for:
- ? .NET 8.0 (`net8.0`)
- ? Latest C# version (`LangVersion: latest`)
- ? Implicit usings (`ImplicitUsings: enable`)
- ? Nullable reference types (`Nullable: enable`)
- ? XML documentation (`GenerateDocumentationFile: true`)

## Benefits of This Consolidation

| Benefit | Description |
|---------|-------------|
| **Single Build** | `dotnet build CalculatorWeb.sln` builds both projects |
| **Unified Versions** | All projects use same .NET target framework |
| **Clear Dependencies** | Visualize relationship between projects |
| **Easier Deployment** | Deploy entire solution as a unit |
| **Simplified CI/CD** | One build step instead of multiple |
| **Team Collaboration** | New developers see complete architecture |
| **Easy Upgrades** | Upgrade all projects to .NET 10.0 together |

## Usage Scenarios

### Scenario 1: Build for Development
```powershell
dotnet build CalculatorWeb.sln --configuration Debug
```

### Scenario 2: Build for Production
```powershell
dotnet build CalculatorWeb.sln --configuration Release
```

### Scenario 3: Publish the Application
```powershell
dotnet publish CalculatorWeb.sln --configuration Release --output ./publish
```

## Integration with Visual Studio

Open `CalculatorWeb.sln` in Visual Studio 2022:

1. **Solution Explorer** shows both projects
2. **Right-click solution** ? Build Solution
3. **Right-click project** ? Properties to configure individual projects
4. **Debug** ? Start Debugging to run CalculatorBlazor
5. **View** ? Solution Explorer to see project structure

## Next Steps

### 1. ? Immediate (Ready Now)
- Build: `dotnet build CalculatorWeb.sln`
- Run: `dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj`
- Test: https://localhost:7264

### 2. ?? Recommended (Optional)
- Add to version control: `git add CalculatorWeb.sln`
- Create CI/CD pipeline using CalculatorWeb.sln
- Set as default solution for team development

### 3. ?? Future Enhancement
- Upgrade to .NET 10.0 (change `net8.0` ? `net10.0`)
- Add additional projects (tests, services, etc.)
- Deploy to Azure App Service or Docker

## Migration from calculator.sln

The original `calculator.sln` has 4 projects:
- calculator (Console)
- calculator.tests (Tests)
- Calculator.Core (Library)
- CalculatorBlazor (Web)

The new `CalculatorWeb.sln` focuses on:
- Calculator.Core (Library)
- CalculatorBlazor (Web)

**Result:** Simpler, focused solution for web-based calculator

## File Locations

```
calculator-xunit-testing/
??? CalculatorWeb.sln              ? New consolidated solution
??? calculator.sln                 ? Original full solution
??? Calculator.Core/
?   ??? Calculator.Core.csproj
?   ??? CalculatorEngine.cs
?   ??? bin/Debug/net8.0/
?       ??? Calculator.Core.dll
??? CalculatorBlazor/
?   ??? CalculatorBlazor.csproj
?   ??? Components/
?   ?   ??? Calculator.razor
?   ??? Pages/
?   ?   ??? Index.razor
?   ?   ??? _Host.cshtml
?   ??? Shared/
?   ?   ??? MainLayout.razor
?   ?   ??? NavMenu.razor
?   ??? bin/Debug/net8.0/
?       ??? CalculatorBlazor.dll
??? ... other files
```

## Troubleshooting

### Issue: "Cannot find project"
**Solution:** Verify file paths are correct relative to solution file location

### Issue: Port 7264 already in use
**Solution:** 
```powershell
dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj -- --urls "https://localhost:7265"
```

### Issue: Calculator.Core not found in CalculatorBlazor
**Solution:** Ensure Calculator.Core/Calculator.Core.csproj exists and is referenced

## Summary

? **CalculatorWeb.sln successfully created and verified**

- **2 Projects:** Calculator.Core + CalculatorBlazor
- **Build Status:** ? Success (2.6s)
- **Purpose:** Consolidated solution for web-based calculator
- **Ready for:** Development, testing, deployment, and .NET upgrades

**Start using it:**
```powershell
cd C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\experimental\calculator-xunit-testing
dotnet build CalculatorWeb.sln
dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj
```

Then open: **https://localhost:7264**
