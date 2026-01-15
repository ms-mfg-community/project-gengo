# CalculatorWeb.sln - Quick Start Guide

## ?? Location
```
C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\experimental\calculator-xunit-testing\CalculatorWeb.sln
```

## ?? Quick Commands

### Build
```powershell
cd C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\experimental\calculator-xunit-testing
dotnet build CalculatorWeb.sln
```

### Run
```powershell
dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj
```

### Open in Browser
```
https://localhost:7264
```

## ?? Solution Contents

| Project | Type | Purpose |
|---------|------|---------|
| **Calculator.Core** | Class Library | Arithmetic operations engine |
| **CalculatorBlazor** | Blazor Web App | Interactive web UI |

## ? Build Status

? **Success** - Both projects build without errors
- Calculator.Core: ? Ready
- CalculatorBlazor: ? Ready

## ?? Configuration

- **.NET Version:** 8.0
- **HTTPS Port:** 7264
- **HTTP Port:** 5073
- **Configuration:** Debug|Any CPU, Release|Any CPU

## ?? Documentation

See `CALCULATORWEB_SOLUTION.md` for detailed information.

## ?? What's Included

? Calculator.Core library with 6 operations
? CalculatorBlazor web application
? Interactive calculator component
? Error handling (division by zero, etc.)
? Bootstrap UI styling
? Full integration between projects

## ?? Next Steps

1. Build: `dotnet build CalculatorWeb.sln`
2. Run: `dotnet run --project CalculatorBlazor\CalculatorBlazor.csproj`
3. Test: Open https://localhost:7264
4. Calculate: Use the interactive calculator UI

## ?? Tips

- Use `dotnet clean CalculatorWeb.sln` to clear build artifacts
- Use `--configuration Release` for production builds
- Both projects automatically update together in this solution

---

**Created:** CalculatorWeb.sln - Consolidated solution combining Calculator.Core and CalculatorBlazor
**Status:** ? Ready for development, testing, and deployment
