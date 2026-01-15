"""
Calculator Application - Basic Arithmetic Operations
This application prompts users for two operands and an operator,
performs the calculation, and allows for continuous use.

This is a Python translation of the C# calculator implementation
for cross-language comparison.
"""

import math
import sys


class CalculatorMethods:
    """
    Static-like class containing calculator operation methods.
    All methods are public to allow testing.
    """

    @staticmethod
    def add(a: float, b: float) -> float:
        """
        Adds two numbers together.
        
        Args:
            a: First operand
            b: Second operand
            
        Returns:
            Sum of a and b
        """
        return a + b

    @staticmethod
    def subtract(a: float, b: float) -> float:
        """
        Subtracts the second number from the first.
        
        Args:
            a: First operand (minuend)
            b: Second operand (subtrahend)
            
        Returns:
            Difference of a and b
        """
        return a - b

    @staticmethod
    def multiply(a: float, b: float) -> float:
        """
        Multiplies two numbers together.
        
        Args:
            a: First operand
            b: Second operand
            
        Returns:
            Product of a and b
        """
        return a * b

    @staticmethod
    def divide(a: float, b: float) -> float:
        """
        Divides the first number by the second.
        
        Args:
            a: First operand (dividend)
            b: Second operand (divisor)
            
        Returns:
            Quotient of a divided by b, or float('inf') if b is 0
        """
        if b == 0:
            return float('inf')
        return a / b

    @staticmethod
    def modulo(a: float, b: float) -> float:
        """
        Calculates the modulo (remainder) of two numbers.
        
        Args:
            a: First operand (dividend)
            b: Second operand (divisor)
            
        Returns:
            Remainder of a divided by b, or float('nan') if b is 0
        """
        if b == 0:
            return float('nan')
        return a % b

    @staticmethod
    def exponent(a: float, b: float) -> float:
        """
        Raises the first number to the power of the second.
        
        Args:
            a: Base (first operand)
            b: Exponent (second operand)
            
        Returns:
            a raised to the power of b
        """
        return math.pow(a, b)


def is_valid_number(value: str) -> bool:
    """
    Validates if a string can be converted to a float.
    
    Args:
        value: String to validate
        
    Returns:
        True if valid, False otherwise
    """
    try:
        float(value)
        return True
    except (ValueError, TypeError):
        return False


def main():
    """Main entry point for the calculator application."""
    continue_calculating = True

    while continue_calculating:
        # Clear screen (works on Windows, macOS, and Linux)
        print("\033[2J\033[H" if sys.platform != "win32" else "\n" * 100)
        print("=== Basic Calculator ===\n")

        # Prompt for first operand
        first_input = input("Enter first number: ").strip()

        if not is_valid_number(first_input):
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue

        first_number = float(first_input)

        # Prompt for second operand
        second_input = input("Enter second number: ").strip()

        if not is_valid_number(second_input):
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue

        second_number = float(second_input)

        # Prompt for operator
        operator_input = input("Enter operator (+, -, *, /, %, ^): ").strip()

        if not operator_input:
            print("Operator cannot be empty.")
            input("Press Enter to continue...")
            continue

        # Perform calculation using methods
        result = None
        if operator_input == "+":
            result = CalculatorMethods.add(first_number, second_number)
        elif operator_input == "-":
            result = CalculatorMethods.subtract(first_number, second_number)
        elif operator_input == "*":
            result = CalculatorMethods.multiply(first_number, second_number)
        elif operator_input == "/":
            result = CalculatorMethods.divide(first_number, second_number)
        elif operator_input == "%":
            result = CalculatorMethods.modulo(first_number, second_number)
        elif operator_input == "^":
            result = CalculatorMethods.exponent(first_number, second_number)
        else:
            result = None

        # Display result or error message
        if result is None:
            print(f"\nError: '{operator_input}' is not a valid operator.")
            print("Valid operators: +, -, *, /, %, ^")
        elif math.isinf(result):
            print(f"\nError: Cannot divide by zero.")
        elif math.isnan(result):
            print(f"\nError: Invalid operation result.")
        else:
            print(f"\nResult: {first_number} {operator_input} {second_number} = {result}")

        # Ask if user wants to perform another calculation
        continue_response = input("\nWould you like to perform another calculation? (y/n): ").strip().lower()

        if not continue_response or continue_response != "y":
            continue_calculating = False
            print("\nThank you for using the calculator. Goodbye!")


if __name__ == "__main__":
    main()
