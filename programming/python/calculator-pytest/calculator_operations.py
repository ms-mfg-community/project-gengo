"""
Calculator operations module for Python implementation.

This module provides arithmetic operations equivalent to the C# CalculatorOperations class.
All functions are designed to be testable with pytest.
"""

import math


def add(a: float, b: float) -> float:
    """
    Adds two numbers and returns the result.
    
    Args:
        a: First operand
        b: Second operand
    
    Returns:
        The sum of a and b
    """
    return a + b


def subtract(a: float, b: float) -> float:
    """
    Subtracts the second number from the first and returns the result.
    
    Args:
        a: First operand (minuend)
        b: Second operand (subtrahend)
    
    Returns:
        The difference of a - b
    """
    return a - b


def multiply(a: float, b: float) -> float:
    """
    Multiplies two numbers and returns the result.
    
    Args:
        a: First operand
        b: Second operand
    
    Returns:
        The product of a and b
    """
    return a * b


def divide(a: float, b: float) -> float:
    """
    Divides the first number by the second. Returns NaN if divisor is zero.
    
    Args:
        a: Dividend (numerator)
        b: Divisor (denominator)
    
    Returns:
        The quotient of a / b, or NaN if b is zero
    """
    if b != 0:
        return a / b
    else:
        return float('nan')


def modulo(a: float, b: float) -> float:
    """
    Performs modulo operation on two numbers. Returns NaN if divisor is zero.
    
    Args:
        a: Dividend
        b: Divisor
    
    Returns:
        The remainder of a % b, or NaN if b is zero
    """
    if b != 0:
        return a % b
    else:
        return float('nan')


def exponent(a: float, b: float) -> float:
    """
    Raises the first number to the power of the second and returns the result.
    
    Args:
        a: Base
        b: Exponent
    
    Returns:
        a raised to the power of b (a^b)
    """
    return math.pow(a, b)


def perform(operand1: float, operand2: float, op: str) -> float:
    """
    Performs the specified arithmetic operation on two operands.
    
    Args:
        operand1: First operand
        operand2: Second operand
        op: Operator string ('+', '-', '*', '/', '%', '^')
    
    Returns:
        Result of the operation, or NaN if operator is invalid
    """
    operations = {
        '+': lambda a, b: add(a, b),
        '-': lambda a, b: subtract(a, b),
        '*': lambda a, b: multiply(a, b),
        '/': lambda a, b: divide(a, b),
        '%': lambda a, b: modulo(a, b),
        '^': lambda a, b: exponent(a, b),
    }
    
    if op in operations:
        return operations[op](operand1, operand2)
    else:
        return float('nan')


def display_result(operand1: float, operand2: float, op: str, result: float) -> None:
    """
    Displays the calculation result or error message.
    
    Args:
        operand1: First operand
        operand2: Second operand
        op: Operator
        result: Calculation result
    """
    if math.isnan(result):
        if op in ('/', '%'):
            print("\nError: Cannot divide or modulo by zero.")
        else:
            print("\nError: Invalid operator.")
    else:
        print(f"\nResult: {operand1} {op} {operand2} = {result}")
