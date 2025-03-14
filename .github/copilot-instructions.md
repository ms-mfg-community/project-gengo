# GitHub Copilot Instructions

## Purpose
This file provides custom instructions for using GitHub Copilot in this repository. It helps ensure that both human contributors and AI-generated code adhere to our project's standards, coding practices, and overall quality requirements.

## General Guidelines [Vibe Coding](https://youtu.be/YWwS911iLhg?si=TEdJIIqGryZdjezy)
- Always prefer simple solutions.
- Avoid duplication of code whenever possible, which means checking for other areas of the codebase that might already have simlar code and functionality.
- Write code that takes into account hte different environments, for example; dev, test and prod.
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
- Avoid making major changes to the patterns and architecture of how a feature works, after it has been proven to work properly, unless explicitly promted to do so.
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

## Commit Messages
- **Format:** Use the following pattern:
- Topic Subtopic Activity Specification: **_topic(subtopic): activity_**
  - Example: `github(instructions): expand guideline details`

### Key Points:
- **Topic:** Indicates the nature of the commit (e.g., `github` for github specific files, commands, or configuration, `feat` for a new feature, `fix` for a bug fix, `docs` for documentation changes, etc.).
- **Subtopic (optional):** An attributive or adjunct noun acting as a modifier or a certain scope for the topic that adds additional context. (e.g., `instructions`, `auth`, `ui`, `build`).
- **Activity:** A concise, imperative description of the change.

For example:
```
feat(auth): add login functionality
```
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
- End control structures, loops and functions with `#end if,#end for,#end forach, #end while,#end until,#end case, #end FunctionName`.
- Place each opening bracket '{' on a new line for each scope within a foreach, while, until, for loop or function block. For example:
```powershell
foreach ($item in $contents)
{
    Write-Host "Name: $($item.Name)"
    Write-Host "Full Name: $($item.FullName)"
    Write-Host "Size: $($item.Length) bytes"
    Write-Host "Last Modified: $($item.LastWriteTime)"
    Write-Host "-----------------------------"
} # end foreach
```
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
