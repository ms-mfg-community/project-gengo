---
description: Create a .NET 8 console calculator application with xUnit testing framework, following best practices for testability, maintainability, and proper error handling.
name: create-basic-calculator-dotnet
agent: agent
model: Claude Haiku 4.5 (copilot)
tools:
  - github/*
---

# Create Basic .NET Calculator with xUnit Testing

You are an expert .NET developer helping users build a well-structured calculator application that demonstrates modern C# development practices.

## Objective

Create a .NET 8 console calculator application with xUnit unit testing that supports arithmetic operations (+, -, *, /, %, ^), proper error handling, and comprehensive test coverage.

## Key Requirements

### Application Structure
- .NET 8 console application using C# top-level statements
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
- Include comprehensive JSDoc/XML documentation comments for all methods
- Implement input validation and early returns for error conditions
- Use meaningful variable names
- Keep functions focused and appropriately sized
- All core functionality covered by unit tests

### Testing Strategy
- Use xUnit framework for unit testing
- Implement both Fact tests for simple assertions
- Use Theory tests with InlineData for multiple test cases
- Include edge cases and failure scenarios (e.g., division by zero)
- Provide at least three test cases per operation
- Ensure all tests pass before completion

## Development Workflow

1. **Setup Phase**
   - Create solution folder structure: `calculator-xunit-testing`
   - Initialize .NET 8 solution
   - Create console application project named `calculator`
   - Create xUnit test project named `calculator.tests`
   - Configure project references

2. **Implementation Phase**
   - Implement calculator in `Calculator.cs` using top-level statements
   - Convert operations to individual testable methods
   - Add input validation and error handling
   - Implement modulo and exponent operations
   - Add screen clearing for better UX
   - Fix null reference warnings using proper null handling

3. **Testing Phase**
   - Create comprehensive xUnit tests in `CalculatorTest.cs`
   - Test all arithmetic operations with multiple scenarios
   - Include edge case testing
   - Verify error handling

4. **Cleanup**
   - Ensure no warnings or errors remain
   - Verify all tests pass
   - Create cleanup script for resetting the exercise

## Guidelines

- **Simplicity First**: Use straightforward implementations before adding complexity
- **No Duplication**: Check for similar code elsewhere in the codebase
- **Testability**: Design all operations as public methods that can be easily tested
- **Error Handling**: Validate inputs and handle exceptions gracefully
- **Documentation**: Include JSDoc comments for each method explaining parameters and return values
- **Best Practices**: Follow the copilot-instructions.md standards for C# and .NET development

## Reference Materials

- PRD Location: [PRD: .NET Calculator with xUnit Testing](${workspaceFolder}/programming/dotnet/csharp/workspace/prd-csharp-basic-calculator-solution.md)
- Coding Standards: [Copilot Instructions](${workspaceFolder}/.github/copilot-instructions.md)

## Success Criteria

- All calculator operations work correctly with valid and invalid inputs
- xUnit tests cover all arithmetic operations with multiple test cases
- Console application runs without crashes
- All build and test commands execute successfully
- Code meets .NET null safety standards
- Clear, helpful documentation is present

## Example Usage

Once created, users can:
1. Run the calculator: `dotnet run --project calculator`
2. Execute tests: `dotnet test calculator.tests`
3. Build solution: `dotnet build`

## Output Format

Provide:
1. Clear step-by-step implementation guidance
2. Complete, production-ready code
3. Explanation of key design decisions
4. Test execution results showing all tests passing
5. Any additional documentation or scripts needed
