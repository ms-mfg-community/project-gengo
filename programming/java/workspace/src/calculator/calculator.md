# Java Calculator - Unit Testing Guide

This document provides a step-by-step guide for setting up and performing unit testing on the Java calculator application.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Setting Up the Test Environment](#setting-up-the-test-environment)
4. [Creating Unit Tests](#creating-unit-tests)
5. [Running the Tests](#running-the-tests)
6. [Best Practices](#best-practices)
7. [Advanced Testing Techniques](#advanced-testing-techniques)

## Project Overview

The Java calculator application is a simple command-line calculator that supports basic arithmetic operations:
- Addition (+)
- Subtraction (-)
- Multiplication (*)
- Division (/)
- Modulo (%)
- Exponentiation (^)

The application follows a typical Maven project structure, with the main code located in `src/main/java` and test code in `src/test/java`.

## Prerequisites

Before setting up unit testing, ensure you have:

1. Java Development Kit (JDK) 11 or later installed
2. Apache Maven installed
3. Basic understanding of JUnit 5 framework
4. Basic understanding of Maven build system

## Setting Up the Test Environment

### Step 1: Verify Maven Dependencies

Ensure your `pom.xml` file includes the necessary JUnit 5 dependencies:

```xml
<dependencies>
    <!-- JUnit 5 dependencies -->
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-api</artifactId>
        <version>${junit.jupiter.version}</version>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-engine</artifactId>
        <version>${junit.jupiter.version}</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### Step 2: Create the Test Directory Structure

Maven follows a standard directory structure for tests:
```
src
├── main
│   └── java
│       └── com
│           └── project13
│               └── App.java
└── test
    └── java
        └── com
            └── project13
                └── AppTest.java
```

If this structure doesn't exist yet, create it:

```bash
mkdir -p src/test/java/com/project13
```

## Creating Unit Tests

### Step 3: Create a Test Class

Create a test class called `AppTest.java` in the `src/test/java/com/project13` directory. Start with a basic structure:

```java
package com.project13;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the App class calculator functionality.
 */
public class AppTest {
    // Tests will go here
}
```

### Step 4: Write Basic Tests for Each Operation

Add tests for each calculator operation. Here's an example for addition:

```java
/**
 * Tests for the add method.
 */
@Test
@DisplayName("Addition: Test with positive numbers")
public void testAddPositiveNumbers() {
    assertEquals(5.0, App.add(2.0, 3.0), 
        "2.0 + 3.0 should equal 5.0");
}

@Test
@DisplayName("Addition: Test with negative numbers")
public void testAddNegativeNumbers() {
    assertEquals(-5.0, App.add(-2.0, -3.0), 
        "-2.0 + -3.0 should equal -5.0");
}

@Test
@DisplayName("Addition: Test with decimal numbers")
public void testAddDecimals() {
    assertEquals(5.3, App.add(2.1, 3.2), 0.0001, 
        "2.1 + 3.2 should equal 5.3");
}
```

### Step 5: Test Edge Cases

Don't forget to test edge cases, such as division by zero:

```java
@Test
@DisplayName("Division: Test division by zero")
public void testDivideByZero() {
    assertEquals(0.0, App.divide(5.0, 0.0), 
        "Division by zero should return 0 as defined in the method");
}
```

### Step 6: Add Parameterized Tests

For more efficient testing of multiple test cases, use parameterized tests:

```java
@ParameterizedTest
@CsvSource({
    "1.0, 1.0, 2.0",
    "10.5, 10.5, 21.0",
    "-5.0, 5.0, 0.0",
    "0.0, 0.0, 0.0"
})
@DisplayName("Addition: Parameterized test")
public void testAddParameterized(double a, double b, double expected) {
    assertEquals(expected, App.add(a, b), 0.0001, 
        String.format("%f + %f should equal %f", a, b, expected));
}
```

### Step 7: Test the Main Calculate Method

Test the central `calculate` method which handles all operations:

```java
@ParameterizedTest
@CsvSource({
    "5.0, 3.0, +, 8.0",
    "5.0, 3.0, -, 2.0",
    "5.0, 3.0, *, 15.0",
    "6.0, 3.0, /, 2.0",
    "7.0, 3.0, %, 1.0",
    "2.0, 3.0, ^, 8.0",
    "5.0, 3.0, X, 0.0"  // Invalid operator test
})
@DisplayName("Calculate method: Parameterized test")
public void testCalculateParameterized(double a, double b, char operator, double expected) {
    assertEquals(expected, App.calculate(a, b, operator), 0.0001,
        String.format("%f %c %f should equal %f", a, b, operator, expected));
}
```

## Running the Tests

### Step 8: Run Tests Using Maven

To run the tests, use Maven from the command line:

```bash
mvn test
```

This will compile the code and run all tests, providing a summary of test results.

### Step 9: Run Tests in an IDE

Most IDEs (like IntelliJ IDEA, Eclipse, or VS Code with Java extensions) have built-in support for running JUnit tests:

1. Open the `AppTest.java` file
2. Right-click in the editor or on the test class/method
3. Select "Run Test" or equivalent option

## Best Practices

### Follow AAA Pattern

Structure your tests using the Arrange-Act-Assert pattern:
- **Arrange**: Set up the test data
- **Act**: Call the method under test
- **Assert**: Verify the result

### Make Tests Independent

Each test should be independent and not rely on other tests or external state.

### Use Descriptive Test Names

Use clear and descriptive test method names that indicate what's being tested.

### Use Meaningful Assertions

Include helpful error messages in assertions to make test failures easier to understand.

## Advanced Testing Techniques

### Test Coverage Analysis

Use tools like JaCoCo to analyze your test coverage:

```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.7</version>
    <executions>
        <execution>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>report</id>
            <phase>test</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

Then run:
```bash
mvn clean test
```

Coverage reports will be generated in `target/site/jacoco/`.

### Continuous Integration

Set up automated testing in a CI environment (like GitHub Actions, Jenkins, etc.) by creating a workflow file that runs your tests on each push or pull request.

---

This completes the guide for unit testing the Java calculator application. By following these steps, you'll have a comprehensive test suite that verifies all the functionality of your calculator and helps maintain code quality as the project evolves.