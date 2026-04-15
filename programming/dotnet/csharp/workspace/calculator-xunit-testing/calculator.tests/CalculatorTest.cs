#nullable enable

using System.Globalization;
using Npgsql;

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit tests for the Calculator class using PostgreSQL-driven and individual tests.
/// Tests all arithmetic operations with normal cases, edge cases, and error conditions.
/// </summary>
public class CalculatorTest
{
    private static readonly CultureInfo InvariantCulture = CultureInfo.InvariantCulture;

    private static string GetRequiredPassword()
    {
        var password = Environment.GetEnvironmentVariable("TEST_PG_PASSWORD") ?? string.Empty;
        if (string.IsNullOrWhiteSpace(password))
        {
            throw new InvalidOperationException(
                "Missing required environment variable TEST_PG_PASSWORD. " +
                "Set TEST_PG_PASSWORD before running calculator.tests."
            );
        }

        return password;
    }

    private static string GetConnectionString()
    {
        var host = Environment.GetEnvironmentVariable("TEST_PG_HOST") ?? "localhost";
        var portText = Environment.GetEnvironmentVariable("TEST_PG_PORT") ?? "5432";
        var database = Environment.GetEnvironmentVariable("TEST_PG_DATABASE") ?? "test_db";
        var user = Environment.GetEnvironmentVariable("TEST_PG_USER") ?? "postgres_user";
        var password = GetRequiredPassword();

        if (!int.TryParse(portText, NumberStyles.Integer, InvariantCulture, out var port))
        {
            throw new InvalidOperationException(
                $"Invalid TEST_PG_PORT value '{portText}'. Expected an integer port number."
            );
        }

        return new NpgsqlConnectionStringBuilder
        {
            Host = host,
            Port = port,
            Database = database,
            Username = user,
            Password = password,
            Pooling = false
        }.ConnectionString;
    }

    private static string SanitizeIdentifier(string value, string envName, string defaultValue)
    {
        var source = string.IsNullOrWhiteSpace(value) ? defaultValue : value;
        foreach (var character in source)
        {
            if (!(char.IsLetterOrDigit(character) || character == '_'))
            {
                throw new InvalidOperationException(
                    $"Invalid identifier '{source}' for {envName}. Use letters, digits, or underscore only."
                );
            }
        }

        return source;
    }

    /// <summary>
    /// Loads test data from PostgreSQL and yields test cases for MemberData.
    /// Table columns: firstNumber, secondNumber, operator, expectedResult, testDescription.
    /// </summary>
    public static IEnumerable<object[]> LoadTestDataFromPostgres()
    {
        var tableName = SanitizeIdentifier(
            Environment.GetEnvironmentVariable("TEST_PG_TABLE") ?? "test_data",
            "TEST_PG_TABLE",
            "test_data"
        );

        var sql = $@"
    SELECT ""firstNumber"", ""secondNumber"", ""operator"", ""expectedResult"", ""testDescription""
    FROM ""{tableName}""
    ORDER BY ""testDescription"";";

        using var connection = new NpgsqlConnection(GetConnectionString());
        try
        {
            connection.Open();
        }
        catch (Exception exception)
        {
            throw new InvalidOperationException(
                "Unable to connect to PostgreSQL for calculator test data. " +
                "Verify TEST_PG_HOST/TEST_PG_PORT/TEST_PG_DATABASE/TEST_PG_USER/TEST_PG_PASSWORD and that the container is running.",
                exception
            );
        }

        using var command = new NpgsqlCommand(sql, connection);
        NpgsqlDataReader reader;
        try
        {
            reader = command.ExecuteReader();
        }
        catch (PostgresException exception) when (exception.SqlState == PostgresErrorCodes.UndefinedTable)
        {
            throw new InvalidOperationException(
                $"PostgreSQL table '{tableName}' was not found. Seed data first using the 2.02 container import workflow.",
                exception
            );
        }

        var cases = new List<object[]>();
        using (reader)
        {
            var rowNumber = 0;
            while (reader.Read())
            {
                rowNumber++;
                string firstText;
                string secondText;
                string op;
                string expectedText;
                string testDescription;

                try
                {
                    firstText = reader.GetString(0).Trim();
                    secondText = reader.GetString(1).Trim();
                    op = reader.GetString(2).Trim();
                    expectedText = reader.GetString(3).Trim();
                    testDescription = reader.GetString(4).Trim();
                }
                catch (Exception exception)
                {
                    Console.WriteLine($"Skipping malformed PostgreSQL test row #{rowNumber}: {exception.Message}");
                    continue;
                }

                if (!double.TryParse(firstText, NumberStyles.Float | NumberStyles.AllowThousands, InvariantCulture, out var firstNumber) ||
                    !double.TryParse(secondText, NumberStyles.Float | NumberStyles.AllowThousands, InvariantCulture, out var secondNumber) ||
                    !double.TryParse(expectedText, NumberStyles.Float | NumberStyles.AllowThousands, InvariantCulture, out var expectedResult) ||
                    string.IsNullOrWhiteSpace(op))
                {
                    Console.WriteLine(
                        $"Skipping malformed PostgreSQL test row #{rowNumber}: first='{firstText}', second='{secondText}', op='{op}', expected='{expectedText}', desc='{testDescription}'."
                    );
                    continue;
                }

                cases.Add(new object[]
                {
                    firstNumber,
                    secondNumber,
                    op,
                    expectedResult,
                    testDescription
                });
            }
        }

        if (cases.Count == 0)
        {
            throw new InvalidOperationException(
                $"No valid test rows were loaded from PostgreSQL table '{tableName}'. Check seeded data in test_data."
            );
        }

        return cases;
    }

    #region PostgreSQL-Driven Calculator Tests

    [Theory]
    [MemberData(nameof(LoadTestDataFromPostgres))]
    public void Calculate_WithPostgresData_ReturnsExpectedResult(
        double firstNumber,
        double secondNumber,
        string op,
        double expectedResult,
        string testDescription)
    {
        _ = testDescription;

        double result = Calculator.Calculate(firstNumber, secondNumber, op);

        if (op == "^" || op == "/")
        {
            Assert.Equal(expectedResult, result, precision: 10);
        }
        else
        {
            Assert.Equal(expectedResult, result);
        }
    }

    #endregion

    #region Error Condition Tests

    [Fact]
    public void Calculate_DivideByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "/"));
    }

    [Fact]
    public void Calculate_ModuloByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "%"));
    }

    [Fact]
    public void Calculate_NullOperator_ThrowsArgumentException()
    {
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, null!));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    [Fact]
    public void Calculate_EmptyOperator_ThrowsArgumentException()
    {
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, ""));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    [Fact]
    public void Calculate_InvalidOperator_ThrowsArgumentException()
    {
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, "&"));
        Assert.Contains("Invalid operator", ex.Message);
    }

    #endregion

    #region Individual Operation Tests (Supplementary)

    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        double result = Calculator.Add(5, 3);
        Assert.Equal(8, result);
    }

    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        double result = Calculator.Subtract(5, 3);
        Assert.Equal(2, result);
    }

    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        double result = Calculator.Multiply(5, 3);
        Assert.Equal(15, result);
    }

    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        double result = Calculator.Divide(6, 2);
        Assert.Equal(3, result);
    }

    [Fact]
    public void Modulo_TwoNumbers_ReturnsCorrectRemainder()
    {
        double result = Calculator.Modulo(7, 3);
        Assert.Equal(1, result);
    }

    [Fact]
    public void Power_BaseAndExponent_ReturnsCorrectPower()
    {
        double result = Calculator.Power(2, 3);
        Assert.Equal(8, result);
    }

    #endregion
}