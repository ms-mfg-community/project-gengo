using CalculatorBlazor.Data;
using Microsoft.EntityFrameworkCore;

namespace CalculatorBlazor.Services;

/// <summary>
/// Service for initializing and seeding the calculator database.
/// </summary>
public class DatabaseInitializationService
{
    private readonly CalculatorDbContext _context;
    private readonly IWebHostEnvironment _env;
    private readonly ILogger<DatabaseInitializationService> _logger;

    /// <summary>
    /// Initializes a new instance of the <see cref="DatabaseInitializationService"/> class.
    /// </summary>
    /// <param name="context">The database context.</param>
    /// <param name="env">The web host environment.</param>
    /// <param name="logger">The logger.</param>
    public DatabaseInitializationService(
        CalculatorDbContext context,
        IWebHostEnvironment env,
        ILogger<DatabaseInitializationService> logger)
    {
        _context = context;
        _env = env;
        _logger = logger;
    } // end constructor

    /// <summary>
    /// Initializes the database and seeds it with data from the CSV file if it's empty.
    /// </summary>
    public async Task InitializeAsync()
    {
        try
        {
            // Ensure database is created
            await _context.Database.EnsureCreatedAsync();
            _logger.LogInformation("Database created or already exists.");

            // Check if data already exists
            if (await _context.TestCases.AnyAsync())
            {
                _logger.LogInformation("Database already contains data. Skipping seed.");
                return;
            } // end if

            // Seed from CSV
            await SeedFromCsvAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An error occurred while initializing the database.");
            throw;
        } // end catch
    } // end InitializeAsync

    /// <summary>
    /// Seeds the database with data from the CSV file.
    /// </summary>
    private async Task SeedFromCsvAsync()
    {
        var csvPath = Path.Combine(_env.ContentRootPath, "TestData", "calculator-test-data.csv");

        if (!File.Exists(csvPath))
        {
            _logger.LogWarning("CSV file not found at {CsvPath}", csvPath);
            return;
        } // end if

        try
        {
            var lines = await File.ReadAllLinesAsync(csvPath);
            var testCases = new List<CalculatorTestCase>();

            // Skip header row
            for (int i = 1; i < lines.Length; i++)
            {
                var line = lines[i].Trim();
                if (string.IsNullOrWhiteSpace(line))
                {
                    continue;
                } // end if

                var parts = line.Split(',');

                if (parts.Length >= 5)
                {
                    var testCase = new CalculatorTestCase
                    {
                        FirstNumber = double.Parse(parts[0].Trim()),
                        SecondNumber = double.Parse(parts[1].Trim()),
                        Operation = parts[2].Trim(),
                        ExpectedValue = double.Parse(parts[3].Trim()),
                        Description = parts[4].Trim(),
                        Result = "pending"
                    };

                    testCases.Add(testCase);
                } // end if
            } // end for

            if (testCases.Any())
            {
                await _context.TestCases.AddRangeAsync(testCases);
                await _context.SaveChangesAsync();
                _logger.LogInformation("Successfully seeded {Count} test cases from CSV.", testCases.Count);
            } // end if
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error seeding data from CSV file.");
            throw;
        } // end catch
    } // end SeedFromCsvAsync
} // end class DatabaseInitializationService
