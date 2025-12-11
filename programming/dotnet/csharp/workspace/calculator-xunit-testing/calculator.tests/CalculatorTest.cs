using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Xunit;
using CalculatorApp;

namespace calculator.tests;

/// <summary>
/// Comprehensive unit tests for the Calculator class
/// Tests cover normal cases, edge cases, and error conditions
/// Test data is sourced from a CSV file for maintainability and clarity
/// </summary>
public class CalculatorTest
{
    /// <summary>
    /// Gets test data from the CSV file
    /// </summary>
    private static IEnumerable<TestDataRecord> GetTestDataFromCsv()
    {
        // Find the CSV file relative to the test assembly location
        string assemblyLocation = System.Reflection.Assembly.GetExecutingAssembly().Location;
        string assemblyDirectory = Path.GetDirectoryName(assemblyLocation) ?? string.Empty;
        
        // Navigate up from bin/Debug/net8.0 to the project root, then to TestData
        string csvPath = Path.Combine(assemblyDirectory, "..", "..", "..", "TestData", "CalculatorTestData.csv");
        string fullPath = Path.GetFullPath(csvPath);

        if (!File.Exists(fullPath))
        {
            throw new FileNotFoundException($"Test data CSV file not found at: {fullPath}");
        }

        var records = new List<TestDataRecord>();

        using (var reader = new StreamReader(fullPath))
        {
            // Skip header line
            reader.ReadLine();

            string? line;
            while ((line = reader.ReadLine()) != null)
            {
                if (string.IsNullOrWhiteSpace(line))
                    continue;

                var parts = line.Split(',');
                if (parts.Length >= 4)
                {
                    records.Add(new TestDataRecord
                    {
                        FirstNumber = double.Parse(parts[0].Trim()),
                        SecondNumber = double.Parse(parts[1].Trim()),
                        Operation = parts[2].Trim(),
                        ExpectedValue = double.Parse(parts[3].Trim()),
                        Result = parts.Length > 4 ? parts[4].Trim() : "unknown"
                    });
                }
            }
        }

        return records;
    }

    /// <summary>
    /// Comprehensive test that validates all operations using CSV data
    /// </summary>
    [Fact]
    public void Calculator_WithCsvTestData_AllOperationsProduceExpectedResults()
    {
        // Arrange
        var testData = GetTestDataFromCsv();
        var failedTests = new List<string>();

        // Act & Assert
        foreach (var record in testData)
        {
            double actualValue = PerformOperation(record.FirstNumber, record.SecondNumber, record.Operation);
            bool testPassed = false;

            // Handle NaN comparisons for division/modulo by zero
            if (double.IsNaN(record.ExpectedValue) && double.IsNaN(actualValue))
            {
                testPassed = true;
            }
            else if (!double.IsNaN(record.ExpectedValue))
            {
                testPassed = Math.Abs(actualValue - record.ExpectedValue) < 0.0001;
            }

            if (!testPassed)
            {
                failedTests.Add(
                    $"Operation: {record.FirstNumber} {record.Operation} {record.SecondNumber}, " +
                    $"Expected: {record.ExpectedValue}, Actual: {actualValue}, Result: FAILED"
                );
            }
        }

        // Assert all tests passed
        Assert.Empty(failedTests);
    }

    /// <summary>
    /// Tests each operation individually by operation type
    /// </summary>
    [Theory]
    [MemberData(nameof(GetAdditionData))]
    public void Add_WithCsvData_ReturnsExpectedSum(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Add(first, second);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [MemberData(nameof(GetSubtractionData))]
    public void Subtract_WithCsvData_ReturnsExpectedDifference(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Subtract(first, second);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [MemberData(nameof(GetMultiplicationData))]
    public void Multiply_WithCsvData_ReturnsExpectedProduct(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Multiply(first, second);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [MemberData(nameof(GetDivisionData))]
    public void Divide_WithCsvData_ReturnsExpectedQuotient(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Divide(first, second);

        // Assert
        if (double.IsNaN(expected))
        {
            Assert.True(double.IsNaN(result), "Expected NaN for division by zero");
        }
        else
        {
            Assert.Equal(expected, result);
        }
    }

    [Theory]
    [MemberData(nameof(GetModuloData))]
    public void Modulo_WithCsvData_ReturnsExpectedRemainder(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Modulo(first, second);

        // Assert
        if (double.IsNaN(expected))
        {
            Assert.True(double.IsNaN(result), "Expected NaN for modulo by zero");
        }
        else
        {
            Assert.Equal(expected, result);
        }
    }

    [Theory]
    [MemberData(nameof(GetExponentData))]
    public void Exponent_WithCsvData_ReturnsExpectedPower(double first, double second, double expected)
    {
        // Act
        double result = Calculator.Exponent(first, second);

        // Assert
        Assert.Equal(expected, result, 10);
    }

    /// <summary>
    /// Member data providers - extract data from CSV by operation type
    /// </summary>
    public static IEnumerable<object[]> GetAdditionData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "+")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    public static IEnumerable<object[]> GetSubtractionData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "-")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    public static IEnumerable<object[]> GetMultiplicationData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "*")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    public static IEnumerable<object[]> GetDivisionData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "/")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    public static IEnumerable<object[]> GetModuloData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "%")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    public static IEnumerable<object[]> GetExponentData()
    {
        return GetTestDataFromCsv()
            .Where(r => r.Operation == "^")
            .Select(r => new object[] { r.FirstNumber, r.SecondNumber, r.ExpectedValue });
    }

    /// <summary>
    /// Helper method to perform the operation
    /// </summary>
    private static double PerformOperation(double first, double second, string operation)
    {
        return operation switch
        {
            "+" => Calculator.Add(first, second),
            "-" => Calculator.Subtract(first, second),
            "*" => Calculator.Multiply(first, second),
            "/" => Calculator.Divide(first, second),
            "%" => Calculator.Modulo(first, second),
            "^" => Calculator.Exponent(first, second),
            _ => double.NaN
        };
    }
}

/// <summary>
/// Data class representing a test record from the CSV file
/// </summary>
public class TestDataRecord
{
    public double FirstNumber { get; set; }
    public double SecondNumber { get; set; }
    public string Operation { get; set; } = string.Empty;
    public double ExpectedValue { get; set; }
    public string Result { get; set; } = "unknown";
}
