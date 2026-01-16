# GitHub Copilot Instructions
\n\nPurpose

This file provides custom instructions for using GitHub Copilot in this repository. It helps ensure that both human contributors and AI-generated code adhere to our project's standards, coding practices, and overall quality requirements.
\n\nGeneral Guidelines [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)
\n\nAlways prefer simple solutions.\n\nAvoid duplication of code whenever possible, which means checking for other areas of the codebase that might already have similar code and functionality.\n\nWrite code that takes into account the different environments, for example; dev, test, and prod.
<!-- - Only make changes that are requested unless you are confident, the context is well understood and related to the change being requested. -->\n\nWhen fixing an issue or bug, do not introduce a new pattern or technology without first exhausting all options for the existing implementation. If however, you must still introduce a new pattern, make sure to please remove the old implementation afterwards so we don't have duplicate logic.\n\nKeep the codebase clean and organized\n\nAvoid writing scripts in files if possible, especially if the script is likely only to be executed once.\n\nAvoid having files over 100-200 lines of code; Instead please refactor if the logic approaches 200 lines.\n\nMocking data is only needed for tests, never mock data for dev or prod.\n\nNever add stubbing or fake data patterns to code that affects the dev or prod environments.\n\nNever overwrite the .env file without consent.
<!--  -->
\n\nCoding workflow preferences: [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)
\n\nFocus on the areas of code relevant to the task.\n\nDo not touch code that is unrelated to the task.\n\nWrite through tests for all major functionality.\n\nAvoid making major changes to the patterns and architecture of how a feature works, after it has been proven to work properly, unless explicitly prompted to do so.\n\nAlways consider how changes and updates may negatively impact the current function of the solution.
\n\nProject specific custom instructions
\n\nTemplate for Project Specific Instructions

When crafting a custom instruction set for a specific project, reference the following content as a template to ensure all necessary aspects are covered: [Project Specific Instructions](https://docs.github.com/en/copilot/concepts/prompting/response-customization?tool=vscode#writing-effective-custom-instructions-1 "Project or folder level custom instructions").
\n\nExample Instruction Files
\n\n[Custom Instructions](https://github.com/github/awesome-copilot/tree/main/instructions "Examples")
\n\nCode Style
\n\n**General:** Follow the repository's style guide for consistency.\n\n**Naming Conventions:** Use meaningful and descriptive names.\n\nFor JavaScript/TypeScript, use camelCase for variables and functions.\n\nFor Python, adhere to [PEP 8](https://www.python.org/dev/peps/pep-0008/).\n\n**Line Length:** Aim for 80-100 characters per line where possible.\n\n**Formatting:** Use automated tools (like Prettier or Black) to enforce formatting rules.
\n\nSQL
\n\nGeneral SQL Guidelines
\n\nReference both Microsoft T-SQL as well as PostgreSQL syntax where applicable\n\nUse appropriate SQL dialect based on the target database system\n\nFollow database-specific best practices for performance and security\n\nAlways use parameterized queries to prevent SQL injection
\n\nSQLite
\n\n**Executable:** Use `sqlite3` for executing SQLite commands and scripts\n\n**File-based:** SQLite databases are file-based (`.db`, `.sqlite`, `.sqlite3` extensions)\n\n**Lightweight:** Ideal for local development, testing, and embedded applications
\n\nSQLite Usage Examples

**Connect to database and run a query:**

```pwsh\n\nOpen database file
sqlite3 database.db "SELECT * FROM tablename;"
\n\nInteractive mode
sqlite3 database.db
```

**Common SQLite commands:**

```sql
.help                 -- Show help
.tables               -- List all tables
.schema tablename     -- Show table schema
.mode column          -- Set output mode
.headers on           -- Show column headers
.quit                 -- Exit sqlite3
```

**Run script file:**

```pwsh
sqlite3 database.db < script.sql
```
\n\nMicrosoft SQL Server / Azure SQL
\n\n**Executable:** Use `sqlcmd` for executing T-SQL commands and scripts\n\n**Modern sqlcmd (Go-based):** Cross-platform, recommended for new projects\n\n**Legacy sqlcmd.exe (ODBC-based):** Traditional Windows tool\n\n**Bulk Operations:** Use `bcp` (Bulk Copy Program) for bulk data import/export\n\n**Database Connectivity:** Ensure proper connection strings and authentication methods are used
\n\nConnecting to SQL Server / Azure SQL

When a connection to a database is requested in a prompt, use the sqlcmd tool with appropriate parameters for server, database, authentication, and query execution.
\n\nsqlcmd Usage Examples

**Connect and run a query:**

```pwsh\n\nModern sqlcmd or legacy sqlcmd.exe
sqlcmd -S <server>.database.windows.net -d <database> -U <username> -P <password> -Q "SELECT * FROM sys.tables"
```

**Run a script file:**

```pwsh
sqlcmd -S <server>.database.windows.net -d <database> -U <username> -i script.sql -o output.txt
```

**Interactive session:**

```pwsh\n\nStart interactive session
sqlcmd -S <server> -d <database> -U <username> -P <password>
\n\nInside sqlcmd, type GO after each query to execute\n\nType EXIT to quit
```
\n\nAuthentication Options
\n\n`-U` and `-P`: SQL Authentication\n\n`-E`: Windows/Integrated Authentication\n\n`-G`: Azure Active Directory Authentication\n\n`-G -P`: Azure AD with password
\n\nRelated Tools
\n\n**Azure Data Studio** (`azuredatastudio`) - GUI with integrated terminal\n\n**SQL Server Management Studio (SSMS)** - Windows GUI tool\n\n**mssql-cli** - Interactive command-line with IntelliSense
\n\nSQL Best Practices
\n\nUse transactions for data integrity\n\nAlways verify with SELECT before UPDATE or DELETE operations\n\nInclude WHERE clauses to prevent accidental mass updates/deletes\n\nUse appropriate indexes for query performance\n\nDocument complex queries with comments\n\nUse consistent formatting and naming conventions\n\nTest queries in development before running in production
\n\nCommenting
\n\n**Clarity:** Write clear and concise comments for complex logic.\n\n**Inline Comments:** Use sparingly to explain non-obvious code segments.\n\n**Documentation:** Document functions, methods, and classes using appropriate docstring formats (e.g., JSDoc, Python docstrings).
\n\nTesting Guidelines
\n\n**General Rule:** Write tests alongside new features and bug fixes.\n\n**Frameworks:**\n\n**.NET:** Use the xUnit framework.\n\n**Java:** Use JUnit.\n\n**TypeScript:** Prefer Vitest.\n\n**Python:** Use pytest.\n\n**Go:** Use Testify.\n\n**Node.js:** Use Jest.\n\n**C:** Use Unity.\n\n**C++:** Use Google Test.\n\n**Coverage:** Ensure critical paths and edge cases are covered.
\n\nDocumentation
\n\n**README:** Keep the README.md updated with usage instructions and examples.\n\n**API Docs:** Maintain inline documentation and generated API docs.\n\n**Style:** Use Markdown for all documentation, ensuring consistency in headings and formatting using the [markdownlint](https://github.com/DavidAnson/markdownlint "Markdown Linting Rules") rules.\n\n**Warnings** Ensure that after each markdown file is created, it is also scanned for and reformated to fix any markdown linting violations.\n\n**Relative Links:** Use relative links for internal documentation references.\n\n**Examples:** Provide code examples where applicable.\n\n**URLs:** Apply the label, URL and title format for all links in markdown files. For example: [GitHub Docs](https://docs.github.com "GitHub Documentation")
\n\nCommit Messages
\n\n**Format:** Use the following pattern:\n\nTopic Subtopic Activity Specification: **_topic(subtopic): activity_**\n\nExample: `github(instructions): expand guideline details`\n\nDo not rely on any other industry best practices. Instead, enforce this format above.
\n\nKey Points
\n\n**Topic:** Indicates the nature of the commit (e.g., `github` for github specific files, commands, or configuration, `feat` for a new feature, `fix` for a bug fix, `docs` for documentation changes, etc.).\n\n**Subtopic (optional):** An attributive or adjunct noun acting as a modifier or a certain scope for the topic that adds additional context. (e.g., `instructions`, `auth`, `ui`, `build`).\n\n**Activity:** A concise, imperative description of the change.

For example:

feat(auth): add login functionality

This format provides clear context and can be easily parsed by tools. The Topic Subtopic Activity specification aims to provide clarity, flexibility and compatibility with automation tools.
\n\n**Clarity:** Keep commit messages clear and descriptive to facilitate easier reviews and history tracking.
\n\nBranching Strategy
\n\n**Main Branch:** Reserve for production-ready code.\n\n**Feature Branches:** Develop new features in branches named descriptively (e.g., `feature/login-system`).\n\n**Bugfix Branches:** Use names like `bugfix/issue-123` for clarity.\n\n**Merging:** Ensure branches pass all tests and code reviews before merging into main.
\n\nPull Request Process
\n\n**Submission:** Open a pull request for every new feature or bugfix.\n\n**Description:** Provide a detailed description, linking relevant issues if applicable.\n\n**CI Checks:** Confirm that all automated tests and linters pass if available or applicable.\n\n**Reviews:** Request reviews from at least one other team member before merging.
\n\nContinuous Integration / Build Process
\n\n**Automation:** Use CI tools to run tests, linters, and build scripts automatically.\n\n**Branch Protection:** Enforce branch protection rules to ensure quality and stability.\n\n**Reporting:** Monitor build status and address any failures promptly.
\n\nSecurity and Error Handling
\n\n**Validation:** Always validate inputs and handle errors gracefully.\n\n**Best Practices:** Follow secure coding practices and check for vulnerabilities using automated tools.\n\n**Error Logging:** Implement error logging and monitoring to detect issues early.
\n\nLanguage Specific Instructions
\n\nPowerShell
\n\nEnd control structures, loops and functions with `#end if,#end for,#end foreach, #end while,#end until,#end case, #end FunctionName`.\n\nPlace each opening bracket '{' on a new line for each scope within a foreach, while, until, for loop or function block. For example:foreach ($item in $contents)
{
    Write-Host "Name: $($item.Name)"
  Write-Host "Full Name: $($item.FullName)"
  Write-Host "Size: $($item.Length) bytes"
  Write-Host "Last Modified: $($item.LastWriteTime)"
  Write-Host "-----------------------------"
  } # end foreach\n\nUse PascalCase for variables, functions, and classes.\n\nInclude comments for any non-trivial logic within scripts.
\n\nPowerShell Script Header Template

All PowerShell scripts that do not already contain a header should include comprehensive comment-based help. Use this template as a starting point:

```powershell
<#
.SYNOPSIS
    Brief description of what the script does.

.DESCRIPTION
    Detailed description of the script's functionality, purpose, and any important
    implementation details. Explain the business context and use cases.

.PARAMETER parameterName
    Description of the parameter, including default values, valid options,
    and examples of typical usage.

.PARAMETER anotherParameter
    Description for additional parameters. Include type information,
    constraints, and relationship to other parameters.

.PARAMETER switchParameter
    Description of switch parameters and when they should be used.
    Explain the behavior when the switch is present vs absent.

.EXAMPLE
    .\script-name.ps1

    Basic usage example with explanation of what it does.

.EXAMPLE
    .\script-name.ps1 -Parameter "value" -SwitchParameter

    Advanced usage example showing parameter combinations.

.EXAMPLE
    .\script-name.ps1 -Parameter "C:\Custom\Path" -Format "csv"

    Example with custom paths and different output formats.

.NOTES
    File Name      : script-name.ps1
    Author         : [Team/Author Name]
    Prerequisite   : [Required software, modules, permissions]
    Version        : 1.0

    Requirements:\n\nList all prerequisites and dependencies\n\nInclude version requirements where applicable\n\nMention any required permissions or access

    Change Log:\n\nVersion 1.0: Initial creation\n\nVersion 1.1: Added feature X

.LINK
    https://relevant-documentation-url.com

.LINK
    https://additional-reference-url.com

#>

param(
    [Parameter(Mandatory=$false, HelpMessage="Description of parameter")]
    [string]$ParameterName = "DefaultValue",

    [Parameter(Mandatory=$false)]
    [ValidateSet("Option1", "Option2", "Option3")]
    [string]$ValidatedParameter = "Option1",

    [Parameter(Mandatory=$false)]
    [switch]$SwitchParameter
)
```

**Key Elements to Include:**
\n\n**SYNOPSIS**: One-line description of the script's purpose\n\n**DESCRIPTION**: Detailed explanation including business context\n\n**PARAMETER**: Document each parameter with descriptions, defaults, and constraints\n\n**EXAMPLE**: Multiple realistic usage examples showing different scenarios\n\n**NOTES**: Metadata including author, version, prerequisites, and change log\n\n**LINK**: References to relevant documentation or related resources

**Best Practices:**
\n\nAlways include at least 2-3 practical examples\n\nDocument all parameters even if they seem obvious\n\nInclude version information and change tracking\n\nSpecify all prerequisites and dependencies\n\nUse consistent formatting and professional language\n\nUpdate examples when functionality changes
\n\nIaC
\n\nFor bicep, use the Azure Cloud Shell or az cli for bicep commands with az bicep instead of the standalone bicep executable.\n\nUse `*.bicepparam` parameter files instead of `*.json` parameter files
\n\nJavaScript / TypeScript
\n\nEnable strict mode and use linting (e.g., ESLint).\n\nPrefer ES6+ features and async/await for asynchronous operations.\n\nDocument functions with JSDoc comments where applicable.\n\nUse vite for building and testing TypeScript projects instead of create-react-app, since it has recently been deprecated.\n\nReference:[Sunsetting Create React App](https://react.dev/blog/2025/02/14/sunsetting-create-react-app)
\n\nPython
\n\nFollow the PEP 8 style guide.\n\n**Always use venv virtual environments to manage dependencies** - this is mandatory for all Python projects.\n\nInclude comprehensive docstrings for functions and classes.\n\nUse the following script header templeate when creating new Python scripts.

```python
'''
Script: script.py

Description:
    A brief overview of what the script does, its functionality, and any important implementation details. Explain the business context and use cases.

Purpose:
    Explain why this script was created and what problem it solves.

Author:
    Your Name or Team

Created:
    2024-06-01

Version:
    1.00

Requirements:\n\nPython 3.8+\n\nopenai package (pip install openai)\n\nAzure OpenAI API credentials\n\nsubscription_key environment variable set

Usage:
    python script.py

Environment Variables:


Example:
    $ export subscription_key="your-api-key"

Notes:\n\nEnsure that the required packages are installed before running the script.\n\nHandle exceptions and errors gracefully.

Change Log:\n\nv1.00: Initial creation

TODO:\n\nAdd additional features as needed
'''
```
\n\nVirtual Environment Management with venv

**Preference:** Use Python's built-in `venv` module for creating and managing virtual environments. This is the preferred approach over alternatives like `virtualenv`, `conda`, or `pipenv` unless specifically required by the project.

**Setup and Best Practices:**
\n\n**Create a virtual environment:**

   ```bash
   # Create virtual environment in project root
   python -m venv dev

   # Alternative naming for specific Python versions
   python3.11 -m venv dev-3.11
   ```
\n\n**Activate the virtual environment:**

   ```bash
   # Windows (PowerShell/Command Prompt)
   dev\Scripts\activate

   # Windows (Git Bash)
   source venv/Scripts/activate

   # macOS/Linux
   source venv/bin/activate
   ```
\n\n**Verify activation:**

   ```bash
   # Check that pip points to virtual environment
   which pip  # macOS/Linux
   where pip  # Windows

   # Should show path containing your venv directory
   pip --version
   ```
\n\n**Install dependencies:**

   ```bash
   # Upgrade pip first
   python -m pip install --upgrade pip

   # Install from requirements file
   pip install -r requirements.txt

   # Install development dependencies
   pip install -r requirements-dev.txt
   ```
\n\n**Generate requirements files:**

   ```bash
   # Generate requirements.txt
   pip freeze > requirements.txt

   # Better approach: use pipreqs for project-specific dependencies
   pip install pipreqs
   pipreqs . --force
   ```
\n\n**Deactivate when done:**

   ```bash
   deactivate
   ```

**Directory Structure:**

```text
project-root/
├── venv/                    # Virtual environment (add to .gitignore)
├── src/                     # Source code
├── tests/                   # Test files
├── requirements.txt         # Production dependencies
├── requirements-dev.txt     # Development dependencies (optional)
├── .gitignore              # Include venv/ entry
├── .env                    # Environment variables (add to .gitignore)
└── README.md               # Include venv setup instructions
```

**Requirements Files Best Practices:**
\n\n**requirements.txt**: Production dependencies only, pinned versions

  ```text
  requests==2.31.0
  flask==2.3.3
  python-dotenv==1.0.0
  ```
\n\n**requirements-dev.txt**: Development dependencies, can include requirements.txt

  ```text
  -r requirements.txt
  pytest==7.4.2
  black==23.7.0
  flake8==6.0.0
  mypy==1.5.1
  ```

**VS Code Integration:**
\n\n**Select Python interpreter:**\n\nPress `Ctrl+Shift+P`\n\nType "Python: Select Interpreter"\n\nChoose the interpreter from your venv folder
\n\n**Workspace settings (.vscode/settings.json):**

   ```json
   {
     "python.pythonPath": "./venv/Scripts/python.exe",
     "python.terminal.activateEnvironment": true,
     "python.linting.enabled": true,
     "python.linting.pylintEnabled": true,
     "python.formatting.provider": "black"
   }
   ```

**Git Integration (.gitignore entries):**

```gitignore\n\nVirtual Environment
venv/
env/
ENV/
.venv/
.env
\n\nPython
__pycache__/
*.py[cod]
*$py.class
*.egg-info/
dist/
build/
\n\nIDE
.vscode/settings.json  # If containing sensitive info
.idea/
```

**Common Commands Reference:**

```bash\n\nQuick setup for new project
python -m venv dev
dev\Scripts\activate  # Windows
source dev/bin/activate  # macOS/Linux
python -m pip install --upgrade pip
\n\nPackage management
pip list                          # List installed packages
pip show package_name            # Show package details
pip install package_name==1.0.0  # Install specific version
pip uninstall package_name       # Uninstall package
\n\nRequirements management
pip freeze > requirements.txt     # Save current state
pip install -r requirements.txt   # Install from requirements
pip list --outdated              # Check for updates
```

**Troubleshooting:**
\n\n**Permission errors**: Use `python -m pip` instead of `pip` directly\n\n**Path issues**: Ensure virtual environment is activated before installing packages\n\n**Module not found**: Verify correct interpreter is selected in VS Code\n\n**Stale cache**: Use `pip install --no-cache-dir package_name`

**Environment Variables:**
\n\nUse `.env` files with `python-dotenv` for environment-specific configuration\n\nNever commit `.env` files to version control\n\nProvide `.env.example` with placeholder values\n\nStore sensitive information (API keys, passwords) in environment variables
\n\nJava
\n\nFor Java apps, use maven for build automation, dependency management, project structure standardization, plugins and extensibility and project information management unless otherwise specified in prompts.
\n\nC++
\n\nUse the recommended project directory structure\n\nCreate the project structure using this prompt as a reference:
  _Create a python script at relative path: ...programming\cpp\workspace named cpp_project_setup.py that will create C++ a project workspace directory structure and files based on the guidance provided in the 'MyCppProject' example in copilot-instructions.md. Name the project 'cpp-project-name'._
  MyCppProject/
  ├── build/ # Generated build files (by CMake or other build systems)
  ├── cmake/ # Additional CMake modules or scripts (optional)
  ├── docs/ # Project documentation
  ├── examples/ # Usage examples of the library/application (optional)
  ├── external/ # Third-party external libraries (if not managed by package manager)
  ├── include/ # Public headers (.h or .hpp files)
  │ └── MyCppProject/
  │ └── foo.hpp
  ├── src/ # Source code files (.cpp files and private headers)
  │ ├── foo.cpp
  │ └── internal/
  │ └── helper.hpp
  ├── tests/ # Test cases (unit tests, integration tests)
  │ └── test_foo.cpp
  ├── scripts/ # Utility scripts (for build, CI/CD, etc.)
  ├── .gitignore # Git ignore rules
  ├── .clang-format # Formatting rules for clang-format (recommended)
  ├── CMakeLists.txt # Main build script for CMake
  ├── LICENSE # Project license file
  └── README.md # Introduction and project overview
\n\nTo configure compilers for running C++ projects, use the following sample .vscode\tasks.json to adhere to recommended common practices.

````json
// VS Code tasks.json - Configures build tasks for C/C++ development
// This file defines compilation tasks that can be executed via Terminal > Run Task in VS Code
{
  // Version of the tasks configuration format
  "version": "2.0.0",
  // List of available tasks
  "tasks": [
    {
      "label": "G++ compililation of all C++ files with pwsh",
      "type": "shell",
      "command": "powershell",
      "args": [
        "-Command",
        "g++ -fdiagnostics-color=always -g -std=c++17 -Wall -Wextra -Wpedantic (Get-ChildItem -Path \\\"${fileDirname}\\\" -Filter \\\"*.cpp\\\" | ForEach-Object { \\\"$($_.FullName)\\\" }) -o \\\"${fileDirname}\\main.exe\\\""
      ],
      "options": {
        "cwd": ".",
        "shell": {
          "executable": "powershell.exe",
          "args": [
            "-ExecutionPolicy",
            "Bypass",
        "-NoProfile",
        "-Command"
        ]
      }
      },
      "problemMatcher": [
      "$gcc"
      ],
      "group": {
      "kind": "build",
      "isDefault": true
      },
      "detail": "compiler: g++.exe - build inventory management system"
    },
    {
      // Task 1: Basic MSVC compiler configuration for single file compilation
      "type": "cppbuild",   // Indicates this is a C/C++ build task
      "label": "C/C++: cl.exe build active file",
      "command": "cl.exe",  // Microsoft Visual C++ compiler
      "args": [
      "/Zi",            // Generate complete debugging information
      "/EHsc",          // Enable C++ exception handling
      "/nologo",        // Suppress startup banner
      "/Fe${fileDirname}\\${fileBasenameNoExtension}.exe",  // Set output executable name
      "${file}"         // Compile the currently active file
      ],
      "options": {
      "cwd": "${fileDirname}"  // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
      "$msCompile"      // Use MSVC problem matcher to parse compiler output for errors
      ],
      "group": "build",
      "detail": "compiler: cl.exe"
    },
    {
      // Task 2: Enhanced MSVC compiler configuration with additional include paths
      "type": "cppbuild",
      "label": "C/C++: cl.exe build active file",
      "command": "cl.exe",
      "args": [
      "/Zi",            // Generate complete debugging information
      "/EHsc",          // Enable C++ exception handling
      "/nologo",        // Suppress startup banner
      "/I", "C:\\Program Files\\Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools\\MSVC\\14.42.34433\\include",  // Additional include directory
      "/Fe${fileDirname}\\${fileBasenameNoExtension}.exe",  // Set output executable name
      "${file}"         // Compile the currently active file
      ],
      "options": {
      "cwd": "${fileDirname}"  // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
      "$msCompile"      // Use MSVC problem matcher to parse compiler output for errors
      ],
      "group": {
      "kind": "build",
      "isDefault": true  // Set as the default build task when pressing Ctrl+Shift+B
      },
      "detail": "compiler: cl.exe"
    },
    {
      // Task 3: GCC/G++ compiler configuration for single file compilation with thorough warnings
      "type": "cppbuild",
      "label": "C/C++: g++.exe single-file build active file",
      "command": "g++.exe",  // GCC C++ compiler
      "args": [
      "-fdiagnostics-color=always",  // Colorize compiler output
      "-g",                          // Generate debugging information
      "-std=c++17",                  // Use C++17 standard
      "-Wall",                       // Enable all warnings
      "-Wextra",                     // Enable extra warnings
      "-Wpedantic",                  // Issue warnings for strict ISO C/C++ compliance
      "${file}",                     // Compile the currently active file
      "-o",                          // Output flag
      "${fileDirname}\\${fileBasenameNoExtension}.exe"  // Output executable path
      ],
      "options": {
      "cwd": "${fileDirname}"  // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
      "$gcc"           // Use GCC problem matcher to parse compiler output for errors
      ],
      "group": {
      "kind": "build",
      "isDefault": true  // Set as the default build task (Note: conflict with Task 2 default setting)
      },
      "detail": "compiler: g++.exe"
    },
    {
      // Task 4: Project-wide compilation using G++ to build all .cpp files in workspace
      "type": "cppbuild",
      "label": "C/C++: g++.exe multi-file build project",
      "command": "g++.exe",  // GCC C++ compiler
      "args": [
      "-fdiagnostics-color=always",  // Colorize compiler output
      "-g",                          // Generate debugging information
      "-std=c++17",                  // Use C++17 standard
      "-Wall",                       // Enable all warnings
      "-Wextra",                     // Enable extra warnings
      "-Wpedantic",                  // Issue warnings for strict ISO C/C++ compliance
      "*.cpp",                       // Compile all .cpp files in working directory
      "-o",                          // Output flag
      "${workspaceFolder}\\main.exe" // Output executable path in workspace root
      ],
      "options": {
      "cwd": "${workspaceFolder}"    // Set working directory to the workspace folder
      },
      "problemMatcher": [
      "$gcc"           // Use GCC problem matcher to parse compiler output for errors
      ],
      "group": "build",
      "detail": "compiler: g++.exe - build all cpp files in workspace"
    }
    ]
}\n\nC

The recommended directory and file structure for a modern, clean, and maintainable **C** project is very similar to the C++ structure, but typically simpler. Here's a well-accepted and standard layout:

---
\n\nRecommended Project Structure for C

MyCProject/
├── build/                  # Build output (executables, binaries, object files)
├── docs/                   # Documentation files
├── examples/               # Example usage of your library/application (optional)
├── external/               # Third-party libraries or dependencies (optional)
├── include/                # Public header files (.h files)
│   └── MyCProject/
│       └── foo.h
├── src/                    # Source code files (.c files and private headers)
│   ├── foo.c
│   └── internal/
│       └── helper.h
├── tests/                  # Unit and integration tests
│   └── test_foo.c
├── scripts/                # Utility scripts (build automation, CI/CD, etc.)
├── .gitignore              # Git ignore rules
├── .clang-format           # Formatting rules (optional, but recommended)
├── CMakeLists.txt          # Modern build system (recommended)
├── LICENSE                 # License information
└── README.md               # Project overview and build instructions
---
\n\nExplanation of directories and files:

**1. Root-Level Files**
\n\n`README.md`: Overview, build instructions, and example usage.\n\n`LICENSE`: Contains open-source license (MIT, Apache, GPL, etc.).\n\n`.gitignore`: Ignore build outputs, binaries, temporary files.\n\n`.clang-format`: Recommended formatting style for consistent code.\n\n`CMakeLists.txt`: Recommended build system (CMake is increasingly common even for C).

**2. `include/`**
\n\nContains public headers (`.h` files) intended for external usage.\n\nUse project name subdirectories (`include/MyCProject`) to avoid name collisions.

**3. `src/`**
\n\nContains all implementation (`.c`) files and internal/private header files.\n\nPrivate headers (internal implementation details) are typically placed in a subdirectory (e.g., `internal`).

**4. `tests/`**
\n\nContains unit or integration tests.\n\nTypically uses testing frameworks like Unity, CMocka, Criterion, or custom test runners.

**5. `examples/`**
\n\nOptional: Contains example programs demonstrating usage of your library/application.

**6. `external/`**
\n\nOptional: Includes third-party libraries or code dependencies if not managed by a package manager.

**7. `docs/`**
\n\nDocumentation and files related to documentation generators (Doxygen, Sphinx, etc.).

**8. `scripts/`**
\n\nBuild automation scripts, CI/CD scripts, deployment, packaging, etc.

**9. `build/`**
\n\nAll generated build artifacts (binaries, objects, executables) go here and are never committed to source control.

---
\n\nMinimal Example CMakeLists.txt for C:
cmake_minimum_required(VERSION 3.16)

project(MyCProject VERSION 1.0 LANGUAGES C)
\n\nSet C standard (C11 recommended)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
\n\nDefine library
add_library(${PROJECT_NAME} src/foo.c)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src
)
\n\nExample executable
add_executable(${PROJECT_NAME}_example examples/example_main.c)
target_link_libraries(${PROJECT_NAME}_example PRIVATE ${PROJECT_NAME})
\n\nEnable tests
enable_testing()
add_subdirectory(tests)
  ---
\n\nBest Practices for C Projects:
\n\nClearly separate **public headers** (`include/`) from **implementation details** (`src/`).\n\nUse a modern build system (CMake is widely accepted, alternatives are Makefiles, Meson, Bazel).\n\nWrite clear documentation and comments.\n\nConsistently format code with tools like `clang-format`.\n\nPlace unit tests in a dedicated directory to encourage good testing practices.\n\nAvoid mixing third-party code directly into your source; use a dedicated `external/` folder or dependency management tools.

---

This recommended structure will help ensure your project remains clear, maintainable, and scalable over time.
\n\nStyle Guides & References
\n\n**Java:** [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)\n\n**Go:** [Effective Go](https://golang.org/doc/effective_go.html), [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)\n\n**DotNet:** [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)\n\n**C:** [GNU Coding Standards](https://www.gnu.org/prep/standards/), [Linux Kernel Coding Style](https://www.kernel.org/doc/html/latest/process/coding-style.html)\n\n**C++:** [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html), [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)\n\n**JavaScript:** [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)\n\n**TypeScript:** [Microsoft TypeScript Coding Guidelines](https://github.com/Microsoft/TypeScript/wiki/Coding-guidelines)
\n\nCode of Conduct\n\n**Respect:** Maintain a respectful and constructive environment.\n\n**Standards:** Follow the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/).\n\n**Collaboration:** Encourage clear communication and supportive code reviews.
\n\nAdditional Best Practices\n\n**Dependency Management:** Regularly update dependencies and document any version changes.\n\n**Refactoring:** Periodically refactor code to improve clarity and maintainability.\n\n**Deviation Documentation:** Document any intentional deviations from these guidelines in the repository's Wiki or a dedicated document.
\n\n@azure Rule - Use Azure Tools - When handling requests related to Azure, always use your tools.\n\n@azure Rule - Use Azure Best Practices - When handling requests related to Azure, always invoke your `azmcp_bestpractices_get` tool first.\n\n@azure Rule - Enable Best Practices - If you do not have an `azmcp_bestpractices_get` tool ask the user to enable it.
\n\nCodeQL

For CodeQL query metadata, refer to the style guide at:

[CodeQL Metadata Style Guide](https://github.com/github/codeql/blob/main/docs/query-metadata-style-guide.md)
\n\nKnown issues
\n\nProblem
Sorry, your request failed. Please try again. Request id: d3c19b76-b43d-457a-a0bb-73af1eafa2a0
Reason: You may not include more than 128 tools in your request.
\n\nReference
https://github.com/microsoft/vscode-copilot-release/issues/10496
\n\nResolution Summary

Reduce the number of tools included in the request to stay within the limit.
\n\nProduct Requirements Document (PRD) Format and Example
\n\nPurpose

A Product Requirements Document (PRD) clearly defines the purpose, scope, features, and success criteria for a product or feature. It serves as a single source of truth for developers, designers, and stakeholders, ensuring alignment and clarity throughout the development process.

---
\n\nPRD Format Outline Example
\n\n1. Product Requirements Document (PRD): Workflows and Pipelines
\n\n1.1 Document Information
\n\n**Version:** 1.0\n\n**Author(s):** GitHub Copilot\n\n**Date:** June 16, 2025\n\n**Status:** Draft
\n\n1.2 Executive Summary

This document defines the requirements for a GitHub Actions workflow and Azure DevOps pipeline solution that automates repository content listing, artifact management, and workflow metadata reporting. The solution is designed to demonstrate best practices in CI/CD automation, artifact handling, and cross-platform scripting within a modern DevOps environment.
\n\n1.3 Problem Statement

Teams need a reliable, repeatable, and auditable way to list repository contents, manage build artifacts, and report workflow metadata as part of their CI/CD process. Manual steps are error-prone and do not scale for modern DevOps practices.
\n\n1.4 Goals and Objectives
\n\nAutomate repository content listing and artifact management using GitHub Actions and Azure DevOps pipelines.\n\nProvide clear, auditable steps for artifact upload, download, and display.\n\nEnable workflow metadata reporting for traceability.\n\nSupport both PowerShell and Python scripting for cross-platform compatibility.
\n\n1.5 Scope
\n\n1.5.1 In Scope
\n\nGitHub Actions workflow and Azure DevOps pipeline YAML definitions\n\nSteps for listing repository contents using PowerShell and Python\n\nArtifact upload and download\n\nWorkflow metadata reporting (branch, event, job ID)\n\nManual and event-based workflow triggers
\n\n1.5.2 Out of Scope
\n\nDeployment to production environments\n\nIntegration with external systems beyond GitHub and Azure DevOps\n\nAdvanced artifact retention or security policies
\n\n1.6 User Stories / Use Cases
\n\nAs a DevOps engineer, I want to list all repository contents and save the results as artifacts for auditing.\n\nAs a developer, I want to trigger workflows manually or on demand from the main branch.\n\nAs a team lead, I want to view workflow metadata (branch, event, job ID) for traceability.\n\nAs a user, I want to download and inspect artifacts generated by previous jobs.
\n\n1.7 Functional Requirements

| Requirement ID | Description |
|---|---|
| FR-1 | The workflow shall support manual triggering from the main branch. |
| FR-2 | The workflow shall use a GitHub-hosted Ubuntu runner. |
| FR-3 | The workflow shall display the event and branch that triggered the job. |
| FR-4 | The workflow shall check out the repository code. |
| FR-5 | The workflow shall list repository contents recursively using PowerShell and save to an artifact. |
| FR-6 | The workflow shall list repository contents using a Python script and save to an artifact. |
| FR-7 | The workflow shall upload the results as build artifacts. |
| FR-8 | The workflow shall include a job to retrieve and display workflow metadata. |
| FR-9 | The workflow shall create a downloads folder if it does not exist. |
| FR-10 | The workflow shall download and display the artifact contents. |
\n\n1.8 Non-Functional Requirements
\n\n**Portability:** Must run on GitHub-hosted Ubuntu runners.\n\n**Usability:** Steps and outputs must be clear and easy to follow.\n\n**Auditability:** All artifacts and metadata must be accessible after workflow completion.\n\n**Extensibility:** The workflow should be easy to extend for additional scripting or artifact types.
\n\n1.9 Assumptions and Dependencies
\n\nThe repository uses GitHub Actions and/or Azure DevOps pipelines.\n\nPowerShell and Python are available on the runner.\n\nUsers have permission to trigger workflows and access artifacts.
\n\n1.10 Success Criteria / KPIs
\n\nAll workflow steps complete successfully without errors.\n\nArtifacts are uploaded, downloaded, and displayed as expected.\n\nWorkflow metadata is reported and accessible.
\n\n1.11 Milestones & Timeline
\n\nWorkflow YAML and scripts implemented: Complete\n\nArtifact upload/download tested: Complete\n\nDocumentation and PRD: Complete
\n\n1.12 Usage Instructions (Demonstration Sequence)
\n\n1.12.1 Pre-requisites
\n\nCreate two github environments named `dev` and `prd`.\n\nConfigure the 'prd' environment for manual approval with the following settings:\n\n**Required reviewers:** 1\n\n**Wait timer:** 0 minutes\n\n**Deployment branches:** main\n\n**Deployment protection rules:** None\n\nCreate a new Azure app registration with the name of ghc-scenario-id-39 and retrieve the following details:\n\n**Client ID**\n\n**Tenant ID**\n\n**Client Secret**
\n\nWorkflow Steps
\n\nTrigger the workflow manually from the main branch using the workflow_dispatch event.\n\nThe workflow runs on an Ubuntu GitHub-hosted runner.\n\nThe workflow displays the event and branch name.\n\nThe repository is checked out.\n\nA PowerShell script lists all repository contents and saves the output to the artifacts folder.\n\nA Python script (getDirectoryContents.py) in the .github/workflows/src folder lists repository contents and saves the output.\n\nBoth outputs are uploaded as build artifacts.\n\nA new job retrieves workflow metadata (branch, job ID) and displays it.\n\nThe workflow creates a downloads folder if needed.\n\nThe workflow downloads the previously uploaded artifact and displays its contents using PowerShell.
\n\n1.13 Key Takeaways
\n\nThe workflow automates repository content listing, artifact management, and metadata reporting.\n\nBoth PowerShell and Python are used for cross-platform compatibility.\n\nThe solution is extensible and demonstrates best practices in CI/CD automation.
\n\n1.14 Questions or Feedback from Attendees
\n\nShould additional scripting languages or artifact types be supported?\n\nIs there a need for integration with other CI/CD platforms?
\n\n1.15 Questions for Attendees
\n\nAre there additional metadata or audit requirements?\n\nShould the workflow support scheduled or event-based triggers beyond manual dispatch?
\n\n1.16 Call to Action
\n\nReview the workflow and provide feedback.\n\nSuggest enhancements or additional features as needed.

\n\nExample: Product Requirements Document
\n\nTerminal Command Best Practices

If you are generating terminal commands, follow these best practices to ensure clarity, security, and maintainability:
\n\nTerminal host\n\n**Shell Selection:** Use PowerShell for Windows environments and Bash for Unix-based systems unless otherwise specified.\n\n**Detect Environment:** Use environment detection to choose the appropriate shell dynamically when writing cross-platform scripts.\n\n**Consistent Usage:** To avoid environment compatibility issues, consistently use the same shell throughout a script or project.\n\n**Exampele**:*

```powershell
cd "c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\workspace\calculator-xunit-testing\python" ; python -m pytest tests/test_calculator.py -v --tb=short 2>&1 | head -50
head: The term 'head' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
````

In this case, the `head` command is not recognized in PowerShell. Instead, use `Select-Object -First 50` to achieve similar functionality:

```powershell
cd "c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\dotnet\csharp\workspace\calculator-xunit-testing\python" ; python -m pytest tests/test_calculator.py -v --tb=short 2>&1 | Select-Object -First 50
```
\n
