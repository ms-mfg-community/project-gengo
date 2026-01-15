using Microsoft.EntityFrameworkCore;

namespace CalculatorBlazor.Data;

/// <summary>
/// Database context for the Calculator application.
/// </summary>
public class CalculatorDbContext : DbContext
{
    /// <summary>
    /// Initializes a new instance of the <see cref="CalculatorDbContext"/> class.
    /// </summary>
    /// <param name="options">The options for this context.</param>
    public CalculatorDbContext(DbContextOptions<CalculatorDbContext> options)
        : base(options)
    {
    } // end constructor

    /// <summary>
    /// Gets or sets the test cases.
    /// </summary>
    public DbSet<CalculatorTestCase> TestCases { get; set; } = null!;

    /// <summary>
    /// Configures the model that was discovered by convention from the entity types.
    /// </summary>
    /// <param name="modelBuilder">The builder being used to construct the model for this context.</param>
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configure the table name
        modelBuilder.Entity<CalculatorTestCase>()
            .ToTable("CalculatorTestCases");

        // Configure indexes for common queries
        modelBuilder.Entity<CalculatorTestCase>()
            .HasIndex(t => t.Operation);

        modelBuilder.Entity<CalculatorTestCase>()
            .HasIndex(t => t.Result);
    } // end OnModelCreating
} // end class CalculatorDbContext
