#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Simple calculator program
This program implements a basic calculator with support for addition, subtraction,
multiplication, division, modulo, and power operations using a console interface.
It demonstrates error handling, user input validation, and clean UI design.
"""

import os
import math

class CalculatorOperations:
    """
    Contains static methods for basic calculator operations.
    All methods are designed to be testable independently.
    """
    
    @staticmethod
    def add(a, b):
        """
        Adds two numeric values.
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            Sum of the two numbers
            
        Notes:
            - This method handles the full range of numeric values including negatives.
            - Adding very large numbers may result in precision issues
        """
        return a + b
    
    @staticmethod
    def subtract(a, b):
        """
        Subtracts the second numeric value from the first.
        
        Args:
            a: Number to subtract from
            b: Number to subtract
            
        Returns:
            Difference between the two numbers
            
        Notes:
            - This method handles the full range of numeric values including negatives.
            - Subtracting very close numbers may result in precision issues
        """
        return a - b
    
    @staticmethod
    def multiply(a, b):
        """
        Multiplies two numeric values.
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            Product of the two numbers
            
        Notes:
            - This method handles the full range of numeric values including negatives.
            - Multiplying by zero always returns zero
            - Sign rules apply (negative * negative = positive)
        """
        return a * b
    
    @staticmethod
    def divide(a, b):
        """
        Divides the first numeric value by the second.
        
        Args:
            a: Numerator
            b: Denominator
            
        Returns:
            Quotient of the division
            
        Raises:
            ZeroDivisionError: When divisor is zero
            
        Notes:
            - Division by zero raises ZeroDivisionError
            - Division of zero by any non-zero number returns zero
            - Sign rules apply (negative / negative = positive)
        """
        if b == 0:
            raise ZeroDivisionError("Cannot divide by zero.")
        return a / b
    
    @staticmethod
    def modulo(a, b):
        """
        Calculates the remainder of dividing the first value by the second.
        
        Args:
            a: Numerator
            b: Denominator
            
        Returns:
            Remainder of the division
            
        Raises:
            ZeroDivisionError: When divisor is zero
            
        Notes:
            - Modulo by zero raises ZeroDivisionError
            - Python modulo with negative numbers might behave differently than C#
            - In Python: -7 % 3 = 2 (different from C#'s -1)
        """
        if b == 0:
            raise ZeroDivisionError("Cannot find modulo with zero divisor.")
        return a % b
    
    @staticmethod
    def power(a, b):
        """
        Raises the first value to the power of the second value.
        
        Args:
            a: Base number
            b: Exponent
            
        Returns:
            The result of raising a to the power of b
            
        Notes:
            - This method uses math.pow internally, which has several edge cases:
            - 0^0 returns 1 (mathematical convention)
            - Any number raised to 0 returns 1
            - 0 raised to any positive power returns 0
            - Negative numbers raised to fractional powers return complex numbers in Python
        """
        return math.pow(a, b)


def clear_screen():
    """Clear the terminal screen"""
    # Using os.system to clear screen - works on both Windows and Unix/Linux/Mac
    os.system('cls' if os.name == 'nt' else 'clear')


def main():
    """Main program logic"""
    # Clear screen at start to provide a clean interface
    clear_screen()
    
    # Main program logic - This flag controls the calculation loop
    continue_calculating = True
    
    # Display welcome message and header
    print("Simple Calculator")
    print("----------------")
    
    # Main calculator loop - continues until the user chooses to exit
    while continue_calculating:
        # Get first operand with error checking
        first_number = None
        while first_number is None:
            try:
                first_input = input("Enter first number: ")
                first_number = float(first_input)
            except ValueError:
                print("Invalid input. Please enter a valid number.")
        
        # Get second operand with the same error checking pattern
        second_number = None
        while second_number is None:
            try:
                second_input = input("Enter second number: ")
                second_number = float(second_input)
            except ValueError:
                print("Invalid input. Please enter a valid number.")
        
        # Get the operation to perform
        # Supported operators: +, -, *, /, %, ^
        operator_input = input("Enter operator (+, -, *, /, %, ^): ")
        
        # Initialize result and valid operation flag
        result = 0
        valid_operation = True
        
        # Use a try-except block to handle potential exceptions from operations
        try:
            # Process the operation based on the provided operator
            if operator_input == "+":
                result = CalculatorOperations.add(first_number, second_number)
            elif operator_input == "-":
                result = CalculatorOperations.subtract(first_number, second_number)
            elif operator_input == "*":
                result = CalculatorOperations.multiply(first_number, second_number)
            elif operator_input == "/":
                result = CalculatorOperations.divide(first_number, second_number)
            elif operator_input == "%":
                result = CalculatorOperations.modulo(first_number, second_number)
            elif operator_input == "^":
                result = CalculatorOperations.power(first_number, second_number)
            else:
                # Handle invalid operator input
                print("Invalid operator. Please use +, -, *, /, %, or ^.")
                valid_operation = False
            
            # Display the result only if the operation was valid
            if valid_operation:
                print(f"Result: {result}")
                
        except ZeroDivisionError:
            # Special handling for division by zero
            print("Error: Cannot divide by zero.")
        except Exception as ex:
            # Handle other exceptions that might occur in the operations
            print(f"Error: {ex}")
        
        # Ask if the user wants to perform another calculation
        user_response = input("Do you want to perform another calculation? (yes/no): ").lower()
        
        # Accept both "yes" and "y" as affirmative responses
        continue_calculating = user_response in ("yes", "y")
        
        if continue_calculating:
            # Clear screen and redisplay header for the next calculation
            # This improves user experience by removing clutter
            clear_screen()
            print("Simple Calculator")
            print("----------------")
        else:
            # Clear screen before displaying goodbye message
            # This provides a clean exit experience
            clear_screen()
    
    # Display farewell message
    print("Thank you for using the calculator. Goodbye!")


if __name__ == "__main__":
    main()