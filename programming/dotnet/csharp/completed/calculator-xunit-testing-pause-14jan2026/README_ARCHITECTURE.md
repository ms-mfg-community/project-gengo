# Calculator Solution - Three-Project Architecture

A comprehensive refactoring of the console calculator into a modular three-project architecture supporting Console, Blazor Server Web, and xUnit testing. The solution uses a shared library with `CalculatorService` wrapper for dependency injection and Playwright testing support.

## Solution Structure

```
calculator-xunit-testing/
├── Calculator.slnx                    # Solution file
├── calculator.shared/                 # Shared library (business logic)
│   ├── CalculatorMethods.cs          # Core arithmetic operations
│   ├── CalculatorService.cs          # Service wrapper with interface
│   └── calculator.shared.csproj
├── calculator/                        # Console application
│   ├── Calculator.cs                 # Console UI using CalculatorService
│   └── calculator.csproj
├── calculator.tests/                  # xUnit test project
│   ├── CalculatorTest.cs             # 33 comprehensive tests
│   └── calculator.tests.csproj
└── calculator.web/                    # Blazor Server web app
    ├── Program.cs                    # Service registration & configuration
    ├── App.razor                     # Root layout component
    ├── Routes.razor                  # Routing configuration
    ├── Components/
    │   ├── Pages/
    │   │   └── Calculator.razor      # Main calculator page component
    │   └── Layout/
    │       └── MainLayout.razor      # Layout wrapper
    ├── Properties/
    │   └── launchSettings.json       # Local debugging configuration
    ├── wwwroot/
    │   └── index.html                # HTML host
    ├── app.css                       # Application styles
    ├── appsettings.json              # Configuration
    └── calculator.web.csproj
```

## Projects Overview

### 1. calculator.shared (Class Library)

**Purpose:** Contains reusable business logic for all consumers (console, web, tests)

**Key Components:**

- **CalculatorMethods** - Static class with 6 arithmetic operations
  - Add, Subtract, Multiply, Divide, Modulo, Exponent
  - Error handling for division by zero and modulo by zero
  
- **ICalculatorService** - Interface for dependency injection
  - `Calculate(double, double, string)` - Performs operation via switch expression
  - `IsValidOperator(string)` - Validates operator support
  - `GetSupportedOperators()` - Returns supported operator array
  
- **CalculatorService** - Implementation of ICalculatorService
  - Delegates to CalculatorMethods
  - Provides abstraction for Playwright testing
  - Supports: +, -, *, /, %, ^

### 2. calculator (Console Application)

**Purpose:** Interactive console calculator using shared CalculatorService

**Features:**
- Uses dependency-injected ICalculatorService
- Continuous calculation loop
- Input validation with error recovery
- Dynamic operator list from service
- Graceful shutdown handling

**Run:**
```bash
dotnet run -p calculator
```

### 3. calculator.web (Blazor Server)

**Purpose:** Interactive web-based calculator with real-time UI

**Architecture:**
- Razor components with Bootstrap 5 styling
- Dependency-injected CalculatorService
- Real-time calculation results
- Calculation history tracking (last 10 calculations)
- Form validation with error messaging

**Components:**
- **Calculator.razor** - Main page component (@page "/")
  - Number input fields (step="any" for decimals)
  - Operator dropdown (dynamically populated)
  - Result display with Bootstrap alerts
  - Calculation history list
  
- **MainLayout.razor** - Layout wrapper
- **Routes.razor** - Routing configuration

**Run Locally:**
```bash
cd calculator.web
dotnet run
# App launches at https://localhost:7001
```

**Configuration:**
- Debug on `https://localhost:7001` and `http://localhost:5001`
- Browser auto-launch enabled in launchSettings.json
- Bootstrap CDN for responsive styling

### 4. calculator.tests (xUnit Test Project)

**Purpose:** Comprehensive unit test coverage of shared library

**Test Coverage:**
- **33 total tests** - All passing ✅
- **6 test classes** - One per operation
- **2 test types:**
  - Fact tests - Basic operation validation
  - Theory tests with InlineData - Parameterized edge cases

**Test Categories:**
- Positive/negative number combinations
- Zero handling
- Division by zero (returns Infinity)
- Modulo by zero (returns NaN)
- Negative exponents
- Large numbers

**Run Tests:**
```bash
dotnet test
dotnet watch test    # Watch mode for development
```

## Architecture Benefits

### Separation of Concerns
- **Business Logic** - Isolated in calculator.shared
- **UI Presentation** - Console and Blazor implementations
- **Testing** - Shared library can be tested independently

### Dependency Injection
- CalculatorService registered in DI container (Blazor)
- Supports inversion of control for testing
- Enables Playwright test automation

### Playwright Testing Ready
- ICalculatorService interface abstraction
- Mock implementation can be created
- Service methods easily testable via Blazor component
- UI elements have clear semantic structure for test selectors

### Code Reuse
- Single business logic implementation
- Multiple UI targets (Console, Web)
- Same calculations across all platforms

## Building & Testing

### Build All Projects
```bash
dotnet build
```

### Run Console App
```bash
dotnet run -p calculator
```

### Run Blazor Web App
```bash
cd calculator.web
dotnet run
```

### Run Tests
```bash
dotnet test                    # Single run
dotnet watch test              # Watch mode
dotnet test --verbosity=detailed  # Detailed output
```

### Solutions & Commands

```bash
# Verify solution integrity
dotnet sln list

# Add new project
dotnet sln add path/to/project.csproj

# Reference shared library
dotnet add project.csproj reference calculator.shared/calculator.shared.csproj
```

## Technology Stack

- **.NET 8.0** - Latest LTS framework
- **C# 12** - Modern language features (implicit usings, nullable refs)
- **Blazor Server** - Interactive web components
- **Bootstrap 5** - Responsive UI styling
- **xUnit 2.5.3** - Unit testing framework
- **Razor Components** - UI component model

## Future Enhancements

1. **Playwright Testing**
   - End-to-end web app testing
   - UI automation and validation
   - Cross-browser compatibility

2. **Enhanced Features**
   - Calculation history persistence
   - Advanced math functions
   - Keyboard shortcuts
   - Dark mode support
   - Mobile optimization

3. **Component Library Testing (bUnit)**
   - Unit test Blazor components
   - Test component state changes
   - Test event handlers

## Local Development

### Prerequisites
- .NET 8.0 SDK
- Visual Studio Code or Visual Studio 2022
- PowerShell 5.1+ (for scripts)

### Launch Blazor Web App for Testing
```powershell
cd calculator.web
dotnet run
# Opens browser at https://localhost:7001 automatically
```

### Test Locally
- Console: `dotnet run -p calculator` - Enter values interactively
- Web: Navigate to https://localhost:7001 - Use Bootstrap UI
- Tests: `dotnet test` - Verify all operations

## Notes

- **Browser Compatibility:** Blazor Server requires WebSocket support
- **Shared Library Size:** Minimal dependencies, just .NET 8.0
- **Test Coverage:** 100% of calculator operations covered
- **Error Handling:** Consistent across console and web implementations

