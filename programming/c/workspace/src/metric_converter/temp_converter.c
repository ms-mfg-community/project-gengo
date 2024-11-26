#include <stdio.h>

// Function to convert Fahrenheit to Celsius
float fahrenheitToCelsius(float fahrenheit) {
    return (fahrenheit - 32) * 5.0 / 9.0;
}

int main() {
    float fahrenheit, celsius;

    // Prompt user for input
    printf("Enter temperature in Fahrenheit: ");
    scanf("%f", &fahrenheit);

    // Convert to Celsius
    celsius = fahrenheitToCelsius(fahrenheit);

    // Display the result
    printf("%.2f Fahrenheit is %.2f Celsius\n", fahrenheit, celsius);

    return 0;
}

// To compile, use: cl /Gw temp_converter.c

