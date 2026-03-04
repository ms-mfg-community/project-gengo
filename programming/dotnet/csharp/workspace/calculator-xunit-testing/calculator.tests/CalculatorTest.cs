#nullable enable

using System.Globalization;
using calculator;
using Npgsql;

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit test suite for the Calculator class.
/// Combines CSV-driven tests for main operations with focused tests for edge cases and error conditions.
/// </summary>
public class CalculatorTest
{
    private const double Tolerance = 0.0001;
    private const string DefaultHost = "localhost";
    private const int DefaultPort = 5432;
    private const string DefaultDatabase = "test_db";
    private const string DefaultUser = "postgres_user";
    private const string DefaultTable = "test_data";

    /// <summary>
    /// Loads test data from PostgreSQL and yields test cases as object arrays for MemberData-driven tests.
    /// </summary>
    public static IEnumerable<object[]> LoadTestDataFromPostgres()
    {
        string host = GetEnvOrDefault("TEST_PG_HOST", DefaultHost);
        string portValue = GetEnvOrDefault("TEST_PG_PORT", DefaultPort.ToString(CultureInfo.InvariantCulture));
        string database = GetEnvOrDefault("TEST_PG_DATABASE", DefaultDatabase);
        string user = GetEnvOrDefault("TEST_PG_USER", DefaultUser);
        string password = GetEnvOrDefault("TEST_PG_PASSWORD", string.Empty);
        string table = GetEnvOrDefault("TEST_PG_TABLE", DefaultTable);

        if (string.IsNullOrWhiteSpace(password))
        {
            throw new InvalidOperationException(
                "Missing PostgreSQL password. Set environment variable TEST_PG_PASSWORD before running tests.");
        }

        if (!int.TryParse(portValue, NumberStyles.Integer, CultureInfo.InvariantCulture, out int port) || port <= 0)
        {
            throw new InvalidOperationException(
                $"Invalid TEST_PG_PORT value '{portValue}'. Provide a valid positive integer port.");
        }

        if (!IsValidSqlIdentifier(table))
        {
            throw new InvalidOperationException(
                $"Invalid TEST_PG_TABLE value '{table}'. Use letters, numbers, and underscores only, starting with a letter or underscore.");
        }

        var builder = new NpgsqlConnectionStringBuilder
        {
            Host = host,
            Port = port,
            Database = database,
            Username = user,
            Password = password,
            Timeout = 10,
            CommandTimeout = 15
        };

        string query = $"SELECT * FROM \"{table}\"";
        var testCases = new List<object[]>();

        try
        {
            using var connection = new NpgsqlConnection(builder.ConnectionString);
            connection.Open();

            using var command = new NpgsqlCommand(query, connection);
            using var reader = command.ExecuteReader();

            int rowNumber = 0;
            while (reader.Read())
            {
                rowNumber++;

                string? firstRaw = GetColumnValue(reader, "firstNumber", "firstnumber", "first_number");
                string? secondRaw = GetColumnValue(reader, "secondNumber", "secondnumber", "second_number");
                string? operatorRaw = GetColumnValue(reader, "operator");
                string? expectedRaw = GetColumnValue(reader, "expectedResult", "expectedresult", "expected_result");
                string? descriptionRaw = GetColumnValue(reader, "testDescription", "testdescription", "test_description");

                if (!TryParseDouble(firstRaw, out double firstNumber)
                    || !TryParseDouble(secondRaw, out double secondNumber)
                    || !TryParseDouble(expectedRaw, out double expectedResult)
                    || string.IsNullOrWhiteSpace(operatorRaw))
                {
                    Console.Error.WriteLine(
                        $"Skipping malformed PostgreSQL row {rowNumber} in table '{table}'. " +
                        $"Values: first='{firstRaw}', second='{secondRaw}', operator='{operatorRaw}', expected='{expectedRaw}', description='{descriptionRaw}'.");
                    continue;
                }

                string description = string.IsNullOrWhiteSpace(descriptionRaw)
                    ? $"PostgreSQL row {rowNumber}"
                    : descriptionRaw.Trim();

                testCases.Add(new object[]
                {
                    firstNumber,
                    secondNumber,
                    operatorRaw.Trim(),
                    expectedResult,
                    description
                });
            }
        }
        catch (PostgresException ex) when (ex.SqlState == PostgresErrorCodes.UndefinedTable)
        {
            throw new InvalidOperationException(
                $"PostgreSQL table '{table}' was not found in database '{database}'. " +
                "Seed the container using prompt 2.02 and verify TEST_PG_TABLE.",
                ex);
        }
        catch (NpgsqlException ex)
        {
            throw new InvalidOperationException(
                $"Failed to reach PostgreSQL at {host}:{port}/{database} as user '{user}'. " +
                "Verify container status and TEST_PG_* environment variables.",
                ex);
        }

            return testCases;
    }

    private static bool TryParseDouble(string? input, out double value)
    {
        return double.TryParse(input, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out value)
            || double.TryParse(input, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.CurrentCulture, out value);
    }

    private static string GetEnvOrDefault(string variableName, string defaultValue)
    {
        string? value = Environment.GetEnvironmentVariable(variableName);
        return string.IsNullOrWhiteSpace(value) ? defaultValue : value.Trim();
    }

    private static bool IsValidSqlIdentifier(string identifier)
    {
        if (string.IsNullOrWhiteSpace(identifier))
        {
            return false;
        }

        if (!(char.IsLetter(identifier[0]) || identifier[0] == '_'))
        {
            return false;
        }

        return identifier.All(ch => char.IsLetterOrDigit(ch) || ch == '_');
    }

    private static string? GetColumnValue(NpgsqlDataReader reader, params string[] candidateNames)
    {
        for (int index = 0; index < reader.FieldCount; index++)
        {
            string currentName = reader.GetName(index);
            if (!candidateNames.Any(candidate => string.Equals(currentName, candidate, StringComparison.OrdinalIgnoreCase)))
            {
                continue;
            }

            if (reader.IsDBNull(index))
            {
                return null;
            }

            object value = reader.GetValue(index);
            return Convert.ToString(value, CultureInfo.InvariantCulture);
        }

        return null;
    }

    #region PostgreSQL-Driven Tests

    /// <summary>
    /// Data-driven test that executes all calculator operations using test data from PostgreSQL table rows.
    /// Combines all operations in a single parameterized test for comprehensive coverage.
    /// The testDescription parameter is used to provide context when a test fails.
    /// </summary>
    [Theory]
    [MemberData(nameof(LoadTestDataFromPostgres))]
    public void Calculate_WithPostgresData_ReturnsExpectedResult(
        double firstNumber, 
        double secondNumber, 
        string operatorSymbol, 
        double expectedResult, 
        string testDescription)
    {
        // Act
        double result = Calculator.Calculate(firstNumber, secondNumber, operatorSymbol);
        
        // Assert with precision handling for floating-point operations
        if (operatorSymbol == "^" || operatorSymbol == "/")
        {
            Assert.Equal(expectedResult, result, precision: 10);
        }
        else
        {
            Assert.Equal(expectedResult, result, Tolerance);
        }
        
        // Context: testDescription is available for debugging test failures
        _ = testDescription;  // Suppress unused parameter warning
    }

    #endregion

    #region Error Condition Tests

    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Divide(10.5, 0));
    }

    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Modulo(10.5, 0));
    }

    [Fact]
    public void Calculate_DivisionByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10.5, 0, "/"));
    }

    [Fact]
    public void Calculate_UnknownOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, "?"));
    }

    [Fact]
    public void Calculate_NullOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, null!));
    }

    [Fact]
    public void Calculate_EmptyOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, ""));
    }

    [Fact]
    public void Calculate_OperatorWithWhitespace_StillWorks()
    {
        // Verify whitespace handling - should still accept " + " as valid operator
        double result = Calculator.Calculate(5.5, 3.2, " + ");
        Assert.Equal(8.7, result, Tolerance);
    }

    #endregion

    #region Edge Case Tests

    [Fact]
    public void Add_WithZero_ReturnsOtherNumber()
    {
        Assert.Equal(5.5, Calculator.Add(5.5, 0), Tolerance);
    }

    [Fact]
    public void Multiply_ByZero_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Multiply(5.5, 0), Tolerance);
    }

    [Fact]
    public void Division_ResultsInDecimal_ReturnsDecimalValue()
    {
        Assert.Equal(2.333333, Calculator.Divide(7.0, 3.0), Tolerance);
    }

    [Fact]
    public void Power_WithZeroExponent_ReturnsOne()
    {
        Assert.Equal(1.0, Calculator.Power(5.5, 0), Tolerance);
    }

    [Fact]
    public void Power_WithNegativeExponent_ReturnsReciprocal()
    {
        Assert.Equal(0.25, Calculator.Power(2.0, -2.0), Tolerance);
    }

    #endregion
}
