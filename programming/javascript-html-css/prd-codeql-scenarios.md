# Product Requirements Document (PRD): CodeQL Custom Query Scenarios for GHAS Workshop

## Document Information

- **Version:** 1.0
- **Author(s):** GitHub Copilot
- **Date:** August 1, 2025
- **Status:** Workshop Ready
- **Target Audience:** GHAS (GitHub Advanced Security) Workshop Participants

## Executive Summary

This document defines custom CodeQL query scenarios and implementation approaches for a GitHub Advanced Security workshop. The scenarios demonstrate how to extend CodeQL's security analysis capabilities beyond standard queries, enabling participants to create targeted security checks for specific application contexts and organizational requirements.

## Problem Statement

While CodeQL provides comprehensive out-of-the-box security analysis with 200+ standard queries, organizations often need:

- Custom security rules specific to their codebase patterns
- Domain-specific vulnerability detection
- Integration of internal security policies into automated scanning
- Educational examples for security team training

## Goals and Objectives

- Demonstrate multiple approaches for implementing custom CodeQL queries
- Provide practical examples relevant to JavaScript/web application security
- Enable workshop participants to create and deploy custom security rules
- Show integration methods with existing CI/CD pipelines
- Establish best practices for custom query development and maintenance

## Scope

### In Scope

- Custom CodeQL query development approaches (3 primary methods)
- JavaScript-focused security query examples
- PowerShell script integration techniques
- Workshop demonstration scenarios using calculator application
- SARIF result integration and reporting

### Out of Scope

- Advanced CodeQL language features beyond workshop scope
- Multi-language query development
- Enterprise-scale query management systems
- Custom IDE integrations

## Implementation Approaches

### Approach 1: Direct Custom Query Files (Recommended for Workshops)

**Use Case:** Simple addition of specific security checks to existing analysis

**Implementation Steps:**

1. **Create Custom Query File** (`custom-security.ql`)

```ql
/**
 * @name Potential XSS vulnerability
 * @description Finds direct DOM manipulation that could lead to XSS
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id js/custom-xss-check
 * @tags security
 *       external/cwe/cwe-79
 */

import javascript

from DOM::Element element, DataFlow::Node source
where element.getChild(_).getStringValue() = source.getStringValue()
  and source.getEnclosingExpr() instanceof VarAccess
select element, "Direct DOM content assignment from variable $@.", source, source.toString()
```

1. **Modify PowerShell Script Integration**

```powershell
# BEFORE: Standard query suite only
& $CodeQLPath database analyze $DatabasePath `
    $QuerySuitePath `
    --format=sarif-latest `
    --output=$OutputPath

# AFTER: Include custom queries
& $CodeQLPath database analyze $DatabasePath `
    $QuerySuitePath `
    "custom-security.ql" `
    --format=sarif-latest `
    --output=$OutputPath
```

**Workshop Advantages:**

- Quick implementation
- Immediate results
- Easy to understand and modify
- Perfect for live demonstrations

### Approach 2: Custom Query Suites (.qls files)

**Use Case:** Organized collection of related custom queries with standard queries

**Implementation Steps:**

1. **Create Custom Suite File** (`workshop-security-suite.qls`)

```yaml
# workshop-security-suite.qls
- description: "GHAS Workshop Security Suite"
- include:
    kind: problem
    tags contain: security
- include:
    kind: path-problem  
    tags contain: security
- include: custom-xss-check.ql
- include: hardcoded-secrets.ql
- include: console-log-production.ql
- exclude:
    id: js/unused-local-variable  # Exclude noise for workshop
```

1. **Script Integration**

```powershell
$WorkshopQuerySuite = "workshop-security-suite.qls"
& $CodeQLPath database analyze $DatabasePath $WorkshopQuerySuite --format=sarif-latest --output=$OutputPath
```

**Workshop Advantages:**

- Demonstrates enterprise-scale organization
- Shows query filtering capabilities
- Reusable across multiple projects
- Professional approach for real-world implementation

### Approach 3: Parameterized Custom Query Integration

**Use Case:** Flexible script allowing workshop participants to experiment with different query combinations

**Implementation:**

```powershell
param(
    [string]$SourcePath = ".",
    [string]$DatabasePath = "js-db",
    [string]$OutputPath = "codeql-results.sarif",
    [string]$GitHubToken = $env:GITHUB_TOKEN,
    [string[]]$CustomQueries = @(),  # Workshop: Allow multiple custom queries
    [switch]$WorkshopMode = $false   # Workshop: Enable educational output
)

# Dynamic query building for workshop scenarios
$queryArgs = @($QuerySuitePath)
if ($CustomQueries.Count -gt 0) {
    Write-Host "🔍 Workshop Mode: Adding custom queries:" -ForegroundColor Cyan
    foreach ($query in $CustomQueries) {
        Write-Host "  - $query" -ForegroundColor Yellow
        $queryArgs += $query
    }
}

& $CodeQLPath database analyze $DatabasePath @queryArgs --format=sarif-latest --output=$OutputPath --threads=4
```

**Workshop Usage Examples:**

```powershell
# Scenario 1: Basic custom query
.\CodeQL-JavaScript-v2.ps1 -CustomQueries @("custom-xss-check.ql") -WorkshopMode

# Scenario 2: Multiple security patterns
.\CodeQL-JavaScript-v2.ps1 -CustomQueries @("hardcoded-secrets.ql", "unsafe-eval.ql") -WorkshopMode

# Scenario 3: Full workshop suite
.\CodeQL-JavaScript-v2.ps1 -CustomQueries @("workshop-security-suite.qls") -WorkshopMode
```

## Workshop Demonstration Scenarios

### Scenario 1: Detecting Unsafe `eval()` Usage

**Security Context:** The calculator application uses `eval()` for mathematical expression evaluation, which is a common XSS vector.

**Custom Query** (`unsafe-eval-detection.ql`):

```ql
/**
 * @name Unsafe eval() usage in calculator
 * @description Detects eval() calls that could lead to code injection
 * @kind problem
 * @problem.severity error
 * @security-severity 9.0
 * @precision high
 * @id js/workshop-unsafe-eval
 * @tags security
 *       external/cwe/cwe-94
 */

import javascript

from CallExpr call
where call.getCallee().(GlobalVarAccess).getName() = "eval"
  and call.getParent*() instanceof Function
select call, "Unsafe eval() usage detected. Consider using safer alternatives like Function constructor with validation."
```

**Expected Finding:** Will detect the `eval(display.innerText)` in `calculateResult()` function

**Workshop Discussion Points:**

- Why `eval()` is dangerous
- Alternative approaches (math expression parsers)
- Input validation strategies

### Scenario 2: Hardcoded Credentials Detection

**Custom Query** (`hardcoded-credentials.ql`):

```ql
/**
 * @name Hardcoded API keys and secrets
 * @description Finds potential hardcoded credentials in JavaScript
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision medium
 * @id js/workshop-hardcoded-secrets
 * @tags security
 *       external/cwe/cwe-798
 */

import javascript

from StringLiteral s
where s.getValue().regexpMatch("(?i).*(api[_-]?key|token|secret|password|auth[_-]?key).*")
  and s.getValue().length() > 8
  and not s.getParent*() instanceof Comment
select s, "Potential hardcoded credential: " + s.getValue()
```

**Workshop Exercise:** Add intentional hardcoded values to calculator for detection

### Scenario 3: Console Statements in Production

**Custom Query** (`console-log-detection.ql`):

```ql
/**
 * @name Console statements in production code
 * @description Finds console.log statements that should be removed for production
 * @kind problem
 * @problem.severity note
 * @precision high
 * @id js/workshop-console-statements
 * @tags maintainability
 *       best-practice
 */

import javascript

from CallExpr call
where call.getCallee().(PropAccess).getPropertyName() = "log"
  and call.getCallee().(PropAccess).getBase().(GlobalVarAccess).getName() = "console"
select call, "Console.log statement found - consider removing for production deployment."
```

### Scenario 4: DOM Manipulation Security

**Custom Query** (`dom-security-check.ql`):

```ql
/**
 * @name Unsafe DOM manipulation
 * @description Detects potentially unsafe DOM content assignments
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision medium
 * @id js/workshop-dom-security
 * @tags security
 *       external/cwe/cwe-79
 */

import javascript

from CallExpr call, MemberExpr member
where member.getPropertyName() = "innerHTML"
  and call.getCallee() = member
  and not call.getArgument(0) instanceof StringLiteral
select call, "Dynamic innerHTML assignment detected. Verify input sanitization."
```

## Workshop Exercise Structure

### Exercise 1: Basic Custom Query (15 minutes)

1. Create `workshop-eval-check.ql`
2. Run analysis on calculator application
3. Review results in SARIF viewer
4. Discuss findings and remediation

### Exercise 2: Query Suite Creation (20 minutes)

1. Combine multiple custom queries into suite
2. Configure query exclusions
3. Run comprehensive analysis
4. Compare results with standard analysis

### Exercise 3: CI/CD Integration (25 minutes)

1. Add custom queries to PowerShell script
2. Configure parameterized execution
3. Test with different query combinations
4. Review automation possibilities

### Exercise 4: Custom Query Development (30 minutes)

1. Identify new security pattern in calculator
2. Write custom CodeQL query
3. Test and refine query logic
4. Document query metadata
5. Integration testing

## Success Criteria

### Workshop Participant Outcomes

- Understand 3 primary approaches for custom CodeQL integration
- Successfully create and execute custom security queries
- Demonstrate ability to modify existing automation scripts
- Identify appropriate use cases for custom queries in their organization

### Technical Validation

- All custom queries execute without syntax errors
- SARIF results include both standard and custom findings
- PowerShell script modifications work correctly
- Query suites load and execute properly

## Implementation Timeline

### Pre-Workshop Setup (Instructor)

- Prepare calculator application with intentional vulnerabilities
- Test all custom queries for accuracy
- Validate PowerShell script modifications
- Prepare SARIF result examples

### Workshop Day Timeline

- **0-15 min:** CodeQL overview and standard analysis demonstration
- **15-30 min:** Exercise 1 - Basic custom query
- **30-50 min:** Exercise 2 - Query suite creation
- **50-75 min:** Exercise 3 - CI/CD integration
- **75-105 min:** Exercise 4 - Custom query development
- **105-120 min:** Wrap-up and real-world application discussion

## Best Practices for Workshop

### Query Development Guidelines

1. Start with simple patterns and gradually increase complexity
2. Always include comprehensive metadata in query headers
3. Use descriptive query IDs following organizational conventions
4. Test queries against known positive and negative cases
5. Document expected findings and remediation approaches

### Workshop Facilitation Tips

1. Provide pre-configured development environment
2. Have backup scenarios ready for different skill levels
3. Encourage experimentation with query modifications
4. Use live coding demonstrations for complex concepts
5. Include real-world examples from participants' organizations

## Additional Resources

### CodeQL Documentation References

- [CodeQL Query Help](https://codeql.github.com/docs/codeql-language-guides/codeql-for-javascript/)
- [Query Metadata](https://codeql.github.com/docs/writing-codeql-queries/metadata-for-codeql-queries/)
- [SARIF Output Format](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning)

### Sample Calculator Vulnerabilities for Testing

```javascript
// Add these to calculator for workshop demonstrations:

// 1. Hardcoded API key
const API_KEY = "sk-1234567890abcdef";

// 2. Console logging
console.log("Debug: calculation performed");

// 3. innerHTML usage
document.getElementById('display').innerHTML = userInput;

// 4. Additional eval usage
function advancedCalculate(expr) {
    return eval("Math." + expr);
}
```

## Conclusion

This PRD provides a comprehensive framework for conducting an effective GHAS workshop focused on custom CodeQL query development. The scenarios progress from basic implementation to advanced integration techniques, ensuring participants gain practical skills applicable to their security programs.

The calculator application serves as an ideal teaching platform, containing realistic security patterns while remaining simple enough for educational purposes. The three implementation approaches (direct queries, query suites, and parameterized scripts) provide flexibility for different organizational maturity levels and use cases.

## Call to Action

Workshop participants should:

1. Practice all three implementation approaches
2. Develop custom queries relevant to their organization's codebase
3. Plan integration strategy for their existing CI/CD pipelines
4. Establish governance processes for custom query management
5. Share learnings with their security and development teams

---

**Document Status:** Ready for Workshop Implementation  
**Next Review:** Post-workshop feedback incorporation  
**Distribution:** GHAS Workshop Participants, Security Teams, DevOps Engineers
