#!/usr/bin/env python3
"""
Unit tests for the CalculatorOperations class
Tests all arithmetic operations including edge cases and error conditions
"""

import pytest
import math
from calculator import CalculatorOperations


class TestCalculatorOperations:
    """Test class for CalculatorOperations"""
    
    def setup_method(self):
        """Set up test fixtures before each test method."""
        self.calculator = CalculatorOperations()

    # Addition Tests
    
    def test_add_positive_numbers_returns_correct_sum(self):
        """Test addition of positive numbers"""
        # Arrange
        a = 5.5
        b = 3.2
        expected = 8.7
        
        # Act
        result = self.calculator.add(a, b)
        
        # Assert
        assert abs(result - expected) < 1e-10
    
    def test_add_negative_numbers_returns_correct_sum(self):
        """Test addition of negative numbers"""
        # Arrange
        a = -10.5
        b = -4.3
        expected = -14.8
        
        # Act
        result = self.calculator.add(a, b)
        
        # Assert
        assert abs(result - expected) < 1e-10
    
    def test_add_positive_and_negative_numbers_returns_correct_sum(self):
        """Test addition of positive and negative numbers"""
        # Arrange
        a = 15.7
        b = -8.2
        expected = 7.5
        
        # Act
        result = self.calculator.add(a, b)
        
        # Assert
        assert abs(result - expected) < 1e-10
    
    def test_add_zero_and_positive_number_returns_positive_number(self):
        """Test addition with zero"""
        # Arrange
        a = 0
        b = 42.5
        expected = 42.5
        
        # Act
        result = self.calculator.add(a, b)
        
        # Assert
        assert result == expected

    # Subtraction Tests
    
    def test_subtract_positive_numbers_returns_correct_difference(self):
        """Test subtraction of positive numbers"""
        # Arrange
        a = 10.5
        b = 3.2
        expected = 7.3
        
        # Act
        result = self.calculator.subtract(a, b)
        
        # Assert
        assert abs(result - expected) < 1e-10
    
    def test_subtract_negative_numbers_returns_correct_difference(self):
        """Test subtraction of negative numbers"""
        # Arrange
        a = -5.5
        b = -2.3
        expected = -3.2
        
        # Act
        result = self.calculator.subtract(a, b)
        
        # Assert
        assert abs(result - expected) < 1e-10
    
    def test_subtract_from_zero_returns_negative_number(self):
        """Test subtraction from zero"""
        # Arrange
        a = 0
        b = 7.5
        expected = -7.5
        
        # Act
        result = self.calculator.subtract(a, b)
        
        # Assert
        assert result == expected
    
    def test_subtract_same_numbers_returns_zero(self):
        """Test subtraction of same numbers"""
        # Arrange
        a = 15.7
        b = 15.7
        expected = 0
        
        # Act
        result = self.calculator.subtract(a, b)
        
        # Assert
        assert result == expected

    # Multiplication Tests
    
    def test_multiply_positive_numbers_returns_correct_product(self):
        """Test multiplication of positive numbers"""
        # Arrange
        a = 4.5
        b = 2.0
        expected = 9.0
        
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected
    
    def test_multiply_negative_numbers_returns_positive_product(self):
        """Test multiplication of negative numbers"""
        # Arrange
        a = -3.0
        b = -4.0
        expected = 12.0
        
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected
    
    def test_multiply_positive_and_negative_numbers_returns_negative_product(self):
        """Test multiplication of positive and negative numbers"""
        # Arrange
        a = 6.0
        b = -2.5
        expected = -15.0
        
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected
    
    def test_multiply_by_zero_returns_zero(self):
        """Test multiplication by zero"""
        # Arrange
        a = 42.7
        b = 0
        expected = 0
        
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected
    
    def test_multiply_by_one_returns_original_number(self):
        """Test multiplication by one"""
        # Arrange
        a = 25.3
        b = 1
        expected = 25.3
        
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected

    # Division Tests
    
    def test_divide_positive_numbers_returns_correct_quotient(self):
        """Test division of positive numbers"""
        # Arrange
        a = 15.0
        b = 3.0
        expected = 5.0
        
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected
    
    def test_divide_negative_numbers_returns_positive_quotient(self):
        """Test division of negative numbers"""
        # Arrange
        a = -20.0
        b = -4.0
        expected = 5.0
        
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected
    
    def test_divide_positive_by_negative_returns_negative_quotient(self):
        """Test division of positive by negative"""
        # Arrange
        a = 12.0
        b = -3.0
        expected = -4.0
        
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected
    
    def test_divide_by_zero_raises_zero_division_error(self):
        """Test division by zero raises exception"""
        # Arrange
        a = 10.0
        b = 0.0
        
        # Act & Assert
        with pytest.raises(ZeroDivisionError) as exc_info:
            self.calculator.divide(a, b)
        assert str(exc_info.value) == "Cannot divide by zero"
    
    def test_divide_zero_by_non_zero_returns_zero(self):
        """Test zero divided by non-zero"""
        # Arrange
        a = 0.0
        b = 5.0
        expected = 0.0
        
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected
    
    def test_divide_by_one_returns_original_number(self):
        """Test division by one"""
        # Arrange
        a = 42.5
        b = 1.0
        expected = 42.5
        
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected

    # Modulo Tests
    
    def test_modulo_positive_numbers_returns_correct_remainder(self):
        """Test modulo of positive numbers"""
        # Arrange
        a = 17.0
        b = 5.0
        expected = 2.0
        
        # Act
        result = self.calculator.modulo(a, b)
        
        # Assert
        assert result == expected
    
    def test_modulo_negative_numbers_returns_correct_remainder(self):
        """Test modulo of negative numbers"""
        # Arrange
        a = -17.0
        b = -5.0
        expected = -2.0
        
        # Act
        result = self.calculator.modulo(a, b)
        
        # Assert
        assert result == expected
    
    def test_modulo_mixed_signs_returns_correct_remainder(self):
        """Test modulo with mixed signs"""
        # Arrange
        a = 17.0
        b = -5.0
        expected = -3.0  # In Python, 17 % -5 = -3 (result has same sign as divisor)
        
        # Act
        result = self.calculator.modulo(a, b)
        
        # Assert
        assert result == expected
    
    def test_modulo_by_zero_raises_zero_division_error(self):
        """Test modulo by zero raises exception"""
        # Arrange
        a = 10.0
        b = 0.0
        
        # Act & Assert
        with pytest.raises(ZeroDivisionError) as exc_info:
            self.calculator.modulo(a, b)
        assert str(exc_info.value) == "Cannot perform modulo with zero divisor"
    
    def test_modulo_zero_by_non_zero_returns_zero(self):
        """Test zero modulo non-zero"""
        # Arrange
        a = 0.0
        b = 5.0
        expected = 0.0
        
        # Act
        result = self.calculator.modulo(a, b)
        
        # Assert
        assert result == expected
    
    def test_modulo_equal_numbers_returns_zero(self):
        """Test modulo of equal numbers"""
        # Arrange
        a = 7.0
        b = 7.0
        expected = 0.0
        
        # Act
        result = self.calculator.modulo(a, b)
        
        # Assert
        assert result == expected

    # Power Tests
    
    def test_power_positive_base_positive_exponent_returns_correct_result(self):
        """Test power with positive base and positive exponent"""
        # Arrange
        base_number = 2.0
        exponent = 3.0
        expected = 8.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_positive_base_negative_exponent_returns_correct_result(self):
        """Test power with positive base and negative exponent"""
        # Arrange
        base_number = 2.0
        exponent = -3.0
        expected = 0.125
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_negative_base_even_exponent_returns_positive_result(self):
        """Test power with negative base and even exponent"""
        # Arrange
        base_number = -3.0
        exponent = 2.0
        expected = 9.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_negative_base_odd_exponent_returns_negative_result(self):
        """Test power with negative base and odd exponent"""
        # Arrange
        base_number = -2.0
        exponent = 3.0
        expected = -8.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_any_number_to_zero_returns_one(self):
        """Test any number to the power of zero"""
        # Arrange
        base_number = 42.0
        exponent = 0.0
        expected = 1.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_zero_to_positive_exponent_returns_zero(self):
        """Test zero to a positive exponent"""
        # Arrange
        base_number = 0.0
        exponent = 5.0
        expected = 0.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_one_to_any_exponent_returns_one(self):
        """Test one to any exponent"""
        # Arrange
        base_number = 1.0
        exponent = 100.0
        expected = 1.0
        
        # Act
        result = self.calculator.power(base_number, exponent)
        
        # Assert
        assert result == expected
    
    def test_power_large_exponent_raises_value_error(self):
        """Test power with large exponent raises exception"""
        # Arrange
        base_number = 10.0
        exponent = 1000.0
        
        # Act & Assert
        with pytest.raises(ValueError):
            self.calculator.power(base_number, exponent)
    
    def test_power_negative_base_decimal_exponent_raises_value_error(self):
        """Test power with negative base and decimal exponent raises exception"""
        # Arrange
        base_number = -4.0
        exponent = 0.5  # Square root of negative number results in NaN
        
        # Act & Assert
        with pytest.raises(ValueError):
            self.calculator.power(base_number, exponent)

    # Parametrized Tests (equivalent to Theory tests in C#)
    
    @pytest.mark.parametrize("a, b, expected", [
        (5.0, 2.0, 25.0),
        (3.0, 4.0, 81.0),
        (10.0, 0.0, 1.0),
        (2.0, -2.0, 0.25),
    ])
    def test_power_various_inputs_returns_expected_results(self, a, b, expected):
        """Test power with various inputs"""
        # Act
        result = self.calculator.power(a, b)
        
        # Assert
        assert result == expected

    @pytest.mark.parametrize("a, b, expected", [
        (1.0, 2.0, 3.0),
        (-1.0, -2.0, -3.0),
        (0.0, 0.0, 0.0),
        (10.5, 5.5, 16.0),
        (-10.0, 15.0, 5.0),
    ])
    def test_add_multiple_scenarios_returns_expected_results(self, a, b, expected):
        """Test addition with multiple scenarios"""
        # Act
        result = self.calculator.add(a, b)
        
        # Assert
        assert result == expected

    @pytest.mark.parametrize("a, b, expected", [
        (10.0, 5.0, 5.0),
        (0.0, 5.0, -5.0),
        (-10.0, -5.0, -5.0),
        (15.5, 10.5, 5.0),
    ])
    def test_subtract_multiple_scenarios_returns_expected_results(self, a, b, expected):
        """Test subtraction with multiple scenarios"""
        # Act
        result = self.calculator.subtract(a, b)
        
        # Assert
        assert result == expected

    @pytest.mark.parametrize("a, b, expected", [
        (2.0, 3.0, 6.0),
        (-2.0, 3.0, -6.0),
        (-2.0, -3.0, 6.0),
        (0.0, 5.0, 0.0),
        (1.0, 100.0, 100.0),
    ])
    def test_multiply_multiple_scenarios_returns_expected_results(self, a, b, expected):
        """Test multiplication with multiple scenarios"""
        # Act
        result = self.calculator.multiply(a, b)
        
        # Assert
        assert result == expected

    @pytest.mark.parametrize("a, b, expected", [
        (10.0, 2.0, 5.0),
        (-10.0, 2.0, -5.0),
        (-10.0, -2.0, 5.0),
        (0.0, 5.0, 0.0),
        (25.0, 5.0, 5.0),
    ])
    def test_divide_multiple_scenarios_returns_expected_results(self, a, b, expected):
        """Test division with multiple scenarios"""
        # Act
        result = self.calculator.divide(a, b)
        
        # Assert
        assert result == expected


if __name__ == "__main__":
    pytest.main([__file__])
