namespace calculator.web.Models;

/// <summary>Represents a calculation record for history tracking.</summary>
public class CalculationRecord
{
    /// <summary>The first operand in the calculation.</summary>
    public double FirstOperand { get; set; }

    /// <summary>The second operand in the calculation.</summary>
    public double SecondOperand { get; set; }

    /// <summary>The operator used in the calculation.</summary>
    public string Operator { get; set; } = string.Empty;

    /// <summary>The result of the calculation.</summary>
    public double Result { get; set; }

    /// <summary>The timestamp when the calculation was performed.</summary>
    public DateTime Timestamp { get; set; }

    /// <summary>Gets a formatted display string for the calculation.</summary>
    public string DisplayText => $"{FirstOperand} {Operator} {SecondOperand} = {Result}";

    /// <summary>Gets the formatted time string.</summary>
    public string TimeString => Timestamp.ToString("HH:mm:ss");
}
