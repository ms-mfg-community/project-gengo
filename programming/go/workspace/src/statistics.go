// Package main provides a statistics calculator for a set of 5 numbers
package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"math"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strconv"
	"strings"
)

// clearScreen clears the terminal screen based on the operating system
func clearScreen() {
	var cmd *exec.Cmd

	switch runtime.GOOS {
	case "windows":
		cmd = exec.Command("cmd", "/c", "cls")
	default: // Linux, macOS, etc.
		cmd = exec.Command("clear")
	}

	cmd.Stdout = os.Stdout
	_ = cmd.Run() // Ignore errors since this is just a visual enhancement
}

// validateInput checks if the input is within the allowed range (1-10)
func validateInput(values []float64) error {
	if len(values) != 5 {
		return fmt.Errorf("expected exactly 5 numbers, got %d", len(values))
	}

	for i, val := range values {
		if val < 1 || val > 10 {
			return fmt.Errorf("value at position %d (%f) is outside the allowed range of 1-10", i+1, val)
		}
	}

	return nil
}

// calculateStatistics computes min, max, mean, and standard deviation
func calculateStatistics(values []float64) (min, max, mean, stdDev float64) {
	// Initialize min and max with the first value
	min = values[0]
	max = values[0]
	sum := 0.0

	// Calculate min, max, and sum for mean
	for _, val := range values {
		if val < min {
			min = val
		}
		if val > max {
			max = val
		}
		sum += val
	}

	// Calculate mean
	mean = sum / float64(len(values))

	// Calculate standard deviation (n-1)
	sumSquaredDiff := 0.0
	for _, val := range values {
		diff := val - mean
		sumSquaredDiff += diff * diff
	}
	// Using n-1 for sample standard deviation
	stdDev = math.Sqrt(sumSquaredDiff / float64(len(values)-1))

	return min, max, mean, stdDev
}

// readUserInput prompts the user to enter values one by one
func readUserInput() ([]float64, error) {
	values := make([]float64, 5)
	reader := bufio.NewReader(os.Stdin)

	for i := 0; i < 5; i++ {
		fmt.Printf("Enter parameter%d (between 1-10): ", i+1)
		input, err := reader.ReadString('\n')
		if err != nil {
			return nil, fmt.Errorf("error reading input: %v", err)
		}

		// Trim whitespace and convert to float
		input = strings.TrimSpace(input)
		val, err := strconv.ParseFloat(input, 64)
		if err != nil {
			return nil, fmt.Errorf("invalid number format: %v", err)
		}

		// Validate the range
		if val < 1 || val > 10 {
			return nil, fmt.Errorf("value %f is outside the allowed range of 1-10", val)
		}

		values[i] = val
	}

	return values, nil
}

func main() {
	// Set up logging
	// Get current working directory instead of using binary location
	currentDir, err := os.Getwd()
	if err != nil {
		fmt.Printf("Error getting current directory: %v\n", err)
		os.Exit(1)
	}

	logDir := filepath.Join(currentDir, "log")
	logFile := filepath.Join(logDir, "statistics.log")

	// Ensure log directory exists
	if err := os.MkdirAll(logDir, 0755); err != nil {
		fmt.Printf("Error creating log directory: %v\n", err)
		os.Exit(1)
	}

	// Open log file
	f, err := os.OpenFile(logFile, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if err != nil {
		fmt.Printf("Error opening log file: %v\n", err)
		os.Exit(1)
	}
	defer f.Close()

	// Set log output to file
	log.SetOutput(f)
	log.Println("Statistics program started")

	// Display help if no arguments are provided
	flag.Parse()
	if flag.NArg() == 0 {
		fmt.Println("Usage: statistics <num1> <num2> <num3> <num4> <num5>")
		fmt.Println("Each number must be a floating point value between 1 and 10")
		log.Println("Program exited: no arguments provided")
		os.Exit(1)
	}

	runCalculation := true
	firstRun := true

	for runCalculation {
		var values []float64
		var err error

		// For first run, use command line arguments
		if firstRun {
			// Parse command line arguments
			values = make([]float64, 0, 5)
			for i := 0; i < flag.NArg(); i++ {
				val, err := strconv.ParseFloat(flag.Arg(i), 64)
				if err != nil {
					fmt.Printf("Error: argument %d ('%s') is not a valid number\n", i+1, flag.Arg(i))
					log.Printf("Invalid argument at position %d: %s - %v", i+1, flag.Arg(i), err)
					os.Exit(1)
				}
				values = append(values, val)
			}

			// Validate input
			if err := validateInput(values); err != nil {
				fmt.Printf("Input validation error: %v\n", err)
				log.Printf("Validation error: %v", err)
				os.Exit(1)
			}

			firstRun = false
		} else {
			// For subsequent runs, read input from user
			clearScreen()
			values, err = readUserInput()
			if err != nil {
				fmt.Printf("Input error: %v\n", err)
				log.Printf("Interactive input error: %v", err)
				fmt.Println("Please try again.")
				continue
			}
		}

		// Clear the screen before displaying results (already cleared for interactive input)
		if firstRun {
			clearScreen()
		}

		// Calculate statistics
		min, max, mean, stdDev := calculateStatistics(values)

		// Output results
		fmt.Printf("\nStatistics for input values: %v\n", values)
		fmt.Printf("Minimum value: %.2f\n", min)
		fmt.Printf("Maximum value: %.2f\n", max)
		fmt.Printf("Mean value: %.2f\n", mean)
		fmt.Printf("Standard deviation (n-1): %.2f\n", stdDev)

		// Log results
		log.Printf("Processed values: %v", values)
		log.Printf("Results - Min: %.2f, Max: %.2f, Mean: %.2f, StdDev: %.2f",
			min, max, mean, stdDev)

		// Ask user if they want to run another calculation
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("\nWould you like to perform another calculation? (yes/no): ")
		response, err := reader.ReadString('\n')
		if err != nil {
			fmt.Printf("Error reading input: %v\n", err)
			log.Printf("Error reading response: %v", err)
			break
		}

		response = strings.TrimSpace(strings.ToLower(response))
		runCalculation = (response == "yes" || response == "y")

		log.Printf("User chose to %s", map[bool]string{true: "continue", false: "exit"}[runCalculation])
	}

	log.Println("Statistics program completed successfully")
}
