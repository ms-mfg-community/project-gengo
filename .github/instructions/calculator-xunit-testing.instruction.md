# Calculator Xunit Testing.Instruction

---
applyTo: "programming/dotnet/csharp/workspace/calculator-xunit-testing/**"
---

\n\nProject Overview

The Calculator xUnit Testing project is a .NET 8.0 solution demonstrating test-driven development with xUnit, parameterized testing using CSV test data, Blazor web UI components, and a service-based architecture. The project includes a core calculator library, comprehensive unit tests, and an interactive web interface.

\n\nFolder Structure

\n\n`/calculator`: Core calculator library with arithmetic logic
\n\n`/calculator.tests`: xUnit unit tests with parameterized test data
\n\n`TestData/`: CSV files for test data
\n\n`/calculator.web`: Blazor web UI application
\n\n`Components/`: Reusable Razor components (CalculatorKeypad, HistoryPanel, ThemeToggle)
\n\n`Services/`: Business logic services (CalculatorService, HistoryService, ThemeService)
\n\n`Pages/`: Routable pages and layouts
\n\n`Models/`: Data models
\n\n`wwwroot/css/`: Styling for components
\n\n`/calculator.sln`: Solution file

\n\nLibraries and Frameworks

\n\n**.NET 8.0**: Target framework (Long-Term Support)
\n\n**xUnit**: Unit testing framework with parameterized test support
\n\n**Blazor**: Interactive web UI framework with component-based architecture
\n\n**Microsoft.NET.Sdk.BlazorWebAssembly**: Blazor web assembly SDK

\n\nCoding Standards

\n\n**Naming**: PascalCase for classes, methods, and properties; camelCase for private fields and local variables
\n\n**Testing**: Write tests before or alongside implementation (TDD); use `[MethodName]_[Condition]_[ExpectedResult]` naming for test methods
\n\n**Test Data**: Store parameterized test data in CSV files within `TestData/` folder; use `[MemberData]` attributes
\n\n**Components**: Keep Razor components focused on UI rendering; use dependency injection for business logic
\n\n**Assertions**: Use xUnit's `Assert` class for clarity in tests
\n\n**Code Organization**: Separate concerns using service-based architecture; avoid over-engineering

\n\nKey Practices

\n\nAlways run `dotnet test` before committing changes
\n\nUse `[Theory]` with `[InlineData]` or `[MemberData]` for parameterized tests
\n\nInject services into Blazor components using `@inject` directive
\n\nValidate numeric inputs in Calculator methods
\n\nKeep test data in CSV files to avoid duplication
\n\nDocument public methods with XML documentation comments (`///`)

\n
