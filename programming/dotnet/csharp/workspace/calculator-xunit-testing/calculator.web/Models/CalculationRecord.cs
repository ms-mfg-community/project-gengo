namespace CalculatorWeb.Models;

/// <summary>
/// Represents a single calculation record in the history
/// </summary>
public class CalculationRecord
{
    /// <summary>
    /// First operand of the calculation
    /// </summary>
    public string Operand1 { get; set; } = string.Empty;

    /// <summary>
    /// Operator used (+, -, *, /, %, ^)
    /// </summary>
    public string Operator { get; set; } = string.Empty;

    /// <summary>
    /// Second operand of the calculation
    /// </summary>
    public string Operand2 { get; set; } = string.Empty;

    /// <summary>
    /// Result of the calculation
    /// </summary>
    public string Result { get; set; } = string.Empty;

    /// <summary>
    /// Timestamp when the calculation was performed
    /// </summary>
    public DateTime Timestamp { get; set; }

    /// <summary>
    /// Formatted display string for the calculation
    /// Format: "5 + 3 = 8 (2:45 PM)"
    /// </summary>
    public string DisplayText =>
        $"{Operand1} {Operator} {Operand2} = {Result} ({Timestamp:h:mm tt})";
}
