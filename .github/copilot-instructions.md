---
applyTo: '**'
---

# GitHub Copilot Instructions for Project Gengo

**Version:** 1.0  
**Last Updated:** February 2026  
**Repository:** [project-gengo](https://github.com/ms-mfg-community/project-gengo)

## Overview

Project Gengo is a comprehensive, multi-technology learning repository demonstrating best practices across programming languages, frameworks, cloud platforms, and DevOps. These instructions guide GitHub Copilot to maintain consistency, quality, and alignment with project standards.

---

## Core Principles

### 1. **Content-Rich Documentation**
- Always include comprehensive context about technology stacks, constraints, and architectural patterns
- Provide examples and references to existing code patterns in the repository
- Document assumptions, dependencies, and edge cases
- Include helpful inline comments explaining non-trivial logic

### 2. **Intent Clarity**
- Start with explicit action verbs: create, refactor, debug, explain, optimize, test, document
- Specify deliverable types: function, class, test suite, configuration file, workflow, script
- Include success criteria and expected outcomes
- Reference the business context and requirements

### 3. **Structured Communication**
- Use bullet points or numbered lists for multiple requirements
- Organize complex requests into sections (Context, Intent, Requirements)
- Avoid ambiguous pronouns (it, this, that) without clear antecedents
- Focus on one primary task per prompt (with sub-tasks allowed)

### 4. **Specificity in Requirements**
- Include exact names for functions, variables, files, and classes
- Specify data types, return types, and format requirements
- Provide numeric constraints (max length, timeout values, retry counts)
- Reference library versions and technology versions

---

## Programming Standards

### Function Writing

When writing functions, always:

- Add descriptive JSDoc/XML/docstring comments with parameters, returns, and exceptions
- Include meaningful inline comments for complex logic
- Use input validation with early returns for error conditions
- Implement meaningful variable names (avoid single letters except in loops)
- Include at least one example usage in comments
- Keep functions focused on a single responsibility (aim for < 50 lines)
- Add error handling appropriate to the context

**Example Pattern (C#):**

```csharp
/// <summary>
/// Validates and processes user input data.
/// </summary>
/// <param name="data">The input data to validate</param>
/// <returns>Validated and sanitized data</returns>
/// <exception cref="ArgumentNullException">Thrown when data is null</exception>
/// <exception cref="ArgumentException">Thrown when validation fails</exception>
/// 
/// <example>
/// <code>
/// var result = ValidateUserData(new UserData { Email = "user@example.com", Age = 25 });
/// Console.WriteLine(result.Email); // user@example.com
/// </code>
/// </example>
public UserData ValidateUserData(UserData data)
{
    // Input validation
    if (data == null) throw new ArgumentNullException(nameof(data));
    if (string.IsNullOrWhiteSpace(data.Email)) 
        throw new ArgumentException("Valid email is required", nameof(data.Email));
    
    // Early return for error conditions
    if (data.Age < 18) 
        throw new ArgumentException("User must be 18 or older", nameof(data.Age));
    
    return new UserData 
    { 
        Email = data.Email.ToLower(), 
        Age = data.Age 
    };
}
```

### Code Organization

- **File Size:** Keep files focused; aim for 100-200 lines per file
- **Naming Conventions:** Use PascalCase for classes, camelCase for functions/variables, UPPER_CASE for constants
- **Module Structure:** One primary export per file when possible
- **Comments:** Use inline comments for "why", not "what"; code should be self-documenting
- **Spacing:** Add blank lines between logical sections
- **Visibility:** Use appropriate access modifiers (private by default, public only when necessary)

### Testing Approach

- Write tests alongside implementation (Test-Driven Development preferred)
- Use language-appropriate testing frameworks (xUnit for .NET, Jest for JavaScript, pytest for Python, JUnit for Java)
- Test naming: `test[FunctionName][Scenario][ExpectedBehavior]` or `[UnitOfWork]_[Scenario]_[ExpectedBehavior]`
- Include edge cases, error conditions, and happy paths
- Aim for minimum 80% code coverage on critical paths

**Example Test Pattern (C#/xUnit):**

```csharp
public class CalculatorTests
{
    private readonly Calculator _calculator = new();

    [Fact]
    public void Add_WithPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        int a = 5;
        int b = 3;
        int expected = 8;

        // Act
        int result = _calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        int dividend = 10;
        int divisor = 0;

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => 
            _calculator.Divide(dividend, divisor));
    }
}
```

---

## Repository-Specific Guidelines

### Multi-Language Support

The repository spans multiple programming languages. When generating code:

- **C/C++:** Use CMake for builds, follow modern C++17+ standards, include header guards or pragma once
- **.NET/C#:** Target .NET 6+, use nullable reference types (`#nullable enable`), follow Microsoft naming conventions
- **Python:** Follow PEP 8, use type hints, target Python 3.8+, use virtual environments
- **TypeScript:** Use strict mode, target ES2020+, include full type definitions, avoid `any` type
- **Java:** Use Maven, follow Java naming conventions, include Javadoc, target Java 11+
- **JavaScript:** Use ES6+ features, include JSDoc comments, use meaningful variable names
- **Go:** Follow `gofmt` conventions, use error wrapping, implement interfaces explicitly
- **PowerShell:** Use PascalCase for functions, place opening braces on new line, include proper error handling

### CI/CD and Workflow Conventions

When creating GitHub Actions workflows or Azure Pipelines:

- **Naming:** Use descriptive, kebab-case names (e.g., `build-and-test-dotnet`)
- **Structure:** Organize jobs logically, use job dependencies (`needs:` in Actions)
- **Documentation:** Add comments explaining triggers, conditions, and special steps
- **Security:** Never hardcode secrets; always use `secrets.` or environment variables
- **Cross-Platform:** Test scripts on both Windows (PowerShell) and Linux (Bash) when applicable
- **Reusability:** Extract common steps into reusable workflows or composite actions
- **Logging:** Add meaningful log messages at each step with `echo` or `Write-Host`
- **Versioning:** Pin action versions for reproducibility (e.g., `actions/checkout@v4`)

**Workflow Structure Example:**

```yaml
name: Build and Test
on:
  push:
    branches: [main, develop]
    paths-ignore: ['.github/**', 'docs/**']
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup environment
        run: |
          echo "Setting up build environment..."
          # Setup commands here
      
      - name: Build application
        run: dotnet build
        
      - name: Run tests
        run: dotnet test --verbosity normal
```

### Infrastructure as Code (IaC)

When writing Bicep, ARM templates, or Terraform:

- **Naming:** Use descriptive names following Azure naming conventions (e.g., `rg-${environment}-${project}`)
- **Parameters:** Include descriptions, metadata, and validation rules
- **Modularization:** Create separate files for logical components
- **Documentation:** Include comments explaining resource purposes and configurations
- **Security:** Use parameterized secrets, enable diagnostics logging, implement least-privilege access
- **Best Practices:** Implement consistent tagging strategy, use minimal RBAC permissions, enable monitoring
- **Testing:** Validate templates with `az deployment` or `terraform plan` before deployment

### Documentation Standards

- **Format:** Use Markdown with proper heading hierarchy (H1 > H2 > H3)
- **Structure:** Start with overview, then detailed sections, code examples, and references
- **Links:** Use relative paths for internal links; include external links with descriptions
- **Code Examples:** Include language identifier in code blocks (e.g., ` ```csharp `)
- **Tables:** Use for structured information comparisons
- **Lists:** Use bullet points for unordered information, numbered lists for procedures
- **PRDs:** Follow the established Product Requirements Document template:
  - Executive Summary
  - Problem Statement / Context
  - Goals and Objectives
  - Functional Requirements
  - Non-Functional Requirements
  - Implementation Guidance
  - Testing Requirements
  - Success Criteria

---

## Pull Request Guidelines

### PR Description Template

When creating pull requests, use this structure:

```markdown
## What changed
[Clear summary of modifications and affected components]
[Link to related issues or tickets]

## Why
[Business context and requirements]
[Technical reasoning for approach taken]

## Testing
- [ ] Unit tests pass and cover new functionality
- [ ] Manual testing completed for user-facing changes
- [ ] Performance/security considerations addressed

## Breaking Changes
[List any API changes or behavioral modifications]
[Include migration instructions if needed]

## Checklist
- [ ] Code follows project style guidelines
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Added tests for new functionality
- [ ] All tests passing locally
```

### Code Review Focus

When requesting code reviews, emphasize:

- **Security:** Input validation, authentication, authorization, data handling, secret management
- **Performance:** Algorithmic complexity, database queries, caching strategies, memory usage
- **Testing:** Code coverage, edge cases, error scenarios, integration tests
- **Documentation:** Comments, README updates, inline documentation, examples
- **Maintainability:** Readability, DRY principle, SOLID principles, separation of concerns

---

## Prompt Templates

### For Initial Project Setup

```
I need to create a [LANGUAGE] project in the project-gengo repository. Please help me:

Context:
- Technology: [Framework/Library and versions]
- Purpose: [What this project demonstrates]
- Existing patterns: [Reference similar projects in the repo]

Please provide:
1. Project structure following repository conventions
2. Configuration files (.gitignore, build config, etc.)
3. README with setup and build instructions
4. Basic example demonstrating core functionality
5. Initial test structure with one sample test
6. Comprehensive inline comments and documentation

Constraints:
- Target location: [path/to/project]
- Follow [language] style guide and conventions
- Include JSDoc/docstring comments for all public members
```

### For Code Generation

```
Generate a [DELIVERABLE TYPE] that [PRIMARY PURPOSE].

Requirements:
1. [Specific requirement with details]
2. [Specific requirement with details]
3. [Error handling and validation requirement]

Context:
- Technology stack: [List versions and frameworks]
- Pattern reference: [Point to existing file or pattern to match]
- File location: [path/to/file.ext]
- Related functionality: [Existing related code]

Success criteria:
- Includes comprehensive documentation/comments
- Has input validation and error handling
- Follows repository naming conventions
- Includes at least one usage example
- Ready for production use
- Minimum 80% test coverage
```

### For Bug Fixes

```
I'm encountering a bug in [FILE/COMPONENT]:

Error message: [Exact error or stack trace]
Expected behavior: [What should happen]
Actual behavior: [What is happening]

Steps to reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Context:
- Environment: [OS, runtime versions]
- Affected code: [Reference specific lines or methods]
- Related issues: [Links to issues if applicable]

Please help me:
1. Analyze the root cause with specific examples
2. Suggest fixes with complete code examples
3. Explain the solution and why it works
4. Recommend preventative measures and tests
```

### For Workflow/Pipeline Creation

```
Create a [GitHub Actions/Azure Pipeline] workflow for [PURPOSE].

Triggers:
- On: [push/pull_request/schedule/workflow_dispatch]
- Branches: [branch patterns]
- Paths: [path filters if applicable]

Environment:
- Runs on: [ubuntu-latest/windows-latest/custom]
- Variables: [Required env vars and secrets]
- Permissions: [Required permissions]

Steps needed:
1. [Checkout]
2. [Setup runtime/dependencies]
3. [Build]
4. [Test]
5. [Report/Deploy if applicable]

Considerations:
- Cross-platform compatibility: [yes/no]
- Artifact handling: [What artifacts to save]
- Status badges: [Required]
- Error handling: [Retry logic, failure notifications]

Include:
- Clear comments for each section
- Meaningful status messages
- Proper error handling
- Conditional steps where appropriate
```

---

## Quality Metrics

### Code Quality Standards

- **Maintainability:** Code should be readable by new team members within 15 minutes
- **Test Coverage:** Minimum 80% coverage on critical paths; aim for 100% on business logic
- **Documentation:** All public APIs documented; complex logic explained in comments
- **Performance:** Build times < 5 minutes; deployment times < 10 minutes
- **Security:** No hardcoded secrets; validated inputs; proper error handling; no sensitive data in logs
- **Complexity:** Cyclomatic complexity < 10 per function; aim for < 5

### Pre-Submission Checklist

Before submitting code for review, verify:

- [ ] Follows language-specific style guide
- [ ] Includes comprehensive comments and JSDoc/docstrings
- [ ] All tests pass locally (`dotnet test`, `npm test`, `pytest`, etc.)
- [ ] No security vulnerabilities (no hardcoded secrets, input validation)
- [ ] Error handling implemented appropriately
- [ ] Performance impact assessed and acceptable
- [ ] PR description follows template and is descriptive
- [ ] Commit messages are clear and follow conventions (`verb: description`)
- [ ] No console.log/Debug.WriteLine left in code
- [ ] No commented-out code blocks

---

## Special Instructions by Technology

### .NET/C# Projects

- Use `#nullable enable` at the top of all files
- Follow Microsoft naming conventions (PascalCase for public members, camelCase for parameters)
- Include XML documentation comments (`///`) for all public members
- Use xUnit for testing
- Target .NET 6 or higher (use latest LTS)
- Implement dependency injection where applicable
- Use async/await for I/O operations
- Structure: `namespace Project.Category.Subcategory { ... }`

**Example:**

```csharp
#nullable enable

namespace Project.Calculator
{
    /// <summary>
    /// Provides basic arithmetic operations.
    /// </summary>
    public class ArithmeticCalculator
    {
        /// <summary>
        /// Calculates the sum of two numbers.
        /// </summary>
        /// <param name="a">First number</param>
        /// <param name="b">Second number</param>
        /// <returns>The sum of a and b</returns>
        /// <exception cref="OverflowException">Thrown when result overflows</exception>
        public int Add(int a, int b)
        {
            return checked(a + b);
        }
    }
}
```

### PowerShell Scripts

- Place opening braces `{` on new line
- Use PascalCase for function and parameter names
- Add comment blocks at end of control structures (`# end if`, `# end function`)
- Use proper parameter validation with `[Parameter(Mandatory=$true)]`
- Include detailed comments for non-trivial logic
- Use proper error handling with try-catch-finally
- Compatible with PowerShell 5.1+ and PowerShell Core 7+
- Use `Set-StrictMode -Version Latest` at script top

**Example:**

```powershell
#Requires -Version 5.1
Set-StrictMode -Version Latest

<#
.SYNOPSIS
    Demonstrates proper PowerShell function structure.
.DESCRIPTION
    This function performs validation and logging.
.PARAMETER InputValue
    The value to process.
.PARAMETER Verbose
    Enable verbose output.
.EXAMPLE
    Invoke-Processing -InputValue "test" -Verbose
#>
function Invoke-Processing
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$InputValue,
        
        [switch]$Verbose
    )
    
    process
    {
        try
        {
            Write-Host "Processing: $InputValue"
            # Implementation here
            
            if ($Verbose)
            {
                Write-Verbose "Detailed processing information"
            }
        }
        catch
        {
            Write-Error "Error occurred: $_"
            throw
        }
    }
    # end process
}
# end function
```

### Python Projects

- Follow PEP 8 conventions rigorously
- Use type hints for all function parameters and return values
- Include docstrings in Google format for all functions
- Use pytest for testing with fixtures where appropriate
- Target Python 3.8+
- Use virtual environments for dependency isolation
- Use logging module instead of print() for production code
- Structure: `from typing import List, Dict, Optional`

**Example:**

```python
"""Calculator module for basic arithmetic operations."""

from typing import Union

def calculate_average(values: list[float]) -> float:
    """Calculate the average of a list of values.
    
    Args:
        values: A list of numeric values to average.
        
    Returns:
        The arithmetic mean of the values.
        
    Raises:
        ValueError: If the list is empty.
        TypeError: If values contain non-numeric types.
        
    Example:
        >>> calculate_average([1.0, 2.0, 3.0])
        2.0
    """
    if not values:
        raise ValueError("Values list cannot be empty")
    
    total = sum(values)
    return total / len(values)
```

### TypeScript/React Projects

- Use `strict: true` in tsconfig.json
- Include full type definitions (never use `any`)
- Use functional components with hooks exclusively
- Include JSDoc comments for components and utilities
- Use absolute imports from configured tsconfig paths
- Implement proper error boundaries for error handling
- Use React.memo for performance optimization when appropriate
- File structure: components in Components/, hooks in hooks/, utils in utils/

**Example:**

```typescript
/**
 * UserProfile component displays user information.
 * 
 * @param userId - The unique identifier for the user
 * @returns The rendered user profile component
 * @throws Error if userId is invalid
 * 
 * @example
 * ```tsx
 * <UserProfile userId="123" />
 * ```
 */
export function UserProfile({ userId }: { userId: string }): JSX.Element {
  const [user, setUser] = React.useState<User | null>(null);
  const [error, setError] = React.useState<Error | null>(null);
  
  React.useEffect(() => {
    if (!userId || userId.trim() === "") {
      setError(new Error("userId is required"));
      return;
    }
    
    // Load user data
    loadUser(userId).catch(setError);
  }, [userId]);
  
  if (error) return <ErrorBoundary error={error} />;
  if (!user) return <LoadingSpinner />;
  
  return <div className="user-profile">{/* Component JSX */}</div>;
}
```

### Java Projects

- Use Maven for dependency management
- Follow Java naming conventions (PascalCase for classes, camelCase for methods)
- Include Javadoc comments (`/** ... */`) for all public methods and classes
- Use JUnit 5 for testing with descriptive test names
- Target Java 11+
- Use try-with-resources for resource management
- Implement proper exception handling with custom exceptions
- Structure: `com.company.project.module.submodule`

**Example:**

```java
package com.project.calculator;

/**
 * Provides basic arithmetic operations.
 * 
 * @author Project Gengo
 * @version 1.0
 */
public class ArithmeticCalculator {
    
    /**
     * Calculates the sum of two numbers.
     * 
     * @param a the first number
     * @param b the second number
     * @return the sum of a and b
     * @throws ArithmeticException if the result overflows
     */
    public int add(int a, int b) throws ArithmeticException {
        if (a > 0 && b > Integer.MAX_VALUE - a) {
            throw new ArithmeticException("Integer overflow");
        }
        return a + b;
    }
}
```

---

## Common Patterns in Project Gengo

### Pattern 1: Calculator Applications

The repository includes multiple calculator implementations across languages. When extending:

- Maintain consistent operation interface (Add, Subtract, Multiply, Divide, Modulo, Power)
- Include input validation with meaningful error messages
- Support multiple interfaces (CLI, GUI, API/Web)
- Include comprehensive unit tests covering all operations
- Document supported number ranges and precision limitations
- Example locations: `programming/dotnet/`, `programming/java/`, `programming/python/`

### Pattern 2: CI/CD Workflows

Workflows follow a consistent pattern:

- **Event triggers:** push, pull_request, schedule, manual dispatch
- **Job structure:** Separate build, test, and optional deploy jobs
- **Variables:** Environment-specific configurations and secrets management
- **Artifacts:** Store build outputs, test reports, coverage reports
- **Notifications:** Status updates to team channels when appropriate
- **Concurrency:** Use concurrency groups to cancel in-progress runs
- Workflow locations: `.github/workflows/`

### Pattern 3: Infrastructure as Code

IaC implementations follow Azure best practices:

- **Resource naming:** Consistent prefixes and suffixes for resource identification
- **Tagging strategy:** Environment, cost center, owner, project tags required
- **Parameters:** Fully configurable for multiple environments
- **Modules:** Reusable components for common patterns
- **Documentation:** Purpose, parameters, and outputs clearly documented
- **Security:** Implement network segmentation, encryption, RBAC
- Template locations: `iac/bicep/`, `iac/terraform/`, `iac/arm/`

---

## When to Use Copilot

✅ **Excellent use cases:**
- Boilerplate code generation (project setup, CRUD operations)
- Test case generation and refactoring
- Documentation, comments, and README creation
- GitHub Actions workflows and Azure Pipelines
- Code refactoring suggestions and cleanup
- Learning new patterns, frameworks, or languages
- Scaffolding new components or modules
- Writing utility functions and helpers

❌ **Not recommended for:**
- Critical security implementations (review manually with security expert)
- Complex business logic (verify against requirements with domain expert)
- High-performance algorithms (benchmark and validate thoroughly)
- Sensitive data handling (review carefully, test extensively)
- Architecture decisions (discuss with team first)
- Code that handles personal/sensitive information
- Authentication and authorization systems (review carefully)

---

## Anti-Patterns to Avoid

1. **Vague Prompts:** ❌ "Fix this code" → ✅ "Fix the null reference exception in the CalculateTotal() method by adding input validation for the values parameter"

2. **Missing Context:** ❌ "Create a function" → ✅ "Create a function that validates email addresses using regex pattern matching RFC 5322 standard and throws ArgumentException for invalid emails"

3. **No Constraints:** ❌ "Optimize performance" → ✅ "Optimize the database query to execute in < 500ms by adding proper indexing on the UserId and CreatedDate columns"

4. **Ambiguous References:** ❌ "Update that file" → ✅ "Update Program.cs to add input validation for command-line arguments following the validation pattern in HelperFunctions.cs"

5. **Unclear Scope:** ❌ "Improve the code" → ✅ "Improve the code by extracting the calculation logic into a separate Calculate() method and adding comprehensive unit tests"

---

## Integration with VS Code

### Recommended Extensions

- **GitHub Copilot** - AI code suggestions and completions
- **GitHub Copilot Chat** - Conversational AI assistance in chat interface
- **GitHub Actions** - YAML workflow editing and validation
- **Azure Tools** - For IaC and cloud resource management
- **Markdown Preview Enhanced** - For better documentation editing
- **Language-specific extensions:**
  - C#: C# Dev Kit
  - Python: Pylance, Python
  - TypeScript: TypeScript Vue Plugin
  - Java: Extension Pack for Java
  - PowerShell: PowerShell

### Usage Tips

1. **Inline Suggestions:** `Tab` to accept, `Esc` to dismiss, `Alt+]` for next suggestion
2. **Copilot Chat Commands:** 
   - `/explain` - Explain selected code
   - `/fix` - Fix the selected code
   - `/test` - Generate tests
   - `/doc` - Generate documentation
3. **Context:** Use `#file:` to reference files or `#selection` for selected code
4. **Selection:** Select code snippets to request improvements
5. **Prompts:** Use Copilot Chat for complex multi-step requests

### Best Practices for Efficiency

- Provide context upfront (technology, framework versions, requirements)
- Reference existing code patterns in the repository
- Be specific about edge cases and constraints
- Review and understand generated code before committing
- Ask Copilot to explain its suggestions
- Iterate on suggestions if the first result isn't perfect

---

## Continuous Learning

When using Copilot for learning:

1. **Understand the "why":** Don't just copy code; understand the reasoning behind it
2. **Verify suggestions:** Cross-reference with official documentation and best practices
3. **Test thoroughly:** Run code locally, check for errors, verify expected behavior
4. **Review variations:** Ask Copilot for alternative approaches and compare
5. **Compare patterns:** Understand how suggestions differ from existing code in the repo
6. **Ask questions:** Follow up with clarifying questions about generated code

---

## Contributing to Copilot Instructions

These instructions evolve as the repository grows. When you discover:

- Patterns not documented here
- New technology stacks added
- Better ways to prompt Copilot
- Anti-patterns or gotchas

Please update this file or create an issue to propose improvements.

---

## Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Repository Instructions](./.github/instructions/)
- [Project Gengo README](../../README.md)
- [Contributing Guidelines](../../SECURITY.md)
- [Agent Prompts](./.github/agents/)
- [Workflow Examples](./.github/workflows/)

---

**Have questions or found an issue?** Create an issue in the repository referencing this file or discuss in your team channels.
