Sure! The most suitable JetBrains IDE for C programming is **CLion**[1](https://www.jetbrains.com/clion/). Here's a step-by-step guide to create a simple temperature conversion program in C and write unit tests using Unity in CLion:

### Step 1: Set Up Your Project

1. **Download and Install CLion**:
   - Download CLion from the [JetBrains website](https://www.jetbrains.com/clion/download/).
   - Install CLion following the instructions for your operating system.

2. **Create a New Project**:
   - Open CLion and click on `New Project`.
   - Select `C Executable` and choose a project location.
   - Click `Create`.

### Step 2: Write the Calculator Code

1. **Create the Calculator File**:
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C File`.
   - Name the file `temp_converter.c` and add the following code:

     ```c
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

### Step 3: Set Up Unity for Testing

1. **Download Unity**:
   - Download Unity from the Unity GitHub repository.

2. **Add Unity to Your Project**:
   - Copy the `unity.h` and `unity.c` files from the Unity repository into your project directory.

### Step 4: Write Unit Tests

1. **Create a Test File**:
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C File`.
   - Name the file `test_temp_converter.c` and add the following code:

     ```c
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

### Step 5: Compile and Run the Tests

1. **Configure CMakeLists.txt**:
   - Open the `CMakeLists.txt` file in your project and add the following lines to include Unity and the test file:

     ```cmake
     cmake_minimum_required(VERSION 3.15)
     project(temp_converter C)

     set(CMAKE_C_STANDARD 99)

     add_executable(temp_converter temp_converter.c)
     add_executable(test_temp_converter test_temp_converter.c unity.c)
     ```

2. **Compile the Tests**:
   - Click on the `Build` menu and select `Build Project` to compile the project.

3. **Run the Tests**:
   - In the Project Explorer, right-click on the `test_temp_converter` target and select `Run 'test_temp_converter'`.
   - CLion will execute the tests and display the results in the Run tool window.

By following these steps, you can create a simple temperature conversion program in C and write unit tests using Unity in CLion. If you have any questions or need further assistance, feel free to ask!