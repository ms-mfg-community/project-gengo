# Basic Calculator with xUnit Testing

A .NET 8 console calculator application demonstrating arithmetic operations, proper error handling, and test-driven development practices.

## Project Structure

```text
calculator-xunit-testing/
├── calculator/                    # Console application project
│   ├── Calculator.cs             # Main calculator implementation
│   └── calculator.csproj         # Project file
├── calculator.tests/             # xUnit test project
│   ├── CalculatorTest.cs        # Unit tests
│   └── calculator.tests.csproj  # Test project file
└── calculator-xunit-testing.sln  # Solution file
```

## Features Implemented (Steps 1.12.1 - 1.12.2)

### Step 1.12.1: Solution Setup ✓

- PowerShell setup script: `Set-DotnetSlnForCalculator.ps1`
- Solution structure with console app and test projects
- Proper project references configured
- Files renamed from defaults (Program.cs → Calculator.cs, UnitTest1.cs → CalculatorTest.cs)

### Step 1.12.2: Calculator Implementation ✓

The calculator implements the following features:

- **Arithmetic Operations:**
  - Addition (+)
  - Subtraction (-)
  - Multiplication (*)
  - Division (/)

- **Input Handling:**
  - Prompts for two numeric operands
  - Prompts for arithmetic operator
  - Validates all user inputs
  - Handles invalid number inputs gracefully

- **Error Handling:**
  - Division by zero detection and prevention
  - Invalid operator detection
  - Null-safe string handling
  - Proper error messages for all error cases

- **User Experience:**
  - Loop for multiple calculations
  - User confirmation before exit
  - Clear output formatting

- **Code Quality:**
  - Top-level statements (modern C# style)
  - Nullable reference types properly handled
  - No compiler warnings
  - Clean, readable code structure

## Building and Running

### Build the Solution

```bash
cd calculator-xunit-testing
dotnet build
```

### Run the Calculator

```bash
dotnet run --project calculator
```

### Run Tests

```bash
dotnet test
```

## Usage Example

```text
Enter the first operand: 10
Enter the second operand: 5
Enter the operator (+, -, *, /): +
Result: 10 + 5 = 15

Do you want to perform another calculation? (y/n): y
Enter the first operand: 20
Enter the second operand: 4
Enter the operator (+, -, *, /): /
Result: 20 / 4 = 5

Do you want to perform another calculation? (y/n): n
Thank you for using the calculator. Goodbye!
```

## Implementation Status

This implementation completes:

- ✅ **Step 1.12.1**: Solution Setup
- ✅ **Step 1.12.2**: Calculator Implementation with null handling

Not yet implemented (future steps):

- ⏸️ **Step 1.12.3**: Refactoring (converting operations to methods)
- ⏸️ **Step 1.12.4**: Testing Strategy (comprehensive xUnit tests)
- ⏸️ **Step 1.12.5**: Final Steps (Python translation, cleanup script)

## Requirements Met

All functional requirements from the PRD have been satisfied:

- FR-1: ✓ Prompts for two operands and one operator
- FR-2: ✓ Addition operations supported
- FR-3: ✓ Subtraction operations supported
- FR-4: ✓ Multiplication operations supported
- FR-5: ✓ Division operations supported
- FR-9: ✓ Division by zero handled gracefully
- FR-10: ✓ Input validation with feedback
- FR-11: ✓ Multiple calculations without restart
- FR-12: ✓ User confirmation before exit
- FR-15: ✓ Null inputs handled properly

## Technical Details

- **Framework**: .NET 8.0
- **Language**: C# with top-level statements
- **Test Framework**: xUnit (configured, tests not yet implemented)
- **Code Style**: Modern C# with nullable reference types
- **Input Validation**: Double.TryParse with null checks
- **Error Handling**: Graceful degradation with user feedback
