#include <stdio.h>
#include <stdlib.h>

// Function to convert Fahrenheit to Celsius
float fahrenheitToCelsius(float fahrenheit) {
    return (fahrenheit - 32) * 5.0 / 9.0;
}

// Function to convert Celsius to Fahrenheit
float celsiusToFahrenheit(float celsius) {
    return (celsius * 9.0 / 5.0) + 32;
}

int main() {
    float temperature, convertedTemperature;
    int choice;
    char repeat;

    do {
        // Clear the console
        system("clear"); // Use "cls" for Windows

        // Prompt the user to select the conversion type
        printf("Select conversion type:\n");
        printf("1. Fahrenheit to Celsius\n");
        printf("2. Celsius to Fahrenheit\n");
        printf("Enter your choice (1 or 2): ");
        scanf("%d", &choice);

        if (choice == 1) {
            // Prompt the user to enter a temperature in Fahrenheit
            printf("Enter temperature in Fahrenheit: ");
            scanf("%f", &temperature);

            // Convert the temperature to Celsius
            convertedTemperature = fahrenheitToCelsius(temperature);

            // Display the input temperature in Fahrenheit and the converted temperature in Celsius
            printf("%.2f Fahrenheit is equivalent to %.2f Celsius\n", temperature, convertedTemperature);
        } else if (choice == 2) {
            // Prompt the user to enter a temperature in Celsius
            printf("Enter temperature in Celsius: ");
            scanf("%f", &temperature);

            // Convert the temperature to Fahrenheit
            convertedTemperature = celsiusToFahrenheit(temperature);

            // Display the input temperature in Celsius and the converted temperature in Fahrenheit
            printf("%.2f Celsius is equivalent to %.2f Fahrenheit\n", temperature, convertedTemperature);
        } else {
            printf("Invalid choice. Please run the program again and select either 1 or 2.\n");
        }

        // Ask the user if they want to convert another temperature
        printf("Do you want to convert another temperature? (y/n): ");
        scanf(" %c", &repeat);

    } while (repeat == 'y' || repeat == 'Y');

    // Clear the console before exiting
    system("clear"); // Use "cls" for Windows

    return 0;
}

/*
To compile the program using WSL2 and gcc, use the following command:
gcc -o temp_converter temp_converter.c
*/
