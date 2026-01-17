# Product Requirements Document (PRD): Refactor Console Calculator as Blazor Web App

\n\n1.1 Document Information

\n\n**Version:** 1.0
\n\n**Author(s):** GitHub Copilot
\n\n**Date:** December 11, 2025
\n\n**Status:** Completed

\n\n1.2 Executive Summary

This document defines the requirements for refactoring a console-based calculator application into a modern Blazor Server web application. The solution demonstrates best practices in ASP.NET Core development, shared library architecture, service-based dependency injection, and responsive web design with theme support.

\n\n1.3 Problem Statement

The existing console calculator application lacks a modern user interface and is limited to command-line interaction. Users require a web-based calculator with visual keypad, themes, keyboard support, and history.

\n\n1.4 Goals and Objectives

\n\nRefactor console calculator logic into reusable shared class library (.NET 8.0)
\n\nCreate Blazor Server web application (.NET 8.0) with professional UI
\n\nImplement service layer for state management
\n\nAdd theme toggle and keyboard support
\n\nMaintain backward compatibility with console application
\n\nEnsure all existing unit tests pass

\n\n1.5 Scope

\n\nIn Scope

\n\nShared class library with pure calculator logic
\n\nBlazor Server web application with responsive layout
\n\nRazor components: CalculatorKeypad, HistoryPanel, ThemeToggle, Index
\n\nService classes: CalculatorService, HistoryService, ThemeService
\n\nCSS with light/dark themes and animations
\n\nJavaScript interop for keyboard support
\n\nSession-only history (max 50 items, FIFO)
\n\n32 unit tests passing

\n\nOut of Scope

\n\nData persistence (localStorage, database)
\n\nMulti-user support or authentication
\n\nAdvanced mathematical functions
\n\nCloud deployment configuration

\n\n1.6 Functional Requirements

| ID | Description |

| ----- | ------------------------------------------------------------------------- |

| FR-1 | Application accessible at <https://localhost:7056> or <http://localhost:5136> |

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

\n\n1.7 Non-Functional Requirements

\n\n**Performance:** Display updates within 100ms
\n\n**Accessibility:** WCAG color contrast, keyboard support, semantic HTML
\n\n**Compatibility:** Chrome, Firefox, Safari, Edge
\n\n**Responsiveness:** Adapt to 480px, 768px, desktop viewports
\n\n**Quality:** Zero compilation errors, 32/32 tests passing

\n\n1.8 Success Criteria

✅ Build with 0 errors, ≤1 warning

✅ All 32 unit tests pass

✅ Web app accessible at both URLs

✅ All operator symbols render correctly

✅ Light/dark theme toggle functional

✅ Keyboard input fully operational

✅ History stores 50 items with replay

✅ Sufficient color contrast

✅ Responsive on all breakpoints

\n\n1.9 Completed Milestones

| Milestone | Status |

| ------------------------------------- | ------ |

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

\n\n1.10 Technical Architecture

\n\nProject Structure

`├── lib/calculator.library/

│ └── Calculator.cs (Pure math, no console dependencies)

├── calculator.web/ (Blazor Server)

│ ├── Components/

│ │ ├── CalculatorKeypad.razor

│ │ ├── HistoryPanel.razor

│ │ ├── ThemeToggle.razor

│ │ └── Index.razor (main page)

│ ├── Services/

│ │ ├── CalculatorService.cs

│ │ ├── HistoryService.cs

│ │ └── ThemeService.cs

│ ├── Models/

│ │ └── CalculationRecord.cs

│ ├── wwwroot/

│ │ ├── css/calculator.css

│ │ └── js/keyboard-support.js

│ └── Program.cs

└── calculator.tests/ (32 tests)`

\n\nServices

## CalculatorService

\n\nState: display, pending operand, operator
\n\nEvents: OnDisplayChanged, OnCalculationCompleted
\n\nSupports chained calculations

## HistoryService

\n\nFIFO queue (max 50 items)
\n\nNewest-first ordering
\n\nReplay functionality
\n\nEvent: OnHistoryChanged

## ThemeService

\n\nLight/Dark modes
\n\nCSS class generation
\n\nIcon state (🌙/☀️)
\n\nSession-only

\n\nCSS Theme Variables

## Light Theme

\n\nbg: #f5f5f5, buttons: #e0e0e0
\n\nOperators: #FF9800 (orange)
\n\nEquals: #4caf50 (green), Clear: #f44336 (red)

## Dark Theme

\n\nbg: #1e1e1e, buttons: #3d3d3d
\n\nOperators: #FF9800 (maintains contrast)
\n\nEquals: #388E3C, Clear: #d32f2f

\n\nKeyboard Bindings

| Key | Action |

| ------------------ | ----------- |

| 0-9 | Digit input |

| . | Decimal |

| +, -, \*, / | Operators |

| ^ | Exponent |

| Enter or = | Equals |

| Backspace/Delete/C | Clear |

\n\n1.11 Implementation Completed

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

✅ Application accessible at <https://localhost:7056>

\n\n1.12 Deployment

\n\nLocal Development

`ash

dotnet build

dotnet run --project calculator.web/calculator.web.csproj

\n\nAccess: <https://localhost:7056>

`

\n\nFuture Hosting

\n\nAzure App Service
\n\nDocker containerization
\n\nSelf-hosted on IIS

\n\n1.13 Known Limitations

\n\nHistory not persistent (session-only by design)
\n\nReset button identical to Clear (no distinction)
\n\nNo scientific mode
\n\nNo copy-to-clipboard

\n\n1.14 Future Enhancements

\n\nlocalStorage persistence for history
\n\nScientific calculator mode
\n\nParentheses support
\n\nCalculation export (CSV, PDF)
\n\nMulti-language support (i18n)
\n\nOS dark mode detection
\n\nMobile app wrapper (MAUI)

\n\n1.15 Sign-Off

| Role | Status | Date |

| -------------- | ------------- | ---------- |

| Implementation | ✅ Complete | 12/11/2025 |

| Testing | ✅ 32/32 Pass | 12/11/2025 |

| Documentation | ✅ Complete | 12/11/2025 |

---

## Document Version History

| Version | Date | Author | Changes |

| ------- | ---------- | -------------- | ------------------------------------- |

| 1.0 | 12/11/2025 | GitHub Copilot | Initial PRD - Implementation Complete |

\n
