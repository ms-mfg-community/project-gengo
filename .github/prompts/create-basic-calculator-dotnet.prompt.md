---
description: Create a .NET 8 console calculator application with xUnit testing framework, following best practices for testability, maintainability, and proper error handling.
name: create-basic-calculator-dotnet
agent: agent
model: Claude Haiku 4.5 (copilot)
---

# Create Basic .NET Calculator with xUnit Testing

You are an expert .NET developer helping users build a well-structured calculator application that demonstrates modern C# development practices.

## Objective

Create a .NET 8 console calculator application with xUnit unit testing that supports arithmetic operations (+, -, *, /, %, ^), proper error handling, and comprehensive test coverage.

## Key Requirements

### Application Structure
- .NET 8 console application using C# (not necessarily top-level statements)
- Separate xUnit test project with comprehensive test coverage
- Well-organized solution following .NET project conventions
- All arithmetic operations implemented as separate, testable methods
- Public methods for testing accessibility

### Functional Requirements
- Support arithmetic operations: addition, subtraction, multiplication, division, modulo, exponent
- Graceful error handling for division by zero
- User input validation with meaningful feedback
- Allow multiple calculations without restarting
- Clear console interface with screen clearing between calculations
- Confirmation before exiting application
- Proper null handling to prevent runtime exceptions

### Code Quality Standards
- Follow C# best practices and coding conventions (PascalCase for variables/functions)
- Include comprehensive XML documentation comments for all methods
- Implement input validation and early returns for error conditions
- Use meaningful variable names
- Keep functions focused and appropriately sized
- All core functionality covered by unit tests

### Testing Strategy
- Use xUnit framework for unit testing
- Implement Fact tests for simple assertions
- Use Theory tests with InlineData for multiple test cases where appropriate
- Use Fact tests instead of Theory for tests with complex assertions (edge cases)
- Include edge cases and failure scenarios (e.g., division by zero)
- Provide at least three test cases per operation
- Ensure all tests pass before completion
- Total target: 40+ comprehensive tests

## Development Workflow

### 1. **Automated Setup Phase** (Recommended)
Use PowerShell script for rapid, consistent initialization:
```bash
# Navigate to workspace
cd programming/dotnet/csharp/workspace

# Execute setup script (creates full structure automatically)
.\Set-DotnetSlnForCalculator.ps1

# Verify structure created correctly
```

**What the script does:**
- Creates `calculator-xunit-testing` directory
- Initializes .NET 8 solution (.slnx format)
- Creates console application project (`calculator`)
- Creates xUnit test project (`calculator.tests`)
- Configures project references automatically
- Handles errors gracefully

### 2. **Manual Setup Phase** (Alternative)
If script is unavailable, run these commands:

```bash
# Create directory
mkdir calculator-xunit-testing
cd calculator-xunit-testing

# Create solution
dotnet new sln -n calculator

# Create projects
dotnet new console -n calculator --framework net8.0
dotnet new xunit -n calculator.tests --framework net8.0

# Add projects to solution
dotnet sln calculator.slnx add calculator/calculator.csproj calculator.tests/calculator.tests.csproj

# Configure references
dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj
```

**Note**: Modern .NET templates create `.slnx` (XML solution format). Both `.sln` and `.slnx` work identically.

### 3. **Implementation Phase**

#### Calculator.cs (6 operations)
Implement each operation as a separate public method:
- `Add(double, double) → double`
- `Subtract(double, double) → double`
- `Multiply(double, double) → double`
- `Divide(double, double) → double` - throws `ArgumentException` if divisor is 0
- `Modulo(double, double) → double` - throws `ArgumentException` if divisor is 0
- `Power(double, double) → double`
- `Operate(double, double, string operator) → double` - universal dispatcher

**Key Implementation Details:**
- Use C# switch expressions for clean operator dispatch
- Add XML documentation (`///`) to all public members
- Include parameter descriptions and return value documentation
- Document exceptions that can be thrown
- Validate operator strings (null/empty checks)

#### Program.cs (Console Application)
- Main method with application loop
- Helper methods:
  - `GetNumericInput(prompt)` - numeric input with retry logic
  - `GetOperatorInput(prompt)` - operator validation, supports "exit" keyword
  - `PromptForAnotherCalculation()` - yes/no confirmation
- Error handling with try-catch for ArgumentException and general exceptions
- Console.Clear() between calculations for clean UX

### 4. **Testing Phase**

#### Test Organization
Organize tests into logical sections using `#region` / `#endregion`:
- **Addition Tests** (Fact + Theory)
- **Subtraction Tests** (Fact + Theory)
- **Multiplication Tests** (Fact + Theory)
- **Division Tests** (Fact + Theory + Exception)
- **Modulo Tests** (Fact + Theory + Exception)
- **Power Tests** (Fact + Theory)
- **Operate Tests** (Theory for all operators + Exception tests)
- **Edge Cases** (Fact tests for negative and decimal numbers)

#### Test Types

**Fact Tests** (Simple single assertions):
```csharp
[Fact]
public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
{
    double result = _calculator.Add(5, 3);
    Assert.Equal(8, result);
}
```

**Theory Tests** (Multiple data sets):
```csharp
[Theory]
[InlineData(10, 5, 15)]
[InlineData(-5, 3, -2)]
[InlineData(0, 0, 0)]
public void Add_MultipleScenarios_ReturnsCorrectSum(
    double firstOperand, double secondOperand, double expected)
{
    double result = _calculator.Add(firstOperand, secondOperand);
    Assert.Equal(expected, result);
}
```

**Exception Tests**:
```csharp
[Fact]
public void Divide_ByZero_ThrowsArgumentException()
{
    Assert.Throws<ArgumentException>(() => _calculator.Divide(10, 0));
}
```

**Edge Case Tests** (Use Fact, not Theory with mismatched data):
```csharp
[Fact]
public void Operations_WithNegativeNumbers_ReturnsCorrectResult()
{
    // Arrange & Act
    double addResult = _calculator.Add(-10, -5);
    double subtractResult = _calculator.Subtract(-10, -5);
    double multiplyResult = _calculator.Multiply(-4, -3);

    // Assert individual results
    Assert.Equal(-15, addResult);
    Assert.Equal(-5, subtractResult);
    Assert.Equal(12, multiplyResult);
}
```

**Common Mistake to Avoid**:

- Don't use Theory with InlineData when you have multiple operations with different expected values
- Use Fact instead and test each operation individually

### 5. **Verification Phase**

```bash
# Build (verify 0 errors, 0 warnings)
dotnet build

# Run tests
dotnet test

# Run specific test file
dotnet test calculator.tests

# Run with verbose output
dotnet test --verbosity detailed
```

**Success Indicators:**
- Build: `Build succeeded. 0 Warning(s) 0 Error(s)`
- Tests: `Passed! - Failed: 0, Passed: 40+, Skipped: 0`

### 6. **Cleanup Phase**

To reset the exercise:
```bash
# Use cleanup script
.\Remove-DotnetSlnForCalculator.ps1

# Or manually
Remove-Item calculator-xunit-testing -Recurse -Force
```

## Guidelines

- **Simplicity First**: Use straightforward implementations before adding complexity
- **No Duplication**: Check for similar code elsewhere in the codebase
- **Testability**: Design all operations as public methods that can be easily tested
- **Error Handling**: Validate inputs and handle exceptions gracefully
- **Test Data**: Ensure Theory test data matches the number of assertions (one expected value per InlineData)
- **Documentation**: Include XML comments for each method explaining parameters and return values
- **Best Practices**: Follow the copilot-instructions.md standards for C# and .NET development

## Common Implementation Patterns

### Universal Operator Dispatcher
```csharp
public double Operate(double firstOperand, double secondOperand, string operatorSymbol)
{
    if (string.IsNullOrWhiteSpace(operatorSymbol))
        throw new ArgumentException("Operator cannot be null or empty.");
    
    return operatorSymbol switch
    {
        "+" => Add(firstOperand, secondOperand),
        "-" => Subtract(firstOperand, secondOperand),
        "*" => Multiply(firstOperand, secondOperand),
        "/" => Divide(firstOperand, secondOperand),
        "%" => Modulo(firstOperand, secondOperand),
        "^" => Power(firstOperand, secondOperand),
        _ => throw new ArgumentException($"Unknown operator: {operatorSymbol}")
    };
}
```

### Input Validation
```csharp
private static double GetNumericInput(string prompt)
{
    while (true)
    {
        Console.Write(prompt);
        string? input = Console.ReadLine();
        
        if (string.IsNullOrWhiteSpace(input))
        {
            Console.WriteLine("Invalid input. Please enter a valid number.");
            continue;
        }
        
        if (double.TryParse(input, out double result))
            return result;
            
        Console.WriteLine("Invalid input. Please enter a valid number.");
    }
}
```

## Reference Materials

To reference files from repository root, use:

```bash
$REPO_ROOT=$(git rev-parse --show-toplevel)
```

Then access files:
- PRD Location: `$REPO_ROOT/programming/dotnet/csharp/workspace/prd-csharp-basic-calculator-solution.md`
- Coding Standards: `$REPO_ROOT/.github/copilot-instructions.md`
- Setup Script: `$REPO_ROOT/programming/dotnet/csharp/workspace/Set-DotnetSlnForCalculator.ps1`
- Cleanup Script: `$REPO_ROOT/programming/dotnet/csharp/workspace/Remove-DotnetSlnForCalculator.ps1`

## Success Criteria

- All calculator operations work correctly with valid and invalid inputs
- xUnit tests cover all arithmetic operations with 40+ test cases
- Console application runs without crashes
- All build and test commands execute successfully
- Code builds with 0 errors and 0 warnings
- All tests pass (100% pass rate)
- Comprehensive XML documentation present
- Clear, helpful README documentation included  

## Expected Output

```
Build Status:
  Build succeeded.
    0 Warning(s)
    0 Error(s)

Test Results:
  Passed!  - Failed:     0, Passed:    43, Skipped:     0, Total:    43
```

## Key Differences from Typical Console Apps

- Operations are extracted into **reusable methods** (not inline in Program.cs)
- All methods are **public** (enables testing)
- **Null-safe** string handling prevents runtime exceptions
- **Comprehensive error messages** aid debugging
- **Test file naming**: Match calculator name (Calculator.cs → CalculatorTest.cs)
- **Test class naming**: Append "Test" suffix (Calculator → CalculatorTest)

## Iterative Development Approach

This prompt supports iterative refinement:
1. Start with setup script execution
2. Implement core operations
3. Write basic tests (Fact tests)
4. Add Theory tests for multiple scenarios
5. Add exception tests
6. Test edge cases
7. Document and refactor
8. Final verification

Each step can be independently tested with `dotnet test` to verify progress.

## Output Format

Provide:
1. Clear step-by-step implementation guidance
2. Complete, production-ready code
3. Explanation of key design decisions
4. Test execution results showing all tests passing
5. Supporting automation scripts (setup/cleanup)
6. Complete README documentation with examples
