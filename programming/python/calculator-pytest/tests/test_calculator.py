"""
Test suite for calculator_operations module using pytest.

This is equivalent to the C# xUnit CalculatorTest.cs file.
Tests include simple assertions and parametrized tests with multiple cases.
Coverage includes normal cases, edge cases, and error conditions.
"""

import pytest
import math
from calculator_operations import (
    add, subtract, multiply, divide, modulo, exponent, perform
)


class TestAddition:
    """Tests for the add() function."""
    
    def test_add_positive_numbers(self):
        """Verify basic addition with positive numbers."""
        result = add(5, 3)
        assert result == 8
    
    @pytest.mark.parametrize("a,b,expected", [
        (5, 3, 8),              # Normal case: positive numbers
        (-5, -3, -8),           # Edge case: negative numbers
        (0, 5, 5),              # Edge case: zero operand
        (5.5, 2.3, 7.8),        # Normal case: decimal numbers
        (-5, 5, 0),             # Edge case: opposites sum to zero
    ])
    def test_add_various_cases(self, a, b, expected):
        """Verify addition with multiple test cases."""
        result = add(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestSubtraction:
    """Tests for the subtract() function."""
    
    def test_subtract_positive_numbers(self):
        """Verify basic subtraction with positive numbers."""
        result = subtract(10, 3)
        assert result == 7
    
    @pytest.mark.parametrize("a,b,expected", [
        (10, 3, 7),             # Normal case: positive numbers
        (-5, -3, -2),           # Edge case: negative numbers
        (5, 0, 5),              # Edge case: subtract zero
        (0, 5, -5),             # Edge case: subtract from zero
        (7.5, 2.3, 5.2),        # Normal case: decimal numbers
    ])
    def test_subtract_various_cases(self, a, b, expected):
        """Verify subtraction with multiple test cases."""
        result = subtract(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestMultiplication:
    """Tests for the multiply() function."""
    
    def test_multiply_positive_numbers(self):
        """Verify basic multiplication with positive numbers."""
        result = multiply(4, 5)
        assert result == 20
    
    @pytest.mark.parametrize("a,b,expected", [
        (4, 5, 20),             # Normal case: positive numbers
        (-4, -5, 20),           # Edge case: negative numbers (product positive)
        (-4, 5, -20),           # Edge case: mixed signs
        (0, 5, 0),              # Edge case: multiply by zero
        (2.5, 4, 10),           # Normal case: decimal numbers
    ])
    def test_multiply_various_cases(self, a, b, expected):
        """Verify multiplication with multiple test cases."""
        result = multiply(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestDivision:
    """Tests for the divide() function."""
    
    def test_divide_positive_numbers(self):
        """Verify basic division with positive numbers."""
        result = divide(20, 4)
        assert result == 5
    
    def test_divide_by_zero(self):
        """Verify division by zero returns NaN."""
        result = divide(10, 0)
        assert math.isnan(result), "Division by zero should return NaN"
    
    @pytest.mark.parametrize("a,b,expected", [
        (20, 4, 5),             # Normal case: positive numbers
        (-20, -4, 5),           # Edge case: negative numbers (quotient positive)
        (-20, 4, -5),           # Edge case: mixed signs
        (0, 5, 0),              # Edge case: zero dividend
        (10, 2.5, 4),           # Normal case: decimal numbers
    ])
    def test_divide_various_cases(self, a, b, expected):
        """Verify division with multiple test cases."""
        result = divide(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestModulo:
    """Tests for the modulo() function."""
    
    def test_modulo_positive_numbers(self):
        """Verify basic modulo operation with positive numbers."""
        result = modulo(10, 3)
        assert result == 1
    
    def test_modulo_by_zero(self):
        """Verify modulo by zero returns NaN."""
        result = modulo(10, 0)
        assert math.isnan(result), "Modulo by zero should return NaN"
    
    @pytest.mark.parametrize("a,b,expected", [
        (10, 3, 1),             # Normal case: positive numbers
        (-10, 3, 2),            # Edge case: negative dividend (Python behavior)
        (10, -3, -2),           # Edge case: negative divisor (Python behavior)
        (0, 5, 0),              # Edge case: zero dividend
        (7.5, 2.5, 0),          # Normal case: decimal numbers
    ])
    def test_modulo_various_cases(self, a, b, expected):
        """Verify modulo with multiple test cases."""
        result = modulo(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestExponent:
    """Tests for the exponent() function."""
    
    def test_exponent_positive_exponent(self):
        """Verify basic exponent operation."""
        result = exponent(2, 3)
        assert result == 8
    
    @pytest.mark.parametrize("a,b,expected", [
        (2, 3, 8),              # Normal case: positive base and exponent
        (2, 0, 1),              # Edge case: any number to power 0 is 1
        (5, 2, 25),             # Normal case: squared
        (10, -1, 0.1),          # Edge case: negative exponent (reciprocal)
        (-2, 3, -8),            # Edge case: negative base with odd exponent
    ])
    def test_exponent_various_cases(self, a, b, expected):
        """Verify exponent with multiple test cases."""
        result = exponent(a, b)
        assert pytest.approx(result, abs=1e-10) == expected


class TestPerformMethod:
    """Tests for the perform() function."""
    
    def test_perform_addition_operator(self):
        """Verify perform method routes to correct operation for addition."""
        result = perform(5, 3, '+')
        assert result == 8
    
    @pytest.mark.parametrize("a,b,op,expected", [
        (10, 5, '+', 15),       # Addition
        (10, 5, '-', 5),        # Subtraction
        (10, 5, '*', 50),       # Multiplication
        (10, 5, '/', 2),        # Division
        (10, 3, '%', 1),        # Modulo
        (2, 3, '^', 8),         # Exponent
    ])
    def test_perform_all_operators(self, a, b, op, expected):
        """Verify perform method with all supported operators."""
        result = perform(a, b, op)
        assert pytest.approx(result, abs=1e-10) == expected
    
    def test_perform_invalid_operator(self):
        """Verify perform method returns NaN for invalid operator."""
        result = perform(10, 5, '&')
        assert math.isnan(result), "Invalid operator should return NaN"


# Additional test for edge cases with multiple operations
class TestComplexScenarios:
    """Tests for complex calculation scenarios."""
    
    def test_chain_operations(self):
        """Verify results can be used in subsequent operations."""
        result1 = add(5, 3)  # 8
        result2 = multiply(result1, 2)  # 16
        assert result2 == 16
    
    def test_mixed_positive_negative(self):
        """Verify mixed positive and negative number calculations."""
        result = perform(-10, 3, '+')
        assert result == -7
    
    def test_very_small_numbers(self):
        """Verify operations with very small decimal numbers."""
        result = divide(0.0001, 0.0002)
        assert pytest.approx(result, abs=1e-10) == 0.5
