import pytest
from unittest.mock import patch
from calculator import add, subtract, multiply, divide, modulo, exponent, main

def test_add():
    assert add(5, 3) == 8
    assert add(-1, 1) == 0
    assert add(0, 0) == 0

def test_subtract():
    assert subtract(5, 3) == 2
    assert subtract(-1, 1) == -2
    assert subtract(0, 0) == 0

def test_multiply():
    assert multiply(5, 3) == 15
    assert multiply(-1, 1) == -1
    assert multiply(0, 0) == 0

def test_divide():
    assert divide(6, 3) == 2
    assert divide(-1, 1) == -1
    with pytest.raises(ZeroDivisionError):
        divide(6, 0)

def test_modulo():
    assert modulo(10, 3) == 1
    assert modulo(10, 2) == 0
    with pytest.raises(ZeroDivisionError):
        modulo(10, 0)

def test_exponent():
    assert exponent(2, 3) == 8
    assert exponent(2, 0) == 1
    assert exponent(2, -1) == 0.5

@patch('builtins.input', side_effect=['5', '3', '+', 'no'])
def test_calculator(mock_input):
    main()

if __name__ == "__main__":
    pytest.main()
