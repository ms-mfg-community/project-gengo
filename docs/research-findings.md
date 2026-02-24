# GitHub Copilot Customization Research Findings

## File Types and Structures

### 1. Custom Agents (.agent.md)
**Location:** `.github/agents/` folder or user profile
**Extension:** `.agent.md`

**Structure:**
```markdown
---
description: Brief description shown in chat input
name: Agent Name
argument-hint: Optional hint for users
tools: ['tool1', 'tool2', 'githubRepo', 'search']
model: Claude Sonnet 4 (or other model)
infer: true (enable as subagent)
target: vscode (or github-copilot)
handoffs:
  - label: Next Step Label
    agent: target-agent-name
    prompt: Prompt to send to next agent
    send: false (auto-submit if true)
---

# Agent Instructions Body
Detailed instructions for the agent behavior, tools, and guidelines.
Can reference tools using #tool:toolName syntax.
```

**Key Features:**
- Defines specialized personas with specific tools and behaviors
- Supports handoffs for sequential workflows
- Can specify AI model to use
- Tools restrict what capabilities the agent has access to

### 2. Custom Instructions (.instructions.md)
**Location:** `.github/copilot-instructions.md` (workspace-wide) or user profile
**Extension:** `.instructions.md`

**Structure:**
```markdown
---
applyTo: "**/*.py" (glob pattern for file matching)
---

# Instruction Title
Specific guidelines and rules for the AI to follow.
Applied automatically based on file patterns.
```

**Key Features:**
- Automatically applied based on file patterns
- Can be workspace-level or user-level
- Multiple instruction files can coexist
- Applied to all chat requests or specific files

### 3. AGENTS.md File
**Location:** Root or subfolders of repository
**Extension:** `AGENTS.md`

**Purpose:**
- Used by AI agents in GitHub Copilot
- Provides project-specific context and guidelines
- Can have multiple AGENTS.md files in different folders
- Automatically applied to all chat requests in workspace

### 4. Prompt Files (.prompt.md)
**Location:** `.github/prompts/` folder or user profile
**Extension:** `.prompt.md`

**Structure:**
```markdown
---
description: Brief description of the prompt
name: Prompt Name
argument-hint: Optional hint for users
agent: agent-name (optional, to use specific agent)
tools: ['tool1', 'tool2']
---

# Prompt Body
Detailed prompt instructions.
Can use variables: ${workspaceFolder}, ${selection}, ${file}
Can use input variables: ${input:variableName:placeholder}
Reference tools: #tool:toolName
```

**Key Features:**
- Reusable, task-specific prompts
- Can reference workspace variables
- Triggered on-demand with `/` command
- Can specify which agent to use

### 5. Skills (Directory-based)
**Location:** Skills are directories containing multiple files

**Typical Structure:**
```
skills/
  skill-name/
    SKILL.md (main skill definition)
    resources/ (optional supporting files)
    templates/ (optional templates)
```

## Tool Reference Syntax
- Use `#tool:toolName` to reference agent tools in body text
- Examples: `#tool:githubRepo`, `#tool:search`, `#tool:fetch`

## Available Tools
Common tools that can be specified:
- `fetch` - Fetch web content
- `githubRepo` - Access GitHub repository information
- `search` - Search capabilities
- `usages` - Find code usages
- `codebase` - Access codebase context
- MCP tools can be included using server name format: `servername/*`

## Priority Order
When multiple customizations exist:
1. Tools specified in prompt file
2. Tools from referenced custom agent in prompt file
3. Default tools for selected agent

## Key Differences

| Feature | Custom Agents | Instructions | Prompts | AGENTS.md |
|---------|--------------|--------------|---------|-----------|
| **Scope** | Session-based persona | File pattern-based | Task-specific | Workspace-wide |
| **Activation** | Manual selection | Automatic | On-demand command | Automatic |
| **Tools Control** | Yes | No | Yes | No |
| **Handoffs** | Yes | No | No | No |
| **File Pattern** | No | Yes | No | No |
| **Variables** | No | No | Yes | No |
