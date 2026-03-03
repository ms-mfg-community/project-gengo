---
name: dotnet-best-practices
description: "Best practices for .NET development — guidelines and conventions to ensure clean, maintainable, and efficient code in C# projects."
applyTo: '**/programming/dotnet/**/*.cs'
---

# .NET Best Practices (March 2026)

## Target Framework and C# Version

- **Minimum Target:** .NET 8 LTS (September 2024) or .NET 9 (November 2024)
- **C# Language Version:** C# 13 (latest, November 2024) or higher
- **Rationale:** Long-term support, modern language features, performance improvements, and security patches

```xml
<PropertyGroup>
  <TargetFramework>net9.0</TargetFramework>
  <LangVersion>latest</LangVersion>
  <Nullable>enable</Nullable>
  <ImplicitUsings>enable</ImplicitUsings>
  <PublishReadyToRun>true</PublishReadyToRun>
</PropertyGroup>
```

---

## Nullable Reference Types

**Always enable nullable reference types** (`#nullable enable` or in project file).

- Prevents null reference exceptions at compile time
- Use `?` to explicitly mark nullable types: `string?`, `List<User>?`
- Non-nullable is the default: `string` cannot be null
- Use `!` only when you're certain: `obj!.Property`

```csharp
#nullable enable

public class UserService
{
    public User? GetUserById(int id)
    {
        return _users.FirstOrDefault(u => u.Id == id);
    }

    public void UpdateUser(User user)
    {
        ArgumentNullException.ThrowIfNull(user, nameof(user));
        // Safe operations here
    }
}
```

---

## Implicit Usings

Enable `<ImplicitUsings>enable</ImplicitUsings>` in .csproj to reduce boilerplate:

- `System`, `System.Collections.Generic`, `System.Linq`, `System.Text` are automatic
- Web projects include `Microsoft.AspNetCore.Builder`, `Microsoft.AspNetCore.Routing`, etc.
- Define additional implicit usings in `GlobalUsings.cs`

```csharp
// GlobalUsings.cs
global using System.Diagnostics;
global using MyProject.Common;
global using MyProject.Domain.Models;
```

---

## Project Structure

Organize code by **feature/domain**, not by technical layer:

```
MyProject/
├── Features/
│   ├── Users/
│   │   ├── Models/
│   │   │   └── User.cs
│   │   ├── Services/
│   │   │   └── UserService.cs
│   │   ├── Handlers/
│   │   │   └── CreateUserHandler.cs
│   │   └── Tests/
│   │       └── UserServiceTests.cs
│   ├── Orders/
│   │   ├── Models/
│   │   ├── Services/
│   │   └── Tests/
├── Common/
│   ├── Exceptions/
│   ├── Extensions/
│   ├── Guards/
│   └── Utilities/
├── Infrastructure/
│   ├── Data/
│   ├── Cache/
│   └── Messaging/
└── Program.cs
```

---

## Naming Conventions

| Identifier | Convention | Example |
|-----------|-----------|---------|
| Namespace | PascalCase | `Company.Product.Feature.SubFeature` |
| Class/Record | PascalCase | `UserService`, `CreateUserCommand` |
| Interface | PascalCase with `I` prefix | `IUserRepository`, `IEmailSender` |
| Method | PascalCase | `GetUserById()`, `SendEmailAsync()` |
| Property | PascalCase | `FirstName`, `IsActive` |
| Parameter | camelCase | `userId`, `emailAddress` |
| Local variable | camelCase | `userName`, `isValid` |
| Constant | UPPER_CASE or PascalCase | `MAX_RETRIES` or `DefaultTimeout` |
| Private field | `_camelCase` | `_logger`, `_userRepository` |
| Generic type parameter | `T` or `TPascalCase` | `T`, `TEntity`, `TRequest` |

---

## Class and Record Definitions

### Use Records for DTOs and Value Objects

Records are immutable by default and provide value-based equality:

```csharp
public record CreateUserDto(string FirstName, string LastName, string Email);

public record UserResponse(int Id, string FirstName, string LastName);

// With validation
public record CreateUserCommand(string FirstName, string LastName)
{
    public CreateUserCommand(string firstName, string lastName) 
        : this(firstName, lastName)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(firstName, nameof(firstName));
        ArgumentException.ThrowIfNullOrWhiteSpace(lastName, nameof(lastName));
    }
}
```

### Use Classes for Domain Models and Services

```csharp
public class User
{
    public int Id { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public DateOnly CreatedDate { get; set; }
    
    public string GetFullName() => $"{FirstName} {LastName}";
}
```

---

## Documentation: XML Comments and Markdown

### For All Public Members

Use triple-slash (`///`) comments with proper `<param>`, `<returns>`, `<exception>`, and `<example>` tags:

```csharp
/// <summary>
/// Retrieves a user by their unique identifier.
/// </summary>
/// <param name="id">The unique identifier of the user to retrieve</param>
/// <returns>The user if found; otherwise null</returns>
/// <exception cref="ArgumentException">Thrown when id is less than 1</exception>
/// <example>
/// <code>
/// var userService = new UserService();
/// var user = await userService.GetUserByIdAsync(42);
/// if (user != null)
///     Console.WriteLine($"Found: {user.FirstName}");
/// </code>
/// </example>
public async Task<User?> GetUserByIdAsync(int id)
{
    if (id < 1)
        throw new ArgumentException("Id must be greater than 0", nameof(id));
    
    return await _userRepository.FindByIdAsync(id);
}
```

### Inline Comments

- Explain **why**, not **what**—code should be self-documenting
- Use `//` for single-line comments
- Use `/* */` rarely; prefer single-line comments

```csharp
// Cache invalidation strategy: Use time-based expiration 
// because the data updates hourly
var cacheOptions = new DistributedCacheEntryOptions()
    .SetAbsoluteExpiration(TimeSpan.FromHours(1));
```

---

## Input Validation and Error Handling

### Use Guard Clauses at Method Entry

```csharp
public void CreateUser(CreateUserDto dto)
{
    ArgumentNullException.ThrowIfNull(dto, nameof(dto));
    ArgumentException.ThrowIfNullOrWhiteSpace(dto.FirstName, nameof(dto.FirstName));
    ArgumentException.ThrowIfNullOrWhiteSpace(dto.Email, nameof(dto.Email));
    
    // Continue with business logic
    var user = new User { FirstName = dto.FirstName, Email = dto.Email };
    _userRepository.Add(user);
}
```

### Create Custom Exceptions for Domain-Specific Errors

```csharp
public class UserNotFoundException : Exception
{
    public int UserId { get; }
    
    public UserNotFoundException(int userId, string? message = null) 
        : base(message ?? $"User with ID {userId} not found")
    {
        UserId = userId;
    }
}

public class InvalidEmailException : ArgumentException
{
    public InvalidEmailException(string email) 
        : base($"Email '{email}' is not valid", nameof(email)) { }
}
```

### Avoid Catch-All Exception Handlers

```csharp
// ❌ Avoid
try { /* code */ }
catch (Exception ex) 
{ 
    Console.WriteLine("Error occurred");
}

// ✅ Good
try { /* code */ }
catch (UserNotFoundException ex)
{
    _logger.LogWarning("User not found: {UserId}", ex.UserId);
    throw;
}
catch (ArgumentException ex)
{
    _logger.LogError("Invalid argument: {Message}", ex.Message);
    throw;
}
```

---

## Asynchronous Programming

- **Always use `async`/`await`** for I/O-bound operations (database, HTTP, file I/O)
- Method names ending in `Async` must be async
- Return `Task` or `Task<T>`, not `void` (except event handlers)

```csharp
// ✅ Good
public async Task<User?> GetUserByIdAsync(int id)
{
    return await _dbContext.Users.FindAsync(id);
}

public async Task UpdateUserAsync(User user)
{
    ArgumentNullException.ThrowIfNull(user, nameof(user));
    await _dbContext.SaveChangesAsync();
}

// ❌ Avoid
public async void ProcessUserAsync(int id) // Fire-and-forget, hard to track
{
    await Task.Delay(1000);
}
```

### ConfigureAwait for Libraries

In libraries, use `ConfigureAwait(false)` to avoid unnecessary context switching:

```csharp
public async Task<User> GetUserAsync(int id)
{
    return await _httpClient.GetFromJsonAsync<User>($"/api/users/{id}")
        .ConfigureAwait(false) ?? throw new UserNotFoundException(id);
}
```

---

## Dependency Injection

- Register dependencies in `Program.cs` (ASP.NET Core) or a DI container
- Inject dependencies via constructor (not property or service locator)
- Use keyed registrations when multiple implementations exist

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddSingleton<ICache, MemoryCache>();

// Keyed registration
builder.Services.AddKeyedScoped<IEmailSender, SmtpEmailSender>("primary");
builder.Services.AddKeyedScoped<IEmailSender, LogEmailSender>("testing");

var app = builder.Build();
```

### Constructor Injection

```csharp
public class UserService
{
    private readonly IUserRepository _userRepository;
    private readonly IEmailSender _emailSender;
    private readonly ILogger<UserService> _logger;

    public UserService(
        IUserRepository userRepository, 
        IEmailSender emailSender,
        ILogger<UserService> logger)
    {
        _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
        _emailSender = emailSender ?? throw new ArgumentNullException(nameof(emailSender));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }

    public async Task<bool> CreateUserAsync(CreateUserDto dto)
    {
        var user = new User { FirstName = dto.FirstName, Email = dto.Email };
        await _userRepository.AddAsync(user);
        await _emailSender.SendWelcomeEmailAsync(user.Email);
        
        _logger.LogInformation("User created: {UserId}", user.Id);
        return true;
    }
}
```

---

## SOLID Principles

### Single Responsibility Principle (SRP)

Each class has one reason to change:

```csharp
// ✅ Good: Separate concerns
public class UserRepository : IUserRepository
{
    public async Task<User?> GetByIdAsync(int id) => 
        await _dbContext.Users.FindAsync(id);
}

public class UserValidator
{
    public void ValidateEmail(string email)
    {
        if (!email.Contains('@'))
            throw new InvalidEmailException(email);
    }
}

// ❌ Avoid: Mixed responsibilities
public class UserManager
{
    public User GetUser(int id) { /* database */ }
    public void SendEmail(string to) { /* SMTP */ }
    public bool ValidateEmail(string email) { /* regex */ }
}
```

### Open/Closed Principle (OCP)

Open for extension, closed for modification:

```csharp
public interface INotificationSender
{
    Task SendAsync(string message, string recipient);
}

public class EmailNotificationSender : INotificationSender
{
    public async Task SendAsync(string message, string recipient) =>
        await _smtpClient.SendMailAsync(recipient, "Notification", message);
}

public class SmsNotificationSender : INotificationSender
{
    public async Task SendAsync(string message, string recipient) =>
        await _twilioClient.SendSmsAsync(recipient, message);
}

// Extensible without modification
public class NotificationService
{
    private readonly INotificationSender _sender;
    
    public NotificationService(INotificationSender sender) => _sender = sender;
    
    public async Task NotifyUserAsync(string message, string recipient) =>
        await _sender.SendAsync(message, recipient);
}
```

### Liskov Substitution Principle (LSP)

Derived types must be substitutable for base types:

```csharp
// ✅ Good: All implementations behave consistently
public interface IRepository<T> where T : class
{
    Task<T?> GetByIdAsync(int id);
    Task AddAsync(T entity);
}

public class UserRepository : IRepository<User> { /* ... */ }
public class OrderRepository : IRepository<Order> { /* ... */ }
```

### Interface Segregation Principle (ISP)

Many client-specific interfaces beat one general-purpose interface:

```csharp
// ✅ Good: Fine-grained interfaces
public interface IUserReader
{
    Task<User?> GetByIdAsync(int id);
}

public interface IUserWriter
{
    Task AddAsync(User user);
    Task UpdateAsync(User user);
}

public interface IUserDeleter
{
    Task DeleteAsync(int id);
}

// Compose as needed
public interface IUserRepository : IUserReader, IUserWriter, IUserDeleter { }
```

### Dependency Inversion Principle (DIP)

Depend on abstractions, not concretions:

```csharp
// ❌ Avoid: Direct dependency on concrete class
public class UserService
{
    private readonly SqlUserRepository _repository = new();
}

// ✅ Good: Depend on interface
public class UserService
{
    private readonly IUserRepository _repository;
    
    public UserService(IUserRepository repository) =>
        _repository = repository;
}
```

---

## Collections and LINQ

- Prefer LINQ methods over loops
- Use `List<T>` for mutable collections, `IEnumerable<T>` for read-only sequences
- Chain LINQ methods fluently; add `.ToList()` or `.ToArrayAsync()` only when needed

```csharp
// ✅ Good
var activeUsers = await _userRepository.GetAllAsync()
    .Where(u => u.IsActive)
    .OrderBy(u => u.LastName)
    .ThenBy(u => u.FirstName)
    .Take(100)
    .ToListAsync();

// ✅ Good: Named queries for clarity
var eligibleUsersQuery = _dbContext.Users
    .Where(u => u.IsActive)
    .Where(u => u.CreatedDate > DateTime.UtcNow.AddYears(-1))
    .OrderByDescending(u => u.CreatedDate);

var count = await eligibleUsersQuery.CountAsync();
var users = await eligibleUsersQuery.Take(50).ToListAsync();
```

---

## Testing

### Use xUnit with AAA Pattern (Arrange-Act-Assert)

```csharp
public class UserServiceTests
{
    private readonly IUserRepository _mockRepository;
    private readonly UserService _service;

    public UserServiceTests()
    {
        _mockRepository = Substitute.For<IUserRepository>();
        _service = new UserService(_mockRepository);
    }

    [Fact]
    public async Task GetUserByIdAsync_WithValidId_ReturnsUser()
    {
        // Arrange
        var userId = 1;
        var expectedUser = new User { Id = userId, FirstName = "John" };
        _mockRepository.GetByIdAsync(userId).Returns(expectedUser);

        // Act
        var result = await _service.GetUserByIdAsync(userId);

        // Assert
        Assert.NotNull(result);
        Assert.Equal("John", result.FirstName);
        await _mockRepository.Received(1).GetByIdAsync(userId);
    }

    [Theory]
    [InlineData(0)]
    [InlineData(-1)]
    public async Task GetUserByIdAsync_WithInvalidId_ThrowsArgumentException(int id)
    {
        // Act & Assert
        await Assert.ThrowsAsync<ArgumentException>(() => _service.GetUserByIdAsync(id));
    }
}
```

### Test Naming Convention

Use `[UnitOfWork]_[Scenario]_[ExpectedResult]` or `Test[Method][Condition][Expectation]`:

```csharp
[Fact]
public void Add_WithTwoPositiveNumbers_ReturnsCorrectSum()

[Fact]
public void Divide_ByZero_ThrowsDivideByZeroException()

[Theory]
[InlineData("user@example.com", true)]
[InlineData("invalid-email", false)]
public void ValidateEmail_WithVariousInputs_ReturnsExpectedResult(string email, bool expected)
```

### Minimum Test Coverage

- Aim for **80% code coverage** on business logic
- **100% coverage** on critical paths (payment, authentication, data validation)
- Test happy path, edge cases, and error conditions

---

## Logging

- Use the built-in `ILogger<T>` from `Microsoft.Extensions.Logging`
- Structured logging with log levels: `LogDebug`, `LogInformation`, `LogWarning`, `LogError`, `LogCritical`
- Use named parameters for structured data

```csharp
private readonly ILogger<UserService> _logger;

public UserService(ILogger<UserService> logger) => _logger = logger;

public async Task CreateUserAsync(CreateUserDto dto)
{
    _logger.LogInformation("Creating user with email: {Email}", dto.Email);
    
    try
    {
        var user = new User { Email = dto.Email, FirstName = dto.FirstName };
        await _userRepository.AddAsync(user);
        _logger.LogInformation("User created successfully: {UserId}", user.Id);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Error creating user with email: {Email}", dto.Email);
        throw;
    }
}
```

---

## Performance

### Use ValueTask for Low-Latency Scenarios

```csharp
// For methods that are often synchronous
public class CachedUserService
{
    private readonly Dictionary<int, User> _cache = new();
    private readonly IUserRepository _repository;

    public ValueTask<User?> GetUserAsync(int id)
    {
        if (_cache.TryGetValue(id, out var user))
            return new ValueTask<User?>(user);

        return new ValueTask<User?>(FetchAndCacheAsync(id));
    }

    private async Task<User?> FetchAndCacheAsync(int id)
    {
        var user = await _repository.GetByIdAsync(id);
        if (user != null) _cache[id] = user;
        return user;
    }
}
```

### Avoid Allocations

```csharp
// ✅ Good: Reuse StringBuilder, avoid string concatenation in loops
var sb = new StringBuilder();
foreach (var user in users)
{
    sb.AppendLine($"{user.FirstName} {user.LastName}");
}
var result = sb.ToString();

// ❌ Avoid: String concatenation in loops allocates memory repeatedly
var result = "";
foreach (var user in users)
{
    result += $"{user.FirstName} {user.LastName}\n"; // Allocates new string each iteration
}
```

### Use Span<T> and Memory<T> for High-Performance Code

```csharp
public class DataProcessor
{
    public static void ProcessLargeBuffer(Memory<byte> buffer)
    {
        var span = buffer.Span;
        for (int i = 0; i < span.Length; i++)
        {
            span[i] = (byte)(span[i] * 2);
        }
    }
}
```

---

## Security

### Never Hardcode Secrets

```csharp
// ❌ Bad: Secrets in code
var connectionString = "Server=prod.database.com;Password=SuperSecret123";

// ✅ Good: Use configuration or Key Vault
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// ✅ Good: Azure Key Vault with Managed Identity
builder.Configuration.AddAzureKeyVault(
    new Uri($"https://{builder.Configuration["KeyVaultName"]}.vault.azure.net/"),
    new DefaultAzureCredential());
```

### Validate All Input

```csharp
public class UserController
{
    [HttpPost]
    public async Task<IActionResult> CreateUser([FromBody] CreateUserDto dto)
    {
        // Automatic validation from data annotations
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var result = await _userService.CreateUserAsync(dto);
        return Ok(result);
    }
}

public record CreateUserDto(
    [EmailAddress] string Email,
    [StringLength(100, MinimumLength = 1)] string FirstName);
```

### Use HTTPS and CORS Correctly

```csharp
// Program.cs
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin", corsBuilder =>
    {
        corsBuilder
            .WithOrigins("https://trusted-domain.com")
            .AllowAnyMethod()
            .AllowCredentials();
    });
});

app.UseHttpsRedirection();
app.UseCors("AllowSpecificOrigin");
```

### Implement Proper Authentication and Authorization

```csharp
// Use built-in authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = builder.Configuration["Authority"];
        options.Audience = builder.Configuration["Audience"];
    });

builder.Services.AddAuthorization();

// In controller
[Authorize(Roles = "Admin")]
[HttpDelete("{id}")]
public async Task<IActionResult> DeleteUser(int id) => 
    Ok(await _userService.DeleteUserAsync(id));
```

---

## Entity Framework Core Patterns

### Use DbContext Correctly

```csharp
public class ApplicationDbContext : DbContext
{
    public DbSet<User> Users { get; set; } = null!;
    public DbSet<Order> Orders { get; set; } = null!;

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) 
        : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configure entity relationships
        modelBuilder.Entity<Order>()
            .HasOne(o => o.User)
            .WithMany(u => u.Orders)
            .HasForeignKey(o => o.UserId);

        // Add data annotations
        modelBuilder.Entity<User>()
            .Property(u => u.Email)
            .IsRequired()
            .HasMaxLength(256);
    }
}
```

### Use Repository Pattern for Data Access (Optional but Recommended)

```csharp
public interface IUserRepository
{
    Task<User?> GetByIdAsync(int id);
    Task<List<User>> GetAllAsync();
    Task AddAsync(User user);
    Task UpdateAsync(User user);
    Task DeleteAsync(int id);
}

public class UserRepository : IUserRepository
{
    private readonly ApplicationDbContext _context;

    public UserRepository(ApplicationDbContext context) => _context = context;

    public async Task<User?> GetByIdAsync(int id) =>
        await _context.Users.FindAsync(id);

    public async Task AddAsync(User user)
    {
        _context.Users.Add(user);
        await _context.SaveChangesAsync();
    }
}
```

### Avoid N+1 Query Problems

```csharp
// ❌ N+1 Problem: Separate database round trips
var users = _context.Users.ToList();
foreach (var user in users)
{
    var orders = _context.Orders.Where(o => o.UserId == user.Id).ToList();
}

// ✅ Good: Eager load with Include
var users = await _context.Users
    .Include(u => u.Orders)
    .ToListAsync();

// ✅ Good: Use Select for specific data
var userOrders = await _context.Users
    .Where(u => u.IsActive)
    .Select(u => new { u.Id, u.Email, OrderCount = u.Orders.Count })
    .ToListAsync();
```

---

## Code Style and Formatting

### Use EditorConfig

Create `.editorconfig` in repository root:

```ini
root = true

[*.cs]
indent_style = space
indent_size = 4
end_of_line = crlf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

# Naming conventions
dotnet_naming_style.pascal_case_style.capitalization = pascal_case
dotnet_naming_style.camel_case_style.capitalization = camel_case

# C# code style
csharp_prefer_braces = true:suggestion
csharp_prefer_simple_using_statement = true:suggestion
csharp_style_pattern_matching_over_is_with_cast_check = true:suggestion
```

### Use C# 13 Features

```csharp
// Collection Expressions (C# 12+)
int[] numbers = [1, 2, 3, 4, 5];
List<string> names = ["Alice", "Bob", "Charlie"];

// Primary Constructor (C# 12+)
public record UserResponse(int Id, string FirstName, string LastName);
public class UserHandler(IUserRepository repository) 
{
    public async Task Handle() => await repository.GetAllAsync();
}

// Init-Only Properties (C# 9+)
public class User
{
    public int Id { get; init; }
    public string Email { get; init; } = null!;
}

// Required Members (C# 11+)
public class Order
{
    public required int Id { get; init; }
    public required DateTime CreatedDate { get; init; }
}

// File-Scoped Types (C# 11+)
file class InternalHelper { /* ... */ }
```

---

## API Design

### RESTful Conventions

```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService) => _userService = userService;

    /// <summary>Retrieves all users with pagination</summary>
    [HttpGet]
    [ProducesResponseType(typeof(PagedResult<UserResponse>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetUsers([FromQuery] int page = 1, [FromQuery] int pageSize = 10)
    {
        var users = await _userService.GetUsersAsync(page, pageSize);
        return Ok(users);
    }

    /// <summary>Retrieves a user by ID</summary>
    [HttpGet("{id}")]
    [ProducesResponseType(typeof(UserResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetUser(int id)
    {
        var user = await _userService.GetUserByIdAsync(id);
        if (user is null)
            return NotFound();

        return Ok(user);
    }

    /// <summary>Creates a new user</summary>
    [HttpPost]
    [ProducesResponseType(typeof(UserResponse), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> CreateUser([FromBody] CreateUserDto dto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var result = await _userService.CreateUserAsync(dto);
        return CreatedAtAction(nameof(GetUser), new { id = result.Id }, result);
    }

    /// <summary>Updates an existing user</summary>
    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UpdateUser(int id, [FromBody] UpdateUserDto dto)
    {
        await _userService.UpdateUserAsync(id, dto);
        return NoContent();
    }

    /// <summary>Deletes a user</summary>
    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _userService.DeleteUserAsync(id);
        return NoContent();
    }
}
```

### Problem Details for Error Responses (RFC 7807)

```csharp
// Configure in Program.cs
builder.Services.AddProblemDetails(options =>
{
    options.CustomizeResponse = context =>
    {
        context.ProblemDetails.Instance = $"{context.HttpContext.Request.Method} {context.HttpContext.Request.Path}";
    };
});

// Exception handling middleware
app.UseExceptionHandler();
app.UseStatusCodePages();
```

---

## Configuration Management

### Use Strong-Typed Options Pattern

```csharp
public class DatabaseOptions
{
    public const string Section = "Database";
    
    public string ConnectionString { get; set; } = null!;
    public int CommandTimeout { get; set; } = 30;
    public bool LazyLoadingEnabled { get; set; } = false;
}

// Program.cs
var builder = WebApplication.CreateBuilder(args);
builder.Services.Configure<DatabaseOptions>(
    builder.Configuration.GetSection(DatabaseOptions.Section));

// Usage in service
public class UserRepository
{
    private readonly DatabaseOptions _options;
    private readonly IOptions<DatabaseOptions> _optionsSnapshot;

    public UserRepository(IOptions<DatabaseOptions> options)
    {
        _options = options.Value;
        _optionsSnapshot = options;
    }
}
```

---

## Health Checks

```csharp
// Program.cs
builder.Services
    .AddHealthChecks()
    .AddSqlServer(builder.Configuration.GetConnectionString("Default")!)
    .AddHttpHealthCheck("https://api.example.com/health")
    .AddMemoryHealthCheck();

app.MapHealthChecks("/health");
app.MapHealthChecks("/health/detailed", new HealthCheckOptions
{
    ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
});
```

---

## Source Link and Debugging

Enable source link in `.csproj`:

```xml
<PropertyGroup>
  <PublishRepositoryUrl>true</PublishRepositoryUrl>
  <IncludeSymbols>true</IncludeSymbols>
  <SymbolPackageFormat>snupkg</SymbolPackageFormat>
</PropertyGroup>
```

---

## GitHub Actions CI/CD

### Build and Test Workflow

```yaml
name: .NET CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        dotnet-version: ['8.0.x', '9.0.x']

    steps:
      - uses: actions/checkout@v4
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: ${{ matrix.dotnet-version }}
      
      - name: Restore dependencies
        run: dotnet restore
      
      - name: Build
        run: dotnet build --no-restore --configuration Release
      
      - name: Run tests
        run: dotnet test --no-build --verbosity normal --logger "trx;LogFileName=test-results.trx"
      
      - name: Publish test results
        if: always()
        uses: EnricoMi/publish-unit-test-result-action@v2
        with:
          files: '**/test-results.trx'
```

---

## Code Review Checklist

- [ ] Follows naming conventions
- [ ] Nullable reference types enabled
- [ ] Error handling with specific exceptions
- [ ] Async/await used for I/O operations
- [ ] Dependencies injected via constructor
- [ ] Public methods documented with XML comments
- [ ] Unit tests included with 80%+ coverage
- [ ] No hardcoded secrets or sensitive data
- [ ] SOLID principles applied
- [ ] Performance considerations addressed
- [ ] Logging implemented where appropriate
- [ ] No console.log or Debug.WriteLine left in code

---

## Resources and References

- [Microsoft C# Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [Framework Design Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/)
- [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/)
- [ASP.NET Core Best Practices](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/best-practices)
- [Microsoft Secure Coding Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/security/)
