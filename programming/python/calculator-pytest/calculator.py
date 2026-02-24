"""
Calculator implementation following section 1.12.3 - Refactored with functions for testability

This is the main console application for the calculator, equivalent to the C# Calculator.cs file.
It provides an interactive loop for performing calculations.
"""

from calculator_operations import perform, display_result
import os


def main():
    """
    Main calculator loop that prompts user for operands and operator,
    performs the calculation, and displays the result.
    """
    continue_calculating = True
    
    while continue_calculating:
        os.system('cls' if os.name == 'nt' else 'clear')
        print("=== Simple Calculator ===\n")
        
        # Prompt for first operand
        try:
            first_input = input("Enter first number: ")
            first_operand = float(first_input)
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue
        
        # Prompt for second operand
        try:
            second_input = input("Enter second number: ")
            second_operand = float(second_input)
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue
        
        # Prompt for operator
        operator_input = input("Enter operator (+, -, *, /, %, ^): ").strip()
        if not operator_input or len(operator_input) != 1:
            print("Invalid operator. Please enter a single operator.")
            input("Press Enter to continue...")
            continue
        
        operator_char = operator_input[0]
        
        # Perform the arithmetic operation using calculator_operations module
        result = perform(first_operand, second_operand, operator_char)
        
        # Display the result
        display_result(first_operand, second_operand, operator_char, result)
        
        # Ask if the user wants to perform another calculation
        continue_input = input("\nDo you want to perform another calculation? (yes/no): ").strip().lower()
        
        # Handle user response
        if continue_input != "yes":
            continue_calculating = False
    
    print("\nThank you for using the calculator. Goodbye!")


if __name__ == "__main__":
    main()
