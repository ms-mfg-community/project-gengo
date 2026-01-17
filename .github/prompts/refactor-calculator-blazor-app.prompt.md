---

description: Refactor the console calculator into a modern Blazor Server web application with responsive UI, theme support, keyboard integration, and service-based architecture.

name: refactor-calculator-blazor-app

agent: agent

model: Claude Haiku 4.5 (copilot)

tools:
\n\ngithub/*

---

\n\nRefactor Calculator as Blazor Web App

You are an expert ASP.NET Core and Blazor developer helping users transform a console calculator into a professional web application.

\n\nObjective

Refactor the existing console calculator into a Blazor Server web application with modern UI components, theme support, keyboard interoperability, and service-based dependency injection while maintaining all existing unit tests.

\n\nKey Requirements

\n\nArchitecture

\n\nCreate shared class library (`calculator.library`) containing pure calculator logic
\n\nBuild Blazor Server web application (`calculator.web`) using .NET 8.0
\n\nImplement service layer with dependency injection (CalculatorService, HistoryService, ThemeService)
\n\nMove Calculator.cs to library, removing console dependencies
\n\nMaintain 32 passing unit tests without modification

\n\nUI Components (Razor)

\n\n**CalculatorKeypad.razor**: 4-column grid with numeric buttons (0-9), operators, equals, clear, power
\n\n**HistoryPanel.razor**: Displays up to 50 recent calculations (FIFO) with replay functionality
\n\n**ThemeToggle.razor**: Light/Dark mode toggle with 🌙/☀️ icons
\n\n**Index.razor**: Main application layout combining all components

\n\nFunctional Requirements

\n\nDisplay shows real-time input and calculation results
\n\nNumeric input via click (buttons) or keyboard (0-9, .)
\n\nOperator buttons: ÷ (division), × (multiplication), − (subtraction), + (addition), ^ (power)
\n\nEquals button calculates result and adds to history
\n\nClear button resets display and operations
\n\nHistory shows: "operand1 operator operand2 = result (time)"
\n\nClicking history replays calculation
\n\nZero button spans 2 columns in grid layout
\n\nUnicode mathematical symbols for clarity (÷, ×, −)

\n\nKeyboard Support

\n\nDigits: 0-9
\n\nOperators: +, -, \*, /, ^
\n\nDecimal: .
\n\nCalculate: Enter or =
\n\nClear: Backspace, Delete, or C
\n\nFull integration via JavaScript interop

\n\nStyling & Themes

\n\nLight Theme: #f5f5f5 background, #e0e0e0 buttons
\n\nDark Theme: #1e1e1e background, #3d3d3d buttons
\n\nHigh-contrast colors: Operators #FF9800 (orange), Equals #4caf50 (green), Clear #f44336 (red)
\n\nSmooth theme transitions with CSS animations
\n\nResponsive design for 480px, 768px, and desktop viewports
\n\nStandard 4-column calculator grid layout
\n\nHover and active states for visual feedback

\n\nServices

# CalculatorService

\n\nState management: display, pending operand, operator
\n\nEvents: OnDisplayChanged, OnCalculationCompleted
\n\nSupport for chained calculations

## HistoryService

\n\nFIFO queue with max 50 items (newest-first ordering)
\n\nReplay functionality
\n\nEvent: OnHistoryChanged
\n\nSession-only storage (no persistence)

## ThemeService

\n\nLight/Dark mode toggle
\n\nCSS class generation
\n\nSession state management

\n\nProject Structure

```text
lib/calculator.library/

  └── Calculator.cs (Pure math logic)

programming/dotnet/csharp/workspace/calculator-xunit-testing/calculator.web/

  ├── Components/

  │   ├── CalculatorKeypad.razor

  │   ├── HistoryPanel.razor

  │   ├── ThemeToggle.razor

  │   └── Index.razor

  ├── Services/

  │   ├── CalculatorService.cs

  │   ├── HistoryService.cs

  │   └── ThemeService.cs

  ├── Models/

  │   └── CalculationRecord.cs

  ├── wwwroot/

  │   ├── css/calculator.css

  │   └── js/keyboard-support.js

  └── Program.cs

calculator.tests/

  └── [32 existing tests - no modification needed]

```text
\n\nDevelopment Workflow

\n\n**Setup Phase**
\n\nCreate `calculator.library` as .NET 8.0 class library
\n\nCreate `calculator.web` as .NET 8.0 Blazor Server application
\n\nConfigure project references (web → library, tests → library)

\n\n**Library Migration**
\n\nMove Calculator.cs to library
\n\nRemove console I/O dependencies
\n\nVerify all 32 tests still pass

\n\n**Service Implementation**
\n\nImplement CalculatorService with state management and events
\n\nImplement HistoryService with FIFO queue and replay
\n\nImplement ThemeService for light/dark modes
\n\nRegister services in Program.cs dependency injection

\n\n**Component Development**
\n\nCreate CalculatorKeypad with grid layout and Unicode symbols
\n\nCreate HistoryPanel with replay functionality
\n\nCreate ThemeToggle with icon and state management
\n\nCreate Index.razor main page combining all components

\n\n**Styling & Interop**
\n\nImplement CSS with light/dark theme variables
\n\nCreate JavaScript keyboard support module
\n\nConfigure JavaScript interop in components
\n\nAdd hover/active state animations

\n\n**Testing & Validation**
\n\nVerify all 32 unit tests pass
\n\nTest keyboard input (all bindings)
\n\nTest theme toggle persistence (session)
\n\nTest history functionality (50 item limit, replay)
\n\nVerify application runs at <https://localhost:7056>

\n\nGuidelines

\n\n**Simplicity First**: Start with basic functionality before advanced features
\n\n**Component Reusability**: Design components to be cohesive and independently testable
\n\n**Separation of Concerns**: Keep business logic in services, UI in components
\n\n**Accessibility**: Ensure keyboard navigation, semantic HTML, color contrast (WCAG)
\n\n**No Breaking Changes**: Maintain compatibility with existing calculator logic
\n\n**Clean Code**: Use meaningful names, appropriate sizing, proper null handling
\n\n**Documentation**: Include JSDoc/XML comments on all public members

\n\nReference Materials

\n\nPRD Location: [PRD: Refactor as Blazor App](${workspaceFolder}/programming/dotnet/csharp/workspace/prd-refactor-as-blazor-app.md)
\n\nCoding Standards: [Copilot Instructions](${workspaceFolder}/.github/copilot-instructions.md)
\n\nBasic Calculator Prompt: [Create Basic .NET Calculator](${workspaceFolder}/.github/prompts/create-basic-calculator-dotnet.prompt.md)

\n\nSuccess Criteria

✅ Build with 0 errors, ≤1 warning

✅ All 32 unit tests pass without modification

✅ Web app accessible at <https://localhost:7056> and <http://localhost:5136>

✅ All operator symbols render correctly (÷, ×, −, +)

✅ Light/dark theme toggle functional with visual feedback

✅ Keyboard input fully operational (digits, operators, Enter, Clear)

✅ History stores up to 50 items with replay functionality

✅ Sufficient color contrast for accessibility

✅ Responsive layout on mobile (480px), tablet (768px), desktop

✅ No console dependencies in calculator logic

\n\nImplementation Notes

\n\nHistory is session-only by design; no persistence layer needed
\n\nServices use Blazor events for component communication
\n\nRazor components leverage @onclick and keyboard event bindings
\n\nCSS custom properties enable theme switching without reloading
\n\nJavaScript interop handles global keyboard events
\n\nUnicode symbols improve visual clarity and usability

\n\nDeployment

```text
bash
\n\nLocal development

dotnet build

dotnet run --project calculator.web/calculator.web.csproj

\n\nAccess application
\n\nhttps://localhost:7056 or <http://localhost:5136>

```text
\n\nOutput Format

Provide:

\n\nStep-by-step refactoring guidance
\n\nComplete service implementations
\n\nAll Razor components with proper structure
\n\nCSS with theme variables and transitions
\n\nJavaScript keyboard interop module
\n\nTest results showing 32/32 passing
\n\nDocumentation for components and services
\n\nExplanation of architectural decisions

\n
