# Python Calculator with pytest

Python equivalent of the C# .NET 8 calculator with xUnit testing.

## Project Structure

```
calculator-pytest/
├── calculator.py                 # Main console application (equivalent to Calculator.cs)
├── calculator_operations.py      # Calculator operations module (equivalent to CalculatorOperations.cs)
├── requirements.txt              # Python dependencies
├── tests/
│   ├── __init__.py
│   └── test_calculator.py        # Comprehensive pytest test suite (equivalent to CalculatorTest.cs)
└── README.md                     # This file
```

## Features

- **Basic arithmetic operations**: Addition, Subtraction, Multiplication, Division
- **Advanced operations**: Modulo, Exponent (power)
- **Interactive console interface**: User-friendly prompts and clear screen between calculations
- **Comprehensive error handling**: Division by zero, invalid input validation
- **Extensive test coverage**: 50+ pytest tests with parametrized test cases
- **Proper null/None handling**: Safe handling of None values and empty input

## Installation

### Prerequisites
- Python 3.8 or higher
- pip (Python package manager)

### Setup

1. Navigate to the project directory:
```bash
cd calculator-pytest
```

2. Create and activate a virtual environment:
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Calculator

To run the interactive calculator:
```bash
python calculator.py
```

The calculator will prompt you to:
1. Enter the first number
2. Enter the second number
3. Enter an operator (+, -, *, /, %, ^)
4. View the result
5. Choose to perform another calculation or exit

## Running Tests

### Run all tests
```bash
pytest
```

### Run tests with verbose output
```bash
pytest -v
```

### Run tests with coverage report
```bash
pytest --cov=. --cov-report=html
```

### Run specific test class
```bash
pytest tests/test_calculator.py::TestAddition -v
```

### Run tests matching a pattern
```bash
pytest -k "test_add" -v
```

## Test Coverage

The test suite includes 50+ tests organized by operation:

- **Addition Tests** (5 tests): Normal cases, negative numbers, zero, decimals, opposites
- **Subtraction Tests** (5 tests): Normal cases, negative numbers, zero, decimals
- **Multiplication Tests** (5 tests): Normal cases, negative numbers, zero, decimals
- **Division Tests** (6 tests): Normal cases, negative numbers, zero, decimals, division by zero
- **Modulo Tests** (6 tests): Normal cases, negative numbers, zero, decimals, modulo by zero
- **Exponent Tests** (5 tests): Normal cases, zero exponent, negative exponents, negative base
- **Perform Method Tests** (8 tests): All operators, invalid operators
- **Complex Scenarios** (3 tests): Chain operations, mixed signs, small decimals

**All tests pass successfully!** ✅

## Differences from C# Version

| Aspect | C# | Python |
|--------|----|----|
| Project Type | .NET 8 Console + xUnit Tests | Python 3.8+ + pytest |
| Main Entry | Top-level statements | `if __name__ == "__main__"` |
| Testing Framework | xUnit | pytest |
| Type Hints | Built-in | Optional (included for clarity) |
| Error Handling | NaN | float('nan') |
| Screen Clear | Console.Clear() | os.system('cls'/'clear') |
| Infinity | double.NaN | math.nan |

## Operations Supported

| Operator | Description | Example |
|----------|-------------|---------|
| + | Addition | 5 + 3 = 8 |
| - | Subtraction | 10 - 3 = 7 |
| * | Multiplication | 4 × 5 = 20 |
| / | Division | 20 ÷ 4 = 5 |
| % | Modulo | 10 % 3 = 1 |
| ^ | Exponent | 2 ^ 3 = 8 |

## Error Handling

- **Invalid input**: Returns error message if input cannot be parsed as a number
- **Division by zero**: Returns NaN with appropriate error message
- **Modulo by zero**: Returns NaN with appropriate error message
- **Invalid operator**: Returns NaN with error message

## Development

### Code Style
- Follows PEP 8 guidelines
- Type hints included for clarity
- Comprehensive docstrings on all functions

### Running Linter (optional)
```bash
# Install flake8
pip install flake8

# Run linter
flake8 calculator.py calculator_operations.py
```

## License

This is an educational project demonstrating Python best practices equivalent to C# patterns.

## See Also

- C# Version: `../dotnet/csharp/workspace/calculator-xunit-testing/`
- Original PRD: `prd-csharp-basic-calculator-solution.md`
