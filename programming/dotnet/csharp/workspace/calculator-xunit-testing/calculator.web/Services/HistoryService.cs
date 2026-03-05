#nullable enable

namespace calculator.web.Services;

/// <summary>
/// Manages calculation history with a FIFO queue (max 50 items, newest first).
/// Session-only storage; no persistence layer.
/// </summary>
public class HistoryService
{
    private const int MaxItems = 50;
    private readonly LinkedList<CalculationRecord> _history = new();

    /// <summary>Raised when the history list changes.</summary>
    public event Action? OnHistoryChanged;

    /// <summary>
    /// Gets the current history items, newest first.
    /// </summary>
    public IReadOnlyList<CalculationRecord> Items => _history.ToList().AsReadOnly();

    /// <summary>
    /// Adds a new calculation record to the history.
    /// If the history exceeds 50 items, the oldest entry is removed.
    /// </summary>
    /// <param name="record">The calculation record to add.</param>
    public void Add(CalculationRecord record)
    {
        _history.AddFirst(record);

        while (_history.Count > MaxItems)
        {
            _history.RemoveLast();
        }

        OnHistoryChanged?.Invoke();
    }

    /// <summary>
    /// Clears all history entries.
    /// </summary>
    public void Clear()
    {
        _history.Clear();
        OnHistoryChanged?.Invoke();
    }
}
