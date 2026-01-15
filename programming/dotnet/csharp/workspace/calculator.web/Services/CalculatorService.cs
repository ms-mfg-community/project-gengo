using CalculatorApp;
using calculator.web.Models;

namespace calculator.web.Services;

/// <summary>Service managing calculator state and operations.</summary>
public class CalculatorService
{
    private readonly Calculator _calculator = new();
    private string _display = "0";
    private double _pendingOperand = 0;
    private string? _pendingOperator = null;
    private bool _newDisplay = true;

    /// <summary>Event raised when display changes.</summary>
    public event Action? OnDisplayChanged;

    /// <summary>Event raised when calculation completes.</summary>
    public event Action<CalculationRecord>? OnCalculationCompleted;

    /// <summary>Gets the current display value.</summary>
    public string Display => _display;

    /// <summary>Appends a digit to the display.</summary>
    public void AppendDigit(string digit)
    {
        if (_newDisplay)
        {
            _display = digit == "." ? "0." : digit;
            _newDisplay = false;
        }
        else
        {
            if (digit == "." && _display.Contains("."))
                return;
            _display += digit;
        }
        OnDisplayChanged?.Invoke();
    }

    /// <summary>Sets an operator and performs pending calculation if needed.</summary>
    public void SetOperator(string op)
    {
        if (!double.TryParse(_display, out double current))
            return;

        if (_pendingOperator != null && !_newDisplay)
        {
            _pendingOperand = _calculator.Operate(_pendingOperand, current, _pendingOperator);
            _display = _pendingOperand.ToString();
        }
        else
        {
            _pendingOperand = current;
        }

        _pendingOperator = op;
        _newDisplay = true;
        OnDisplayChanged?.Invoke();
    }

    /// <summary>Calculates the result of the pending operation.</summary>
    public CalculationRecord? Calculate()
    {
        if (!double.TryParse(_display, out double current) || _pendingOperator == null)
            return null;

        try
        {
            double result = _calculator.Operate(_pendingOperand, current, _pendingOperator);
            _display = result.ToString();

            var record = new CalculationRecord
            {
                FirstOperand = _pendingOperand,
                SecondOperand = current,
                Operator = _pendingOperator,
                Result = result,
                Timestamp = DateTime.Now
            };

            _pendingOperator = null;
            _newDisplay = true;
            OnCalculationCompleted?.Invoke(record);
            OnDisplayChanged?.Invoke();

            return record;
        }
        catch (ArgumentException)
        {
            _display = "Error";
            _pendingOperator = null;
            _newDisplay = true;
            OnDisplayChanged?.Invoke();
            return null;
        }
    }

    /// <summary>Clears the calculator state.</summary>
    public void Clear()
    {
        _display = "0";
        _pendingOperand = 0;
        _pendingOperator = null;
        _newDisplay = true;
        OnDisplayChanged?.Invoke();
    }

    /// <summary>Replays a calculation from history.</summary>
    public void ReplayCalculation(CalculationRecord record)
    {
        _pendingOperand = record.FirstOperand;
        _pendingOperator = record.Operator;
        _display = record.SecondOperand.ToString();
        _newDisplay = false;
        OnDisplayChanged?.Invoke();
    }
}
