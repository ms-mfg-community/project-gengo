# Product Requirements Document: Console Calculator Application
\n\n1. Document Information
\n\n**Version:** 1.0\n\n**Author:** [Author Name]\n\n**Date:** [Current Date]\n\n**Status:** Draft
\n\n2. Executive Summary

The Console Calculator Application is a .NET 8-based command-line tool that provides users with a clean, intuitive interface to perform common mathematical operations. The calculator supports six fundamental operations: addition, subtraction, multiplication, division, modulo, and exponentiation. It includes robust error handling, input validation, and a user-friendly loop that enables multiple calculations in sequence.
\n\n3. Problem Statement

Many command-line calculators lack proper error handling, clear user interfaces, or a complete set of operations. This application aims to provide a comprehensive calculator experience with a focus on robustness, usability, and maintainability, while also serving as an example of good practices in C# programming, including unit testing.
\n\n4. Goals and Objectives
\n\nCreate an easy-to-use console calculator with a clean UI\n\nSupport six fundamental mathematical operations (+, -, \*, /, %, ^)\n\nImplement robust error handling and input validation\n\nEnable repeatable calculations through a simple prompt flow\n\nProvide extensive documentation of edge cases and mathematical behaviors\n\nDemonstrate test-driven development with comprehensive unit tests
\n\n5. Scope

**In Scope:**
\n\nConsole-based calculator interface\n\nSix operations: addition, subtraction, multiplication, division, modulo, power\n\nInput validation and error handling\n\nRepeatable calculation flow\n\nUnit test coverage for all operations

**Out of Scope:**
\n\nAdvanced mathematical functions (trigonometry, logarithms, etc.)\n\nMemory functions (store/recall)\n\nGUI interface\n\nPersistence of calculation history\n\nScientific notation support
\n\n6. User Stories / Use Cases
\n\n**Basic Calculation:** As a user, I want to perform a simple calculation with two operands and receive the correct result.\n\n**Error Recovery:** As a user, I want to be notified of errors (like division by zero) and given an opportunity to try again.\n\n**Invalid Input Handling:** As a user, I want the application to gracefully handle invalid inputs rather than crashing.\n\n**Multiple Calculations:** As a user, I want to perform multiple calculations in sequence without restarting the program.\n\n**Clean Exit:** As a user, I want to exit the program with a friendly message when I'm finished.
\n\n7. Functional Requirements
\n\n7.1 User Interface
\n\nThe application shall display a title and header at startup\n\nThe application shall clear the screen at start, between calculations, and before exit\n\nThe application shall display clear prompts for entering numbers and operators\n\nThe application shall display calculation results clearly
\n\n7.2 Input Handling
\n\nThe application shall validate numeric inputs and display appropriate error messages\n\nThe application shall accept these operators: +, -, \*, /, %, ^\n\nThe application shall validate operators and display an error for invalid operators
\n\n7.3 Calculation Features
\n\nThe application shall support addition of two numbers\n\nThe application shall support subtraction of one number from another\n\nThe application shall support multiplication of two numbers\n\nThe application shall support division of one number by another (except by zero)\n\nThe application shall support modulo operation (remainder of division)\n\nThe application shall support exponentiation (raising one number to the power of another)
\n\n7.4 Error Handling
\n\nThe application shall prevent division by zero and display an appropriate error\n\nThe application shall prevent modulo with zero divisor and display an appropriate error\n\nThe application shall handle other potential errors (like argument exceptions)
\n\n7.5 Program Flow
\n\nThe application shall allow the user to perform multiple calculations in sequence\n\nThe application shall provide a yes/no prompt after each calculation\n\nThe application shall accept both "yes" and "y" (case insensitive) to continue\n\nThe application shall display a friendly exit message upon completion
\n\n8. Non-Functional Requirements
\n\n8.1 Performance
\n\nThe application shall provide calculation results immediately (within 100ms)\n\nThe application shall handle numbers within the range of the double data type
\n\n8.2 Usability
\n\nThe application shall use clear, concise prompts\n\nThe application shall use consistent language and formatting\n\nThe application shall provide helpful error messages
\n\n8.3 Maintainability
\n\nThe code shall be well-documented with comments explaining logic and edge cases\n\nMath operations shall be implemented as independent, testable methods\n\nThe application shall follow C# best practices and coding standards
\n\n8.4 Testability
\n\nAll mathematical operations shall be implemented as public methods\n\nAll operations shall be thoroughly tested, including edge cases
\n\n9. Operation Details and Edge Cases
\n\n9.1 Addition Operation
\n\n**Syntax:** `a + b`\n\n**Function:** Returns the sum of two numbers\n\n**Edge Cases:**\n\nAdding very large numbers may result in double.PositiveInfinity\n\nAdding very small negatives to very large positives may lose precision
\n\n9.2 Subtraction Operation
\n\n**Syntax:** `a - b`\n\n**Function:** Returns the difference between two numbers\n\n**Edge Cases:**\n\nSubtracting a negative is equivalent to addition and may overflow\n\nSubtracting very close numbers may result in precision issues
\n\n9.3 Multiplication Operation
\n\n**Syntax:** `a * b`\n\n**Function:** Returns the product of two numbers\n\n**Edge Cases:**\n\nMultiplying by zero always returns zero\n\nMultiplying large numbers may result in double.PositiveInfinity\n\nSign rules: negative \* negative = positive
\n\n9.4 Division Operation
\n\n**Syntax:** `a / b`\n\n**Function:** Returns the quotient of a divided by b\n\n**Edge Cases:**\n\nDivision by zero throws DivideByZeroException\n\nDivision of zero by any non-zero number returns zero\n\nSign rules: negative / negative = positive\n\nDivision by very small numbers can result in very large results
\n\n9.5 Modulo Operation
\n\n**Syntax:** `a % b`\n\n**Function:** Returns the remainder of a divided by b\n\n**Edge Cases:**\n\nModulo by zero throws DivideByZeroException\n\nIn C#, modulo with negative numbers follows the sign of the dividend\n\nExample: -7 % 3 = -1 (may differ from other languages)
\n\n9.6 Power Operation
\n\n**Syntax:** `a ^ b`\n\n**Function:** Returns a raised to the power of b\n\n**Edge Cases:**\n\n0^0 returns 1 (mathematical convention)\n\nAny number raised to 0 returns 1\n\n0 raised to any positive power returns 0\n\nNegative numbers raised to fractional powers return NaN\n\nVery large results might return double.PositiveInfinity
\n\n10. User Experience Flow
\n\n**Program Start:**\n\nScreen is cleared\n\nTitle "Simple Calculator" is displayed\n\nSeparator line is shown
\n\n**Input Sequence:**\n\nUser is prompted for first number\n\nUser is prompted for second number\n\nUser is prompted for operator
\n\n**Result Display:**\n\nCalculation is performed\n\nResult is displayed\n\nOr error message is shown for invalid operations
\n\n**Continuation:**\n\nUser is asked if they want to perform another calculation\n\nIf yes: screen is cleared and the process repeats\n\nIf no: screen is cleared and goodbye message is displayed
\n\n**Program Exit:**\n\n"Thank you for using the calculator. Goodbye!" message is displayed\n\nProgram terminates
\n\n11. Testing Strategy
\n\n11.1 Unit Testing
\n\nEach mathematical operation shall have dedicated unit tests\n\nTests shall include normal cases, edge cases, and exception scenarios\n\nTests shall use both individual [Fact] tests and parameterized [Theory] tests
\n\n11.2 Test Coverage
\n\nAddition: Testing positive numbers, negative numbers, zeros\n\nSubtraction: Testing positive results, negative results, zeros\n\nMultiplication: Testing positive/negative combinations, zeros\n\nDivision: Testing various combinations, division by zero exception\n\nModulo: Testing various combinations, modulo by zero exception\n\nPower: Testing positive/negative bases and exponents, special cases like 0^0
\n\n12. Implementation Notes
\n\n12.1 Code Structure
\n\n**Top-Level Statements:** Main program flow and user interaction\n\n**CalculatorOperations Class:** Contains all mathematical operation methods\n\n**Exception Handling:** try-catch blocks for operation exceptions\n\n**Input Validation:** TryParse for numeric inputs, validation for operators
\n\n12.2 Key Technical Decisions
\n\nUsing nullable string types (string?) to handle potential null returns from Console.ReadLine()\n\nUsing null-conditional (?.) and null-coalescing (??) operators to prevent NullReferenceException\n\nUsing TryParse instead of Parse to avoid exceptions for invalid inputs\n\nImplementing operations as pure methods with no side effects for better testability\n\nUsing XML documentation comments for better code documentation
\n\n13. Usage Instructions
\n\n13.1 Starting the Application

```
dotnet run
```
\n\n13.2 Performing Calculations
\n\nEnter the first number when prompted\n\nEnter the second number when prompted\n\nEnter one of these operators: +, -, \*, /, %, ^\n\nView the result\n\nAnswer yes/no to perform another calculation
\n\n13.3 Handling Errors
\n\nIf you enter invalid numbers, you'll be prompted to try again\n\nIf you attempt division or modulo by zero, an error message will be displayed\n\nIf you enter an invalid operator, you'll be notified and prompted to continue
\n\n13.4 Exiting the Application
\n\nAnswer "no" or "n" when asked if you want to perform another calculation
\n\n14. Appendices
\n\n14.1 Example Calculations
\n\nAddition: 5 + 3 = 8\n\nSubtraction: 10 - 4 = 6\n\nMultiplication: 7 \* 8 = 56\n\nDivision: 20 / 4 = 5\n\nModulo: 7 % 3 = 1\n\nPower: 2 ^ 3 = 8
\n\n14.2 Common Error Scenarios
\n\nDivision by zero: "Error: Cannot divide by zero."\n\nInvalid number input: "Invalid input. Please enter a valid number."\n\nInvalid operator: "Invalid operator. Please use +, -, \*, /, %, or ^."
\n
