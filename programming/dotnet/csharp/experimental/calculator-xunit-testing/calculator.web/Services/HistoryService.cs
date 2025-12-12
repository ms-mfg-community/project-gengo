using CalculatorWeb.Models;

namespace CalculatorWeb.Services;

/// <summary>
/// Service that manages calculation history (session-only, max 50 items)
/// </summary>
public class HistoryService
{
    private const int MaxItems = 50;
    private readonly List<CalculationRecord> _calculations = new();

    /// <summary>
    /// List of calculation records (newest first)
    /// </summary>
    public IReadOnlyList<CalculationRecord> Calculations => _calculations.AsReadOnly();

    /// <summary>
    /// Event raised when history changes
    /// </summary>
    public event Action? OnHistoryChanged;

    /// <summary>
    /// Adds a new calculation to history
    /// </summary>
    public void AddCalculation(string operand1, string op, string operand2, string result)
    {
        var record = new CalculationRecord
        {
            Operand1 = operand1,
            Operator = op,
            Operand2 = operand2,
            Result = result,
            Timestamp = DateTime.Now
        };

        _calculations.Insert(0, record);

        // Keep only last 50 items (FIFO)
        if (_calculations.Count > MaxItems)
        {
            _calculations.RemoveAt(_calculations.Count - 1);
        }

        OnHistoryChanged?.Invoke();
    }

    /// <summary>
    /// Clears all history
    /// </summary>
    public void ClearHistory()
    {
        _calculations.Clear();
        OnHistoryChanged?.Invoke();
    }

    /// <summary>
    /// Replays a calculation from history
    /// Returns the result value
    /// </summary>
    public string? ReplayCalculation(int index)
    {
        if (index >= 0 && index < _calculations.Count)
        {
            return _calculations[index].Result;
        }
        return null;
    }

    /// <summary>
    /// Checks if history is empty
    /// </summary>
    public bool IsEmpty => _calculations.Count == 0;

    /// <summary>
    /// Gets the count of items in history
    /// </summary>
    public int Count => _calculations.Count;
}
