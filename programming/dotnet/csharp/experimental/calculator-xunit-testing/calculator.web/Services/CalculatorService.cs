using CalculatorApp;

namespace CalculatorWeb.Services;

/// <summary>
/// Service that manages calculator state and operations
/// </summary>
public class CalculatorService
{
    private double? _firstOperand;
    private double? _secondOperand;
    private string? _pendingOperation;
    private bool _shouldResetDisplay = false;
    private string _lastFirstOperand = "";
    private string _lastSecondOperand = "";

    /// <summary>
    /// Current display value
    /// </summary>
    public string Display { get; private set; } = "0";

    /// <summary>
    /// Event raised when the display changes
    /// </summary>
    public event Action? OnDisplayChanged;

    /// <summary>
    /// Event raised when a calculation is completed
    /// Parameters: operand1, operator, operand2, result
    /// </summary>
    public event Action<string, string, string, string>? OnCalculationCompleted;

    /// <summary>
    /// Handles number button clicks
    /// </summary>
    public void HandleNumberClick(string digit)
    {
        if (_shouldResetDisplay)
        {
            Display = digit == "." ? "0." : digit;
            _shouldResetDisplay = false;
        }
        else
        {
            if (digit == "." && Display.Contains("."))
                return;

            if (Display == "0" && digit != ".")
                Display = digit;
            else if (Display == "0" && digit == ".")
                Display = "0.";
            else
                Display += digit;
        }

        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Handles operator button clicks
    /// </summary>
    public void HandleOperatorClick(string op)
    {
        if (double.TryParse(Display, out double currentValue))
        {
            if (_firstOperand == null)
            {
                _firstOperand = currentValue;
                _lastFirstOperand = Display;
            }
            else if (!string.IsNullOrEmpty(_pendingOperation))
            {
                _secondOperand = currentValue;
                _lastSecondOperand = Display;
                PerformPendingOperation();
                _firstOperand = double.TryParse(Display, out double result) ? result : 0;
                _lastFirstOperand = Display;
                _secondOperand = null;
            }

            _pendingOperation = op;
            _shouldResetDisplay = true;
        }

        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Handles equals button click
    /// </summary>
    public void HandleEquals()
    {
        if (_firstOperand != null && !string.IsNullOrEmpty(_pendingOperation))
        {
            if (double.TryParse(Display, out double currentValue))
            {
                _secondOperand = currentValue;
                _lastSecondOperand = Display;
                PerformPendingOperation();
                
                // Raise event with calculation details for history
                OnCalculationCompleted?.Invoke(_lastFirstOperand, _pendingOperation, _lastSecondOperand, Display);
                
                _firstOperand = null;
                _pendingOperation = null;
                _shouldResetDisplay = true;
            }
        }

        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Handles clear button click
    /// </summary>
    public void HandleClear()
    {
        Display = "0";
        _firstOperand = null;
        _secondOperand = null;
        _pendingOperation = null;
        _shouldResetDisplay = false;
        _lastFirstOperand = "";
        _lastSecondOperand = "";
        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Performs the pending operation
    /// </summary>
    private void PerformPendingOperation()
    {
        if (_firstOperand == null || _secondOperand == null || string.IsNullOrEmpty(_pendingOperation))
            return;

        double result = Calculator.PerformCalculation(_firstOperand.Value, _pendingOperation, _secondOperand.Value);

        if (double.IsNaN(result))
        {
            Display = "Error";
        }
        else
        {
            Display = FormatResult(result);
        }
    }

    /// <summary>
    /// Formats the result for display
    /// </summary>
    private string FormatResult(double value)
    {
        if (double.IsInfinity(value) || double.IsNaN(value))
            return "Error";

        // Format to remove unnecessary trailing zeros
        string formatted = value.ToString("G15");
        if (formatted.Length > 12)
            formatted = formatted.Substring(0, 12) + "...";

        return formatted;
    }
}
