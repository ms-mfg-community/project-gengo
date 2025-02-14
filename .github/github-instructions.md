# GitHub Copilot Instructions

## Purpose
This file provides custom instructions for using GitHub Copilot in this repository. These guidelines help ensure that Copilot generates code that aligns with our project's standards and practices.

## Code Style
- Follow the PEP 8 style guide for Python code.
- Use 4 spaces for indentation.
- Ensure all variable names are descriptive and use snake_case.

## Commenting
- Write clear and concise comments for complex code blocks.
- Use docstrings for all functions and classes.
- Include TODO comments for any incomplete or future work.

## Testing
- Write unit tests for all new features and bug fixes.
- Use pytest for running tests.
- Ensure all tests pass before committing code.

## Documentation
- Update the `README.md` file with any new instructions or changes.
- Use Sphinx for generating project documentation.
- Ensure documentation is clear and easy to follow.

## Commit Messages
- Use the 'primary-noun(secondary-noun): verb or activity' description format for all commit messages, in lowercase and without a period '.'. For example: `github(instructions): update`.
- Keep messages short and descriptive.
- Reference relevant issues or pull requests.

## Branching Strategy
- Use the `main` branch for production-ready code.
- Create feature branches from `main` using the format `feature/your-feature-name`.
- Merge feature branches into `main` only after code review and approval.

## Pull Request Process
- Ensure your code passes all tests before submitting a pull request.
- Provide a detailed description of the changes and the problem they solve.
- Request a review from at least one other team member.

## Code of Conduct
- Be respectful and considerate in all interactions.
- Follow the Contributor Covenant Code of Conduct.

## Language specific instructions

### PowerShell
- When writing powershell code blocks, like if, for, or functions, use #end at the end of each block.

Thank you for using GitHub Copilot and contributing to our project! Your efforts are greatly appreciated.