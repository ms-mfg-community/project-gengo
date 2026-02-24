---
description: Create a .NET 8 console calculator application with xUnit testing framework, following best practices for testability, maintainability, and proper error handling.

name: create-basic-calculator-dotnet

agent: agent

model: Claude Haiku 4.5 (copilot)
---

\n\nCreate Basic .NET Calculator with xUnit Testing

You are an expert .NET developer helping users build a well-structured calculator application that demonstrates modern C# development practices.

\n\nObjective

Create a .NET 8 console calculator application with xUnit unit testing that supports arithmetic operations (+, -, \*, /, %, ^), proper error handling, and comprehensive test coverage.

\n\nKey Requirements

\n\nApplication Structure

\n\n.NET 8 console application using C# (not necessarily top-level statements)

\n\nSeparate xUnit test project with comprehensive test coverage
\n\nWell-organized solution following .NET project conventions
\n\nAll arithmetic operations implemented as separate, testable methods
\n\nPublic methods for testing accessibility

\n\nFunctional Requirements

\n\nSupport arithmetic operations: addition, subtraction, multiplication, division, modulo, exponent
\n\nGraceful error handling for division by zero
\n\nUser input validation with meaningful feedback
\n\nAllow multiple calculations without restarting
\n\nClear console interface with screen clearing between calculations
\n\nConfirmation before exiting application
\n\nProper null handling to prevent runtime exceptions

\n\nCode Quality Standards

\n\nFollow C# best practices and coding conventions (PascalCase for variables/functions)

\n\nInclude comprehensive XML documentation comments for all methods
\n\nImplement input validation and early returns for error conditions
\n\nUse meaningful variable names
\n\nKeep functions focused and appropriately sized
\n\nAll core functionality covered by unit tests

\n\nTesting Strategy

\n\nUse xUnit framework for unit testing
\n\nImplement Fact tests for simple assertions
\n\nUse Theory tests with InlineData for multiple test cases where appropriate
\n\nUse Fact tests instead of Theory for tests with complex assertions (edge cases)
\n\nInclude edge cases and failure scenarios (e.g., division by zero)
\n\nProvide at least three test cases per operation
\n\nEnsure all tests pass before completion
\n\nTotal target: 40+ comprehensive tests

\n\nDevelopment Workflow

\n\n1. **Automated Setup Phase** (Recommended)

Use PowerShell script for rapid, consistent initialization:

```bash
\n\nNavigate to workspace

cd programming/dotnet/csharp/workspace

\n\nExecute setup script (creates full structure automatically)

.\Set-DotnetSlnForCalculator.ps1

\n\nVerify structure created correctly

```text

# What the script does

\n\nCreates `calculator-xunit-testing` directory
\n\nInitializes .NET 8 solution (.slnx format)
\n\nCreates console application project (`calculator`)
\n\nCreates xUnit test project (`calculator.tests`)
\n\nConfigures project references automatically
\n\nHandles errors gracefully

\n\n2. **Manual Setup Phase** (Alternative)

If script is unavailable, run these commands:

```text
bash
\n\nCreate directory

mkdir calculator-xunit-testing

cd calculator-xunit-testing

\n\nCreate solution

dotnet new sln -n calculator

\n\nCreate projects

dotnet new console -n calculator --framework net8.0

dotnet new xunit -n calculator.tests --framework net8.0

\n\nAdd projects to solution

dotnet sln calculator.slnx add calculator/calculator.csproj calculator.tests/calculator.tests.csproj

\n\nConfigure references

dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj

```text
**Note**: Modern .NET templates create `.slnx` (XML solution format). Both `.sln` and `.slnx` work identically.

\n\n3. **Implementation Phase**

\n\nCalculator.cs (6 operations)

Implement each operation as a separate public method:

\n\n`Add(double, double) → double`
\n\n`Subtract(double, double) → double`
\n\n`Multiply(double, double) → double`
\n\n`Divide(double, double) → double` - throws `ArgumentException` if divisor is 0
\n\n`Modulo(double, double) → double` - throws `ArgumentException` if divisor is 0
\n\n`Power(double, double) → double`
\n\n`Operate(double, double, string operator) → double` - universal dispatcher

## Key Implementation Details

\n\nUse C# switch expressions for clean operator dispatch

\n\nAdd XML documentation (`///`) to all public members
\n\nInclude parameter descriptions and return value documentation
\n\nDocument exceptions that can be thrown
\n\nValidate operator strings (null/empty checks)

\n\nProgram.cs (Console Application)

\n\nMain method with application loop
\n\nHelper methods:
\n\n`GetNumericInput(prompt)` - numeric input with retry logic
\n\n`GetOperatorInput(prompt)` - operator validation, supports "exit" keyword
\n\n`PromptForAnotherCalculation()` - yes/no confirmation
\n\nError handling with try-catch for ArgumentException and general exceptions
\n\nConsole.Clear() between calculations for clean UX

\n\n4. **Testing Phase**

\n\nTest Organization

Organize tests into logical sections using `#region` / `#endregion`:

\n\n**Addition Tests** (Fact + Theory)
\n\n**Subtraction Tests** (Fact + Theory)
\n\n**Multiplication Tests** (Fact + Theory)
\n\n**Division Tests** (Fact + Theory + Exception)
\n\n**Modulo Tests** (Fact + Theory + Exception)
\n\n**Power Tests** (Fact + Theory)
\n\n**Operate Tests** (Theory for all operators + Exception tests)
\n\n**Edge Cases** (Fact tests for negative and decimal numbers)

\n\nTest Types

**Fact Tests** (Simple single assertions):

```text
csharp

[Fact]

public void Add_TwoPositiveNumbers_ReturnsCorrectSum()

{

    double result = _calculator.Add(5, 3);

    Assert.Equal(8, result);

}

```text
**Theory Tests** (Multiple data sets):

```text
csharp

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

```text
**Exception Tests**:

```text
csharp

[Fact]

public void Divide_ByZero_ThrowsArgumentException()

{

    Assert.Throws<ArgumentException>(() => _calculator.Divide(10, 0));

}

```text
**Edge Case Tests** (Use Fact, not Theory with mismatched data):

```text
csharp

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

```text
**Common Mistake to Avoid**:

\n\nDon't use Theory with InlineData when you have multiple operations with different expected values
\n\nUse Fact instead and test each operation individually

\n\n5. **Verification Phase**

```text
bash
\n\nBuild (verify 0 errors, 0 warnings)

dotnet build

\n\nRun tests

dotnet test

\n\nRun specific test file

dotnet test calculator.tests

\n\nRun with verbose output

dotnet test --verbosity detailed

```text

## Success Indicators

\n\nBuild: `Build succeeded. 0 Warning(s) 0 Error(s)`
\n\nTests: `Passed! - Failed: 0, Passed: 40+, Skipped: 0`

\n\n6. **Cleanup Phase**

To reset the exercise:

```text
bash
\n\nUse cleanup script

.\Remove-DotnetSlnForCalculator.ps1

\n\nOr manually

Remove-Item calculator-xunit-testing -Recurse -Force

```text
\n\nGuidelines

\n\n**Simplicity First**: Use straightforward implementations before adding complexity
\n\n**No Duplication**: Check for similar code elsewhere in the codebase
\n\n**Testability**: Design all operations as public methods that can be easily tested
\n\n**Error Handling**: Validate inputs and handle exceptions gracefully
\n\n**Test Data**: Ensure Theory test data matches the number of assertions (one expected value per InlineData)
\n\n**Documentation**: Include XML comments for each method explaining parameters and return values
\n\n**Best Practices**: Follow the copilot-instructions.md standards for C# and .NET development

\n\nCommon Implementation Patterns

\n\nUniversal Operator Dispatcher

```text
csharp

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

```text
\n\nInput Validation

```text
csharp

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

```text
\n\nReference Materials

To reference files from repository root, use:

```text
bash

$REPO_ROOT=$(git rev-parse --show-toplevel)

```text
Then access files:

\n\nPRD Location: `$REPO_ROOT/programming/dotnet/csharp/workspace/prd-csharp-basic-calculator-solution.md`
\n\nCoding Standards: `$REPO_ROOT/.github/copilot-instructions.md`
\n\nSetup Script: `$REPO_ROOT/programming/dotnet/csharp/workspace/Set-DotnetSlnForCalculator.ps1`
\n\nCleanup Script: `$REPO_ROOT/programming/dotnet/csharp/workspace/Remove-DotnetSlnForCalculator.ps1`

\n\nSuccess Criteria

\n\nAll calculator operations work correctly with valid and invalid inputs
\n\nxUnit tests cover all arithmetic operations with 40+ test cases
\n\nConsole application runs without crashes
\n\nAll build and test commands execute successfully
\n\nCode builds with 0 errors and 0 warnings
\n\nAll tests pass (100% pass rate)
\n\nComprehensive XML documentation present
\n\nClear, helpful README documentation included

\n\nExpected Output

```text
Build Status:

  Build succeeded.

    0 Warning(s)

    0 Error(s)

Test Results:

  Passed!  - Failed:     0, Passed:    43, Skipped:     0, Total:    43

```text
\n\nKey Differences from Typical Console Apps

\n\nOperations are extracted into **reusable methods** (not inline in Program.cs)
\n\nAll methods are **public** (enables testing)
\n\n**Null-safe** string handling prevents runtime exceptions
\n\n**Comprehensive error messages** aid debugging
\n\n**Test file naming**: Match calculator name (Calculator.cs → CalculatorTest.cs)
\n\n**Test class naming**: Append "Test" suffix (Calculator → CalculatorTest)

\n\nIterative Development Approach

This prompt supports iterative refinement:

\n\nStart with setup script execution
\n\nImplement core operations
\n\nWrite basic tests (Fact tests)
\n\nAdd Theory tests for multiple scenarios
\n\nAdd exception tests
\n\nTest edge cases
\n\nDocument and refactor
\n\nFinal verification

Each step can be independently tested with `dotnet test` to verify progress.

\n\nOutput Format

Provide:

\n\nClear step-by-step implementation guidance
\n\nComplete, production-ready code
\n\nExplanation of key design decisions
\n\nTest execution results showing all tests passing
\n\nSupporting automation scripts (setup/cleanup)
\n\nComplete README documentation with examples

\n
