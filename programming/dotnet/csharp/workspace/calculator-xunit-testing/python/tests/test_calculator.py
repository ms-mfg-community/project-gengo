"""
Comprehensive unit tests for the Calculator class.

Tests cover normal cases, edge cases, and error conditions.
Test data is sourced from a CSV file for maintainability and clarity.
"""

import csv
import math
import os
from typing import List, Tuple

import pytest

from calculator.calculator import Calculator


class DataRecord:
    """Data class representing a test record from the CSV file."""
    
    def __init__(self, first_number: float, second_number: float, 
                 operation: str, expected_value: float, result: str = "unknown"):
        self.first_number = first_number
        self.second_number = second_number
        self.operation = operation
        self.expected_value = expected_value
        self.result = result


def get_test_data_from_csv() -> List[DataRecord]:
    """
    Gets test data from the CSV file.
    
    Returns:
        List of DataRecord objects containing test cases
    """
    # Find the CSV file relative to this test file
    current_dir = os.path.dirname(os.path.abspath(__file__))
    csv_path = os.path.join(current_dir, "test_data", "CalculatorTestData.csv")
    
    if not os.path.exists(csv_path):
        raise FileNotFoundError(f"Test data CSV file not found at: {csv_path}")
    
    records = []
    
    with open(csv_path, 'r', encoding='utf-8-sig') as file:
        csv_reader = csv.reader(file)
        # Skip header line
        next(csv_reader)
        
        for row in csv_reader:
            if not row or len(row) < 4:
                continue
            
            first_number = float(row[0].strip())
            second_number = float(row[1].strip())
            operation = row[2].strip()
            expected_value = float(row[3].strip())
            result = row[4].strip() if len(row) > 4 else "unknown"
            
            records.append(DataRecord(
                first_number, second_number, operation, expected_value, result
            ))
    
    return records


def perform_operation(first: float, second: float, operation: str) -> float:
    """
    Helper method to perform the operation.
    
    Args:
        first: First operand
        second: Second operand
        operation: Operation to perform
        
    Returns:
        Result of the operation
    """
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


def test_calculator_with_csv_test_data_all_operations_produce_expected_results():
    """
    Comprehensive test that validates all operations using CSV data.
    
    This test runs through all test cases in the CSV file and validates
    that each operation produces the expected result.
    """
    # Arrange
    test_data = get_test_data_from_csv()
    failed_tests = []
    
    # Act & Assert
    for record in test_data:
        actual_value = perform_operation(
            record.first_number, 
            record.second_number, 
            record.operation
        )
        test_passed = False
        
        # Handle NaN comparisons for division/modulo by zero
        if math.isnan(record.expected_value) and math.isnan(actual_value):
            test_passed = True
        elif not math.isnan(record.expected_value):
            test_passed = abs(actual_value - record.expected_value) < 0.0001
        
        if not test_passed:
            failed_tests.append(
                f"Operation: {record.first_number} {record.operation} {record.second_number}, "
                f"Expected: {record.expected_value}, Actual: {actual_value}, Result: FAILED"
            )
    
    # Assert all tests passed
    assert not failed_tests, f"Failed tests:\n" + "\n".join(failed_tests)


# Data providers - extract data from CSV by operation type
def get_addition_data() -> List[Tuple[float, float, float]]:
    """Get addition test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "+"
    ]


def get_subtraction_data() -> List[Tuple[float, float, float]]:
    """Get subtraction test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "-"
    ]


def get_multiplication_data() -> List[Tuple[float, float, float]]:
    """Get multiplication test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "*"
    ]


def get_division_data() -> List[Tuple[float, float, float]]:
    """Get division test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "/"
    ]


def get_modulo_data() -> List[Tuple[float, float, float]]:
    """Get modulo test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "%"
    ]


def get_exponent_data() -> List[Tuple[float, float, float]]:
    """Get exponent test data from CSV."""
    return [
        (r.first_number, r.second_number, r.expected_value)
        for r in get_test_data_from_csv()
        if r.operation == "^"
    ]


@pytest.mark.parametrize("first,second,expected", get_addition_data())
def test_add_with_csv_data_returns_expected_sum(first: float, second: float, expected: float):
    """Test addition operation with CSV data."""
    # Act
    result = Calculator.add(first, second)
    
    # Assert
    assert result == expected


@pytest.mark.parametrize("first,second,expected", get_subtraction_data())
def test_subtract_with_csv_data_returns_expected_difference(first: float, second: float, expected: float):
    """Test subtraction operation with CSV data."""
    # Act
    result = Calculator.subtract(first, second)
    
    # Assert
    assert result == expected


@pytest.mark.parametrize("first,second,expected", get_multiplication_data())
def test_multiply_with_csv_data_returns_expected_product(first: float, second: float, expected: float):
    """Test multiplication operation with CSV data."""
    # Act
    result = Calculator.multiply(first, second)
    
    # Assert
    assert result == expected


@pytest.mark.parametrize("first,second,expected", get_division_data())
def test_divide_with_csv_data_returns_expected_quotient(first: float, second: float, expected: float):
    """Test division operation with CSV data."""
    # Act
    result = Calculator.divide(first, second)
    
    # Assert
    if math.isnan(expected):
        assert math.isnan(result), "Expected NaN for division by zero"
    else:
        assert result == expected


@pytest.mark.parametrize("first,second,expected", get_modulo_data())
def test_modulo_with_csv_data_returns_expected_remainder(first: float, second: float, expected: float):
    """Test modulo operation with CSV data."""
    # Act
    result = Calculator.modulo(first, second)
    
    # Assert
    if math.isnan(expected):
        assert math.isnan(result), "Expected NaN for modulo by zero"
    else:
        assert result == expected


@pytest.mark.parametrize("first,second,expected", get_exponent_data())
def test_exponent_with_csv_data_returns_expected_power(first: float, second: float, expected: float):
    """Test exponent operation with CSV data."""
    # Act
    result = Calculator.exponent(first, second)
    
    # Assert
    assert pytest.approx(result, rel=1e-10) == expected
