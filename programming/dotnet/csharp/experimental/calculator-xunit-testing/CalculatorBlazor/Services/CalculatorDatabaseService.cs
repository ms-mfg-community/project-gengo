using CalculatorBlazor.Data;
using Microsoft.EntityFrameworkCore;

namespace CalculatorBlazor.Services;

/// <summary>
/// Service for managing calculator test cases in the database.
/// </summary>
public class CalculatorDatabaseService
{
    private readonly IDbContextFactory<CalculatorDbContext> _contextFactory;
    private readonly ILogger<CalculatorDatabaseService> _logger;

    /// <summary>
    /// Initializes a new instance of the <see cref="CalculatorDatabaseService"/> class.
    /// </summary>
    /// <param name="contextFactory">The database context factory.</param>
    /// <param name="logger">The logger.</param>
    public CalculatorDatabaseService(
        IDbContextFactory<CalculatorDbContext> contextFactory,
        ILogger<CalculatorDatabaseService> logger)
    {
        _contextFactory = contextFactory;
        _logger = logger;
    } // end constructor

    /// <summary>
    /// Gets all test cases from the database.
    /// </summary>
    /// <returns>A list of all test cases.</returns>
    public async Task<List<CalculatorTestCase>> GetAllTestCasesAsync()
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.TestCases.ToListAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving test cases from database.");
            return new List<CalculatorTestCase>();
        } // end catch
    } // end GetAllTestCasesAsync

    /// <summary>
    /// Gets test cases filtered by operation.
    /// </summary>
    /// <param name="operation">The operation to filter by.</param>
    /// <returns>A list of test cases for the specified operation.</returns>
    public async Task<List<CalculatorTestCase>> GetTestCasesByOperationAsync(string operation)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.TestCases
                .Where(t => t.Operation == operation)
                .ToListAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving test cases for operation {Operation}.", operation);
            return new List<CalculatorTestCase>();
        } // end catch
    } // end GetTestCasesByOperationAsync

    /// <summary>
    /// Gets a test case by ID.
    /// </summary>
    /// <param name="id">The test case ID.</param>
    /// <returns>The test case if found, otherwise null.</returns>
    public async Task<CalculatorTestCase?> GetTestCaseByIdAsync(int id)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.TestCases.FindAsync(id);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving test case with ID {Id}.", id);
            return null;
        } // end catch
    } // end GetTestCaseByIdAsync

    /// <summary>
    /// Updates a test case with actual value and result.
    /// </summary>
    /// <param name="id">The test case ID.</param>
    /// <param name="actualValue">The actual calculated value.</param>
    /// <param name="result">The test result (passed/failed).</param>
    /// <returns>True if successful, otherwise false.</returns>
    public async Task<bool> UpdateTestResultAsync(int id, double actualValue, string result)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            var testCase = await context.TestCases.FindAsync(id);
            
            if (testCase == null)
            {
                return false;
            } // end if

            testCase.ActualValue = actualValue;
            testCase.Result = result;

            await context.SaveChangesAsync();
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating test case with ID {Id}.", id);
            return false;
        } // end catch
    } // end UpdateTestResultAsync

    /// <summary>
    /// Adds a new test case to the database.
    /// </summary>
    /// <param name="testCase">The test case to add.</param>
    /// <returns>The ID of the newly added test case, or -1 if failed.</returns>
    public async Task<int> AddTestCaseAsync(CalculatorTestCase testCase)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            context.TestCases.Add(testCase);
            await context.SaveChangesAsync();
            return testCase.Id;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error adding new test case.");
            return -1;
        } // end catch
    } // end AddTestCaseAsync

    /// <summary>
    /// Deletes a test case from the database.
    /// </summary>
    /// <param name="id">The test case ID.</param>
    /// <returns>True if successful, otherwise false.</returns>
    public async Task<bool> DeleteTestCaseAsync(int id)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            var testCase = await context.TestCases.FindAsync(id);
            
            if (testCase == null)
            {
                return false;
            } // end if

            context.TestCases.Remove(testCase);
            await context.SaveChangesAsync();
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting test case with ID {Id}.", id);
            return false;
        } // end catch
    } // end DeleteTestCaseAsync

    /// <summary>
    /// Gets the count of test cases by result status.
    /// </summary>
    /// <param name="result">The result status to count.</param>
    /// <returns>The count of test cases with the specified result.</returns>
    public async Task<int> GetTestCaseCountByResultAsync(string result)
    {
        try
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.TestCases
                .CountAsync(t => t.Result == result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error counting test cases with result {Result}.", result);
            return 0;
        } // end catch
    } // end GetTestCaseCountByResultAsync
} // end class CalculatorDatabaseService
