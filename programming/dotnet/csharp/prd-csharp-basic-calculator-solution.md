# Product Requirements Document: .NET Calculator with xUnit Testing

## 1. Document Information

- **Version:** 1.0
- **Author:** [Your Name]
- **Date:** [YYYY-MM-DD]
- **Status:** Draft

## 2. Executive Summary

This document describes the requirements for a basic .NET 8 console calculator application with xUnit-based unit testing. The calculator will support basic arithmetic operations and provide a simple user interface for repeated calculations.

## 3. Problem Statement

There is a need for a simple, interactive calculator application that demonstrates .NET 8 console programming and test-driven development using xUnit. The solution should be easy to set up, run, and extend.

## 4. Goals and Objectives

- Provide a .NET 8 console calculator supporting +, -, *, / operations.
- Enable repeated calculations in a user-friendly loop.
- Ensure code is testable with xUnit and follows best practices.
- Demonstrate solution setup, build, run, and test workflows.

## 5. Scope

**In Scope:**
- .NET 8 console application project (`calculator`)
- xUnit test project (`calculator.tests`)
- Arithmetic operations: addition, subtraction, multiplication, division
- User prompt and loop for repeated calculations
- Refactoring for testability

**Out of Scope:**
- Advanced math functions (beyond +, -, *, /)
- GUI or web interface
- Persistence or external data storage

## 6. User Stories / Use Cases

- As a user, I want to perform basic arithmetic calculations interactively.
- As a developer, I want to run unit tests to verify calculator operations.
- As a user, I want to repeat calculations until I choose to exit.

## 7. Functional Requirements

- The calculator shall prompt for two operands and an operator (+, -, *, /).
- The calculator shall display the result of the operation.
- The calculator shall ask the user if they want to perform another calculation.
- The calculator shall terminate with a friendly message if the user chooses not to continue.
- Each arithmetic operation shall be implemented as a separate method for testability.

## 8. Non-Functional Requirements

- The application must run on .NET 8.
- The code must be organized for clarity and maintainability.
- Unit tests must cover all arithmetic operations and edge cases (e.g., division by zero).
- The solution must be buildable and runnable via standard .NET CLI commands.

## 9. Assumptions and Dependencies

- .NET 8 SDK is installed.
- xUnit is used for unit testing.
- The solution is managed via the .NET CLI and compatible with Visual Studio 2022.

## 10. Success Criteria / KPIs

- All calculator operations are correct and covered by passing unit tests.
- The application runs without errors or unhandled exceptions.
- The user experience is clear and repeatable.
- The solution can be set up and built using the provided scripts and instructions.

## 11. Milestones & Timeline

- Solution and project setup script: [Date]
- Initial calculator implementation: [Date]
- Unit test implementation: [Date]
- Refactoring and documentation: [Date]
- Final review and acceptance: [Date]

## 12. Appendix A: Demonstration Sequence

### 12.1 Solution Setup

1. Create a PowerShell script named `Set-DotnetSlnForCalculator.ps1` in the `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\workspace` directory.
2. Add content to the script to perform the following steps (each as a comment in the script):
   - Create a new folder for the solution named `calculator-xunit-testing`.
   - Change into the newly created solution directory.
   - Create a new solution named `calculator-xunit-testing`.
   - Create a .NET 8 console application project named `calculator` (without an explicit Main method) and rename `Program.cs` to `Calculator.cs`.
   - Add the calculator project to the solution.
   - Create a new xUnit test project named `calculator.tests`, targeting .NET 8, and rename `UnitTest1.cs` to `CalculatorTest.cs`.
   - Add a project reference from `calculator.tests` to `calculator`.
   - Add the `calculator.tests` project to the solution.
   - Use `dotnet new sln`, `dotnet new console`, `dotnet sln add`, and `dotnet add reference` commands in the correct order.

### 12.2 Prepare

- Execute the `Set-DotnetSolutionForUnitTesting.ps1` script to set up the solution, main project, and test project.

### 12.3 Generate

1. In `Calculator.cs`, create a simple calculator program using top-level statements with the following arithmetic operations: +, -, *, /.
2. The program should:
   - Prompt the user for the first operand, second operand, and the operator.
   - Display the result.
   - Ask the user if they want to perform another calculation (yes/no).
   - Repeat the process if 'yes'; terminate with a friendly message if 'no'.

#### Build and Run

cd ./calculator

dotnet build calculator.csproj

dotnet run calculator

#### Common Errors and Fixes

- **Error:** `Calculator.cs(22,24): warning CS8600: Converting null literal or possible null value to non-nullable type.`
- **Error:** `Calculator.cs(52,23): warning CS8602: Dereference of a possibly null reference.`

**Explanation:**
- These warnings occur when assigning or dereferencing a value that could be null (e.g., from `Console.ReadLine()`).
- Use the null-coalescing operator (`??`) to provide a default value if `Console.ReadLine()` returns null.

### 12.4 Refactor

- Refactor the code so each operation is implemented as its own independent method for easier unit testing.

### 12.5 Iterate

- Clear the screen at program start and after each calculation.
- If the user responds 'no', clear the screen before displaying the thank you message.
- Make methods in `Calculator.cs` public for xUnit testing.
- Add modulo and exponent operations.

### 12.6 Fix

- Fix: `string userResponse = Console.ReadLine()?.ToLower() ?? "";` to prevent `NullReferenceException`.

### 12.7 Build, Restore, and Run

Build the solution

```bash
cd ..
dotnet build .\calculator-xunit-testing.sln --verbosity diagnostic
```

Restore and build the project

```bash
cd .\calculator
dotnet restore .\Calculator.csproj
dotnet build .\Calculator.csproj
dotnet run .\Calculator.csproj
```

### 12.8 Write and Run Unit Tests

- Add xUnit tests for all calculator operations in the test project.
- Example:

```bash
dotnet test .\calculator.tests.csproj
```

### 12.9 Continuous Improvement

- Add `[Theory]` and `[InlineData]` for each method, including at least one failing case.
- Update failing cases to pass.
- Document code in `Calculator.cs` and `CalculatorTest.cs`.

### 12.10 Translate to Python

- Translate the code in `Calculator.cs` to Python.
- Reference: `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\python\prompts.txt`

### 12.11 Reverse Prompting

- Write a prompt that would generate the code in `calculator\Program.cs`.

### 12.12 Cleanup Script

- Create a PowerShell script named `Remove-DotnetSlnForCalculator.ps1` to reset the exercise:
   1. Get the repository root path.
   2. Append the relative path `\programming\dotnet\csharp\workspace\src` to the root and assign to `$targetPath`.
   3. Set the current path to `$targetPath`.
   4. Remove the `calculator-xunit-testing` folder from `$targetPath`.

## 13. **Key Takaways**
	- Summary of the most important points
	
## 14. **Questions or Feedback from Attendees**
	- Frequently Asked Questions or common concerns

## 15. **Questions for Attendees**

## 16. **Call to Action**
	- Next steps for stakeholders or team members

## 17. **References**
    - Supporting documents, diagrams, or links

## 18. **References**	

- [.NET Calculator with xUnit Testing Setup Instructions](#)
- [Microsoft .NET Documentation](https://docs.microsoft.com/en-us/dotnet/)
- [xUnit Documentation](https://xunit.net/) 