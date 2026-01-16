# Simple Java Calculator

A command-line calculator application that performs basic arithmetic operations.
\n\nFeatures
\n\nAddition, subtraction, multiplication, and division operations\n\nInput validation for numbers and operators\n\nSupport for decimal numbers\n\nUser-friendly interface with clear prompts
\n\nRequirements
\n\nJava 11 or higher\n\nMaven (for building)
\n\nHow to Build

From the project root directory, run:

```bash
mvn clean package
```

This will create a runnable JAR file in the `target` directory.
\n\nHow to Run

After building the project, you can run the calculator using:

```bash
java -jar target/calculator-1.0-SNAPSHOT.jar
```

Alternatively, you can run it directly with:

```bash
mvn exec:java -Dexec.mainClass="com.calculator.Calculator"
```
\n\nUsage Instructions
\n\nEnter the first number when prompted\n\nEnter the second number when prompted\n\nSelect an operation (+, -, \*, /)\n\nView the calculation result\n\nChoose whether to perform another calculation or exit
\n\nExample Session

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
\n
