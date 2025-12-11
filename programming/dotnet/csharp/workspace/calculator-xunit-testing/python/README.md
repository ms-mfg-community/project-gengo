# Python Calculator with Web Interface

A fully-featured calculator application in Python, converted from the C# xUnit Testing solution. This implementation includes:

- **Calculator Library**: Core arithmetic operations (add, subtract, multiply, divide, modulo, exponent)
- **Comprehensive Tests**: pytest-based unit tests with CSV-driven parameterization
- **Web Application**: Flask-based web UI with light/dark theme support and calculation history
- **Interactive Components**: Calculator keypad, history panel, and theme toggle

## Project Structure

```
python/
├── calculator/                 # Core calculator library
│   ├── __init__.py
│   └── calculator.py          # Calculator class with all arithmetic operations
├── tests/                     # pytest unit tests
│   ├── __init__.py
│   ├── test_calculator.py     # Comprehensive test suite
│   └── test_data/
│       └── CalculatorTestData.csv  # CSV test data (from C# version)
├── web/                       # Flask web application
│   ├── app.py                # Main Flask application
│   ├── services/             # Business logic services
│   │   ├── __init__.py
│   │   ├── calculator_service.py   # Calculator state management
│   │   ├── history_service.py      # Calculation history (max 50 items)
│   │   └── theme_service.py        # Light/dark theme management
│   ├── templates/            # HTML templates
│   │   └── index.html        # Main calculator page
│   └── static/               # Static files (CSS, JS)
│       ├── css/
│       │   └── calculator.css      # Styling with theme support
│       └── js/
│           └── calculator.js       # Client-side interactivity
├── requirements.txt          # Python dependencies
└── README.md                # This file
```

## Features

### Calculator Library

- **Six Arithmetic Operations**:
  - Addition (`+`)
  - Subtraction (`-`)
  - Multiplication (`*`)
  - Division (`/`) with division-by-zero handling
  - Modulo (`%`) with modulo-by-zero handling
  - Exponentiation (`^`)

- **Input Validation**: Numeric input validation and error handling
- **Type Hints**: Full type hint support for better code clarity
- **Docstrings**: Comprehensive documentation for all functions

### Testing

- **pytest Framework**: Modern Python testing with pytest
- **CSV-Based Test Data**: Maintains the same test data as the C# version
- **Parameterized Tests**: Uses `@pytest.mark.parametrize` for data-driven testing
- **Comprehensive Coverage**: Tests for all operations including edge cases
- **Test Naming Convention**: Clear naming pattern `test_[method]_with_csv_data_returns_expected_[result]`

### Web Application

- **Flask Framework**: Lightweight Python web framework
- **Session Management**: Calculator state persists across requests
- **RESTful API**: JSON API endpoints for all calculator operations
- **Responsive Design**: Works on desktop, tablet, and mobile devices

#### UI Components

1. **Calculator Keypad**:
   - Number buttons (0-9) and decimal point
   - Operator buttons (+, -, ×, ÷, %, x^y)
   - Equals and Clear buttons
   - Keyboard support for all operations

2. **History Panel**:
   - Displays last 50 calculations (newest first)
   - Click to replay any calculation
   - Clear history button
   - Timestamps for each calculation

3. **Theme Toggle**:
   - Switch between light and dark themes
   - Persists theme preference in session
   - Smooth transitions between themes

## Setup Instructions

### Prerequisites

- Python 3.8 or higher
- pip (Python package installer)

### Installation

1. **Navigate to the Python project directory**:

   ```bash
   cd programming/dotnet/csharp/workspace/calculator-xunit-testing/python
   ```

2. **Create a virtual environment** (recommended):

   ```bash
   # Windows
   python -m venv venv
   venv\Scripts\activate

   # macOS/Linux
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies**:

   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Running Tests

Run all tests:

```bash
pytest
```

Run tests with verbose output:

```bash
pytest -v
```

Run tests with coverage report:

```bash
pytest --cov=calculator --cov-report=html
```

Run specific test file:

```bash
pytest tests/test_calculator.py
```

### Running the Web Application

1. **Start the Flask development server**:

   ```bash
   cd web
   # For development with debug mode (optional)
   export FLASK_DEBUG=True  # or set FLASK_DEBUG=True on Windows
   python app.py
   ```

   **Note**: Debug mode is disabled by default for security. Only enable it during development.

2. **Open your browser** and navigate to:

   ```
   http://localhost:5000
   ```

3. **Use the calculator**:
   - Click number buttons or use keyboard to enter numbers
   - Click operator buttons or use keyboard (+, -, *, /, %, ^)
   - Press Enter or click = to calculate
   - Press Escape or click C to clear
   - Toggle theme using the moon/sun icon
   - View calculation history in the right panel
   - Click history items to replay calculations

### Production Deployment

For production deployment, use a production WSGI server like **gunicorn**:

```bash
pip install gunicorn
cd web
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Running the Command-Line Calculator

```bash
python -m calculator.calculator
```

This will start an interactive command-line calculator session.

## Keyboard Shortcuts

The web calculator supports keyboard input:

- **0-9**: Enter numbers
- **.**: Decimal point
- **+, -, *, /, %, ^**: Operators
- **Enter or =**: Calculate result
- **Escape or C**: Clear calculator

## API Endpoints

The web application exposes the following REST API endpoints:

- `POST /api/number` - Handle number button click
- `POST /api/operator` - Handle operator button click
- `POST /api/equals` - Calculate result
- `POST /api/clear` - Clear calculator
- `POST /api/theme/toggle` - Toggle light/dark theme
- `POST /api/history/clear` - Clear calculation history
- `POST /api/history/replay/<index>` - Replay calculation from history

## Development

### Code Style

This project follows:

- **PEP 8**: Python style guide
- **Type hints**: For better code clarity and IDE support
- **Docstrings**: Google-style docstrings for all public functions
- **pytest conventions**: For test organization and naming

### Project Guidelines

- Use virtual environments for dependency isolation
- Run tests before committing changes
- Maintain test coverage above 90%
- Follow existing naming conventions
- Update documentation when adding features

## Comparison with C# Version

This Python implementation maintains feature parity with the original C# solution:

| Feature | C# Version | Python Version |
|---------|-----------|----------------|
| Calculator operations | ✓ (6 operations) | ✓ (6 operations) |
| Unit testing | ✓ (xUnit) | ✓ (pytest) |
| CSV test data | ✓ | ✓ (same file) |
| Web UI | ✓ (Blazor) | ✓ (Flask + Jinja2) |
| Theme support | ✓ (Light/Dark) | ✓ (Light/Dark) |
| History panel | ✓ (50 items) | ✓ (50 items) |
| Responsive design | ✓ | ✓ |
| Keyboard support | ✓ | ✓ |

## Testing Results

All tests pass with the same test data as the C# version:

- **Addition tests**: 5 test cases
- **Subtraction tests**: 5 test cases
- **Multiplication tests**: 5 test cases
- **Division tests**: 5 test cases (including division by zero)
- **Modulo tests**: 5 test cases (including modulo by zero)
- **Exponent tests**: 6 test cases

Total: **31 test cases** from CSV + 1 comprehensive test = **32 passing tests**

## Screenshots

The web application features:

- Clean, modern UI with gradient buttons
- Smooth animations and transitions
- Responsive layout that works on all screen sizes
- Professional light and dark themes
- Interactive history panel with timestamps

## License

This project is part of the project-gengo repository and follows the same license.

## Acknowledgments

Converted from the C# Calculator xUnit Testing solution, maintaining all functionality while adapting to Python best practices and idioms.
