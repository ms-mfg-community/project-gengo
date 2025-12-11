# Product Requirements Document (PRD): Refactor Console Calculator as Blazor Web App

## 1.1 Document Information

- **Version:** 1.0
- **Author(s):** GitHub Copilot
- **Date:** December 11, 2025
- **Status:** Completed

## 1.2 Executive Summary

This document defines the requirements for refactoring a console-based calculator application into a modern Blazor Server web application. The solution demonstrates best practices in ASP.NET Core development, shared library architecture, service-based dependency injection, and responsive web design with theme support.

## 1.3 Problem Statement

The existing console calculator application lacks a modern user interface and is limited to command-line interaction. Users require a web-based calculator with visual keypad, themes, keyboard support, and history.

## 1.4 Goals and Objectives

- Refactor console calculator logic into reusable shared class library (.NET 8.0)
- Create Blazor Server web application (.NET 8.0) with professional UI
- Implement service layer for state management
- Add theme toggle and keyboard support
- Maintain backward compatibility with console application
- Ensure all existing unit tests pass

## 1.5 Scope

### In Scope
- Shared class library with pure calculator logic
- Blazor Server web application with responsive layout
- Razor components: CalculatorKeypad, HistoryPanel, ThemeToggle, Index
- Service classes: CalculatorService, HistoryService, ThemeService
- CSS with light/dark themes and animations
- JavaScript interop for keyboard support
- Session-only history (max 50 items, FIFO)
- 32 unit tests passing

### Out of Scope
- Data persistence (localStorage, database)
- Multi-user support or authentication
- Advanced mathematical functions
- Cloud deployment configuration

## 1.6 Functional Requirements

| ID | Description |
|---|---|
| FR-1 | Application accessible at https://localhost:7056 or http://localhost:5136 |
| FR-2 | Display shows current input or calculation result in real-time |
| FR-3 | Numeric buttons (0-9) input digits via click or keyboard |
| FR-4 | Decimal point with validation prevents multiple dots |
| FR-5 | Operator buttons (÷, ×, −, +) accept pending operations |
| FR-6 | Equals button calculates result and adds to history |
| FR-7 | Clear button resets display and operations |
| FR-8 | Power button calculates exponentiation |
| FR-9 | History displays up to 50 recent calculations (FIFO) |
| FR-10 | History items show: "operand1 operator operand2 = result (time)" |
| FR-11 | Clicking history replays calculation |
| FR-12 | Theme toggle switches Light/Dark themes |
| FR-13 | Unicode mathematical symbols (÷, ×, −) for clarity |
| FR-14 | Keyboard support: 0-9, operators, Enter, Backspace/Delete/C |
| FR-15 | High-contrast colors: operators (orange), equals (green), clear (red) |
| FR-16 | Standard 4-column calculator grid layout |
| FR-17 | Zero button spans 2 columns |
| FR-18 | Hover/active states provide visual feedback |

## 1.7 Non-Functional Requirements

- **Performance:** Display updates within 100ms
- **Accessibility:** WCAG color contrast, keyboard support, semantic HTML
- **Compatibility:** Chrome, Firefox, Safari, Edge
- **Responsiveness:** Adapt to 480px, 768px, desktop viewports
- **Quality:** Zero compilation errors, 32/32 tests passing

## 1.8 Success Criteria

✅ Build with 0 errors, ≤1 warning
✅ All 32 unit tests pass
✅ Web app accessible at both URLs
✅ All operator symbols render correctly
✅ Light/dark theme toggle functional
✅ Keyboard input fully operational
✅ History stores 50 items with replay
✅ Sufficient color contrast
✅ Responsive on all breakpoints

## 1.9 Completed Milestones

| Milestone | Status |
|---|---|
| Create calculator.library (.NET 8.0) | ✅ |
| Move Calculator.cs to library | ✅ |
| Create calculator.web (Blazor Server) | ✅ |
| Implement CalculatorService | ✅ |
| Implement HistoryService | ✅ |
| Implement ThemeService | ✅ |
| Create CalculatorKeypad component | ✅ |
| Create HistoryPanel component | ✅ |
| Create ThemeToggle component | ✅ |
| Create Index.razor main page | ✅ |
| CSS with theme variables/animations | ✅ |
| JavaScript keyboard support | ✅ |
| Service injection in Program.cs | ✅ |
| Update test project references | ✅ |
| 32 unit tests passing | ✅ |
| Application running on localhost | ✅ |
| Keypad refactor with Unicode symbols | ✅ |
| High-contrast color scheme | ✅ |

## 1.10 Technical Architecture

### Project Structure
`
├── lib/calculator.library/
│   └── Calculator.cs (Pure math, no console dependencies)
├── calculator.web/ (Blazor Server)
│   ├── Components/
│   │   ├── CalculatorKeypad.razor
│   │   ├── HistoryPanel.razor
│   │   ├── ThemeToggle.razor
│   │   └── Index.razor (main page)
│   ├── Services/
│   │   ├── CalculatorService.cs
│   │   ├── HistoryService.cs
│   │   └── ThemeService.cs
│   ├── Models/
│   │   └── CalculationRecord.cs
│   ├── wwwroot/
│   │   ├── css/calculator.css
│   │   └── js/keyboard-support.js
│   └── Program.cs
└── calculator.tests/ (32 tests)
`

### Services

**CalculatorService**
- State: display, pending operand, operator
- Events: OnDisplayChanged, OnCalculationCompleted
- Supports chained calculations

**HistoryService**
- FIFO queue (max 50 items)
- Newest-first ordering
- Replay functionality
- Event: OnHistoryChanged

**ThemeService**
- Light/Dark modes
- CSS class generation
- Icon state (🌙/☀️)
- Session-only

### CSS Theme Variables

**Light Theme**
- bg: #f5f5f5, buttons: #e0e0e0
- Operators: #FF9800 (orange)
- Equals: #4caf50 (green), Clear: #f44336 (red)

**Dark Theme**
- bg: #1e1e1e, buttons: #3d3d3d
- Operators: #FF9800 (maintains contrast)
- Equals: #388E3C, Clear: #d32f2f

### Keyboard Bindings

| Key | Action |
|---|---|
| 0-9 | Digit input |
| . | Decimal |
| +, -, *, / | Operators |
| ^ | Exponent |
| Enter or = | Equals |
| Backspace/Delete/C | Clear |

## 1.11 Implementation Completed

All requirements have been successfully implemented and tested:

✅ Console calculator refactored to shared library
✅ Blazor Server web app created and running
✅ All 4 Razor components implemented
✅ All 3 services implemented with events
✅ CSS with light/dark themes and animations
✅ JavaScript keyboard interop functional
✅ Unicode symbols (÷, ×, −, +) displaying
✅ High-contrast color scheme applied
✅ Standard calculator layout with proper grid
✅ 32 unit tests passing without modification
✅ Application accessible at https://localhost:7056

## 1.12 Deployment

### Local Development
`ash
dotnet build
dotnet run --project calculator.web/calculator.web.csproj
# Access: https://localhost:7056
`

### Future Hosting
- Azure App Service
- Docker containerization
- Self-hosted on IIS

## 1.13 Known Limitations

- History not persistent (session-only by design)
- Reset button identical to Clear (no distinction)
- No scientific mode
- No copy-to-clipboard

## 1.14 Future Enhancements

- localStorage persistence for history
- Scientific calculator mode
- Parentheses support
- Calculation export (CSV, PDF)
- Multi-language support (i18n)
- OS dark mode detection
- Mobile app wrapper (MAUI)

## 1.15 Sign-Off

| Role | Status | Date |
|---|---|---|
| Implementation | ✅ Complete | 12/11/2025 |
| Testing | ✅ 32/32 Pass | 12/11/2025 |
| Documentation | ✅ Complete | 12/11/2025 |

---

**Document Version History**

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | 12/11/2025 | GitHub Copilot | Initial PRD - Implementation Complete |
