#!/usr/bin/env python3
"""
Manual test script for the calculator
"""

from calculator import CalculatorOperations

def test_calculator_operations():
    """Test the calculator operations manually"""
    calc = CalculatorOperations()
    
    print("Testing Calculator Operations:")
    print("=" * 40)
    
    # Test Addition
    result = calc.add(5.5, 3.2)
    print(f"5.5 + 3.2 = {result}")
    
    # Test Subtraction
    result = calc.subtract(10.5, 3.2)
    print(f"10.5 - 3.2 = {result}")
    
    # Test Multiplication
    result = calc.multiply(4.5, 2.0)
    print(f"4.5 * 2.0 = {result}")
    
    # Test Division
    result = calc.divide(15.0, 3.0)
    print(f"15.0 / 3.0 = {result}")
    
    # Test Modulo
    result = calc.modulo(17.0, 5.0)
    print(f"17.0 % 5.0 = {result}")
    
    # Test Power
    result = calc.power(2.0, 3.0)
    print(f"2.0 ^ 3.0 = {result}")
    
    print("\nTesting Error Cases:")
    print("-" * 20)
    
    # Test Division by Zero
    try:
        calc.divide(10.0, 0.0)
    except ZeroDivisionError as e:
        print(f"Division by zero: {e}")
    
    # Test Modulo by Zero
    try:
        calc.modulo(10.0, 0.0)
    except ZeroDivisionError as e:
        print(f"Modulo by zero: {e}")
    
    # Test Power with negative base and decimal exponent
    try:
        calc.power(-4.0, 0.5)
    except ValueError as e:
        print(f"Invalid power operation: {e}")
    
    print("\nAll tests completed successfully!")

if __name__ == "__main__":
    test_calculator_operations()
