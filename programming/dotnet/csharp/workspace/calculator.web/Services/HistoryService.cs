using calculator.web.Models;

namespace calculator.web.Services;

/// <summary>Service managing calculation history with FIFO queue.</summary>
public class HistoryService
{
    private const int MaxHistoryItems = 50;
    private readonly Queue<CalculationRecord> _history = new();

    /// <summary>Event raised when history changes.</summary>
    public event Action? OnHistoryChanged;

    /// <summary>Gets all history items (newest first).</summary>
    public IEnumerable<CalculationRecord> GetHistory() => _history.Reverse();

    /// <summary>Adds a calculation to history.</summary>
    public void AddCalculation(CalculationRecord record)
    {
        _history.Enqueue(record);
        if (_history.Count > MaxHistoryItems)
            _history.Dequeue();
        OnHistoryChanged?.Invoke();
    }

    /// <summary>Clears all history.</summary>
    public void Clear()
    {
        _history.Clear();
        OnHistoryChanged?.Invoke();
    }
}
