namespace calculator.tests;

using System.Reflection;
using Xunit;

/// <summary>
/// Helper class to load and parse test data from CSV file.
/// </summary>
public class CalculatorTestDataLoader
{
    /// <summary>
    /// Gets the path to the test data CSV file.
    /// </summary>
    private static string GetTestDataPath()
    {
        var assemblyLocation = typeof(CalculatorTestDataLoader).Assembly.Location;
        var assemblyDirectory = Path.GetDirectoryName(assemblyLocation);
        return Path.Combine(assemblyDirectory, "TestData", "calculator-test-data.csv");
    } // end GetTestDataPath

    /// <summary>
    /// Loads test data from CSV file and returns as list of objects for Theory tests.
    /// </summary>
    /// <returns>Collection of objects containing test data.</returns>
    public static IEnumerable<object[]> GetTestData()
    {
        var csvPath = GetTestDataPath();

        if (!File.Exists(csvPath))
        {
            throw new FileNotFoundException($"Test data file not found: {csvPath}");
        } // end if

        var lines = File.ReadAllLines(csvPath).Skip(1); // Skip header row

        foreach (var line in lines)
        {
            var parts = line.Split(',');
            if (parts.Length >= 5)
            {
                double.TryParse(parts[0], out double firstNumber);
                double.TryParse(parts[1], out double secondNumber);
                var operation = parts[2].Trim();
                double.TryParse(parts[3], out double expectedValue);
                var description = parts[4].Trim();

                yield return new object[] { firstNumber, secondNumber, operation, expectedValue, description };
            } // end if
        } // end foreach
    } // end GetTestData
}
