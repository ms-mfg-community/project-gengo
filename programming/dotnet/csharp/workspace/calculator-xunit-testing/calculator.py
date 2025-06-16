"""
A simple interactive calculator supporting +, -, *, /, %, ^ operations.
Handles invalid input, division/modulo by zero, and allows repeated calculations.
"""
import math

def add(a, b):
    """Returns the sum of two numbers."""
    return a + b

def subtract(a, b):
    """Returns the difference of two numbers (a - b)."""
    return a - b

def multiply(a, b):
    """Returns the product of two numbers."""
    return a * b

def divide(a, b):
    """Returns the quotient of two numbers (a / b). Raises ZeroDivisionError if b is zero."""
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero.")
    return a / b

def modulo(a, b):
    """Returns the remainder of division (a % b). Raises ZeroDivisionError if b is zero."""
    if b == 0:
        raise ZeroDivisionError("Cannot modulo by zero.")
    return a % b

def exponent(a, b):
    """Returns a raised to the power of b (a^b)."""
    return math.pow(a, b)

if __name__ == "__main__":
    while True:
        # Clear the screen at the start of each calculation
        try:
            import os
            os.system('cls' if os.name == 'nt' else 'clear')
        except Exception:
            pass

        # Prompt for the first operand
        try:
            num1 = float(input("Enter the first number: "))
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue

        # Prompt for the second operand
        try:
            num2 = float(input("Enter the second number: "))
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            input("Press Enter to continue...")
            continue

        # Prompt for the operator
        op = input("Enter the operator (+, -, *, /, %, ^): ")
        result = None
        valid = True
        try:
            if op == "+":
                result = add(num1, num2)
            elif op == "-":
                result = subtract(num1, num2)
            elif op == "*":
                result = multiply(num1, num2)
            elif op == "/":
                result = divide(num1, num2)
            elif op == "%":
                result = modulo(num1, num2)
            elif op == "^":
                result = exponent(num1, num2)
            else:
                print("Invalid operator. Please enter one of +, -, *, /, %, ^")
                valid = False
        except ZeroDivisionError as e:
            print(e)
            valid = False
        if valid and result is not None:
            print(f"Result: {num1} {op} {num2} = {result}")

        again = input("Do you want to perform another calculation? (yes/no): ").strip().lower()
        if again not in ("yes", "y"):
            try:
                import os
                os.system('cls' if os.name == 'nt' else 'clear')
            except Exception:
                pass
            print("Thank you for using the calculator. Goodbye!")
            break
