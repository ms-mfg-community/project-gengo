package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"path/filepath"
	"strconv"
)

func main() {
	// Setup logging
	// Create absolute path for log directory at ../src/log/ relative to execution directory
	execDir, _ := filepath.Abs(filepath.Dir(os.Args[0]))
	parentDir := filepath.Dir(filepath.Dir(execDir)) // Go up two levels
	logDir := filepath.Join(parentDir, "src", "log")

	err := os.MkdirAll(logDir, 0755)
	if err != nil {
		fmt.Printf("Error creating log directory: %v\n", err)
		os.Exit(1)
	}

	logFile := filepath.Join(logDir, "statistics.log")
	file, err := os.OpenFile(logFile, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err != nil {
		fmt.Printf("Error opening log file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	logger := log.New(file, "STATS: ", log.LstdFlags)
	logger.Println("Starting statistics calculation")

	// Get command line arguments (skip program name at index 0)
	args := os.Args[1:]

	// Validate number of arguments
	if len(args) < 3 || len(args) > 10 {
		errMsg := fmt.Sprintf("Invalid number of arguments. Please provide between 3 and 10 numbers. Got %d", len(args))
		fmt.Println(errMsg)
		logger.Println(errMsg)
		os.Exit(1)
	}

	// Parse and validate arguments as float64
	numbers, err := parseArgs(args)
	if err != nil {
		fmt.Println(err)
		logger.Println(err)
		os.Exit(1)
	}

	// Calculate statistics
	min := findMin(numbers)
	max := findMax(numbers)
	mean := calculateMean(numbers)
	stdDev := calculateStdDev(numbers, mean)

	// Format and display results with 2 decimal places precision
	result := fmt.Sprintf("Statistics for %v:\n- Minimum: %.2f\n- Maximum: %.2f\n- Mean: %.2f\n- Standard Deviation (n-1): %.2f",
		numbers, min, max, mean, stdDev)

	fmt.Println(result)
	logger.Println(result)
	logger.Println("Statistics calculation completed")
}

// parseArgs converts string arguments to float64 and validates them
func parseArgs(args []string) ([]float64, error) {
	numbers := make([]float64, len(args))

	for i, arg := range args {
		num, err := strconv.ParseFloat(arg, 64)
		if err != nil {
			return nil, fmt.Errorf("argument '%s' is not a valid number", arg)
		}
		numbers[i] = num
	}

	return numbers, nil
}

// findMin returns the minimum value in the slice
func findMin(numbers []float64) float64 {
	min := numbers[0]
	for _, num := range numbers {
		if num < min {
			min = num
		}
	}
	return min
}

// findMax returns the maximum value in the slice
func findMax(numbers []float64) float64 {
	max := numbers[0]
	for _, num := range numbers {
		if num > max {
			max = num
		}
	}
	return max
}

// calculateMean returns the average of all values
func calculateMean(numbers []float64) float64 {
	sum := 0.0
	for _, num := range numbers {
		sum += num
	}
	return sum / float64(len(numbers))
}

// calculateStdDev calculates the population standard deviation (n-1)
func calculateStdDev(numbers []float64, mean float64) float64 {
	if len(numbers) <= 1 {
		return 0.0 // Cannot calculate standard deviation with fewer than 2 values
	}

	sumSquaredDiffs := 0.0
	for _, num := range numbers {
		diff := num - mean
		sumSquaredDiffs += diff * diff
	}

	// Use n-1 (Bessel's correction) for sample standard deviation
	return math.Sqrt(sumSquaredDiffs / float64(len(numbers)-1))
}
