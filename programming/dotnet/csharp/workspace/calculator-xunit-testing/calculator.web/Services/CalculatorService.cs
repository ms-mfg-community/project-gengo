using calculator.library;
using calculator.web.Models;

namespace calculator.web.Services;

/// <summary>
/// Service managing calculator state, operations, and display.
/// Fires events when display changes or calculations complete.
/// </summary>
public class CalculatorService
{
    private readonly Calculator _calculator = new();
    private string _display = "0";
    private decimal _pendingOperand = 0;
    private char? _pendingOperator = null;
    private bool _isNewDisplay = true;

    public string Display => _display;

    public event EventHandler? OnDisplayChanged;
    public event EventHandler<CalculationRecord>? OnCalculationCompleted;

    /// <summary>
    /// Appends a digit to the display.
    /// </summary>
    public void AppendDigit(string digit)
    {
        if (_isNewDisplay)
        {
            _display = digit;
            _isNewDisplay = false;
        }
        else
        {
            _display += digit;
        }

        OnDisplayChanged?.Invoke(this, EventArgs.Empty);
    }

    /// <summary>
    /// Adds decimal point to display.
    /// </summary>
    public void AppendDecimal()
    {
        if (!_display.Contains("."))
        {
            _display += ".";
            _isNewDisplay = false;
            OnDisplayChanged?.Invoke(this, EventArgs.Empty);
        }
    }

    /// <summary>
    /// Sets the pending operator and calculates previous operation if needed.
    /// </summary>
    public void SetOperator(char op)
    {
        if (!decimal.TryParse(_display, out var currentValue))
            return;

        if (_pendingOperator.HasValue && !_isNewDisplay)
        {
            try
            {
                var result = _calculator.Operate(_pendingOperand, currentValue, _pendingOperator.Value);
                _display = result.ToString();
            }
            catch
            {
                _display = "Error";
            }
        }
        else
        {
            _pendingOperand = currentValue;
        }

        _pendingOperator = op;
        _isNewDisplay = true;
        OnDisplayChanged?.Invoke(this, EventArgs.Empty);
    }

    /// <summary>
    /// Calculates the result of pending operation.
    /// </summary>
    public void Calculate()
    {
        if (!_pendingOperator.HasValue || !decimal.TryParse(_display, out var currentValue))
            return;

        decimal result;
        try
        {
            result = _calculator.Operate(_pendingOperand, currentValue, _pendingOperator.Value);
        }
        catch
        {
            _display = "Error";
            _pendingOperator = null;
            _isNewDisplay = true;
            OnDisplayChanged?.Invoke(this, EventArgs.Empty);
            return;
        }

        var record = new CalculationRecord
        {
            FirstOperand = _pendingOperand,
            SecondOperand = currentValue,
            Operator = _pendingOperator.Value,
            Result = result,
            Timestamp = DateTime.Now
        };

        _display = result.ToString();
        _pendingOperator = null;
        _isNewDisplay = true;

        OnDisplayChanged?.Invoke(this, EventArgs.Empty);
        OnCalculationCompleted?.Invoke(this, record);
    }

    /// <summary>
    /// Clears calculator state.
    /// </summary>
    public void Clear()
    {
        _display = "0";
        _pendingOperand = 0;
        _pendingOperator = null;
        _isNewDisplay = true;
        OnDisplayChanged?.Invoke(this, EventArgs.Empty);
    }

    /// <summary>
    /// Replays a calculation from history.
    /// </summary>
    public void ReplayCalculation(CalculationRecord record)
    {
        _display = record.Result.ToString();
        _pendingOperand = record.Result;
        _pendingOperator = null;
        _isNewDisplay = true;
        OnDisplayChanged?.Invoke(this, EventArgs.Empty);
    }
}
