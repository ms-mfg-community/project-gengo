# Iterative Development Workflow: Calculator with xUnit Testing

## Overview

This document demonstrates the complete iterative development workflow for the .NET 8 Calculator application, from automated setup through testing and verification.

## Workflow Phases

### Phase 1: Automated Project Setup
**Script**: `Set-DotnetSlnForCalculator.ps1`
**Location**: `c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\workspace\`

The automated setup script creates the complete project structure in a single step:

```powershell
# Execution
.\Set-DotnetSlnForCalculator.ps1

# Output
✓ Created directory: calculator-xunit-testing
✓ Solution created: calculator.slnx
✓ Console app created: calculator/
✓ Test project created: calculator.tests/
✓ Projects added to solution
✓ Project references configured
```

**Project Structure Created**:
```
calculator-xunit-testing/
├── calculator/
│   ├── calculator.csproj
│   ├── Program.cs
│   └── Calculator.cs
├── calculator.tests/
│   ├── calculator.tests.csproj
│   └── UnitTest1.cs
└── calculator.slnx
```

### Phase 2: Core Implementation

#### Calculator.cs (Core Logic)
**Purpose**: Pure arithmetic operations library
**Lines**: ~100
**Key Operations**:
- `Add(first, second)` - Addition
- `Subtract(first, second)` - Subtraction
- `Multiply(first, second)` - Multiplication
- `Divide(first, second)` - Division with ArgumentException on zero
- `Modulo(first, second)` - Modulo with ArgumentException on zero
- `Power(first, second)` - Exponentiation using Math.Pow()
- `Operate(first, second, operator)` - Universal dispatcher with switch expressions

**Features**:
- Full XML documentation on all public members
- Input validation with meaningful error messages
- Support for negative and decimal numbers
- Zero-check exceptions for division and modulo operations

#### Program.cs (Console Interface)
**Purpose**: Interactive console application
**Lines**: ~100+
**Key Methods**:
- `Main()` - Application loop with try-catch error handling
- `GetNumericInput()` - Numeric input validation with retry logic
- `GetOperatorInput()` - Operator validation supporting "+", "-", "*", "/", "%", "^", "exit"
- `PromptForAnotherCalculation()` - Yes/no confirmation for continuing

**Features**:
- User-friendly error messages
- Input validation and retry prompts
- Exit mechanism via "exit" keyword
- Clean separation of concerns

### Phase 3: Comprehensive Testing

#### UnitTest1.cs (xUnit Test Suite)
**Total Tests**: 43
**Status**: ✅ All Passing

**Test Organization** (8 regions):

1. **Addition Tests** (2 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios (positive, negative, zero, decimal)

2. **Subtraction Tests** (2 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios

3. **Multiplication Tests** (2 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios

4. **Division Tests** (3 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios (positive, negative, decimals)
   - Exception: Division by zero throws ArgumentException

5. **Modulo Tests** (3 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios
   - Exception: Modulo by zero throws ArgumentException

6. **Power Tests** (2 tests)
   - Fact: Two positive numbers
   - Theory: Multiple scenarios (zero exponent, large exponents)

7. **Operate Tests** (3 tests)
   - Theory: All operators ("+", "-", "*", "/", "%", "^")
   - Exception: Invalid operator
   - Exception: Null operator
   - Exception: Empty operator

8. **Edge Cases** (2 tests)
   - Fact: Operations with negative numbers
   - Fact: Operations with decimal numbers

### Phase 4: Build Verification

**Command**: `dotnet build`

**Result**:
```
Build succeeded.
  0 Warning(s)
  0 Error(s)
Time Elapsed 00:00:02.20
```

### Phase 5: Test Execution

**Command**: `dotnet test --no-build`

**Result**:
```
Test run for calculator.tests.dll (.NETCoreApp,Version=v8.0)
VSTest version 18.0.1 (x64)

Passed!  - Failed:  0, Passed: 43, Skipped: 0, Total: 43, Duration: 59 ms
```

## Key Findings from Implementation

### 1. Solution Format
- Modern .NET 8 templates create `.slnx` files (XML-based solution format)
- `.slnx` format works identically to traditional `.sln` files
- Both formats are fully compatible with `dotnet` CLI

### 2. Test Data Patterns
**Theory vs Fact Tests**:
- **Theory Tests**: Use for uniform data patterns with consistent expected results
- **Fact Tests**: Use for complex multi-assertion scenarios or where data doesn't fit uniform patterns
- **Edge Cases**: Complex operations (negative numbers, decimals) work best as Fact tests

### 3. Project Structure
- Solution file references project files
- Project files specify target framework (net8.0)
- Test project references calculator project as a dependency
- Clean separation of concerns: library logic vs console UI vs tests

### 4. Error Handling Validation
- `Division(x, 0)` → ArgumentException ✓
- `Modulo(x, 0)` → ArgumentException ✓
- `Operate(x, y, null)` → ArgumentException ✓
- `Operate(x, y, "")` → ArgumentException ✓
- `Operate(x, y, invalid)` → ArgumentException ✓

### 5. Numeric Precision
- All operations handle:
  - Positive numbers ✓
  - Negative numbers ✓
  - Zero values ✓
  - Decimal numbers ✓
  - Large numbers ✓

## Iterative Development Best Practices

### 1. Automated Setup
✅ Use PowerShell scripts to create consistent project structure
✅ Eliminates manual directory/file creation errors
✅ Enables quick project reset/recreation
✅ Supports repeated builds from fresh state

### 2. Incremental Implementation
✅ Create core library first (Calculator.cs)
✅ Create console UI second (Program.cs)
✅ Create test suite last (UnitTest1.cs)
✅ Test each phase independently

### 3. Test-Driven Validation
✅ Separate Fact and Theory tests by pattern type
✅ Use InlineData for consistent data patterns
✅ Use individual Fact tests for complex scenarios
✅ Verify exception handling explicitly

### 4. Build/Test Cycles
✅ Run `dotnet build` to catch compilation errors early
✅ Run `dotnet test --no-build` to verify without rebuild
✅ Check for 0 errors and 0 warnings consistently
✅ Ensure all tests pass before proceeding

### 5. Documentation
✅ XML documentation comments on public APIs
✅ Clear method summaries and parameter descriptions
✅ Example usage patterns in comments
✅ Exception documentation for error cases

## Commands Reference

### Setup
```powershell
cd <workspace-path>
.\Set-DotnetSlnForCalculator.ps1
```

### Build
```bash
cd calculator-xunit-testing
dotnet build
```

### Test
```bash
dotnet test --no-build
```

### Run Application
```bash
cd calculator
dotnet run
```

### Clean/Reset
```powershell
.\Remove-DotnetSlnForCalculator.ps1
```

## Success Metrics

| Metric | Target | Achieved |
|--------|--------|----------|
| Build Errors | 0 | ✅ 0 |
| Build Warnings | 0 | ✅ 0 |
| Unit Tests | 40+ | ✅ 43 |
| Test Pass Rate | 100% | ✅ 100% |
| Code Coverage | All operations | ✅ Verified |
| Error Handling | All edge cases | ✅ Verified |

## Lessons Applied

1. **Fresh Setup**: Always start with clean project structure
2. **Incremental Development**: Build and test at each phase
3. **Test Organization**: Group related tests by functionality
4. **Data Pattern Matching**: Choose appropriate test type (Fact vs Theory)
5. **Error Validation**: Explicitly test all exception cases
6. **Build Cleanliness**: Maintain 0 errors, 0 warnings consistently

## Conclusion

This iterative workflow demonstrates a complete, repeatable development cycle that:
- ✅ Automates tedious setup tasks
- ✅ Enables incremental implementation and verification
- ✅ Maintains code quality through comprehensive testing
- ✅ Provides clear success metrics and validation
- ✅ Supports rapid iteration and refinement

The approach can be applied to any .NET project by adapting the PowerShell setup script and tailoring the application logic to specific requirements.
