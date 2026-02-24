# GitHub Copilot Custom Agents for Project-Gengo

This directory contains custom GitHub Copilot agents tailored to the project-gengo repository. These agents embody different expertise personas that can be used to get specialized guidance and assistance across various aspects of the project.

## Available Agents

### 1. Code Reviewer (`code-reviewer.agent.md`)

**Persona**: Expert code reviewer focusing on security, performance, testing coverage, and maintainability

**Use When**:
- Reviewing pull requests
- Assessing code quality
- Identifying security vulnerabilities
- Evaluating performance implications
- Checking testing coverage
- Ensuring documentation completeness

**Capabilities**:
- Security analysis (input validation, authentication, data protection)
- Performance optimization detection
- Code quality standards enforcement
- Testing coverage assessment
- Project-specific guideline compliance
- Constructive feedback generation

**Example Prompt**:
> @code-reviewer Review this Python function for security vulnerabilities and performance issues. Consider database access patterns and error handling.

---

### 2. Multi-Language Software Engineer (`multi-language-engineer.agent.md`)

**Persona**: Expert software engineer spanning C++, Python, TypeScript, Java, C#, and Go

**Use When**:
- Implementing features across multiple languages
- Fixing bugs in unfamiliar languages
- Refactoring existing code
- Following project language-specific standards
- Creating new components
- Learning project patterns

**Capabilities**:
- Multi-language implementation expertise
- Language-specific best practices
- Testing alongside features
- Design pattern guidance
- Documentation generation
- Performance optimization

**Example Prompt**:
> @multi-language-engineer Implement a REST API endpoint in Python that connects to our database and returns paginated user data. Include proper error handling and type hints.

---

### 3. DevOps & CI/CD Specialist (`devops-specialist.agent.md`)

**Persona**: DevOps expert specializing in GitHub Actions, Azure DevOps, IaC, and deployment automation

**Use When**:
- Creating or updating CI/CD pipelines
- Designing infrastructure as code
- Optimizing deployment processes
- Implementing containerization
- Setting up monitoring and observability
- Automating security scanning

**Capabilities**:
- GitHub Actions workflow design
- Azure DevOps pipeline creation
- Bicep and Terraform expertise
- Container orchestration guidance
- Deployment strategy optimization
- Security automation

**Example Prompt**:
> @devops-specialist Create a GitHub Actions workflow that builds a Docker image, runs security scans, and deploys to Azure Container Instances.

---

### 4. Security & Quality Auditor (`security-auditor.agent.md`)

**Persona**: Security expert specializing in vulnerability detection, security analysis, and code quality metrics

**Use When**:
- Conducting security audits
- Identifying vulnerabilities
- Assessing compliance
- Analyzing code quality metrics
- Reviewing testing coverage
- Performing risk assessments

**Capabilities**:
- Vulnerability detection (OWASP, CWE)
- Dependency security analysis
- Secret scanning guidance
- Compliance validation
- Code quality metrics interpretation
- Risk prioritization

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

## How to Use Agents

### In VS Code with GitHub Copilot

1. Open the Chat panel (Ctrl+L or Cmd+L)
2. Reference an agent with `@agent-name`
3. Ask your question or provide context
4. The agent responds with specialized guidance

### Example Usage Flow

```
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
```
❌ @multi-language-engineer How do I sort a list?
✅ @multi-language-engineer I need to sort user records by creation date in a Python service that uses SQLAlchemy ORM.
```

### 2. Reference Project Conventions
```
❌ @code-reviewer Review this code.
✅ @code-reviewer Review this Python code for compliance with our PEP 8 standards and test coverage requirements.
```

### 3. Ask Specific Questions
```
❌ @architect How should I design my system?
✅ @architect Design a microservices architecture for a real-time data processing system that needs to handle 1M events/second with <100ms latency.
```

### 4. Combine Agents for Comprehensive Feedback
```
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
