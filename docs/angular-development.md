# GitHub Copilot Persona Templates for .NET/Angular Development

This repository contains example template markdown files for GitHub Copilot that facilitate various development personas in a .NET backend and Angular frontend application development lifecycle. These templates demonstrate how to leverage GitHub Copilot's customization features including custom agents, instructions, prompts, and skills to accelerate development across different roles.

## Overview

GitHub Copilot can be customized to adopt different personas tailored to specific development roles and tasks. This collection provides ready-to-use templates for seven key personas commonly found in software development teams working with .NET and Angular applications.

## Personas Included

The following personas are included in this template collection, each with their own set of custom agents, instructions, prompts, and skills:

### 1. Software (SW) Developer
**Focus:** Code completion, boilerplate generation, refactoring, debugging, API integration, and documentation for .NET and Angular applications.

**Key Capabilities:**
- Generates C# and TypeScript code following best practices
- Creates boilerplate code for new features
- Assists with SOLID principles and design patterns
- Supports multi-language development across the stack

### 2. SW Tester/QA Engineer
**Focus:** Automated test case generation, edge case identification, test data creation, and regression testing for .NET and Angular applications.

**Key Capabilities:**
- Generates unit tests using xUnit, NUnit, Jasmine, and Karma
- Creates test cases following the Arrange-Act-Assert pattern
- Identifies edge cases and negative scenarios
- Supports Playwright for end-to-end testing

### 3. Database Administrator (DBA)
**Focus:** SQL query optimization, schema design, stored procedures, indexing, and data migration for SQL Server and Azure SQL Database.

**Key Capabilities:**
- Optimizes SQL queries and analyzes execution plans
- Designs database schemas and suggests improvements
- Generates stored procedures and migration scripts
- Provides indexing recommendations

### 4. DevOps/Platform Engineer
**Focus:** Infrastructure as Code (IaC), CI/CD pipeline automation, containerization, and system monitoring for Azure environments.

**Key Capabilities:**
- Creates Azure DevOps and GitHub Actions pipelines
- Generates Bicep and Terraform templates
- Writes Docker and Kubernetes configurations
- Develops shell scripts for automation

### 5. Security Engineer
**Focus:** Secure coding practices, vulnerability identification, threat modeling, security policy enforcement, and compliance for .NET and Angular applications.

**Key Capabilities:**
- Identifies OWASP Top 10 vulnerabilities
- Suggests secure coding patterns
- Reviews code for security flaws
- Recommends encryption and authentication best practices

### 6. Project Manager
**Focus:** Project planning, user story creation, effort estimation, sprint planning, and risk management using Agile methodologies.

**Key Capabilities:**
- Creates well-formed user stories with acceptance criteria
- Generates project plans and milestones
- Estimates effort and identifies risks
- Facilitates sprint planning and backlog refinement

### 7. Data Scientist
**Focus:** Data analysis, exploratory data analysis (EDA), model prototyping, feature engineering, and ML pipeline automation.

**Key Capabilities:**
- Performs data cleaning and transformation
- Creates visualizations using Matplotlib and Seaborn
- Develops machine learning models with scikit-learn, TensorFlow, and PyTorch
- Generates experiment tracking and reporting code

## Directory Structure

Each persona has its own directory containing the following files:

```
persona-name/
├── persona-name.agent.md          # Custom agent definition
├── copilot-instructions.md        # File pattern-based instructions
├── prompts/                       # Task-specific prompts
│   └── example-prompt.prompt.md
└── skills/                        # Specialized skills
    └── skill-name/
        └── SKILL.md
```

## File Types Explained

### Custom Agents (`.agent.md`)

Custom agents define specialized personas with specific behaviors, available tools, and handoff capabilities. They are stored in the `.github/agents/` folder of your workspace or in your VS Code user profile.

**Key Features:**
- Define persona-specific instructions and guidelines
- Restrict available tools to match the role's needs
- Enable handoffs to other agents for sequential workflows
- Specify which AI model to use

**Usage:** Select the custom agent from the agents dropdown in GitHub Copilot Chat to activate the persona.

### Custom Instructions (`.instructions.md`)

Custom instructions provide file pattern-based guidelines that are automatically applied when working with matching files. The main instruction file is typically named `copilot-instructions.md` and placed in the `.github/` folder.

**Key Features:**
- Automatically applied based on file patterns (glob syntax)
- Define coding standards and best practices
- Can be workspace-level or user-level
- Applied to all chat requests for matching files

**Usage:** Instructions are automatically applied when you work with files matching the specified patterns.

### Prompt Files (`.prompt.md`)

Prompt files are reusable, task-specific prompts that can be invoked on-demand. They are stored in the `.github/prompts/` folder of your workspace or in your VS Code user profile.

**Key Features:**
- Reusable prompts for common tasks
- Support variables like `${workspaceFolder}`, `${selection}`, `${file}`
- Can accept input variables from the user
- Can specify which agent to use

**Usage:** Type `/` in GitHub Copilot Chat followed by the prompt name to invoke it.

### Skills (`SKILL.md`)

Skills are self-contained folders with instructions and bundled resources that enhance AI capabilities for specialized tasks.

**Key Features:**
- Directory-based organization with supporting files
- Provide specialized knowledge and workflows
- Can include templates, scripts, and other resources

**Usage:** Reference the skill instructions in your custom agent or prompt files.

## Installation and Usage

### Installing Custom Agents

1. Copy the desired persona's `.agent.md` file to one of these locations:
   - **Workspace-level:** `.github/agents/` folder in your repository
   - **User-level:** Your VS Code user profile folder

2. Open GitHub Copilot Chat in VS Code
3. Select the custom agent from the agents dropdown at the bottom of the chat view

### Installing Custom Instructions

1. Copy the `copilot-instructions.md` file to the `.github/` folder in your repository
2. The instructions will automatically apply when working with files matching the specified patterns

### Installing Prompt Files

1. Copy the `.prompt.md` files to one of these locations:
   - **Workspace-level:** `.github/prompts/` folder in your repository
   - **User-level:** Your VS Code user profile folder

2. In GitHub Copilot Chat, type `/` followed by the prompt name to invoke it

### Using Skills

Skills can be referenced in your custom agent or prompt files by including their instructions inline or by referencing the skill directory.

## Customization

These templates are designed to be starting points. You can customize them to match your team's specific needs:

- **Modify instructions:** Update the guidelines to reflect your team's coding standards
- **Add or remove tools:** Adjust the `tools` list in custom agents to match available capabilities
- **Create handoffs:** Define workflows between agents using the `handoffs` field
- **Add variables:** Use variables in prompt files to make them more flexible
- **Extend skills:** Add additional resources and templates to skill directories

## Agent Handoffs

Agent handoffs enable guided sequential workflows that transition between agents with suggested next steps. This is particularly useful for orchestrating multi-step processes:

**Example Workflows:**
- **SW Developer → SW Tester:** After implementing a feature, hand off to the tester to generate tests
- **SW Developer → Security Engineer:** After writing code, hand off to security for vulnerability review
- **Project Manager → SW Developer:** After creating user stories, hand off to developers for implementation
- **DevOps Engineer → Security Engineer:** After creating infrastructure, hand off to security for review

Handoffs are defined in the custom agent's YAML frontmatter:

```yaml
handoffs:
  - label: Generate Tests
    agent: sw-tester
    prompt: Generate unit tests for the code above.
    send: false
```

## Tool Reference Syntax

When referencing agent tools in the body text of custom agents, instructions, or prompts, use the `#tool:toolName` syntax:

- `#tool:githubRepo` - Access GitHub repository information
- `#tool:search` - Search capabilities
- `#tool:fetch` - Fetch web content
- `#tool:codebase` - Access codebase context
- `#tool:usages` - Find code usages

## Best Practices

### For Custom Agents
- Keep instructions clear and focused on the persona's primary responsibilities
- Limit tools to only those needed for the role to prevent confusion
- Use handoffs to create smooth transitions between related tasks
- Test agents with realistic scenarios to ensure they behave as expected

### For Custom Instructions
- Use specific file patterns to avoid applying instructions too broadly
- Keep guidelines concise and actionable
- Focus on language-specific and framework-specific best practices
- Update instructions as your team's standards evolve

### For Prompt Files
- Write prompts that are clear and unambiguous
- Use variables to make prompts flexible and reusable
- Include examples in the prompt body when appropriate
- Test prompts with different inputs to ensure consistent results

### For Skills
- Organize skills by domain or technology area
- Include comprehensive documentation in the SKILL.md file
- Provide examples and usage instructions
- Keep supporting resources up to date

## Integration with MCP (Model Context Protocol)

Custom agents can integrate with MCP servers to provide enhanced capabilities. To include MCP tools in your custom agent, add them to the `tools` list using the format `servername/*` to include all tools from a specific server.

Example:
```yaml
tools: ['githubRepo', 'search', 'myMcpServer/*']
```

## Limitations and Workarounds

### Current Limitations
- Custom agents are available as of VS Code release 1.106
- Some tools may not be available in all environments
- MCP integration requires additional configuration

### Workarounds
- If a tool is not available, the agent will ignore it and continue
- Use custom instructions as a fallback when agents are not available
- Manually include skill instructions in agent definitions if needed
- Test in your specific environment to identify limitations

## Testing with Playwright

For testing scenarios, the templates include support for Playwright with both Jest and PyTest:

### Playwright with Jest (TypeScript)
- Use for Angular frontend testing
- Configure in `playwright.config.ts`
- Run tests with `npx playwright test`

### Playwright with PyTest (Python)
- Use for API and integration testing
- Install with `pip install pytest-playwright`
- Run tests with `pytest`

## Modernization Scenarios

These templates support modernization scenarios for .NET applications:

- **Upgrading from .NET 6.0 to .NET 8.0:** Use the SW Developer agent to identify breaking changes and suggest updates
- **Migrating to Azure:** Use the DevOps/Platform Engineer agent to generate IaC templates
- **Implementing security best practices:** Use the Security Engineer agent to review and update code
- **Adding automated testing:** Use the SW Tester/QA Engineer agent to generate comprehensive test suites

## Contributing

These templates are designed to be extended and improved. Consider:

- Adding new personas for additional roles (e.g., UX Designer, Technical Writer)
- Creating more specialized prompts for common tasks
- Developing additional skills for specific technologies
- Sharing your customizations with the community

## Resources

- [VS Code Custom Agents Documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [VS Code Custom Instructions Documentation](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [VS Code Prompt Files Documentation](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [GitHub Awesome Copilot Repository](https://github.com/github/awesome-copilot)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

## License

These templates are provided as examples for educational and demonstration purposes. Feel free to use, modify, and distribute them as needed for your projects.

---

**Last Updated:** January 2026  
**Version:** 1.0
