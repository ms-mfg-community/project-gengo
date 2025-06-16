# Product Requirements Document (PRD)

## Document Information

- **Version:** 1.0
- **Author(s):** GitHub Copilot
- **Date:** June 16, 2025
- **Status:** Draft

## Executive Summary

This document defines the requirements for a cross-language (C# and Python) command-line calculator application. The calculator supports basic arithmetic operations, exponentiation, and modulo, with robust error handling and a user-friendly interactive interface. The solution includes unit tests to ensure correctness and reliability.

## Problem Statement

Users need a simple, reliable, and interactive calculator that can be run from the command line, supporting common arithmetic operations and providing clear feedback for invalid input or errors.

## Goals and Objectives

- Provide a calculator that supports addition, subtraction, multiplication, division, modulo, and exponentiation.
- Ensure robust input validation and error handling.
- Offer a clean, interactive user experience.
- Supply unit tests to guarantee correctness of all operations.
- Deliver both C# and Python implementations for flexibility and learning.

## Scope

### In Scope

- Command-line calculator in C# and Python
- Operations: +, -, *, /, %, ^
- Input validation and error messages
- Unit tests for all operations and edge cases
- Usage documentation

### Out of Scope

- GUI or web-based interfaces
- Advanced mathematical functions (e.g., trigonometry, logarithms)
- Persistent storage or history

## User Stories / Use Cases

- As a user, I want to perform basic arithmetic operations interactively.
- As a user, I want to be notified if I enter invalid input or attempt division/modulo by zero.
- As a developer, I want to run automated tests to verify all calculator logic.

## Functional Requirements

| Requirement ID | Description |
|---|---|
| FR-1 | The calculator shall prompt the user for two numbers and an operator. |
| FR-2 | The calculator shall support addition (+), subtraction (-), multiplication (*), division (/), modulo (%), and exponentiation (^). |
| FR-3 | The calculator shall validate numeric input and display an error for invalid entries. |
| FR-4 | The calculator shall handle division and modulo by zero with a clear error message. |
| FR-5 | The calculator shall display the result of the operation in a clear format. |
| FR-6 | The calculator shall allow the user to perform multiple calculations in a session. |
| FR-7 | The calculator shall clear the screen at the start of each calculation and before exit. |
| FR-8 | The solution shall include unit tests for all operations and edge cases. |

## Non-Functional Requirements

- **Performance:** Results should be displayed instantly for all supported operations.
- **Usability:** The interface must be clear, with prompts and error messages that are easy to understand.
- **Portability:** The solution must run on Windows (C# and Python) and any platform supporting Python 3.7+.
- **Reliability:** All operations must be covered by automated tests.

## Assumptions and Dependencies

- Python 3.7+ and/or .NET 6+ must be installed on the user's system.
- For Python, `pytest` is used for unit testing.
- No external libraries are required for calculator functionality.

## Success Criteria / KPIs

- All unit tests pass for both C# and Python implementations.
- Users can perform all supported operations without encountering unhandled errors.
- Invalid input and edge cases are handled gracefully.

## Milestones & Timeline

- Calculator logic implemented in C# and Python: Complete
- Unit tests implemented: Complete
- Documentation and PRD: Complete

## Appendix A: Demonstration Sequence

1. User starts the calculator from the command line.
2. Calculator clears the screen and prompts for the first number.
3. User enters a valid number; calculator prompts for the second number.
4. User enters a valid number; calculator prompts for the operator.
5. User enters a supported operator; calculator displays the result.
6. User is asked if they want to perform another calculation.
7. If yes, the process repeats; if no, the screen is cleared and a thank you message is shown.

## Key Takeaways

- The calculator is robust, interactive, and easy to use.
- All core arithmetic operations and edge cases are covered by tests.
- The solution is portable and easy to maintain.

## Questions or Feedback from Attendees

- Should additional operations (e.g., square root, logarithm) be supported in the future?
- Is there a need for a graphical or web-based interface?

## Questions for Attendees

- Are there any additional features or usability improvements desired?
- Should the calculator support localization or additional languages?

## Call to Action

- Review the calculator’s functionality and provide feedback.
- Suggest enhancements or additional features as needed.

## References

- [calculator.py](./calculator.py)
- [calculator_test.py](./calculator_test.py)
- [Calculator.cs](../calculator/Calculator.cs)
- [CalculatorTest.cs](../calculator.tests/CalculatorTest.cs)
