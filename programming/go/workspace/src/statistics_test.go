package main

import (
	"testing"
)

// TestCalculateStatistics tests the calculateStatistics function with three different arrays
func TestCalculateStatistics(t *testing.T) {
	// Define test cases
	testCases := []struct {
		name           string
		values         []float64
		expectedMin    float64
		expectedMax    float64
		expectedMean   float64
		expectedStdDev float64
	}{
		{
			name:           "Same values",
			values:         []float64{5.0, 5.0, 5.0, 5.0, 5.0},
			expectedMin:    5.0,
			expectedMax:    5.0,
			expectedMean:   5.0,
			expectedStdDev: 0.0,
		},
		{
			name:           "Varied values",
			values:         []float64{2.0, 4.0, 6.0, 8.0, 10.0},
			expectedMin:    2.0,
			expectedMax:    10.0,
			expectedMean:   6.0,
			expectedStdDev: 3.1622776601683795, // sqrt(10) = approx 3.162
		},
		{
			name:           "Boundary values",
			values:         []float64{1.0, 3.5, 5.5, 7.5, 10.0},
			expectedMin:    1.0,
			expectedMax:    10.0,
			expectedMean:   5.5,
			expectedStdDev: 3.5355339059327378, // approx 3.536
		},
	}

	// Iterate over all test cases
	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			min, max, mean, stdDev := calculateStatistics(tc.values)

			if min != tc.expectedMin {
				t.Errorf("Expected min to be %f, got %f", tc.expectedMin, min)
			}
			if max != tc.expectedMax {
				t.Errorf("Expected max to be %f, got %f", tc.expectedMax, max)
			}
			if mean != tc.expectedMean {
				t.Errorf("Expected mean to be %f, got %f", tc.expectedMean, mean)
			}
			if stdDev != tc.expectedStdDev {
				t.Errorf("Expected stdDev to be %f, got %f", tc.expectedStdDev, stdDev)
			}
		})
	}
}

// TestValidateInput tests the validateInput function
func TestValidateInput(t *testing.T) {
	// Test valid input
	t.Run("Valid input", func(t *testing.T) {
		values := []float64{1.0, 2.0, 3.0, 4.0, 5.0}
		err := validateInput(values)
		if err != nil {
			t.Errorf("Expected no error for valid input, got: %v", err)
		}
	})

	// Test invalid input - wrong number of values
	t.Run("Wrong number of values", func(t *testing.T) {
		values := []float64{1.0, 2.0, 3.0, 4.0} // Only 4 values
		err := validateInput(values)
		if err == nil {
			t.Error("Expected error for wrong number of values, got nil")
		}
	})

	// Test invalid input - value out of range
	t.Run("Value out of range", func(t *testing.T) {
		values := []float64{1.0, 2.0, 11.0, 4.0, 5.0} // 11 is > 10
		err := validateInput(values)
		if err == nil {
			t.Error("Expected error for value out of range, got nil")
		}
	})
}
