# Quick Start Guide

## Run the Blazor Web App Locally

### Option 1: Command Line
```powershell
cd calculator.web
dotnet run
# Browser opens automatically at https://localhost:7001
```

### Option 2: VS Code
1. Open the solution folder
2. Press `Ctrl+Shift+D` to open Debug view
3. Select "https" configuration
4. Press `F5` to launch

## Testing the Web App

1. **Access the App**
   - Navigate to https://localhost:7001

2. **Test Calculations**
   - Enter first number: `10`
   - Enter second number: `5`
   - Select operator: `+` (dropdown)
   - Click "Calculate"
   - Result displayed: `10 + 5 = 15`

3. **Check History**
   - Scroll down to see "Calculation History"
   - Last 10 calculations displayed
   - Each new calculation prepended to list

## Supported Operations

| Operator | Name | Example |
|----------|------|---------|
| + | Addition | 5 + 3 = 8 |
| - | Subtraction | 10 - 4 = 6 |
| * | Multiplication | 6 × 7 = 42 |
| / | Division | 20 ÷ 4 = 5 |
| % | Modulo | 10 % 3 = 1 |
| ^ | Exponent | 2 ^ 3 = 8 |

## Error Handling

- **Invalid Number:** Shows error, allows retry
- **Division by Zero:** Error message "Cannot divide by zero"
- **Invalid Operator:** Error message with valid operators list
- **Empty Inputs:** Form validation prevents submission

## Console App

### Run Console Version
```bash
dotnet run -p calculator
```

Interactive console application:
- Enter numbers at prompts
- Type operator symbol
- View result
- Press 'y' to continue, any other key to exit

## Run Tests

### All Tests
```bash
dotnet test
# Expected: 33 tests, 0 failures
```

### Watch Mode (Auto-rerun on file changes)
```bash
dotnet watch test
```

### Specific Test Class
```bash
dotnet test --filter "TestAddition"
```

## Architecture Overview

```
Shared Library (calculator.shared)
    ├── CalculatorMethods (6 operations)
    ├── ICalculatorService (interface)
    └── CalculatorService (implementation)
            ↓
    ┌───────┼───────┐
    ↓       ↓       ↓
Console   Blazor  Tests
  App      Web    (xUnit)
```

All implementations use the same business logic from shared library.

## Debugging

### VS Code Debug Console
1. Set breakpoints in components
2. Press F5 to launch with debugger
3. View variable values in Debug pane
4. Step through code with F10/F11

### Browser DevTools
1. Press F12 in browser
2. Use Console tab for JavaScript errors
3. Use Network tab to monitor API calls

## Project Files

- `Calculator.slnx` - Solution file
- `calculator.shared/calculator.shared.csproj` - Shared library
- `calculator/calculator.csproj` - Console app
- `calculator.web/calculator.web.csproj` - Blazor web app
- `calculator.tests/calculator.tests.csproj` - xUnit tests

## Common Issues

**Issue:** Port 7001 already in use
- **Fix:** Kill process on that port or change port in launchSettings.json

**Issue:** HTTPS certificate error
- **Fix:** Run `dotnet dev-certs https --trust` to trust development cert

**Issue:** Tests failing after code changes
- **Fix:** Rebuild solution (`dotnet build`) before running tests

## Next Steps

1. ✅ Web app running locally
2. Test all calculator operations
3. Add Playwright tests for UI automation
4. Deploy to Azure (optional)
5. Add additional features (history persistence, etc.)

