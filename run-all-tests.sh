#!/bin/bash
# Run all tests across the project-gengo repository
# This script executes tests for Python, .NET, Node.js, and Go projects

set -e  # Exit on error

echo "========================================"
echo "Project Gengo - Comprehensive Test Suite"
echo "========================================"
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Counter for test results
total_passed=0
total_failed=0

# Function to print section header
print_header() {
    echo ""
    echo -e "${BLUE}========================================"
    echo "$1"
    echo -e "========================================${NC}"
}

# Function to report test results
report_results() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ Tests passed: $2${NC}"
        total_passed=$((total_passed + $2))
    else
        echo -e "${RED}✗ Tests failed${NC}"
        total_failed=$((total_failed + 1))
    fi
}

# Python Tests
print_header "Running Python Tests (pytest)"

echo "1. Calculator tests..."
cd programming/python/completed/src/calculator
python -m pytest test_calculator.py -v --tb=short
report_results $? 7

echo ""
echo "2. Rock-Paper-Scissors game tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/python/completed/src/rps-demo-py
python -m pytest test_game.py -v --tb=short
report_results $? 9

echo ""
echo "3. Calculator tests (DotNet workspace - Python)..."
cd /home/runner/work/project-gengo/project-gengo/programming/dotnet/csharp/workspace/calculator-xunit-testing/python
python -m pytest tests/test_calculator.py -v --tb=short
report_results $? 32

echo ""
echo "4. Calculator tests (DotNet experimental - Python)..."
cd /home/runner/work/project-gengo/project-gengo/programming/dotnet/csharp/experimental/calculator-xunit-testing/python
python -m pytest tests/test_calculator.py -v --tb=short
report_results $? 32

# .NET Tests
print_header "Running .NET Tests (xUnit)"

echo "1. Calculator workspace tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/dotnet/csharp/workspace/calculator-xunit-testing
dotnet test calculator.tests/calculator.tests.csproj --verbosity quiet
report_results $? 32

echo ""
echo "2. Calculator experimental tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/dotnet/csharp/experimental/calculator-xunit-testing
dotnet test calculator.tests/calculator.tests.csproj --verbosity quiet
report_results $? 32

echo ""
echo "3. Calculator completed tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/dotnet/csharp/completed/calculator-xunit-testing
dotnet test calculator.tests/calculator.tests.csproj --verbosity quiet
report_results $? 39

# Node.js Tests
print_header "Running Node.js Tests (Jest)"

echo "1. Calculator tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/node/completed/calculator
npm test
report_results $? 20

# Go Tests
print_header "Running Go Tests"

echo "1. Statistics tests..."
cd /home/runner/work/project-gengo/project-gengo/programming/go/completed/src
go test -v ./...
report_results $? 5

# Summary
print_header "Test Execution Summary"
echo ""
echo "Total tests passed: $total_passed"
echo "Total test suites failed: $total_failed"
echo ""

if [ $total_failed -eq 0 ]; then
    echo -e "${GREEN}✓ All test suites passed successfully!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some test suites failed${NC}"
    exit 1
fi
