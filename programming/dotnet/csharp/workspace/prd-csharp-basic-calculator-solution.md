# 1. Product Requirements Document (PRD): .NET Calculator with xUnit Testing

\n\n1.1 Document Information

\n\n**Version:** 1.0
\n\n**Author:** GitHub Copilot
\n\n**Date:** November 3rd, 2025
\n\n**Status:** Draft

\n\n1.2 Executive Summary

This document describes the requirements for developing a basic .NET 8 console calculator application with comprehensive xUnit testing. The calculator will support standard arithmetic operations and be designed with a focus on testability, maintainability, and proper error handling.

\n\n1.3 Problem Statement

Developers need a practical example of a well-structured .NET application that demonstrates:

\n\nBasic calculator functionality with support for essential arithmetic operations
\n\nProper application structure with testable components
\n\nImplementation of unit testing with xUnit framework
\n\nEffective error handling and input validation

The solution will serve as both a functional calculator and a reference implementation for .NET best practices.

\n\n1.4 Goals and Objectives

\n\nCreate a fully functional calculator application using .NET 8 and C#
\n\nImplement core arithmetic operations (+, -, \*, /) using case expressions

\n\nDemonstrate proper C# coding practices including null handling, error management, and code organization

\n\nRefactor code from using case expressions to methods for better testability
\n\nDemonstrate incremental development by adding modulo and exponent operations
\n\nProvide comprehensive xUnit tests with different test approaches (fact, theory)
\n\nEnable a clean, interactive console experience with proper user feedback
\n\nShowcase proper solution structure with separate application and test projects

\n\n1.5 Scope

\n\n1.5.1 In Scope

\n\nPowerShell script to set up the solution and project structure
\n\n.NET 8 console application using top-level statements
\n\nCalculator core arithmetic operations (addition, subtraction, multiplication, division, modulo, exponent)
\n\nUser input handling with proper validation
\n\nxUnit test project with comprehensive test coverage
\n\nMethod refactoring for testability
\n\nProper error handling and null safety
\n\nDocumentation for both application code and tests

\n\n1.5.2 Out of Scope

\n\nGUI implementation
\n\nAdvanced mathematical functions (logarithms, trigonometry, etc.)
\n\nPersistence of calculations
\n\nScientific calculator features
\n\nMulti-language support
\n\nCalculator history feature

\n\n1.6 User Stories / Use Cases

\n\nAs a user, I want to perform basic arithmetic calculations with two operands so that I can quickly compute results
\n\nAs a user, I want clear prompts and feedback during calculation so I can understand how to use the application
\n\nAs a user, I want to perform multiple calculations in sequence so I don't have to restart the application
\n\nAs a user, I want proper error handling so invalid inputs don't crash the application
\n\nAs a developer, I want well-structured and tested code so that I can understand best practices in .NET development
\n\nAs a QA tester, I want comprehensive unit tests so I can verify the calculator functions correctly

\n\n1.7 Functional Requirements

| Requirement ID | Description |

| -------------- | --------------------------------------------------------------------------------------- |

| FR-1 | The application shall prompt users for two numeric operands and one operator |

| FR-2 | The application shall support addition (+) operations between two numbers |

| FR-3 | The application shall support subtraction (-) operations between two numbers |

| FR-4 | The application shall support multiplication (\*) operations between two numbers |

| FR-5 | The application shall support division (/) operations between two numbers |

| FR-6 | The application shall support modulo (%) operations between two numbers |

| FR-7 | The application shall support exponent (^) operations between two numbers |

| FR-8 | The application shall display the result of each calculation to the user |

| FR-9 | The application shall handle division by zero errors gracefully |

| FR-10 | The application shall validate user input and provide feedback for invalid entries |

| FR-11 | The application shall allow users to perform additional calculations without restarting |

| FR-12 | The application shall confirm with the user before exiting |

| FR-13 | The application shall clear the screen between calculations for a clean interface |

| FR-14 | Each arithmetic operation shall be implemented as a separate, testable method |

| FR-15 | The application shall properly handle null inputs to prevent runtime exceptions |

\n\n1.8 Non-Functional Requirements

\n\n**Performance:** The calculator shall provide immediate feedback for all operations
\n\n**Usability:** The console interface shall be intuitive with clear instructions for users
\n\n**Reliability:** The application shall handle edge cases and invalid inputs without crashing
\n\n**Testability:** All core functionality shall be covered by unit tests
\n\n**Maintainability:** Code shall follow C# best practices and be well-documented

\n\n**Compatibility:** The application shall run on any platform supporting .NET 8

\n\n1.9 Assumptions and Dependencies

\n\nDevelopment will use .NET 8 SDK
\n\nxUnit will be used as the testing framework
\n\nDevelopers have access to appropriate .NET development tools
\n\nThe application will use standard C# console I/O features

\n\nNo external libraries beyond .NET Standard and xUnit are required

\n\n1.10 Success Criteria / KPIs

\n\nAll specified calculator operations work correctly
\n\nUnit tests cover all arithmetic operations with multiple test cases
\n\nThe console application runs without crashing when given valid or invalid input
\n\nAll build and test commands execute successfully
\n\nCode meets appropriate null safety standards for C#
\n\nDocumentation is clear and comprehensive

\n\n1.11 Milestones & Timeline

\n\nSolution Setup
\n\nCreate PowerShell script for initializing solution structure
\n\nSet up the .NET 8 console application and xUnit test project

\n\nInitial Implementation
\n\nImplement basic calculator operations with top-level statements
\n\nBuild and test the initial version

\n\nRefactoring
\n\nConvert operations to testable methods
\n\nAdd proper error handling and screen clearing
\n\nMake methods public for testing accessibility

\n\nTesting
\n\nCreate comprehensive xUnit tests for all operations
\n\nImplement both fact and theory test approaches
\n\nEnsure all tests pass

\n\nFinal Improvements
\n\nAdd modulo and exponent operations
\n\nDocument the code
\n\nFix any remaining issues or warnings

\n\nDocumentation
\n\nUpdate documentation
\n\nCreate setup and cleanup scripts

\n\n1.12 Implementation Guidance

\n\n1.12.1 Solution Setup

\n\nCreate a PowerShell script named `Set-DotnetSlnForCalculator.ps1` in "$(git rev-parse --show-toplevel)\programming\dotnet\csharp\workspace" that:
\n\nCreates a solution folder named `calculator-xunit-testing`
\n\nSets up a new solution
\n\nAdds a console application project named `calculator`
\n\nAdds an xUnit test project named `calculator.tests`
\n\nConfigures appropriate project references
\n\nChanges default file names from `Program.cs` to `Calculator.cs` and from `UnitTest1.cs` to `CalculatorTest.cs`
\n\nExecute the powershell script to create the solution structure

\n\n1.12.2 Calculator Implementation

\n\nImplement the calculator in `Calculator.cs` using top-level statements:
\n\nPrompt for first operand, second operand, and operator
\n\nPerform the appropriate arithmetic operation
\n\nDisplay the result
\n\nAsk if the user wants to perform another calculation
\n\nHandle user response to continue or exit

\n\nFix null reference warnings using appropriate null handling techniques

\n\n1.12.3 Refactoring Steps

\n\nConvert each arithmetic operation into its own method for testability
\n\nMake methods public to allow testing from the xUnit project
\n\nAdd screen clearing for a better user experience
\n\nImplement modulo and exponent operations
\n\nAdd proper null handling to prevent exceptions

\n\n1.12.4 Testing Strategy

\n\nCreate xUnit tests for each calculator operation
\n\nUse Fact tests for simple assertions
\n\nUse Theory tests with InlineData for testing multiple cases
\n\nInclude test cases for edge conditions (like division by zero)
\n\nImplement tests for normal, edge, and error cases

\n\n1.12.5 Final Steps

\n\nTranslate calculator code to Python for cross-language comparison
\n\nWrite a cleanup script to reset the exercise
\n\nComplete documentation

\n\n1.13 Testing Requirements

\n\nAll arithmetic operations must have unit tests
\n\nEach operation should have at least three test cases using Theory and InlineData
\n\nTests should include edge cases and failure scenarios
\n\nAll tests must pass before completion

\n\n1.14 Cleanup Procedure

Create a PowerShell script named `Remove-DotnetSlnForCalculator.ps1` to reset the exercise by:

\n\nGetting the repository root path
\n\nAppending the workspace path
\n\nSetting the current path to the target
\n\nRemoving the calculator solution directory

\n\n1.15 Additional Learning Outcomes

\n\nUnderstanding .NET solution and project structure
\n\nWorking with C# top-level statements

\n\nImplementing proper null handling in C# code

\n\nWriting effective xUnit tests with different techniques
\n\nCreating reusable setup and cleanup scripts
\n\nTranslating C# concepts to other languages (Python)

\n
