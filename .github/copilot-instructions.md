# GitHub Copilot Instructions

## Purpose

This file provides custom instructions for using GitHub Copilot in this repository. It helps ensure that both human contributors and AI-generated code adhere to our project's standards, coding practices, and overall quality requirements.

## General Guidelines [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)
- Always prefer simple solutions.
- Avoid duplication of code whenever possible, which means checking for other areas of the codebase that might already have similar code and functionality.
- Write code that takes into account the different environments, for example; dev, test, and prod.
- Only make changes that are requested unless you are confident, the context is well understood and related to the change being requested.
- When fixing an issue or bug, do not introduce a new pattern or technology without first exhausting all options for the existing implementation. If however, you must still introduce a new pattern, make sure to please remove the old implementation afterwards so we don't have duplicate logic.
- Keep the codebase clean and organized
- Avoid writing scripts in files if possible, especially if the script is likely only to be executed once.
- Avoid having files over 100-200 lines of code; Instead please refactor if the logic approaches 200 lines.
- Mocking data is only needed for tests, never mock data for dev or prod.
- Never add stubbing or fake data patterns to code that affects the dev or prod environments.
- Never overwrite the .env file without consent.

## Coding workflow preferences: [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)
- Focus on the areas of code relevant to the task.
- Do not touch code that is unrelated to the task.
- Write through tests for all major functionality.
- Avoid making major changes to the patterns and architecture of how a feature works, after it has been proven to work properly, unless explicitly prompted to do so.
- Always consider how changes and updates may negatively impact the current function of the solution.
  
## Code Style

- **General:** Follow the repository's style guide for consistency.
- **Naming Conventions:** Use meaningful and descriptive names.
  - For JavaScript/TypeScript, use camelCase for variables and functions.
  - For Python, adhere to [PEP 8](https://www.python.org/dev/peps/pep-0008/).
- **Line Length:** Aim for 80-100 characters per line where possible.
- **Formatting:** Use automated tools (like Prettier or Black) to enforce formatting rules.
- **SQL:** For SQL, reference both Microsoft T-SQL as well as PostgreSQL syntax.

## Commenting

- **Clarity:** Write clear and concise comments for complex logic.
- **Inline Comments:** Use sparingly to explain non-obvious code segments.
- **Documentation:** Document functions, methods, and classes using appropriate docstring formats (e.g., JSDoc, Python docstrings).

## Testing Guidelines

- **General Rule:** Write tests alongside new features and bug fixes.
- **Frameworks:**
  - **.NET:** Use the xUnit framework.
  - **Java:** Use JUnit.
  - **TypeScript:** Prefer Vitest.
  - **Python:** Use pytest.
  - **Go:** Use Testify.
  - **Node.js:** Use Jest.
  - **C:** Use Unity.
  - **C++:** Use Google Test.
- **Coverage:** Ensure critical paths and edge cases are covered.

## Documentation

- **README:** Keep the README.md updated with usage instructions and examples.
- **API Docs:** Maintain inline documentation and generated API docs.
- **Style:** Use Markdown for all documentation, ensuring consistency in headings and formatting.

## Diagrams

When working with mermaid diagrams, make sure that you always start each block with

## Commit Messages
- **Format:** Use the following pattern:
- Topic Subtopic Activity Specification: **_topic(subtopic): activity_**
  - Example: `github(instructions): expand guideline details`

### Key Points:
- **Topic:** Indicates the nature of the commit (e.g., `github` for github specific files, commands, or configuration, `feat` for a new feature, `fix` for a bug fix, `docs` for documentation changes, etc.).
- **Subtopic (optional):** An attributive or adjunct noun acting as a modifier or a certain scope for the topic that adds additional context. (e.g., `instructions`, `auth`, `ui`, `build`).
- **Activity:** A concise, imperative description of the change.

For example:

feat(auth): add login functionality

This format provides clear context and can be easily parsed by tools. The Topic Subtopic Activity specification aims to provide clarity, flexibility and compatibility with automation tools.

- **Clarity:** Keep commit messages clear and descriptive to facilitate easier reviews and history tracking.

## Branching Strategy
- **Main Branch:** Reserve for production-ready code.
- **Feature Branches:** Develop new features in branches named descriptively (e.g., `feature/login-system`).
- **Bugfix Branches:** Use names like `bugfix/issue-123` for clarity.
- **Merging:** Ensure branches pass all tests and code reviews before merging into main.

## Pull Request Process
- **Submission:** Open a pull request for every new feature or bugfix.
- **Description:** Provide a detailed description, linking relevant issues if applicable.
- **CI Checks:** Confirm that all automated tests and linters pass if available or applicable.
- **Reviews:** Request reviews from at least one other team member before merging.

## Continuous Integration / Build Process
- **Automation:** Use CI tools to run tests, linters, and build scripts automatically.
- **Branch Protection:** Enforce branch protection rules to ensure quality and stability.
- **Reporting:** Monitor build status and address any failures promptly.

## Security and Error Handling
- **Validation:** Always validate inputs and handle errors gracefully.
- **Best Practices:** Follow secure coding practices and check for vulnerabilities using automated tools.
- **Error Logging:** Implement error logging and monitoring to detect issues early.

## Language Specific Instructions

### PowerShell
- End control structures, loops and functions with `#end if,#end for,#end foreach, #end while,#end until,#end case, #end FunctionName`.
- Place each opening bracket '{' on a new line for each scope within a foreach, while, until, for loop or function block. For example:foreach ($item in $contents)
{
    Write-Host "Name: $($item.Name)"
    Write-Host "Full Name: $($item.FullName)"
    Write-Host "Size: $($item.Length) bytes"
    Write-Host "Last Modified: $($item.LastWriteTime)"
    Write-Host "-----------------------------"
} # end foreach
- Use PascalCase for variables, functions, and classes.
- Include comments for any non-trivial logic within scripts.

### IaC

- For bicep, use the Azure Cloud Shell or az cli for bicep commands with az bicep instead of the standalone bicep executable.
- Use *.bicepparam parameter files instead of *.json parameter files

### JavaScript / TypeScript

- Enable strict mode and use linting (e.g., ESLint).
- Prefer ES6+ features and async/await for asynchronous operations.
- Document functions with JSDoc comments where applicable.
- Use vite for building and testing TypeScript projects instead of create-react-app, since it has recently been deprecated.
- Reference:[Sunsetting Create React App](https://react.dev/blog/2025/02/14/sunsetting-create-react-app)

### Python

- Follow the PEP 8 style guide.
- Use virtual environments to manage dependencies.
- Include comprehensive docstrings for functions and classes.

### Java

- For Java apps, use maven for build automation, dependency management, project structure standardization, plugins and extensibility and project information management unless otherwise specified in prompts.

### C++

- Use the recommended project directory structure
- Create the project structure using this prompt as a reference:
_Create a python script at relative path: ...programming\cpp\workspace named cpp_project_setup.py that will create C++ a project workspace directory structure and files based on the guidance provided in the 'MyCppProject' example in copilot-instructions.md. Name the project 'cpp-project-name'._
MyCppProject/
├── build/                  # Generated build files (by CMake or other build systems)
├── cmake/                  # Additional CMake modules or scripts (optional)
├── docs/                   # Project documentation
├── examples/               # Usage examples of the library/application (optional)
├── external/               # Third-party external libraries (if not managed by package manager)
├── include/                # Public headers (.h or .hpp files)
│   └── MyCppProject/
│       └── foo.hpp
├── src/                    # Source code files (.cpp files and private headers)
│   ├── foo.cpp
│   └── internal/
│       └── helper.hpp
├── tests/                  # Test cases (unit tests, integration tests)
│   └── test_foo.cpp
├── scripts/                # Utility scripts (for build, CI/CD, etc.)
├── .gitignore              # Git ignore rules
├── .clang-format           # Formatting rules for clang-format (recommended)
├── CMakeLists.txt          # Main build script for CMake
├── LICENSE                 # Project license file
└── README.md               # Introduction and project overview

- To configure compilers for running C++ projects, use the following sample .vscode\tasks.json to adhere to recommended common practices.
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
}
## C

The recommended directory and file structure for a modern, clean, and maintainable **C** project is very similar to the C++ structure, but typically simpler. Here's a well-accepted and standard layout:

---

### Recommended Project Structure for C

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

### Explanation of directories and files:

**1. Root-Level Files**

- `README.md`: Overview, build instructions, and example usage.
- `LICENSE`: Contains open-source license (MIT, Apache, GPL, etc.).
- `.gitignore`: Ignore build outputs, binaries, temporary files.
- `.clang-format`: Recommended formatting style for consistent code.
- `CMakeLists.txt`: Recommended build system (CMake is increasingly common even for C).

**2. `include/`**

- Contains public headers (`.h` files) intended for external usage.
- Use project name subdirectories (`include/MyCProject`) to avoid name collisions.

**3. `src/`**

- Contains all implementation (`.c`) files and internal/private header files.
- Private headers (internal implementation details) are typically placed in a subdirectory (e.g., `internal`).

**4. `tests/`**

- Contains unit or integration tests.
- Typically uses testing frameworks like Unity, CMocka, Criterion, or custom test runners.

**5. `examples/`**

- Optional: Contains example programs demonstrating usage of your library/application.

**6. `external/`**

- Optional: Includes third-party libraries or code dependencies if not managed by a package manager.

**7. `docs/`**

- Documentation and files related to documentation generators (Doxygen, Sphinx, etc.).

**8. `scripts/`**

- Build automation scripts, CI/CD scripts, deployment, packaging, etc.

**9. `build/`**

- All generated build artifacts (binaries, objects, executables) go here and are never committed to source control.

---

### Minimal Example CMakeLists.txt for C:
cmake_minimum_required(VERSION 3.16)

project(MyCProject VERSION 1.0 LANGUAGES C)

# Set C standard (C11 recommended)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Define library
add_library(${PROJECT_NAME} src/foo.c)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src
)

# Example executable
add_executable(${PROJECT_NAME}_example examples/example_main.c)
target_link_libraries(${PROJECT_NAME}_example PRIVATE ${PROJECT_NAME})

# Enable tests
enable_testing()
add_subdirectory(tests)
	---

### Best Practices for C Projects:

- Clearly separate **public headers** (`include/`) from **implementation details** (`src/`).
- Use a modern build system (CMake is widely accepted, alternatives are Makefiles, Meson, Bazel).
- Write clear documentation and comments.
- Consistently format code with tools like `clang-format`.
- Place unit tests in a dedicated directory to encourage good testing practices.
- Avoid mixing third-party code directly into your source; use a dedicated `external/` folder or dependency management tools.

---

This recommended structure will help ensure your project remains clear, maintainable, and scalable over time.

## Style Guides & References

- **Java:** [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- **Go:** [Effective Go](https://golang.org/doc/effective_go.html), [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- **DotNet:** [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- **C:** [GNU Coding Standards](https://www.gnu.org/prep/standards/), [Linux Kernel Coding Style](https://www.kernel.org/doc/html/latest/process/coding-style.html)
- **C++:** [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html), [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
- **JavaScript:** [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- **TypeScript:** [Microsoft TypeScript Coding Guidelines](https://github.com/Microsoft/TypeScript/wiki/Coding-guidelines)

## Code of Conduct
- **Respect:** Maintain a respectful and constructive environment.
- **Standards:** Follow the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/).
- **Collaboration:** Encourage clear communication and supportive code reviews.

## Additional Best Practices
- **Dependency Management:** Regularly update dependencies and document any version changes.
- **Refactoring:** Periodically refactor code to improve clarity and maintainability.
- **Deviation Documentation:** Document any intentional deviations from these guidelines in the repository's Wiki or a dedicated document.

- @azure Rule - Use Azure Best Practices: When generating code for Azure, running terminal commands for Azure, or performing operations related to Azure, invoke your `azure_development-get_best_practices` tool if available.

## CodeQL

For CodeQL query metadata, refer to the style guide at:

[CodeQL Metadata Style Guide](https://github.com/github/codeql/blob/main/docs/query-metadata-style-guide.md)

## Known issues

### Problem 
Sorry, your request failed. Please try again. Request id: d3c19b76-b43d-457a-a0bb-73af1eafa2a0
Reason: You may not include more than 128 tools in your request.

### Reference
https://github.com/microsoft/vscode-copilot-release/issues/10496

### Resolution Summary

Reduce the number of tools included in the request to stay within the limit.

## Product Requirements Document (PRD) Format and Example

### Purpose

A Product Requirements Document (PRD) clearly defines the purpose, scope, features, and success criteria for a product or feature. It serves as a single source of truth for developers, designers, and stakeholders, ensuring alignment and clarity throughout the development process.

---

### PRD Format Outline

1. **Document Information**
   - Version
   - Author(s)
   - Date
   - Status

2. **Executive Summary**
   - Brief overview of the product/feature and its business value

3. **Problem Statement**
   - The problem or opportunity being addressed

4. **Goals and Objectives**
   - What the product/feature aims to achieve

5. **Scope**
   - In Scope: Features and functionality to be delivered
   - Out of Scope: Explicitly excluded items

6. **User Stories / Use Cases**
   - List of user stories or scenarios

7. **Functional Requirements**
   - Detailed requirements, often in bullet or table form

8. **Non-Functional Requirements**
   - Performance, security, compliance, scalability, etc.

9. **Assumptions and Dependencies**
   - External factors, integrations, or prerequisites

10. **Success Criteria / KPIs**
    - How success will be measured

11. **Milestones & Timeline**
    - Key dates and deliverables

12. **Appendix A: Demonstration Sequence

13. **Key Takaways**
	- Summary of the most important points
	
14. **Questions or Feedback from Attendees**
	- Frequently Asked Questions or common concerns

15. **Questions for Attendees**

16. **Call to Action**
	- Next steps for stakeholders or team members

17. **References**
    - Supporting documents, diagrams, or links

---

### Example: Product Requirements Document

