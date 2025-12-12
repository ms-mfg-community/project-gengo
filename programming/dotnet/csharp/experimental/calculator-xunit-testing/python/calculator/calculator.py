"""
Calculator class that provides arithmetic operations.

This module implements a calculator with basic arithmetic operations including
addition, subtraction, multiplication, division, modulo, and exponentiation.
It handles edge cases such as division by zero appropriately.
"""

import math
from typing import Optional


class Calculator:
    """
    Calculator class that provides arithmetic operations and user interaction.
    
    All methods are static and can be used without instantiating the class.
    Provides operations: addition, subtraction, multiplication, division,
    modulo, and exponentiation.
    """

    @staticmethod
    def add(first: float, second: float) -> float:
        """
        Adds two numbers.
        
        Args:
            first: The first operand
            second: The second operand
            
        Returns:
            The sum of the two numbers
        """
        return first + second

    @staticmethod
    def subtract(first: float, second: float) -> float:
        """
        Subtracts two numbers.
        
        Args:
            first: The first operand
            second: The second operand
            
        Returns:
            The difference (first - second)
        """
        return first - second

    @staticmethod
    def multiply(first: float, second: float) -> float:
        """
        Multiplies two numbers.
        
        Args:
            first: The first operand
            second: The second operand
            
        Returns:
            The product of the two numbers
        """
        return first * second

    @staticmethod
    def divide(first: float, second: float) -> float:
        """
        Divides two numbers.
        
        Args:
            first: The dividend
            second: The divisor
            
        Returns:
            The quotient, or NaN if division by zero
        """
        if second == 0:
            return Calculator._handle_division_by_zero()
        return first / second

    @staticmethod
    def modulo(first: float, second: float) -> float:
        """
        Performs modulo operation on two numbers.
        
        Uses truncated division (C# style) where the result has the sign of the dividend.
        This differs from Python's default behavior which uses floored division.
        
        Args:
            first: The dividend
            second: The divisor
            
        Returns:
            The remainder, or NaN if modulo by zero
        """
        if second == 0:
            print("Error: Cannot perform modulo by zero.")
            return float('nan')
        # Use C# style truncated modulo (result has sign of dividend)
        # Python's % uses floored division, but C# uses truncated division
        return first - second * int(first / second)

    @staticmethod
    def exponent(first: float, second: float) -> float:
        """
        Raises the first number to the power of the second number.
        
        Args:
            first: The base
            second: The exponent
            
        Returns:
            first raised to the power of second
        """
        return math.pow(first, second)

    @staticmethod
    def _handle_division_by_zero() -> float:
        """
        Handles division by zero error.
        
        Returns:
            NaN (Not a Number)
        """
        print("Error: Cannot divide by zero.")
        return float('nan')

    @staticmethod
    def perform_calculation(first: float, operation: Optional[str], second: float) -> float:
        """
        Performs the calculation based on the operation.
        
        Args:
            first: The first operand
            operation: The operation to perform (+, -, *, /, %, ^)
            second: The second operand
            
        Returns:
            The result of the operation, or NaN for invalid operations
        """
        if not operation:
            return float('nan')
        
        operations = {
            '+': Calculator.add,
            '-': Calculator.subtract,
            '*': Calculator.multiply,
            '/': Calculator.divide,
            '%': Calculator.modulo,
            '^': Calculator.exponent,
        }
        
        operation_func = operations.get(operation)
        if operation_func:
            return operation_func(first, second)
        
        return float('nan')

    @staticmethod
    def _get_numeric_input(prompt: str) -> float:
        """
        Gets numeric input from the user with validation.
        
        Args:
            prompt: The prompt to display to the user
            
        Returns:
            The validated numeric input
        """
        while True:
            try:
                user_input = input(prompt)
                return float(user_input)
            except ValueError:
                print("Invalid input. Please enter a valid number.")

    @staticmethod
    def _get_operator(prompt: str) -> str:
        """
        Gets and validates operator input from the user.
        
        Args:
            prompt: The prompt to display to the user
            
        Returns:
            The validated operator
        """
        valid_operators = ['+', '-', '*', '/', '%', '^']
        
        while True:
            user_input = input(prompt).strip()
            
            if not user_input:
                print(f"Invalid operator. Please enter {', '.join(valid_operators)}")
                continue
            
            if user_input in valid_operators:
                return user_input
            
            print(f"Invalid operator. Please enter {', '.join(valid_operators)}")

    @staticmethod
    def main() -> None:
        """
        Main entry point for the calculator application.
        
        Provides an interactive command-line calculator interface that
        continues to accept calculations until the user chooses to exit.
        """
        continue_calculating = True

        while continue_calculating:
            # Clear screen (platform-independent way)
            print("\n" * 2)
            print("=== Simple Calculator ===")
            
            # Get first operand
            first_operand = Calculator._get_numeric_input("Enter first operand: ")
            
            # Get second operand
            second_operand = Calculator._get_numeric_input("Enter second operand: ")
            
            # Get operator
            operator = Calculator._get_operator("Enter operator (+, -, *, /, %, ^): ")
            
            # Perform calculation
            result = Calculator.perform_calculation(first_operand, operator, second_operand)
            
            if math.isnan(result):
                print("Error: Invalid operation")
            else:
                print(f"\nResult: {first_operand} {operator} {second_operand} = {result}")
            
            # Ask if user wants to continue
            response = input("\nDo you want to perform another calculation? (yes/no): ").lower()
            continue_calculating = response in ['yes', 'y']

        print("\nThank you for using the calculator. Goodbye!")


if __name__ == "__main__":
    Calculator.main()
