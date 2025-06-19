#!/usr/bin/env python3
"""
Simple Calculator Program
This program performs basic arithmetic operations: addition, subtraction, multiplication, division, modulo, and power.
"""

import math
import os


class CalculatorOperations:
    """
    Provides basic arithmetic operations for the calculator
    """
    
    def add(self, a: float, b: float) -> float:
        """
        Adds two numbers
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            Sum of the two numbers
        """
        return a + b
    
    def subtract(self, a: float, b: float) -> float:
        """
        Subtracts the second number from the first number
        
        Args:
            a: First number (minuend)
            b: Second number (subtrahend)
            
        Returns:
            Difference of the two numbers
        """
        return a - b
    
    def multiply(self, a: float, b: float) -> float:
        """
        Multiplies two numbers
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            Product of the two numbers
        """
        return a * b
    
    def divide(self, a: float, b: float) -> float:
        """
        Divides the first number by the second number
        
        Args:
            a: Dividend
            b: Divisor
            
        Returns:
            Quotient of the division
            
        Raises:
            ZeroDivisionError: When divisor is zero
        """
        if b == 0:
            raise ZeroDivisionError("Cannot divide by zero")
        return a / b
    
    def modulo(self, a: float, b: float) -> float:
        """
        Calculates the modulo (remainder) of the first number divided by the second number
        
        Args:
            a: Dividend
            b: Divisor
            
        Returns:
            Remainder of the division
            
        Raises:
            ZeroDivisionError: When divisor is zero        """
        if b == 0:
            raise ZeroDivisionError("Cannot perform modulo with zero divisor")
        return a % b
    
    def power(self, base_number: float, exponent: float) -> float:
        """
        Raises the first number to the power of the second number
        
        Args:
            base_number: Base number
            exponent: Exponent
            
        Returns:
            Result of base raised to the power of exponent
            
        Raises:
            ValueError: When result would be infinite or invalid
        """
        try:
            result = math.pow(base_number, exponent)
            if math.isinf(result) or math.isnan(result):
                raise ValueError("Result is infinite or not a valid number")
            return result
        except OverflowError:
            raise ValueError("Result is infinite or not a valid number")


def clear_screen():
    """Clear the console screen"""
    os.system('cls' if os.name == 'nt' else 'clear')


def get_number_input(prompt: str) -> float:
    """
    Get a valid number input from the user
    
    Args:
        prompt: The prompt to display to the user
        
    Returns:
        The parsed float value
        
    Raises:
        ValueError: If the input cannot be parsed as a float
    """
    user_input = input(prompt).strip()
    try:
        return float(user_input)
    except ValueError:
        raise ValueError("Invalid input. Please enter a valid number.")


def main():
    """Main calculator program loop"""
    # Create instance of CalculatorOperations for performing calculations
    calculator = CalculatorOperations()
    
    # Clear the screen at program start
    clear_screen()
    
    # Main calculator loop
    continue_calculating = True
    
    while continue_calculating:
        print("Simple Calculator")
        print("----------------")
        
        try:
            # Get first operand
            first_number = get_number_input("Enter first number: ")
            
            # Get second operand
            second_number = get_number_input("Enter second number: ")
            
            # Get operator
            operator_input = input("Enter operator (+, -, *, /, %, ^): ").strip()
            
            # Calculate and display result
            result = 0.0
            valid_operation = True
            
            # Check if operator input is valid
            if not operator_input:
                print("Invalid operator. Please use +, -, *, /, %, or ^.")
                valid_operation = False
            else:
                try:
                    if operator_input == "+":
                        result = calculator.add(first_number, second_number)
                    elif operator_input == "-":
                        result = calculator.subtract(first_number, second_number)
                    elif operator_input == "*":
                        result = calculator.multiply(first_number, second_number)
                    elif operator_input == "/":
                        result = calculator.divide(first_number, second_number)
                    elif operator_input == "%":
                        result = calculator.modulo(first_number, second_number)
                    elif operator_input == "^":
                        result = calculator.power(first_number, second_number)
                    else:
                        print("Invalid operator. Please use +, -, *, /, %, or ^.")
                        valid_operation = False
                        
                except ZeroDivisionError:
                    print("Error: Division by zero is not allowed.")
                    valid_operation = False
                except ValueError as ex:
                    print(f"Error: {ex}")
                    valid_operation = False
            
            # Display the result if operation was valid
            if valid_operation:
                print(f"Result: {result}")
                
        except ValueError as ex:
            print(str(ex))
            valid_operation = False
        
        # Ask if the user wants to perform another calculation
        user_response = input("Do you want to perform another calculation? (yes/no): ").strip().lower()
        
        # Determine if the calculator should continue running
        continue_calculating = user_response in ["yes", "y"]
        
        # Clear screen after each calculation or before exit
        if continue_calculating:
            clear_screen()
        else:
            clear_screen()
    
    # Display exit message
    print("Thank you for using the Simple Calculator. Goodbye!")


if __name__ == "__main__":
    main()
