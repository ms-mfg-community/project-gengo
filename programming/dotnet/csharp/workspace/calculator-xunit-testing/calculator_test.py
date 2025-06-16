"""
Unit tests for calculator.py using pytest.
Covers all operations and edge cases as in CalculatorTest.cs.
"""
import pytest
import math
from calculator import add, subtract, multiply, divide, modulo, exponent

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0

def test_subtract():
    assert subtract(5, 3) == 2
    assert subtract(0, 1) == -1
    assert subtract(-2, -2) == 0

def test_multiply():
    assert multiply(2, 3) == 6
    assert multiply(-2, 2) == -4
    assert multiply(0, 5) == 0

def test_divide():
    assert divide(6, 3) == 2
    assert divide(-4, 2) == -2
    assert divide(5, 2) == 2.5
    with pytest.raises(ZeroDivisionError):
        divide(1, 0)

def test_modulo():
    assert modulo(7, 3) == 1
    assert modulo(10, 2) == 0
    # Python's modulo: (-5 % 2) == 1
    assert modulo(-5, 2) == 1
    with pytest.raises(ZeroDivisionError):
        modulo(1, 0)

def test_exponent():
    assert exponent(2, 3) == 8
    assert math.isclose(exponent(4, 0.5), 2, rel_tol=1e-9)
    assert math.isclose(exponent(9, 0.5), 3, rel_tol=1e-9)
