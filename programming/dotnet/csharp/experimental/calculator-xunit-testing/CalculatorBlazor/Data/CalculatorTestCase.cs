using System.ComponentModel.DataAnnotations;

namespace CalculatorBlazor.Data;

/// <summary>
/// Entity representing a calculator test case stored in the database.
/// </summary>
public class CalculatorTestCase
{
    /// <summary>
    /// Gets or sets the unique identifier for the test case.
    /// </summary>
    [Key]
    public int Id { get; set; }

    /// <summary>
    /// Gets or sets the first number in the calculation.
    /// </summary>
    public double FirstNumber { get; set; }

    /// <summary>
    /// Gets or sets the second number in the calculation.
    /// </summary>
    public double SecondNumber { get; set; }

    /// <summary>
    /// Gets or sets the operation to perform (Add, Subtract, Multiply, Divide, Modulo, Exponent).
    /// </summary>
    [Required]
    [MaxLength(50)]
    public string Operation { get; set; } = string.Empty;

    /// <summary>
    /// Gets or sets the expected result of the calculation.
    /// </summary>
    public double ExpectedValue { get; set; }

    /// <summary>
    /// Gets or sets the description of the test case.
    /// </summary>
    [Required]
    [MaxLength(200)]
    public string Description { get; set; } = string.Empty;

    /// <summary>
    /// Gets or sets the actual calculated value (used at runtime).
    /// </summary>
    public double? ActualValue { get; set; }

    /// <summary>
    /// Gets or sets the test result status (pending, passed, failed).
    /// </summary>
    [MaxLength(20)]
    public string Result { get; set; } = "pending";
} // end class CalculatorTestCase
