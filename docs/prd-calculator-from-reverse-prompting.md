# Product Requirements Document: Console Calculator Application



1. Document Information



**Version:** 1.0


**Author:** [Author Name]


**Date:** [Current Date]


**Status:** Draft



2. Executive Summary

The Console Calculator Application is a .NET 6-based command-line tool that provides users with a clean, intuitive interface to perform common mathematical operations. The calculator supports six fundamental operations: addition, subtraction, multiplication, division, modulo, and exponentiation. It includes robust error handling, input validation, and a user-friendly loop that enables multiple calculations in sequence.



3. Problem Statement

Many command-line calculators lack proper error handling, clear user interfaces, or a complete set of operations. This application aims to provide a comprehensive calculator experience with a focus on robustness, usability, and maintainability, while also serving as an example of good practices in C# programming, including unit testing.



4. Goals and Objectives



Create an easy-to-use console calculator with a clean UI


Support six fundamental mathematical operations (+, -, \*, /, %, ^)


Implement robust error handling and input validation


Enable repeatable calculations through a simple prompt flow


Provide extensive documentation of edge cases and mathematical behaviors


Demonstrate test-driven development with comprehensive unit tests



5. Scope

## In Scope



Console-based calculator interface


Six operations: addition, subtraction, multiplication, division, modulo, power


Input validation and error handling


Repeatable calculation flow


Unit test coverage for all operations

## Out of Scope



Advanced mathematical functions (trigonometry, logarithms, etc.)


Memory functions (store/recall)


GUI interface


Persistence of calculation history


Scientific notation support



6. User Stories / Use Cases



**Basic Calculation:** As a user, I want to perform a simple calculation with two operands and receive the correct result.


**Error Recovery:** As a user, I want to be notified of errors (like division by zero) and given an opportunity to try again.


**Invalid Input Handling:** As a user, I want the application to gracefully handle invalid inputs rather than crashing.


**Multiple Calculations:** As a user, I want to perform multiple calculations in sequence without restarting the program.


**Clean Exit:** As a user, I want to exit the program with a friendly message when I'm finished.



7. Functional Requirements



7.1 User Interface



The application shall display a title and header at startup


The application shall clear the screen at start, between calculations, and before exit


The application shall display clear prompts for entering numbers and operators


The application shall display calculation results clearly



7.2 Input Handling



The application shall validate numeric inputs and display appropriate error messages


The application shall accept these operators: +, -, \*, /, %, ^


The application shall validate operators and display an error for invalid operators



7.3 Calculation Features



The application shall support addition of two numbers


The application shall support subtraction of one number from another


The application shall support multiplication of two numbers


The application shall support division of one number by another (except by zero)


The application shall support modulo operation (remainder of division)


The application shall support exponentiation (raising one number to the power of another)



7.4 Error Handling



The application shall prevent division by zero and display an appropriate error


The application shall prevent modulo with zero divisor and display an appropriate error


The application shall handle other potential errors (like argument exceptions)



7.5 Program Flow



The application shall allow the user to perform multiple calculations in sequence


The application shall provide a yes/no prompt after each calculation


The application shall accept both "yes" and "y" (case insensitive) to continue


The application shall display a friendly exit message upon completion



8. Non-Functional Requirements



8.1 Performance



The application shall provide calculation results immediately (within 100ms)


The application shall handle numbers within the range of the double data type



8.2 Usability



The application shall use clear, concise prompts


The application shall use consistent language and formatting


The application shall provide helpful error messages



8.3 Maintainability



The code shall be well-documented with comments explaining logic and edge cases


Math operations shall be implemented as independent, testable methods


The application shall follow C# best practices and coding standards



8.4 Testability



All mathematical operations shall be implemented as public methods


All operations shall be thoroughly tested, including edge cases



9. Operation Details and Edge Cases



9.1 Addition Operation



**Syntax:** `a + b`


**Function:** Returns the sum of two numbers


**Edge Cases:**


Adding very large numbers may result in double.PositiveInfinity


Adding very small negatives to very large positives may lose precision



9.2 Subtraction Operation



**Syntax:** `a - b`


**Function:** Returns the difference between two numbers


**Edge Cases:**


Subtracting a negative is equivalent to addition and may overflow


Subtracting very close numbers may result in precision issues



9.3 Multiplication Operation



**Syntax:** `a * b`


**Function:** Returns the product of two numbers


**Edge Cases:**


Multiplying by zero always returns zero


Multiplying large numbers may result in double.PositiveInfinity


Sign rules: negative \* negative = positive



9.4 Division Operation



**Syntax:** `a / b`


**Function:** Returns the quotient of a divided by b


**Edge Cases:**


Division by zero throws DivideByZeroException


Division of zero by any non-zero number returns zero


Sign rules: negative / negative = positive


Division by very small numbers can result in very large results



9.5 Modulo Operation



**Syntax:** `a % b`


**Function:** Returns the remainder of a divided by b


**Edge Cases:**


Modulo by zero throws DivideByZeroException


In C#, modulo with negative numbers follows the sign of the dividend


Example: -7 % 3 = -1 (may differ from other languages)



9.6 Power Operation



**Syntax:** `a ^ b`


**Function:** Returns a raised to the power of b


**Edge Cases:**


0^0 returns 1 (mathematical convention)


Any number raised to 0 returns 1


0 raised to any positive power returns 0


Negative numbers raised to fractional powers return NaN


Very large results might return double.PositiveInfinity



10. User Experience Flow



**Program Start:**


Screen is cleared


Title "Simple Calculator" is displayed


Separator line is shown



**Input Sequence:**


User is prompted for first number


User is prompted for second number


User is prompted for operator



**Result Display:**


Calculation is performed


Result is displayed


Or error message is shown for invalid operations



**Continuation:**


User is asked if they want to perform another calculation


If yes: screen is cleared and the process repeats


If no: screen is cleared and goodbye message is displayed



**Program Exit:**


"Thank you for using the calculator. Goodbye!" message is displayed


Program terminates



11. Testing Strategy



11.1 Unit Testing



Each mathematical operation shall have dedicated unit tests


Tests shall include normal cases, edge cases, and exception scenarios


Tests shall use both individual [Fact] tests and parameterized [Theory] tests



11.2 Test Coverage



Addition: Testing positive numbers, negative numbers, zeros


Subtraction: Testing positive results, negative results, zeros


Multiplication: Testing positive/negative combinations, zeros


Division: Testing various combinations, division by zero exception


Modulo: Testing various combinations, modulo by zero exception


Power: Testing positive/negative bases and exponents, special cases like 0^0



12. Implementation Notes



12.1 Code Structure



**Top-Level Statements:** Main program flow and user interaction


**CalculatorOperations Class:** Contains all mathematical operation methods


**Exception Handling:** try-catch blocks for operation exceptions


**Input Validation:** TryParse for numeric inputs, validation for operators



12.2 Key Technical Decisions



Using nullable string types (string?) to handle potential null returns from Console.ReadLine()


Using null-conditional (?.) and null-coalescing (??) operators to prevent NullReferenceException


Using TryParse instead of Parse to avoid exceptions for invalid inputs


Implementing operations as pure methods with no side effects for better testability


Using XML documentation comments for better code documentation



13. Usage Instructions



13.1 Starting the Application

```

text

dotnet run

```

text
text



13.2 Performing Calculations



Enter the first number when prompted


Enter the second number when prompted


Enter one of these operators: +, -, \*, /, %, ^


View the result


Answer yes/no to perform another calculation



13.3 Handling Errors



If you enter invalid numbers, you'll be prompted to try again


If you attempt division or modulo by zero, an error message will be displayed


If you enter an invalid operator, you'll be notified and prompted to continue



13.4 Exiting the Application



Answer "no" or "n" when asked if you want to perform another calculation



14. Appendices



14.1 Example Calculations



Addition: 5 + 3 = 8


Subtraction: 10 - 4 = 6


Multiplication: 7 \* 8 = 56


Division: 20 / 4 = 5


Modulo: 7 % 3 = 1


Power: 2 ^ 3 = 8



14.2 Common Error Scenarios



Division by zero: "Error: Cannot divide by zero."


Invalid number input: "Invalid input. Please enter a valid number."


Invalid operator: "Invalid operator. Please use +, -, \*, /, %, or ^."
