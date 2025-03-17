package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"math"
	"os"
	"path/filepath"
	"strconv"
	"testing"
)

// TestCase represents a single test scenario
type TestCase struct {
	name           string
	values         []float64
	expectedMin    float64
	expectedMax    float64
	expectedMean   float64
	expectedStdDev float64
	result         string // Added result field to track pass/fail status
}

// readTestDataFromCSV reads test data from a CSV file
func readTestDataFromCSV(filePath string) ([]TestCase, error) {
	// Open the CSV file
	file, err := os.Open(filePath)
	if err != nil {
		return nil, fmt.Errorf("failed to open CSV file: %w", err)
	}
	defer file.Close()

	// Create a new CSV reader
	reader := csv.NewReader(file)

	// Read the header row
	header, err := reader.Read()
	if err != nil {
		return nil, fmt.Errorf("failed to read CSV header: %w", err)
	}

	// Check if we have a result column already
	hasResultColumn := false
	expectedColumns := 10 // Without result column
	if len(header) == 11 && header[10] == "result" {
		hasResultColumn = true
	} else if len(header) != expectedColumns {
		return nil, fmt.Errorf("invalid CSV format: expected %d columns, got %d", expectedColumns, len(header))
	}

	testCases := []TestCase{}

	// Read each row of test data
	for {
		row, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			return nil, fmt.Errorf("error reading CSV row: %w", err)
		}

		// Parse the test case data
		values := make([]float64, 5)
		for i := 0; i < 5; i++ {
			val, err := strconv.ParseFloat(row[i+1], 64) // +1 to skip the test_name column
			if err != nil {
				return nil, fmt.Errorf("failed to parse value %s: %w", row[i+1], err)
			}
			values[i] = val
		}

		// Parse expected values
		expectedMin, err := strconv.ParseFloat(row[6], 64)
		if err != nil {
			return nil, fmt.Errorf("failed to parse expected_min: %w", err)
		}

		expectedMax, err := strconv.ParseFloat(row[7], 64)
		if err != nil {
			return nil, fmt.Errorf("failed to parse expected_max: %w", err)
		}

		expectedMean, err := strconv.ParseFloat(row[8], 64)
		if err != nil {
			return nil, fmt.Errorf("failed to parse expected_mean: %w", err)
		}

		expectedStdDev, err := strconv.ParseFloat(row[9], 64)
		if err != nil {
			return nil, fmt.Errorf("failed to parse expected_stddev: %w", err)
		}

		// Get result if it exists
		result := ""
		if hasResultColumn && len(row) > 10 {
			result = row[10]
		}

		testCases = append(testCases, TestCase{
			name:           row[0],
			values:         values,
			expectedMin:    expectedMin,
			expectedMax:    expectedMax,
			expectedMean:   expectedMean,
			expectedStdDev: expectedStdDev,
			result:         result,
		})
	}

	return testCases, nil
}

// writeTestResultsToCSV writes updated test cases back to the CSV file
func writeTestResultsToCSV(filePath string, testCases []TestCase) error {
	file, err := os.Create(filePath)
	if err != nil {
		return fmt.Errorf("failed to create CSV file: %w", err)
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Write header row
	header := []string{"test_name", "val1", "val2", "val3", "val4", "val5",
		"expected_min", "expected_max", "expected_mean", "expected_stddev", "result"}
	if err := writer.Write(header); err != nil {
		return fmt.Errorf("error writing header row: %w", err)
	}

	// Write test cases
	for _, tc := range testCases {
		row := []string{
			tc.name,
			fmt.Sprintf("%.2f", tc.values[0]),
			fmt.Sprintf("%.2f", tc.values[1]),
			fmt.Sprintf("%.2f", tc.values[2]),
			fmt.Sprintf("%.2f", tc.values[3]),
			fmt.Sprintf("%.2f", tc.values[4]),
			fmt.Sprintf("%.2f", tc.expectedMin),
			fmt.Sprintf("%.2f", tc.expectedMax),
			fmt.Sprintf("%.2f", tc.expectedMean),
			fmt.Sprintf("%.2f", tc.expectedStdDev),
			tc.result,
		}

		if err := writer.Write(row); err != nil {
			return fmt.Errorf("error writing data row: %w", err)
		}
	}

	return nil
}

func TestStatistics(t *testing.T) {
	// Get the path to the CSV file
	csvPath := filepath.Join(".", "statistics_test.csv")

	// Read test cases from CSV
	testCases, err := readTestDataFromCSV(csvPath)
	if err != nil {
		t.Fatalf("Failed to read test data from CSV: %v", err)
	}

	// Run tests for each test case
	for i := range testCases {
		tc := &testCases[i] // Use pointer to modify the slice element

		t.Run(tc.name, func(t *testing.T) {
			testPassed := true

			// Test minimum calculation
			min := findMin(tc.values)
			if min != tc.expectedMin {
				t.Errorf("findMin() = %.2f, want %.2f", min, tc.expectedMin)
				testPassed = false
			}

			// Test maximum calculation
			max := findMax(tc.values)
			if max != tc.expectedMax {
				t.Errorf("findMax() = %.2f, want %.2f", max, tc.expectedMax)
				testPassed = false
			}

			// Test mean calculation
			mean := calculateMean(tc.values)
			if math.Abs(mean-tc.expectedMean) > 0.01 { // Adjusted tolerance for 2 decimal places
				t.Errorf("calculateMean() = %.2f, want %.2f", mean, tc.expectedMean)
				testPassed = false
			}

			// Test standard deviation calculation
			stdDev := calculateStdDev(tc.values, mean)
			if math.Abs(stdDev-tc.expectedStdDev) > 0.01 { // Adjusted tolerance for 2 decimal places
				t.Errorf("calculateStdDev() = %.2f, want %.2f", stdDev, tc.expectedStdDev)
				testPassed = false
			}

			// Set the test result
			if testPassed {
				tc.result = "pass"
			} else {
				tc.result = "fail"
			}
		})
	}

	// Write results back to the CSV file
	if err := writeTestResultsToCSV(csvPath, testCases); err != nil {
		t.Fatalf("Failed to write test results to CSV: %v", err)
	}

	// Display the content of the CSV file after writing results
	t.Log("CSV file content after test execution:")
	if err := displayCSVContent(csvPath, t); err != nil {
		t.Logf("Failed to display CSV content: %v", err)
	}
}

// TestParseArgs tests the argument parsing function
func TestParseArgs(t *testing.T) {
	// Test valid arguments
	validArgs := []string{"10.50", "20.30", "15.70", "30.20", "25.00"}
	values, err := parseArgs(validArgs)
	if err != nil {
		t.Errorf("parseArgs() returned unexpected error: %v", err)
	}
	if len(values) != 5 {
		t.Errorf("parseArgs() returned slice with length %d, want 5", len(values))
	}

	// Test invalid arguments
	invalidArgs := []string{"10.50", "not-a-number", "15.70"}
	_, err = parseArgs(invalidArgs)
	if err == nil {
		t.Error("parseArgs() did not return error for invalid argument")
	}
}

// displayCSVContent reads and displays the content of a CSV file
func displayCSVContent(filePath string, t *testing.T) error {
	file, err := os.Open(filePath)
	if err != nil {
		return fmt.Errorf("failed to open CSV file: %w", err)
	}
	defer file.Close()

	reader := csv.NewReader(file)
	rows, err := reader.ReadAll()
	if err != nil {
		return fmt.Errorf("failed to read CSV content: %w", err)
	}

	t.Log("CSV File Content:")
	t.Log("-----------------")

	// Calculate column widths for formatting
	columnWidths := make([]int, 0)
	if len(rows) > 0 {
		columnWidths = make([]int, len(rows[0]))

		// Find the maximum width of each column
		for _, row := range rows {
			for i, cell := range row {
				if len(cell) > columnWidths[i] {
					columnWidths[i] = len(cell)
				}
			}
		}
	}

	// Print rows with aligned columns
	for _, row := range rows {
		var rowStr string
		for i, cell := range row {
			format := fmt.Sprintf("%%-%ds | ", columnWidths[i])
			rowStr += fmt.Sprintf(format, cell)
		}
		t.Log(rowStr)
	}

	return nil
}

// TestMain runs setup before tests and teardown after tests
func TestMain(m *testing.M) {
	// Run the tests
	code := m.Run()

	// Display the CSV content after tests
	csvPath := filepath.Join(".", "statistics_test.csv")
	if err := displayCSVContent(csvPath, &testing.T{}); err != nil {
		fmt.Printf("Failed to display CSV content: %v\n", err)
	}

	// Exit with the test code
	os.Exit(code)
}
