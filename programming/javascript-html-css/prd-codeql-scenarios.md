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
 * @name Potential XSS vulnerability                    // Human-readable name for the query
 * @description Finds direct DOM manipulation that could lead to XSS  // Brief description of what the query detects
 * @kind problem                                         // Query type: 'problem' reports issues at specific locations
 * @problem.severity warning                             // Severity level: error, warning, note, or recommendation
 * @security-severity 6.0                               // CVSS-style security severity score (0.0-10.0)
 * @precision medium                                     // Confidence level: high, medium, low
 * @id js/custom-xss-check                              // Unique identifier for this query
 * @tags security                                        // Categories for filtering and organization
 *       external/cwe/cwe-79                            // Links to CWE-79 (Cross-site Scripting)
 */

import javascript                                        // Import the JavaScript CodeQL library for web analysis

from DOM::Element element, DataFlow::Node source        // Declare variables: DOM element and data source node
where element.getChild(_).getStringValue() = source.getStringValue()  // Find DOM elements with string content matching source
  and source.getEnclosingExpr() instanceof VarAccess    // Ensure the source comes from a variable access (not literal)
select element, "Direct DOM content assignment from variable $@.", source, source.toString()  // Report the finding with message and source reference
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
- description: "GHAS Workshop Security Suite"           # Human-readable description of this query suite
- include:                                              # Include queries that match these criteria
    kind: problem                                       # Include all 'problem' type queries (report specific issues)
    tags contain: security                              # Only include queries tagged with 'security'
- include:                                              # Additional include rule for path-problem queries
    kind: path-problem                                  # Include 'path-problem' queries (show data flow paths)
    tags contain: security                              # Only security-related path-problem queries
- include: custom-xss-check.ql                          # Explicitly include our custom XSS detection query
- include: hardcoded-secrets.ql                         # Explicitly include hardcoded secrets detection query
- include: console-log-production.ql                    # Explicitly include console.log detection query
- exclude:                                              # Exclude specific queries to reduce noise
    id: js/unused-local-variable                        # Exclude unused variable warnings (not security-focused)
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
 * @name Unsafe eval() usage in calculator                // Human-readable name specific to calculator context
 * @description Detects eval() calls that could lead to code injection  // Description of security risk
 * @kind problem                                           // Query type: reports specific problem locations
 * @problem.severity error                                 // High severity: eval() is dangerous
 * @security-severity 9.0                                  // Very high security score (code injection risk)
 * @precision high                                         // High confidence in findings
 * @id js/workshop-unsafe-eval                            // Unique workshop-specific identifier
 * @tags security                                          // Security category tag
 *       external/cwe/cwe-94                              // Links to CWE-94 (Code Injection)
 */

import javascript                                          // Import JavaScript analysis library

from CallExpr call                                         // Declare variable for function call expressions
where call.getCallee().(GlobalVarAccess).getName() = "eval"  // Find calls where callee is global 'eval' function
  and call.getParent*() instanceof Function               // Ensure eval call is within a function (not global scope)
select call, "Unsafe eval() usage detected. Consider using safer alternatives like Function constructor with validation."  // Report with remediation advice
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
 * @name Hardcoded API keys and secrets                   // Human-readable name for credential detection
 * @description Finds potential hardcoded credentials in JavaScript  // Description of what we're looking for
 * @kind problem                                           // Query type: reports specific issues
 * @problem.severity error                                 // High severity: credentials are critical security issue
 * @security-severity 8.0                                  // High security score for credential exposure
 * @precision medium                                       // Medium precision due to regex-based detection
 * @id js/workshop-hardcoded-secrets                      // Unique workshop identifier
 * @tags security                                          // Security category
 *       external/cwe/cwe-798                              // Links to CWE-798 (Use of Hard-coded Credentials)
 */

import javascript                                          // Import JavaScript analysis library

from StringLiteral s                                       // Declare variable for string literal expressions
where s.getValue().regexpMatch("(?i).*(api[_-]?key|token|secret|password|auth[_-]?key).*")  // Case-insensitive regex for credential patterns
  and s.getValue().length() > 8                           // Filter out short strings (likely not real credentials)
  and not s.getParent*() instanceof Comment               // Exclude strings that are within comments
select s, "Potential hardcoded credential: " + s.getValue()  // Report the finding with the actual string value
```

**Workshop Exercise:** Add intentional hardcoded values to calculator for detection

### Scenario 3: Console Statements in Production

**Custom Query** (`console-log-detection.ql`):

```ql
/**
 * @name Console statements in production code             // Human-readable name for console detection
 * @description Finds console.log statements that should be removed for production  // What this query finds
 * @kind problem                                           // Query type: reports maintenance issues
 * @problem.severity note                                  // Low severity: maintenance issue, not security
 * @precision high                                         // High precision: specific method call pattern
 * @id js/workshop-console-statements                     // Unique workshop identifier
 * @tags maintainability                                   // Categorized as code maintainability issue
 *       best-practice                                     // Also tagged as best practice violation
 */

import javascript                                          // Import JavaScript analysis library

from CallExpr call                                         // Declare variable for function call expressions
where call.getCallee().(PropAccess).getPropertyName() = "log"  // Find property access where property name is "log"
  and call.getCallee().(PropAccess).getBase().(GlobalVarAccess).getName() = "console"  // Ensure base object is global "console"
select call, "Console.log statement found - consider removing for production deployment."  // Report with remediation advice
```

### Scenario 4: DOM Manipulation Security

**Custom Query** (`dom-security-check.ql`):

```ql
/**
 * @name Unsafe DOM manipulation                          // Human-readable name for DOM security check
 * @description Detects potentially unsafe DOM content assignments  // Description of security concern
 * @kind problem                                           // Query type: reports security problems
 * @problem.severity warning                               // Medium severity: potential XSS vector
 * @security-severity 6.0                                  // Medium-high security score for XSS risk
 * @precision medium                                       // Medium precision: may have false positives
 * @id js/workshop-dom-security                           // Unique workshop identifier
 * @tags security                                          // Security category
 *       external/cwe/cwe-79                              // Links to CWE-79 (Cross-site Scripting)
 */

import javascript                                          // Import JavaScript analysis library

from CallExpr call, MemberExpr member                     // Declare variables for call expression and member access
where member.getPropertyName() = "innerHTML"              // Find member access to 'innerHTML' property
  and call.getCallee() = member                           // Ensure the member access is the function being called
  and not call.getArgument(0) instanceof StringLiteral    // Flag calls where argument is NOT a string literal (dynamic content)
select call, "Dynamic innerHTML assignment detected. Verify input sanitization."  // Report with security advice
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
