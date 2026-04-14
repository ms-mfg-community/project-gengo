# GitHub Copilot Custom Agents for Project Gengo

This directory contains custom GitHub Copilot agents tailored to the project-gengo repository. These agents embody different expertise personas that can be invoked to get specialized guidance and assistance across various aspects of the project.

## Quick Start

To use an agent, reference it in Copilot Chat:

```text
@agent-name Your question or task
```

For example:

```text
@sw-developer Create a new Calculator API endpoint
@security-engineer Review this authentication implementation
@devops-engineer Set up a CI/CD pipeline for this service
```

---

## Available Agents

### Development & Architecture

#### [`architect`](architect.agent.md)
Expert in system design, architectural patterns, scalability, and technical decision-making for complex systems.

**Use for**: Designing system architecture, evaluating design patterns, making technical decisions, planning scalability.

#### [`sw-developer`](sw-developer.agent.md)
Assists with common software development tasks for .NET and Angular. Includes handoffs to `sw-tester` and `devops-engineer`.

**Use for**: Implementing features, fixing bugs, refactoring code in .NET/Angular, code reviews.

#### [`azure-architect`](azure-architect.agent.md)
Specialized in Azure cloud architecture and cloud-native design patterns.

**Use for**: Azure infrastructure design, cloud migration planning, cost optimization, cloud-native architecture.

#### [`data-scientist`](data-scientist.agent.md)
Specializes in data analysis, machine learning, and data-driven solutions.

**Use for**: Data analysis, building ML models, statistical analysis, data processing pipelines.

---

### Database & Infrastructure

#### [`dba`](dba.agent.md)
Database administration expert with general relational database knowledge.

**Use for**: Database design, query optimization, performance tuning, backup/recovery strategies.

#### [`ms-sql-dba`](ms-sql-dba.agent.md)
Specialized database administrator focused on Microsoft SQL Server.

**Use for**: SQL Server administration, T-SQL optimization, security, replication, high availability.

#### [`devops-engineer`](devops-engineer.agent.md)
DevOps specialist for CI/CD pipelines, infrastructure as code, and deployment automation.

**Use for**: Creating/updating pipelines, automation, containers, infrastructure, monitoring setup.

---

### Security & Testing

#### [`security-engineer`](security-engineer.agent.md)
Security expert specializing in vulnerability detection, threat modeling, and security best practices.

**Use for**: Security audits, vulnerability assessment, threat modeling, compliance verification, security design review.

#### [`sw-tester`](sw-tester.agent.md)
QA and testing specialist focused on test strategy, automation, and quality assurance.

**Use for**: Test plan creation, test automation, quality metrics, bug analysis, testing strategy.

---

### Documentation & Code Quality

#### [`readme-creator`](readme-creator.agent.md)
Documentation specialist focused on creating and updating README files and related documentation.

**Use for**: Creating READMEs, writing documentation, structuring guides, API documentation.

#### [`linter`](linter.agent.md)
Code quality and linting expert for enforcing standards and fixing code style issues.

**Use for**: Code style violations, linting rules, formatting, code cleanup, standards enforcement.

#### [`markdown-lint-editor`](markdown-lint-editor.agent.md)
Markdown formatting and linting specialist for documentation quality.

**Use for**: Formatting markdown, linting documentation, fixing formatting issues, style consistency.

---

### Project Management & Tools

#### [`project-manager`](project-manager.agent.md)
Project management expert for planning, tracking, and coordination.

**Use for**: Project planning, milestone tracking, resource allocation, timeline estimation.

#### [`ado-boards`](ado-boards.agent.md)
Azure DevOps Boards specialist for work item management and tracking.

**Use for**: Creating work items, managing sprints, board organization, linking items.

---

### Custom/Sandbox

#### [`my-agent`](my-agent.agent.md)
Template or custom agent for user-specific extensions.

**Use for**: Custom workflows, personal preferences, experimental personas.

---

## How to Choose an Agent

| Task | Recommended Agent |
|------|------------------|
| System architecture design | `architect`, `azure-architect` |
| Implement features | `sw-developer` |
| Review code quality & security | `security-engineer`, `linter` |
| Database work | `dba`, `ms-sql-dba` |
| CI/CD & deployment | `devops-engineer` |
| Testing & QA | `sw-tester` |
| Create documentation | `readme-creator`, `markdown-lint-editor` |
| Data analysis & ML | `data-scientist` |
| Work item tracking | `ado-boards`, `project-manager` |

---

## Agent Handoffs

Some agents have configured handoffs to related agents. These appear as suggestions during chat and allow seamless transitions:

- `sw-developer` → `sw-tester` (for test generation)
- `sw-developer` → `devops-engineer` (for deployment feedback)
- `readme-creator` → `markdown-lint-editor` (for markdown formatting)

---

## Creating Custom Agents

To create a new custom agent:

1. Create a new `.agent.md` file with frontmatter and documentation
2. Include required fields: `name`, `description`, `target`, `model`
3. Add optional fields: `tools`, `handoffs`, `argument-hint`
4. Document the agent's purpose and usage in the file

See [Creating a Custom Agent (GitHub Docs)](https://docs.github.com/en/copilot/concepts/agents/coding-agent/creating-a-custom-agent) for detailed guidance.

---

## References

- [GitHub Copilot Custom Agents](https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-custom-agents)
- [Creating a Custom Agent](https://docs.github.com/en/copilot/concepts/agents/coding-agent/creating-a-custom-agent)
- [Agent Best Practices](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Project Gengo Copilot Instructions](./../copilot-instructions.md)

**Example Prompt**:
> @security-auditor Audit this TypeScript service for security vulnerabilities, focusing on input validation and authentication handling.

---

### 5. Architecture & Design Consultant (`architect.agent.md`)

**Persona**: System architect specializing in design patterns, scalability, and technical decision-making

**Use When**:
- Planning system architecture
- Making technology decisions
- Reviewing architectural designs
- Assessing scalability approach
- Evaluating trade-offs
- Designing data models

**Capabilities**:
- System design guidance
- Architectural pattern selection
- Scalability assessment
- Trade-off analysis
- Technology evaluation
- Performance optimization strategy

**Example Prompt**:
> @architect Design a microservices architecture for a new real-time data processing system. Consider scalability, reliability, and technology choices.

---

### 6. Testing & Quality Automation Expert (`testing-expert.agent.md`)

**Persona**: Testing specialist focused on test strategy, automation frameworks, and coverage analysis

**Use When**:
- Creating test strategies
- Writing test suites
- Improving test coverage
- Selecting testing frameworks
- Fixing flaky tests
- Performance testing

**Capabilities**:
- Test framework selection and setup
- Test coverage analysis and improvement
- Mocking and stubbing patterns
- Performance testing design
- CI/CD test automation
- Test maintenance strategies

**Example Prompt**:
> @testing-expert Create a comprehensive test suite for a Python microservice using pytest, including unit, integration, and API tests with >80% coverage.

---

### 7. Documentation & Developer Experience Expert (`documentation-expert.agent.md`)

**Persona**: Documentation specialist focused on technical writing, API docs, and developer onboarding

**Use When**:
- Writing API documentation
- Creating architecture documentation
- Improving developer onboarding
- Writing README files
- Creating troubleshooting guides
- Organizing documentation structure

**Capabilities**:
- API documentation generation
- Code comment and docstring guidance
- Developer onboarding guide creation
- Documentation structure design
- Clarity and accessibility improvement
- Developer experience enhancement

**Example Prompt**:
> @documentation-expert Create comprehensive API documentation for our REST endpoints, including authentication, examples, and error codes.

---

### How to Use Agents

### In VS Code with GitHub Copilot

1. Open the Chat panel (Ctrl+L or Cmd+L)
2. Reference an agent with `@agent-name`
3. Ask your question or provide context
4. The agent responds with specialized guidance

### Example Usage Flow

```text
You: @code-reviewer Review this pull request for security issues
Copilot: I'll analyze the code for security vulnerabilities, performance concerns, and testing coverage...

You: @multi-language-engineer How should I implement user authentication in Python?
Copilot: I recommend using [framework] following [pattern] as outlined in our project standards...

You: @testing-expert My test coverage is only 45%, how can I improve it?
Copilot: Let's increase coverage by focusing on critical paths and untested error cases...
```

## Agent Capabilities Matrix

| Task | Code Reviewer | Engineer | DevOps | Security | Architect | Testing | Docs |
|------|---|---|---|---|---|---|---|
| Code Review | ✅ | ✅ |  | ✅ |  |  |  |
| Feature Implementation |  | ✅ |  |  |  |  |  |
| Pipeline Design |  |  | ✅ |  |  |  |  |
| Security Audit |  |  |  | ✅ |  |  |  |
| Architecture Planning |  |  |  |  | ✅ |  |  |
| Test Strategy |  |  |  |  |  | ✅ |  |
| Documentation |  |  |  |  |  |  | ✅ |

## Project Context

These agents are specifically configured for the project-gengo repository, which includes:

- **Languages**: Python, TypeScript/JavaScript, C/C++, Java, C#/.NET, Go, PowerShell
- **Frameworks**: FastAPI, Flask, React, Vue, Spring, ASP.NET Core, CMake
- **Testing**: pytest, Vitest, xUnit, Jest, Google Test
- **DevOps**: GitHub Actions, Azure DevOps, Bicep, Terraform, Docker
- **Cloud**: Azure (Functions, SQL Database, Static Web Apps, KeyVault)

## Guidelines for Effective Agent Use

### 1. Provide Context
```text
❌ @multi-language-engineer How do I sort a list?
✅ @multi-language-engineer I need to sort user records by creation date in a Python service that uses SQLAlchemy ORM.
```

### 2. Reference Project Conventions
```text
❌ @code-reviewer Review this code.
✅ @code-reviewer Review this Python code for compliance with our PEP 8 standards and test coverage requirements.
```

### 3. Ask Specific Questions
```text
❌ @architect How should I design my system?
✅ @architect Design a microservices architecture for a real-time data processing system that needs to handle 1M events/second with <100ms latency.
```

### 4. Combine Agents for Comprehensive Feedback
```text
1. @code-reviewer for code quality
2. @security-auditor for security analysis
3. @testing-expert for test coverage
4. @documentation-expert for API docs
```

## Agent Philosophy

These agents embody the project-gengo principles:

- **Simplicity First**: Prefer simple solutions over complex ones
- **Code Consistency**: Maintain existing patterns and styles
- **Quality First**: Testing and security are mandatory
- **Documentation Matters**: Code should be self-documenting
- **Collaboration**: Security and performance are team responsibilities
- **Continuous Improvement**: Always look for optimization opportunities

## Customization & Extension

To add or modify agents:

1. Follow the frontmatter format:
   ```yaml
   ---
   name: 'Agent Name'
   description: 'Brief description'
   tools: ['codebase', 'search', 'edit/editFiles', 'terminalCommand']
   ---
   ```

2. Structure content with clear sections
3. Provide practical examples
4. Reference project-specific standards
5. Include checklists and workflows

## Related Documentation

- [Project Copilot Instructions](./../copilot-instructions.md)
- [Contributing Guidelines](../../CONTRIBUTING.md)
- [Architecture Documentation](../../ARCHITECTURE.md)
- [Development Setup Guide](../../docs/development-setup.md)

## Feedback & Improvements

If you have suggestions for improving these agents:

1. Create an issue describing the improvement
2. Provide context about your use case
3. Suggest specific changes
4. Reference relevant examples

---

**Last Updated**: January 26, 2026  
**Version**: 1.0  
**Maintainer**: GitHub Copilot Agent Team
