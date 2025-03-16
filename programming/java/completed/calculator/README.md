# Simple Java Calculator

A command-line calculator application that performs basic arithmetic operations.

## Features

- Addition, subtraction, multiplication, and division operations
- Input validation for numbers and operators
- Support for decimal numbers
- User-friendly interface with clear prompts

## Requirements

- Java 11 or higher
- Maven (for building)

## How to Build

From the project root directory, run:

```bash
mvn clean package
```

This will create a runnable JAR file in the `target` directory.

## How to Run

After building the project, you can run the calculator using:

```bash
java -jar target/calculator-1.0-SNAPSHOT.jar
```

Alternatively, you can run it directly with:

```bash
mvn exec:java -Dexec.mainClass="com.calculator.Calculator"
```

## Usage Instructions

1. Enter the first number when prompted
2. Enter the second number when prompted
3. Select an operation (+, -, *, /)
4. View the calculation result
5. Choose whether to perform another calculation or exit

## Example Session

```
Welcome to the Simple Calculator!
Enter the first number: 10
Enter the second number: 5
Enter the operator (+, -, *, /): +
Result: 15.0
Do you want to perform another calculation? (yes/no): yes
Enter the first number: 20
Enter the second number: 4
Enter the operator (+, -, *, /): /
Result: 5.0
Do you want to perform another calculation? (yes/no): no
Thank you for using the Simple Calculator. Goodbye!
```