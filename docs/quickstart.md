# Quick Start Guide: GitHub Copilot Persona Templates

This guide will help you quickly get started with using the GitHub Copilot persona templates for your .NET and Angular development projects.

## Prerequisites

Before you begin, ensure you have the following:

- **Visual Studio Code** (version 1.106 or later)
- **GitHub Copilot extension** installed and activated
- **A .NET/Angular project** (or create a new one)
- **Basic familiarity** with GitHub Copilot Chat

## Step 1: Choose Your Persona

Identify which persona best matches your current task:

| Persona | Use When |
|---------|----------|
| **SW Developer** | Writing code, refactoring, debugging, or generating boilerplate |
| **SW Tester/QA Engineer** | Creating tests, identifying edge cases, or generating test data |
| **Database Administrator** | Optimizing queries, designing schemas, or creating migrations |
| **DevOps/Platform Engineer** | Building pipelines, writing IaC, or automating deployments |
| **Security Engineer** | Reviewing code for vulnerabilities or implementing security best practices |
| **Project Manager** | Creating user stories, planning sprints, or estimating effort |
| **Data Scientist** | Analyzing data, building models, or creating visualizations |

## Step 2: Install the Custom Agent

### For Workspace-Level Installation (Recommended for Team Use)

1. Navigate to your project root directory
2. Create the `.github/agents/` folder if it doesn't exist:
   ```bash
   mkdir -p .github/agents
   ```
3. Copy the desired persona's `.agent.md` file to `.github/agents/`:
   ```bash
   cp path/to/templates/sw-developer/sw-developer.agent.md .github/agents/
   ```

### For User-Level Installation (Personal Use Across Projects)

1. Open VS Code Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`)
2. Run: **Chat: New Custom Agent**
3. Select **User profile** as the location
4. Name the agent (e.g., "sw-developer")
5. Copy the content from the template's `.agent.md` file into the newly created file

## Step 3: Install Custom Instructions (Optional)

Custom instructions automatically apply coding guidelines based on file patterns.

1. Create the `.github/` folder in your project root if it doesn't exist:
   ```bash
   mkdir -p .github
   ```
2. Copy the `copilot-instructions.md` file from your chosen persona:
   ```bash
   cp path/to/templates/sw-developer/copilot-instructions.md .github/
   ```

**Note:** You can combine instructions from multiple personas by merging their content into a single file.

## Step 4: Install Prompt Files (Optional)

Prompt files provide reusable task-specific prompts.

1. Create the `.github/prompts/` folder in your project root:
   ```bash
   mkdir -p .github/prompts
   ```
2. Copy the desired `.prompt.md` files:
   ```bash
   cp path/to/templates/sw-developer/prompts/*.prompt.md .github/prompts/
   ```

## Step 5: Use Your Custom Agent

### Activating the Agent

1. Open **GitHub Copilot Chat** in VS Code (click the chat icon in the sidebar or press `Ctrl+Alt+I`)
2. Click the **agents dropdown** at the bottom of the chat view
3. Select your custom agent (e.g., "SW Developer")

### Interacting with the Agent

Once activated, the agent will follow its persona-specific instructions. Try these examples:

#### SW Developer Examples
```
Generate a new API controller for managing products
```
```
Refactor this method to use the repository pattern
```
```
Add XML documentation comments to this class
```

#### SW Tester/QA Engineer Examples
```
Generate unit tests for the ProductController class
```
```
Create test cases for edge cases in the login function
```
```
Generate Playwright tests for the checkout flow
```

#### DBA Examples
```
Optimize this SQL query for better performance
```
```
Design a database schema for an e-commerce application
```
```
Create a migration script to add a new column
```

## Step 6: Use Prompt Files

If you installed prompt files, you can invoke them using the `/` command:

1. In GitHub Copilot Chat, type `/`
2. Select the prompt from the list (e.g., "New Feature Boilerplate")
3. Provide any required inputs
4. Press Enter to execute

Example:
```
/new-feature-boilerplate
```

## Step 7: Leverage Agent Handoffs

Agent handoffs allow you to transition between personas seamlessly:

1. Complete a task with one agent (e.g., SW Developer writes code)
2. Look for the **handoff button** that appears after the response
3. Click the button to switch to the next agent (e.g., SW Tester)
4. The context is automatically passed to the new agent

Example workflow:
```
SW Developer → Generate a new feature
↓ (Handoff)
SW Tester → Generate tests for the new feature
↓ (Handoff)
Security Engineer → Review for security vulnerabilities
```

## Step 8: Customize for Your Team

Once you're comfortable with the basics, customize the templates:

### Modify Agent Instructions
Edit the `.agent.md` files to reflect your team's specific needs:
- Update coding standards
- Add or remove tools
- Modify handoff workflows

### Update Custom Instructions
Edit `copilot-instructions.md` to match your team's guidelines:
- Add framework-specific rules
- Include company-specific standards
- Update file patterns

### Create New Prompts
Add new `.prompt.md` files for common tasks:
- Use variables like `${workspaceFolder}` and `${selection}`
- Reference other files with Markdown links
- Include clear descriptions

## Common Use Cases

### Use Case 1: Building a New Feature
1. **Project Manager** creates user stories and acceptance criteria
2. **SW Developer** implements the feature
3. **SW Tester** generates unit and integration tests
4. **Security Engineer** reviews for vulnerabilities
5. **DevOps Engineer** updates CI/CD pipeline

### Use Case 2: Optimizing Performance
1. **DBA** analyzes slow queries and suggests optimizations
2. **SW Developer** refactors code based on recommendations
3. **SW Tester** creates performance tests
4. **DevOps Engineer** sets up monitoring

### Use Case 3: Modernizing Legacy Code
1. **SW Developer** identifies code to modernize
2. **Security Engineer** reviews for security issues
3. **SW Developer** refactors with modern patterns
4. **SW Tester** ensures functionality is preserved
5. **DevOps Engineer** updates deployment scripts

## Troubleshooting

### Agent Not Appearing in Dropdown
- Ensure the `.agent.md` file is in the correct location (`.github/agents/` or user profile)
- Restart VS Code
- Check that the file has the correct `.agent.md` extension

### Instructions Not Being Applied
- Verify the file pattern in the `applyTo` field matches your files
- Check that the file is named `copilot-instructions.md` and is in the `.github/` folder
- Ensure there are no syntax errors in the YAML frontmatter

### Prompt Not Found
- Confirm the `.prompt.md` file is in `.github/prompts/` or your user profile
- Check that the file has the correct `.prompt.md` extension
- Restart VS Code if the prompt was just added

### Tool Not Available
- Some tools may not be available in all environments
- The agent will ignore unavailable tools and continue
- Check the VS Code output panel for any error messages

## Next Steps

Now that you're up and running, explore these advanced features:

1. **Create custom skills** for specialized tasks
2. **Integrate MCP servers** for enhanced capabilities
3. **Share agents** with your team via the repository
4. **Combine multiple personas** for complex workflows
5. **Contribute improvements** back to the template collection

## Additional Resources

- [Full README](./README.md) - Comprehensive documentation
- [VS Code Copilot Docs](https://code.visualstudio.com/docs/copilot/customization/overview) - Official documentation
- [GitHub Awesome Copilot](https://github.com/github/awesome-copilot) - Community examples

## Support

For questions or issues:
- Review the [README.md](./README.md) for detailed documentation
- Check the [VS Code Copilot documentation](https://code.visualstudio.com/docs/copilot)
- Consult the [GitHub Copilot documentation](https://docs.github.com/en/copilot)

---

**Happy Coding with GitHub Copilot!** 🚀
