# Projects and dependencies analysis

This document provides a comprehensive overview of the projects and their dependencies in the context of upgrading to .NETCoreApp,Version=v10.0.

## Table of Contents

- [Executive Summary](#executive-Summary)
  - [Highlevel Metrics](#highlevel-metrics)
  - [Projects Compatibility](#projects-compatibility)
  - [Package Compatibility](#package-compatibility)
  - [API Compatibility](#api-compatibility)
- [Aggregate NuGet packages details](#aggregate-nuget-packages-details)
- [Top API Migration Challenges](#top-api-migration-challenges)
  - [Technologies and Features](#technologies-and-features)
  - [Most Frequent API Issues](#most-frequent-api-issues)
- [Projects Relationship Graph](#projects-relationship-graph)
- [Project Details](#project-details)

  - [Calculator.Core\Calculator.Core.csproj](#calculatorcorecalculatorcorecsproj)
  - [calculator.tests\calculator.tests.csproj](#calculatortestscalculatortestscsproj)
  - [calculator\calculator.csproj](#calculatorcalculatorcsproj)
  - [CalculatorBlazor\CalculatorBlazor.csproj](#calculatorblazorcalculatorblazorcsproj)


## Executive Summary

### Highlevel Metrics

| Metric | Count | Status |
| :--- | :---: | :--- |
| Total Projects | 4 | All require upgrade |
| Total NuGet Packages | 4 | All compatible |
| Total Code Files | 12 |  |
| Total Code Files with Incidents | 5 |  |
| Total Lines of Code | 755 |  |
| Total Number of Issues | 5 |  |
| Estimated LOC to modify | 1+ | at least 0.1% of codebase |

### Projects Compatibility

| Project | Target Framework | Difficulty | Package Issues | API Issues | Est. LOC Impact | Description |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| [Calculator.Core\Calculator.Core.csproj](#calculatorcorecalculatorcorecsproj) | net8.0 | 🟢 Low | 0 | 0 |  | ClassLibrary, Sdk Style = True |
| [calculator.tests\calculator.tests.csproj](#calculatortestscalculatortestscsproj) | net8.0 | 🟢 Low | 0 | 0 |  | DotNetCoreApp, Sdk Style = True |
| [calculator\calculator.csproj](#calculatorcalculatorcsproj) | net8.0 | 🟢 Low | 0 | 0 |  | DotNetCoreApp, Sdk Style = True |
| [CalculatorBlazor\CalculatorBlazor.csproj](#calculatorblazorcalculatorblazorcsproj) | net8.0 | 🟢 Low | 0 | 1 | 1+ | AspNetCore, Sdk Style = True |

### Package Compatibility

| Status | Count | Percentage |
| :--- | :---: | :---: |
| ✅ Compatible | 4 | 100.0% |
| ⚠️ Incompatible | 0 | 0.0% |
| 🔄 Upgrade Recommended | 0 | 0.0% |
| ***Total NuGet Packages*** | ***4*** | ***100%*** |

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 1 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 499 |  |
| ***Total APIs Analyzed*** | ***500*** |  |

## Aggregate NuGet packages details

| Package | Current Version | Suggested Version | Projects | Description |
| :--- | :---: | :---: | :--- | :--- |
| coverlet.collector | 6.0.0 |  | [calculator.tests.csproj](#calculatortestscalculatortestscsproj) | ✅Compatible |
| Microsoft.NET.Test.Sdk | 17.8.0 |  | [calculator.tests.csproj](#calculatortestscalculatortestscsproj) | ✅Compatible |
| xunit | 2.5.3 |  | [calculator.tests.csproj](#calculatortestscalculatortestscsproj) | ✅Compatible |
| xunit.runner.visualstudio | 2.5.3 |  | [calculator.tests.csproj](#calculatortestscalculatortestscsproj) | ✅Compatible |

## Top API Migration Challenges

### Technologies and Features

| Technology | Issues | Percentage | Migration Path |
| :--- | :---: | :---: | :--- |

### Most Frequent API Issues

| API | Count | Percentage | Category |
| :--- | :---: | :---: | :--- |
| M:Microsoft.AspNetCore.Builder.ExceptionHandlerExtensions.UseExceptionHandler(Microsoft.AspNetCore.Builder.IApplicationBuilder,System.String) | 1 | 100.0% | Behavioral Change |

## Projects Relationship Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart LR
    P1["<b>📦&nbsp;calculator.csproj</b><br/><small>net8.0</small>"]
    P2["<b>📦&nbsp;calculator.tests.csproj</b><br/><small>net8.0</small>"]
    P3["<b>📦&nbsp;Calculator.Core.csproj</b><br/><small>net8.0</small>"]
    P4["<b>📦&nbsp;CalculatorBlazor.csproj</b><br/><small>net8.0</small>"]
    P1 --> P3
    P2 --> P1
    P2 --> P3
    P4 --> P3
    click P1 "#calculatorcalculatorcsproj"
    click P2 "#calculatortestscalculatortestscsproj"
    click P3 "#calculatorcorecalculatorcorecsproj"
    click P4 "#calculatorblazorcalculatorblazorcsproj"

```

## Project Details

<a id="calculatorcorecalculatorcorecsproj"></a>
### Calculator.Core\Calculator.Core.csproj

#### Project Info

- **Current Target Framework:** net8.0
- **Proposed Target Framework:** net10.0
- **SDK-style**: True
- **Project Kind:** ClassLibrary
- **Dependencies**: 0
- **Dependants**: 3
- **Number of Files**: 1
- **Number of Files with Incidents**: 1
- **Lines of Code**: 86
- **Estimated LOC to modify**: 0+ (at least 0.0% of the project)

#### Dependency Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart TB
    subgraph upstream["Dependants (3)"]
        P1["<b>📦&nbsp;calculator.csproj</b><br/><small>net8.0</small>"]
        P2["<b>📦&nbsp;calculator.tests.csproj</b><br/><small>net8.0</small>"]
        P4["<b>📦&nbsp;CalculatorBlazor.csproj</b><br/><small>net8.0</small>"]
        click P1 "#calculatorcalculatorcsproj"
        click P2 "#calculatortestscalculatortestscsproj"
        click P4 "#calculatorblazorcalculatorblazorcsproj"
    end
    subgraph current["Calculator.Core.csproj"]
        MAIN["<b>📦&nbsp;Calculator.Core.csproj</b><br/><small>net8.0</small>"]
        click MAIN "#calculatorcorecalculatorcorecsproj"
    end
    P1 --> MAIN
    P2 --> MAIN
    P4 --> MAIN

```

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 0 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 25 |  |
| ***Total APIs Analyzed*** | ***25*** |  |

<a id="calculatortestscalculatortestscsproj"></a>
### calculator.tests\calculator.tests.csproj

#### Project Info

- **Current Target Framework:** net8.0
- **Proposed Target Framework:** net10.0
- **SDK-style**: True
- **Project Kind:** DotNetCoreApp
- **Dependencies**: 2
- **Dependants**: 0
- **Number of Files**: 4
- **Number of Files with Incidents**: 1
- **Lines of Code**: 239
- **Estimated LOC to modify**: 0+ (at least 0.0% of the project)

#### Dependency Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart TB
    subgraph current["calculator.tests.csproj"]
        MAIN["<b>📦&nbsp;calculator.tests.csproj</b><br/><small>net8.0</small>"]
        click MAIN "#calculatortestscalculatortestscsproj"
    end
    subgraph downstream["Dependencies (2"]
        P1["<b>📦&nbsp;calculator.csproj</b><br/><small>net8.0</small>"]
        P3["<b>📦&nbsp;Calculator.Core.csproj</b><br/><small>net8.0</small>"]
        click P1 "#calculatorcalculatorcsproj"
        click P3 "#calculatorcorecalculatorcorecsproj"
    end
    MAIN --> P1
    MAIN --> P3

```

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 0 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 117 |  |
| ***Total APIs Analyzed*** | ***117*** |  |

<a id="calculatorcalculatorcsproj"></a>
### calculator\calculator.csproj

#### Project Info

- **Current Target Framework:** net8.0
- **Proposed Target Framework:** net10.0
- **SDK-style**: True
- **Project Kind:** DotNetCoreApp
- **Dependencies**: 1
- **Dependants**: 1
- **Number of Files**: 1
- **Number of Files with Incidents**: 1
- **Lines of Code**: 184
- **Estimated LOC to modify**: 0+ (at least 0.0% of the project)

#### Dependency Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart TB
    subgraph upstream["Dependants (1)"]
        P2["<b>📦&nbsp;calculator.tests.csproj</b><br/><small>net8.0</small>"]
        click P2 "#calculatortestscalculatortestscsproj"
    end
    subgraph current["calculator.csproj"]
        MAIN["<b>📦&nbsp;calculator.csproj</b><br/><small>net8.0</small>"]
        click MAIN "#calculatorcalculatorcsproj"
    end
    subgraph downstream["Dependencies (1"]
        P3["<b>📦&nbsp;Calculator.Core.csproj</b><br/><small>net8.0</small>"]
        click P3 "#calculatorcorecalculatorcorecsproj"
    end
    P2 --> MAIN
    MAIN --> P3

```

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 0 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 127 |  |
| ***Total APIs Analyzed*** | ***127*** |  |

<a id="calculatorblazorcalculatorblazorcsproj"></a>
### CalculatorBlazor\CalculatorBlazor.csproj

#### Project Info

- **Current Target Framework:** net8.0
- **Proposed Target Framework:** net10.0
- **SDK-style**: True
- **Project Kind:** AspNetCore
- **Dependencies**: 1
- **Dependants**: 0
- **Number of Files**: 32
- **Number of Files with Incidents**: 2
- **Lines of Code**: 246
- **Estimated LOC to modify**: 1+ (at least 0.4% of the project)

#### Dependency Graph

Legend:
📦 SDK-style project
⚙️ Classic project

```mermaid
flowchart TB
    subgraph current["CalculatorBlazor.csproj"]
        MAIN["<b>📦&nbsp;CalculatorBlazor.csproj</b><br/><small>net8.0</small>"]
        click MAIN "#calculatorblazorcalculatorblazorcsproj"
    end
    subgraph downstream["Dependencies (1"]
        P3["<b>📦&nbsp;Calculator.Core.csproj</b><br/><small>net8.0</small>"]
        click P3 "#calculatorcorecalculatorcorecsproj"
    end
    MAIN --> P3

```

### API Compatibility

| Category | Count | Impact |
| :--- | :---: | :--- |
| 🔴 Binary Incompatible | 0 | High - Require code changes |
| 🟡 Source Incompatible | 0 | Medium - Needs re-compilation and potential conflicting API error fixing |
| 🔵 Behavioral change | 1 | Low - Behavioral changes that may require testing at runtime |
| ✅ Compatible | 230 |  |
| ***Total APIs Analyzed*** | ***231*** |  |

