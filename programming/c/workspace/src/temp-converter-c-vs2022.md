# Temp Converter C Vs2022

Sure! Here's a simple temperature conversion program in C that meets your requirements:

```

c

// temp_converter.c

#include <stdio.h>

// Function to convert Fahrenheit to Celsius

float fahrenheitToCelsius(float fahrenheit) {

    return (fahrenheit - 32) * 5.0 / 9.0;

}

int main() {

    float fahrenheit, celsius;

    // Prompt the user to enter a temperature in Fahrenheit

    printf("Enter temperature in Fahrenheit: ");

    scanf("%f", &fahrenheit);

    // Convert the temperature to Celsius

    celsius = fahrenheitToCelsius(fahrenheit);

    // Display the input temperature in Fahrenheit and the converted temperature in Celsius

    printf("%.2f Fahrenheit is %.2f Celsius\n", fahrenheit, celsius);

    return 0;

}

/*

To compile the program using the Windows Subsystem for Linux (WSL2) and the gcc compiler, use the following command:

gcc -o temp_converter temp_converter.c

*/

```

text
text

This program includes a function `fahrenheitToCelsius` that converts a temperature from Fahrenheit to Celsius using the formula provided. The `main` function prompts the user to enter a temperature in Fahrenheit, reads the input, converts it to Celsius, and displays both temperatures formatted to two decimal places.

If you have any questions or need further assistance, feel free to ask!

Sure! Here's how you can write a set of unit tests for the temperature conversion program using the Unity testing framework:

\n\nStep 1: Set Up Unity

\n\n**Download Unity**:
\n\nYou can download Unity from the Unity GitHub repository.

\n\n**Add Unity to Your Project**:
\n\nCopy the `unity.h` and `unity.c` files from the Unity repository into your project directory.

\n\nStep 2: Write the Unit Tests

\n\n**Create a Test File**:
\n\nCreate a new file named `test_temp_converter.c` and add the following code:

     ```

c

     // test_temp_converter.c

     #include "unity.h"

     #include "temp_converter.c"

     void setUp(void) {

         // Set up code if needed

     }

     void tearDown(void) {

         // Tear down code if needed

     }

     void test_fahrenheitToCelsius(void) {

         // Test cases

         TEST_ASSERT_FLOAT_WITHIN(0.01, 0.0, fahrenheitToCelsius(32.0));

         TEST_ASSERT_FLOAT_WITHIN(0.01, 100.0, fahrenheitToCelsius(212.0));

         TEST_ASSERT_FLOAT_WITHIN(0.01, -17.78, fahrenheitToCelsius(0.0));

         TEST_ASSERT_FLOAT_WITHIN(0.01, 37.78, fahrenheitToCelsius(100.0));

     }

     int main(void) {

         UNITY_BEGIN();

         RUN_TEST(test_fahrenheitToCelsius);

         return UNITY_END();

     }

     ```

\n\nStep 3: Compile and Run the Tests

\n\n**Compile the Tests**:
\n\nOpen the terminal and navigate to your project directory.
\n\nCompile the tests using the gcc compiler:

     ```

sh

     gcc -o test_temp_converter test_temp_converter.c unity.c -I.

     ```

\n\n**Run the Tests**:
\n\nExecute the compiled test program:

     ```

sh

     ./test_temp_converter

     ```

\n\nUnity will run the tests and display the results in the terminal.

This setup includes a test file `test_temp_converter.c` that uses Unity to test the `fahrenheitToCelsius` function. The `TEST_ASSERT_FLOAT_WITHIN` macro is used to check if the actual output is within a small range of the expected value, accounting for floating-point precision.

If you have any questions or need further assistance, feel free to ask!

\n
