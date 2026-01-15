"""
Unit tests for the calculator application.
This is a Python translation of the xUnit tests from the C# project
for cross-language comparison testing practices.
"""

import pytest
import math
from calculator_python import CalculatorMethods


class TestAddition:
    """Test cases for the Add operation."""

    def test_add_two_positive_numbers(self):
        """Test basic addition of two positive numbers."""
        assert CalculatorMethods.add(5, 3) == 8

    def test_add_various_numbers(self):
        """Test addition with various number combinations."""
        assert CalculatorMethods.add(10, 5) == 15
        assert CalculatorMethods.add(-10, -5) == -15
        assert CalculatorMethods.add(10, -5) == 5
        assert CalculatorMethods.add(-10, 5) == -5


class TestSubtraction:
    """Test cases for the Subtract operation."""

    def test_subtract_two_positive_numbers(self):
        """Test basic subtraction of two positive numbers."""
        assert CalculatorMethods.subtract(10, 3) == 7

    def test_subtract_various_numbers(self):
        """Test subtraction with various number combinations."""
        assert CalculatorMethods.subtract(10, 5) == 5
        assert CalculatorMethods.subtract(-10, -5) == -5
        assert CalculatorMethods.subtract(10, -5) == 15
        assert CalculatorMethods.subtract(-10, 5) == -15


class TestMultiplication:
    """Test cases for the Multiply operation."""

    def test_multiply_two_positive_numbers(self):
        """Test basic multiplication of two positive numbers."""
        assert CalculatorMethods.multiply(4, 5) == 20

    def test_multiply_various_numbers(self):
        """Test multiplication with various number combinations."""
        assert CalculatorMethods.multiply(6, 7) == 42
        assert CalculatorMethods.multiply(-6, 7) == -42
        assert CalculatorMethods.multiply(6, -7) == -42
        assert CalculatorMethods.multiply(-6, -7) == 42
        assert CalculatorMethods.multiply(0, 5) == 0


class TestDivision:
    """Test cases for the Divide operation."""

    def test_divide_two_positive_numbers(self):
        """Test basic division of two positive numbers."""
        assert CalculatorMethods.divide(20, 4) == 5

    def test_divide_various_numbers(self):
        """Test division with various number combinations."""
        assert CalculatorMethods.divide(20, 4) == 5
        assert CalculatorMethods.divide(-20, 4) == -5
        assert CalculatorMethods.divide(20, -4) == -5
        assert CalculatorMethods.divide(-20, -4) == 5

    def test_divide_by_zero_returns_infinity(self):
        """Test division by zero returns positive infinity."""
        result = CalculatorMethods.divide(10, 0)
        assert math.isinf(result)


class TestModulo:
    """Test cases for the Modulo operation."""

    def test_modulo_two_positive_numbers(self):
        """Test basic modulo operation."""
        assert CalculatorMethods.modulo(10, 3) == 1

    def test_modulo_various_numbers(self):
        """Test modulo with various number combinations.
        Note: Python's modulo behavior differs from C# for negative numbers.
        Python returns a positive result with the sign of divisor.
        """
        assert CalculatorMethods.modulo(10, 3) == 1
        assert CalculatorMethods.modulo(15, 4) == 3
        assert CalculatorMethods.modulo(20, 5) == 0
        # Python modulo: -10 % 3 = 2 (not -1 like C#)
        assert CalculatorMethods.modulo(-10, 3) == 2

    def test_modulo_by_zero_returns_nan(self):
        """Test modulo by zero returns NaN."""
        result = CalculatorMethods.modulo(10, 0)
        assert math.isnan(result)


class TestExponent:
    """Test cases for the Exponent operation."""

    def test_exponent_positive_base_and_exponent(self):
        """Test basic exponentiation."""
        assert CalculatorMethods.exponent(2, 3) == 8

    def test_exponent_various_numbers(self):
        """Test exponentiation with various number combinations."""
        assert CalculatorMethods.exponent(2, 3) == 8
        assert CalculatorMethods.exponent(5, 2) == 25
        assert CalculatorMethods.exponent(10, 0) == 1
        assert CalculatorMethods.exponent(2, -2) == pytest.approx(0.25)


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
