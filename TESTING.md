# Testing Guide for Project Gengo

This guide provides information on how to run tests in the project-gengo polyglot repository.

## Quick Start

### Run All Tests

The easiest way to run all tests across all languages:

**On Linux/macOS:**

```bash
./run-all-tests.sh
```

**On Windows (PowerShell):**

```powershell
.\Run-AllTests.ps1
```

These scripts will:

- Execute all Python tests using pytest
- Execute all .NET tests using xUnit
- Execute all Node.js tests using Jest
- Execute all Go tests
- Provide a summary of results with color-coded output

## Test Organization

The repository contains tests for multiple programming languages:

### Python Tests

**Framework**: pytest  
**Location**: `programming/python/completed/src/`

| Test Suite | Location | Tests | Framework |
|------------|----------|-------|-----------|
| Calculator | `calculator/test_calculator.py` | 7 | pytest |
| Rock-Paper-Scissors | `rps-demo-py/test_game.py` | 9 | pytest |
| Calculator (DotNet Workspace) | `dotnet/csharp/workspace/calculator-xunit-testing/python/tests/` | 32 | pytest |
| Calculator (DotNet Experimental) | `dotnet/csharp/experimental/calculator-xunit-testing/python/tests/` | 32 | pytest |

**Total Python Tests**: 80

### .NET/C# Tests

**Framework**: xUnit  
**Location**: `programming/dotnet/csharp/`

| Test Suite | Location | Tests | Framework |
|------------|----------|-------|-----------|
| Calculator Workspace | `workspace/calculator-xunit-testing/calculator.tests/` | 32 | xUnit |
| Calculator Experimental | `experimental/calculator-xunit-testing/calculator.tests/` | 32 | xUnit |
| Calculator Completed | `completed/calculator-xunit-testing/calculator.tests/` | 39 | xUnit |

**Total .NET Tests**: 103

### Node.js/TypeScript Tests

**Framework**: Jest with ts-jest  
**Location**: `programming/node/completed/calculator/`

| Test Suite | Location | Tests | Framework |
|------------|----------|-------|-----------|
| Calculator | `src/tests/Calculator.test.ts` | 20 | Jest |

**Total Node.js Tests**: 20

### Go Tests

**Framework**: testify/suite  
**Location**: `programming/go/completed/src/`

| Test Suite | Location | Tests | Framework |
|------------|----------|-------|-----------|
| Statistics | `statistics_test.go` | 5 | testify |

**Total Go Tests**: 5

## Running Tests Individually

### Python Tests

**Prerequisites**: Python 3.12+ with pytest installed

```bash
# Install pytest if not already installed
pip install pytest

# Run specific test file
cd programming/python/completed/src/calculator
python -m pytest test_calculator.py -v

# Run with coverage
python -m pytest test_calculator.py --cov=calculator -v

# Run all Python tests
python -m pytest --tb=short
```

### .NET Tests

**Prerequisites**: .NET SDK 8.0+

```bash
# Run tests for a specific project
cd programming/dotnet/csharp/workspace/calculator-xunit-testing
dotnet test calculator.tests/calculator.tests.csproj

# Run with detailed output
dotnet test calculator.tests/calculator.tests.csproj --verbosity normal

# Run with code coverage
dotnet test calculator.tests/calculator.tests.csproj /p:CollectCoverage=true
```

### Node.js Tests

**Prerequisites**: Node.js 20+ with npm

```bash
# Install dependencies
cd programming/node/completed/calculator
npm install

# Run tests
npm test

# Run tests with coverage
npm test -- --coverage

# Run tests in watch mode
npm test -- --watch
```

### Go Tests

**Prerequisites**: Go (latest version)

```bash
# Run tests
cd programming/go/completed/src
go test -v ./...

# Run with coverage
go test -cover ./...

# Run with detailed coverage report
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

## Test Patterns and Practices

### Python (pytest)

- Test files: `test_*.py` or `*_test.py`
- Test functions: Start with `test_`
- Test classes: Start with `Test`
- Fixtures: Use `@pytest.fixture` decorator
- Parameterized tests: Use `@pytest.mark.parametrize`

**Example:**

```python
import pytest

def test_addition():
    assert 2 + 2 == 4

@pytest.mark.parametrize("a,b,expected", [
    (1, 2, 3),
    (2, 3, 5),
])
def test_addition_parametrized(a, b, expected):
    assert a + b == expected
```

### .NET (xUnit)

- Test files: Typically `*Test.cs` or `*Tests.cs`
- Test methods: Decorated with `[Fact]` or `[Theory]`
- Test classes: Must be public
- Data-driven tests: Use `[Theory]` with `[InlineData]` or `[ClassData]`

**Example:**

```csharp
using Xunit;

public class CalculatorTests
{
    [Fact]
    public void Add_TwoNumbers_ReturnsSum()
    {
        var result = Calculator.Add(2, 3);
        Assert.Equal(5, result);
    }

    [Theory]
    [InlineData(1, 2, 3)]
    [InlineData(2, 3, 5)]
    public void Add_MultipleValues_ReturnsCorrectSum(int a, int b, int expected)
    {
        var result = Calculator.Add(a, b);
        Assert.Equal(expected, result);
    }
}
```

### Node.js/TypeScript (Jest)

- Test files: `*.test.ts` or `*.spec.ts`
- Test suites: Use `describe()` blocks
- Test cases: Use `test()` or `it()` functions
- Assertions: Use `expect()` with matchers

**Example:**

```typescript
describe('Calculator', () => {
    test('add() should return sum of two numbers', () => {
        expect(Calculator.add(2, 3)).toBe(5);
    });

    test.each([
        [1, 2, 3],
        [2, 3, 5],
    ])('add(%i, %i) should return %i', (a, b, expected) => {
        expect(Calculator.add(a, b)).toBe(expected);
    });
});
```

### Go (testify)

- Test files: `*_test.go` in the same package
- Test functions: Start with `Test` and take `*testing.T`
- Test suites: Use `suite.Suite` from testify
- Assertions: Use `assert` or `require` from testify

**Example:**

```go
import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestAddition(t *testing.T) {
    result := Add(2, 3)
    assert.Equal(t, 5, result)
}

func TestAdditionTable(t *testing.T) {
    tests := []struct {
        a, b, expected int
    }{
        {1, 2, 3},
        {2, 3, 5},
    }

    for _, tt := range tests {
        result := Add(tt.a, tt.b)
        assert.Equal(t, tt.expected, result)
    }
}
```

## Continuous Integration

Tests can be integrated into CI/CD pipelines:

### GitHub Actions Example

```yaml
name: Run Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      
      - name: Set up .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '8.0.x'
      
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.21'
      
      - name: Run all tests
        run: ./run-all-tests.sh
```

## Test Reports

After running tests, view the comprehensive test report:

- **[TEST_REPORT.md](TEST_REPORT.md)**: Detailed test execution results, coverage, and recommendations

## Troubleshooting

### Common Issues

**Python: ModuleNotFoundError**

```bash
# Solution: Install pytest and dependencies
pip install pytest
```

**.NET: Project not found**

```bash
# Solution: Ensure you're in the correct directory and restore packages
dotnet restore
dotnet test
```

**Node.js: Cannot find module**

```bash
# Solution: Install dependencies
npm install
```

**Go: Package not found**

```bash
# Solution: Initialize Go modules
go mod download
go test ./...
```

### Running Tests in Specific Scenarios

**Run only failed tests (pytest):**

```bash
pytest --lf  # Last failed
pytest --ff  # Failed first
```

**Run tests matching pattern (.NET):**

```bash
dotnet test --filter FullyQualifiedName~Calculator
```

**Run specific test file (Jest):**

```bash
npm test -- Calculator.test.ts
```

**Run tests with race detection (Go):**

```bash
go test -race ./...
```

## Contributing

When adding new tests:

1. Follow the naming conventions for your language
2. Include both positive and negative test cases
3. Add edge case testing
4. Document complex test scenarios
5. Ensure tests are isolated and repeatable
6. Update this guide if adding new test suites

## Resources

- [pytest Documentation](https://docs.pytest.org/)
- [xUnit Documentation](https://xunit.net/)
- [Jest Documentation](https://jestjs.io/)
- [Go Testing Package](https://pkg.go.dev/testing)
- [testify Documentation](https://github.com/stretchr/testify)

---

**Last Updated**: December 12, 2025  
**Total Tests**: 208 across 4 languages  
**Maintained by**: Project Gengo Contributors
