#nullable enable

namespace calculator.web.Services;

/// <summary>
/// Represents a single calculation entry in the history.
/// </summary>
public class CalculationRecord
{
    /// <summary>Gets the first operand.</summary>
    public double Operand1 { get; init; }

    /// <summary>Gets the second operand.</summary>
    public double Operand2 { get; init; }

    /// <summary>Gets the operator symbol.</summary>
    public string OperatorSymbol { get; init; } = string.Empty;

    /// <summary>Gets the calculation result.</summary>
    public double Result { get; init; }

    /// <summary>Gets the time of the calculation.</summary>
    public DateTime Timestamp { get; init; } = DateTime.Now;

    /// <summary>
    /// Returns a formatted display string for the history entry.
    /// </summary>
    public override string ToString()
    {
        string displayOp = OperatorSymbol switch
        {
            "/" => "÷",
            "*" => "×",
            "-" => "−",
            _ => OperatorSymbol
        };
        return $"{Operand1} {displayOp} {Operand2} = {Result} ({Timestamp:HH:mm:ss})";
    }
}

/// <summary>
/// Manages calculator state, display, and calculations using the Calculator library.
/// </summary>
public class CalculatorService
{
    private double? _pendingOperand;
    private string? _pendingOperator;
    private bool _resetOnNextInput;

    /// <summary>Gets the current display value.</summary>
    public string Display { get; private set; } = "0";

    /// <summary>Raised when the display value changes.</summary>
    public event Action? OnDisplayChanged;

    /// <summary>Raised when a calculation completes, providing the record.</summary>
    public event Action<CalculationRecord>? OnCalculationCompleted;

    /// <summary>
    /// Appends a digit or decimal point to the current display.
    /// </summary>
    /// <param name="input">A digit character (0-9) or decimal point (.)</param>
    public void InputDigit(string input)
    {
        if (_resetOnNextInput)
        {
            Display = input == "." ? "0." : input;
            _resetOnNextInput = false;
        }
        else if (Display == "0" && input != ".")
        {
            Display = input;
        }
        else if (input == "." && Display.Contains('.'))
        {
            return;
        }
        else
        {
            Display += input;
        }

        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Sets the pending operator for a chained calculation.
    /// If an operator is already pending, performs the intermediate calculation first.
    /// </summary>
    /// <param name="op">The operator symbol (+, -, *, /, ^)</param>
    public void InputOperator(string op)
    {
        if (_pendingOperand.HasValue && _pendingOperator != null && !_resetOnNextInput)
        {
            Calculate();
        }

        if (double.TryParse(Display, out double current))
        {
            _pendingOperand = current;
        }

        _pendingOperator = op;
        _resetOnNextInput = true;
    }

    /// <summary>
    /// Executes the pending calculation and updates the display with the result.
    /// </summary>
    public void Calculate()
    {
        if (!_pendingOperand.HasValue || _pendingOperator == null)
            return;

        if (!double.TryParse(Display, out double secondOperand))
            return;

        double firstOperand = _pendingOperand.Value;
        string operatorSymbol = _pendingOperator;

        try
        {
            double result = calculator.Calculator.Calculate(firstOperand, secondOperand, operatorSymbol);
            var record = new CalculationRecord
            {
                Operand1 = firstOperand,
                Operand2 = secondOperand,
                OperatorSymbol = operatorSymbol,
                Result = result,
                Timestamp = DateTime.Now
            };

            Display = result.ToString("G");
            _pendingOperand = null;
            _pendingOperator = null;
            _resetOnNextInput = true;

            OnDisplayChanged?.Invoke();
            OnCalculationCompleted?.Invoke(record);
        }
        catch (DivideByZeroException)
        {
            Display = "Error: Div/0";
            _pendingOperand = null;
            _pendingOperator = null;
            _resetOnNextInput = true;
            OnDisplayChanged?.Invoke();
        }
        catch (ArgumentException)
        {
            Display = "Error";
            _pendingOperand = null;
            _pendingOperator = null;
            _resetOnNextInput = true;
            OnDisplayChanged?.Invoke();
        }
    }

    /// <summary>
    /// Resets the calculator to its initial state.
    /// </summary>
    public void Clear()
    {
        Display = "0";
        _pendingOperand = null;
        _pendingOperator = null;
        _resetOnNextInput = false;
        OnDisplayChanged?.Invoke();
    }

    /// <summary>
    /// Loads a calculation record for replay, setting the display to its result.
    /// </summary>
    /// <param name="record">The calculation record to replay.</param>
    public void Replay(CalculationRecord record)
    {
        Clear();
        _pendingOperand = record.Operand1;
        _pendingOperator = record.OperatorSymbol;
        Display = record.Operand2.ToString("G");
        _resetOnNextInput = false;
        OnDisplayChanged?.Invoke();
        Calculate();
    }
}
