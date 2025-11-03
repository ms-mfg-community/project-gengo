# Product Requirements Document (PRD): Effective Prompting for GitHub Copilot

## Document Information

- **Version:** 1.0
- **Author(s):** GitHub Copilot
- **Date:** November 3, 2025
- **Status:** Draft

## Executive Summary

This document defines the requirements and best practices for effective prompting when working with GitHub Copilot (GHCP). It demonstrates four core prompting concepts—Content, Intent, Clarity, and Specificity—that enable developers to maximize the quality and relevance of AI-generated code suggestions and responses.

## Problem Statement

Developers often struggle to get precise, contextually relevant responses from AI coding assistants due to poorly structured prompts. Vague requests lead to generic solutions, while overly complex prompts without clear structure result in confusion and irrelevant outputs. A standardized approach to prompting is needed to improve productivity and code quality.

## Goals and Objectives

- **Primary Goal:** Establish a framework for effective prompting that maximizes GitHub Copilot's utility
- **Objectives:**
  - Define the four pillars of effective prompting (Content, Intent, Clarity, Specificity)
  - Provide actionable examples demonstrating good vs. poor prompts
  - Enable developers to self-assess and improve their prompt quality
  - Reduce iteration cycles needed to achieve desired outputs

## Scope

### In Scope

- Definition and explanation of the four prompting concepts
- Practical examples for each concept with before/after comparisons
- Guidelines for combining all four concepts in a single prompt
- Metrics for evaluating prompt effectiveness
- Common anti-patterns and how to avoid them

### Out of Scope

- GitHub Copilot API integration details
- Model training or fine-tuning procedures
- Language-specific syntax (examples will be language-agnostic where possible)
- Debugging GitHub Copilot technical issues

## The Four Pillars of Effective Prompting

### 1. Content: Information Provided to Help GHCP Understand the Task Better

**Definition:** Content refers to all contextual information, constraints, requirements, and background knowledge included in the prompt to guide the AI's understanding.

**Key Elements:**

- **Context:** Domain knowledge, existing code patterns, architectural constraints
- **Requirements:** Functional and non-functional requirements
- **Constraints:** Technology stack, libraries to use/avoid, performance requirements
- **Examples:** Sample inputs/outputs, existing code snippets
- **Environment:** Language version, framework version, platform (web/mobile/desktop)

**Examples:**

❌ **Poor Content (Insufficient Context):**

**Prompt:**
```
Create a function to validate data.
```

**Result:** `validateData.js`
```javascript
function validateData(data) {
  if (!data) {
    return false;
  }
  return true;
}
```

**Problems with this result:**
- No type safety - accepts any data type
- Only checks if data exists, not what's in it
- No actual validation logic for specific fields
- No error messages or feedback
- Unclear what "valid" means in this context
- No documentation or usage examples

✅ **Good Content (Rich Context):**

**Prompt:**
```
Create a TypeScript function to validate user registration data for a React application using Zod schema validation. The function should:
- Accept an object with email, password, and username fields
- Return a typed validation result with error messages
- Use Zod v3.22 library
- Follow the existing validation pattern used in src/validators/loginValidator.ts
```

**Result:** `validateDataGood.ts` (150+ lines)

**Key highlights from the generated code:**

```typescript
import { z } from 'zod';

export interface ValidationResult {
  isValid: boolean;
  errors: string[];
  data?: UserRegistrationData;
}

const userRegistrationSchema = z.object({
  email: z
    .string()
    .min(1, 'Email is required')
    .email('Email format is invalid'),
  
  password: z
    .string()
    .min(8, 'Password must be at least 8 characters')
    .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
    .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
    .regex(/\d/, 'Password must contain at least one number')
    .regex(/[!@#$%^&*(),.?":{}|<>]/, 'Password must contain at least one special character'),
  
  username: z
    .string()
    .min(3, 'Username must be at least 3 characters')
    .max(20, 'Username must be at most 20 characters')
    .regex(/^[a-zA-Z]/, 'Username must start with a letter')
    .regex(/^[a-zA-Z0-9_]+$/, 'Username can only contain letters, numbers, and underscores'),
});

export function validateUserRegistration(
  data: UserRegistrationData
): ValidationResult {
  try {
    const validatedData = userRegistrationSchema.parse(data);
    return { isValid: true, errors: [], data: validatedData };
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errors = error.errors.map((err) => err.message);
      return { isValid: false, errors };
    }
    return { isValid: false, errors: ['An unexpected validation error occurred'] };
  }
}
```

**Benefits of this result:**
- ✅ Full TypeScript type safety with interfaces and type guards
- ✅ Uses Zod v3.22 library as specified
- ✅ Comprehensive validation rules for each field
- ✅ Detailed, user-friendly error messages
- ✅ Follows ValidationResult pattern from existing codebase
- ✅ Includes JSDoc documentation with usage examples
- ✅ Additional helper functions (type guards, safe wrapper)
- ✅ Professional error handling for edge cases

**Comparison:**

| Aspect | Poor Prompt (`validateData.js`) | Good Prompt (`validateDataGood.ts`) |
|--------|----------------------------------|--------------------------------------|
| **Lines of Code** | 6 lines | 150+ lines |
| **Type Safety** | ❌ None | ✅ Full TypeScript + Zod schemas |
| **Validation Logic** | ❌ Only checks existence | ✅ Field-specific validation with rules |
| **Error Messages** | ❌ None | ✅ Detailed, actionable messages |
| **Documentation** | ❌ None | ✅ Complete JSDoc with examples |
| **Library Usage** | ❌ None | ✅ Zod v3.22 as requested |
| **Pattern Consistency** | ❌ No pattern | ✅ Matches loginValidator.ts pattern |
| **Production Ready** | ❌ No | ✅ Yes |

### 2. Intent: The Specific Goal or Purpose of the Prompt

**Definition:** Intent is the explicit statement of what you want to achieve—the desired outcome, deliverable, or action you expect from GitHub Copilot.

**Key Elements:**

- **Action Verb:** Create, refactor, debug, explain, optimize, test, document
- **Deliverable:** Function, class, test suite, configuration file, documentation
- **Outcome:** Working code, explanation, comparison, recommendation
- **Success Criteria:** What "done" looks like

**Examples:**

❌ **Poor Intent (Vague Goal):**

```
Something with database connections.
```

✅ **Good Intent (Clear Goal):**

```
Create a reusable database connection pool manager for PostgreSQL that:
- Initializes a connection pool on application startup
- Provides a method to execute queries with automatic connection handling
- Includes error handling and connection retry logic
- Exports a singleton instance for use across the application
```

### 3. Clarity: Ease of Understanding

**Definition:** Clarity measures how easily GitHub Copilot (and humans) can understand your request without ambiguity or confusion.

**Key Elements:**

- **Simple Language:** Avoid jargon when plain terms suffice
- **Logical Structure:** Organize requests with clear sections or bullet points
- **One Primary Task:** Focus on a single main objective per prompt
- **Unambiguous Terms:** Use precise terminology without conflicting meanings
- **Consistent Terminology:** Use the same terms throughout the prompt

**Examples:**

❌ **Poor Clarity (Confusing and Ambiguous):**

```
Make a thing that does stuff with the API and handles the errors but also needs to work with the other thing we talked about before and maybe use async or callbacks depending on what works better and it should probably log things too.
```

✅ **Good Clarity (Clear and Structured):**

```
Create an API client wrapper with the following features:

1. Error Handling:
   - Catch network errors and return user-friendly messages
   - Retry failed requests up to 3 times with exponential backoff

2. Async Implementation:
   - Use async/await pattern (not callbacks)
   - Return Promises for all API calls

3. Logging:
   - Log all requests and responses to console in development mode
   - Include timestamp and endpoint in log messages
```

### 4. Specificity: The Level of Detail and Precision

**Definition:** Specificity determines how detailed and precise your requirements are, providing exact constraints, formats, names, and implementation details.

**Key Elements:**

- **Exact Names:** Variable names, function names, file names, class names
- **Data Types:** Specific types (string, number, boolean, custom interfaces)
- **Format Requirements:** Date formats, naming conventions, code style
- **Numeric Constraints:** Max length, min value, array size, timeout values
- **Technology Versions:** Library versions, language versions, framework versions
- **Edge Cases:** Specific scenarios to handle or avoid

**Examples:**

❌ **Poor Specificity (Generic and Vague):**

```
Create a function to format dates nicely.
```

✅ **Good Specificity (Detailed and Precise):**

```
Create a TypeScript function named `formatDateForDisplay` that:
- Accepts a Date object or ISO 8601 string as input
- Returns a string formatted as "MMM DD, YYYY" (e.g., "Nov 03, 2025")
- Uses the date-fns library (v2.30.0) format function
- Handles invalid dates by returning "Invalid Date"
- Includes JSDoc comments with @param and @returns tags
- Export as a named export from src/utils/dateFormatter.ts
```

## Combining All Four Concepts: Complete Prompt Example

### Poor Prompt (Lacking All Four Pillars)

```
Make a login function.
```

**Analysis:**

- ❌ **Content:** No context about authentication method, technology stack, or requirements
- ❌ **Intent:** Unclear what "make" means—create, refactor, test, document?
- ❌ **Clarity:** Too vague, no structure
- ❌ **Specificity:** No details about implementation, return types, or error handling

### Excellent Prompt (Demonstrating All Four Pillars)

```
**Context:** I'm building a Node.js REST API using Express and JWT authentication. The existing codebase uses bcrypt for password hashing and stores users in a PostgreSQL database via Prisma ORM.

**Intent:** Create an async login function that authenticates users and returns a JWT token.

**Requirements:**
1. Function name: `authenticateUser`
2. Accept email and password as parameters (both strings)
3. Query the database using Prisma to find user by email
4. Compare password with hashed password using bcrypt.compare()
5. If authentication succeeds:
   - Generate a JWT token with user ID and email in payload
   - Token should expire in 24 hours
   - Return object: `{ success: true, token: string, userId: number }`
6. If authentication fails:
   - Return object: `{ success: false, error: string }`
7. Include TypeScript types for return value
8. Add error handling for database errors
9. Use environment variable JWT_SECRET for token signing

**Style:**
- Use async/await (not callbacks)
- Follow existing error handling patterns in src/middleware/errorHandler.ts
- Add JSDoc comments
```

**Analysis:**

- ✅ **Content:** Rich context about tech stack, existing patterns, and architecture
- ✅ **Intent:** Clear goal—create an authentication function with specific behavior
- ✅ **Clarity:** Well-structured with sections, numbered requirements, easy to parse
- ✅ **Specificity:** Exact function name, parameter types, return format, library methods, and timeout values

## User Stories / Use Cases

### User Story 1: Junior Developer Seeking Code Generation

**As a** junior developer  
**I want** to provide effective prompts to GitHub Copilot  
**So that** I receive production-ready code that matches my project's standards without extensive iteration

**Acceptance Criteria:**

- Developer can identify missing Content, Intent, Clarity, or Specificity in their prompt
- Generated code matches project architecture and coding standards
- First suggestion requires minimal modifications (< 20% changes)

### User Story 2: Senior Developer Refactoring Legacy Code

**As a** senior developer  
**I want** to clearly communicate refactoring intent with sufficient context  
**So that** GitHub Copilot suggests modern patterns while preserving business logic

**Acceptance Criteria:**

- Prompt includes legacy code snippet for context
- Intent specifies "refactor" vs "rewrite" vs "modernize"
- Specificity includes which patterns to apply and which to avoid

### User Story 3: Team Lead Establishing Prompting Standards

**As a** team lead  
**I want** a framework for evaluating prompt quality  
**So that** my team can consistently get high-quality suggestions and reduce review cycles

**Acceptance Criteria:**

- Team members can score prompts on 4-pillar scale (1-5 for each pillar)
- Documentation includes examples of good/poor prompts
- Prompts with scores < 3 in any pillar are revised before submission

## Functional Requirements

| Requirement ID | Pillar | Description |
|---|---|---|
| FR-1 | Content | Prompts MUST include technology stack and language version |
| FR-2 | Content | Prompts SHOULD include relevant code snippets for context when modifying existing code |
| FR-3 | Content | Prompts SHOULD reference existing patterns or files to maintain consistency |
| FR-4 | Intent | Prompts MUST start with an action verb (create, refactor, debug, explain, etc.) |
| FR-5 | Intent | Prompts MUST specify the deliverable type (function, class, test, config, etc.) |
| FR-6 | Intent | Prompts SHOULD include success criteria or expected outcome |
| FR-7 | Clarity | Prompts MUST focus on one primary task (may have sub-tasks) |
| FR-8 | Clarity | Prompts SHOULD use bullet points or numbered lists for multiple requirements |
| FR-9 | Clarity | Prompts MUST avoid ambiguous pronouns (it, this, that) without clear antecedents |
| FR-10 | Specificity | Prompts SHOULD include exact names for functions, variables, and files |
| FR-11 | Specificity | Prompts SHOULD specify data types and return types |
| FR-12 | Specificity | Prompts SHOULD include numeric constraints (max length, timeout, retry count, etc.) |

## Non-Functional Requirements

- **Usability:** Prompts should be readable by both AI and human developers
- **Maintainability:** Prompt patterns should be reusable across similar tasks
- **Efficiency:** Well-structured prompts should reduce iteration cycles by 50%
- **Consistency:** Team members should achieve similar results with similar prompts
- **Learning Curve:** New developers should be able to write effective prompts within 1 week

## Prompt Quality Scoring Rubric

Use this rubric to evaluate prompt effectiveness:

| Pillar | Score 1 (Poor) | Score 3 (Acceptable) | Score 5 (Excellent) |
|---|---|---|---|
| **Content** | No context or constraints provided | Basic context included (language, framework) | Rich context including tech stack, existing patterns, architecture, constraints, and examples |
| **Intent** | Vague or missing goal | Clear action verb and deliverable type | Explicit goal with success criteria and expected outcome |
| **Clarity** | Confusing, ambiguous, or rambling | Understandable with minor ambiguities | Crystal clear with logical structure and precise terminology |
| **Specificity** | Generic with no details | Some details (names or types) | Comprehensive details including names, types, formats, values, and edge cases |

**Total Score Interpretation:**

- **16-20:** Excellent prompt—likely to produce high-quality results on first attempt
- **12-15:** Good prompt—may require minor refinements
- **8-11:** Acceptable prompt—will likely need iteration
- **4-7:** Poor prompt—needs significant improvement before use

## Common Anti-Patterns and Solutions

### Anti-Pattern 1: The "Make It Work" Prompt

❌ **Example:** "Fix this code"

**Problems:**

- No intent specified (debug? refactor? optimize?)
- No content about what's broken or expected behavior
- No specificity about constraints or requirements

✅ **Solution:**

```
Debug this TypeScript function that's throwing a "Cannot read property 'length' of undefined" error.

[Include code snippet]

Expected behavior: Function should return the length of the input array, or 0 if array is null/undefined.
```

### Anti-Pattern 2: The "Do Everything" Prompt

❌ **Example:** "Create a complete authentication system with login, signup, password reset, email verification, OAuth, 2FA, session management, and admin panel"

**Problems:**

- Violates clarity principle (too many tasks)
- Impossible to complete in one interaction
- Lacks specificity for each feature

✅ **Solution:** Break into multiple focused prompts:

```
Prompt 1: Create a user registration function with email and password
Prompt 2: Create a login function with JWT token generation
Prompt 3: Create a password reset request handler
[etc.]
```

### Anti-Pattern 3: The "Assumed Context" Prompt

❌ **Example:** "Add that validation we discussed earlier to the form"

**Problems:**

- Assumes AI remembers previous conversation context
- No content about which validation or which form
- Unclear intent and specificity

✅ **Solution:**

```
Add email format validation to the ContactForm component in src/components/ContactForm.tsx.

Requirements:
- Use Zod schema validation
- Validate email format using regex pattern
- Display error message below email input field
- Prevent form submission if email is invalid
```

### Anti-Pattern 4: The "Jargon Overload" Prompt

❌ **Example:** "Implement a DAL with CQRS pattern using the repository pattern and UoW for the aggregate roots in the bounded context"

**Problems:**

- Violates clarity with excessive jargon
- Assumes AI interprets jargon exactly as intended
- Missing specificity about actual implementation

✅ **Solution:**

```
Create a data access layer for the User entity with separate read and write operations:

1. Create UserRepository class with:
   - getById(id): User - Read single user
   - getAll(): User[] - Read all users
   - create(user): void - Write new user
   - update(user): void - Update existing user

2. Use the repository pattern to abstract database operations
3. Implement unit of work pattern to manage transactions
4. Target entity: User (properties: id, email, name, createdAt)
```

## Success Criteria / KPIs

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| First-suggestion acceptance rate | 30% | 70% | % of suggestions used without modification |
| Iteration cycles per task | 3.5 | 1.5 | Avg. number of prompt refinements needed |
| Prompt quality score | 2.5/5 | 4.0/5 | Team self-assessment using rubric |
| Developer satisfaction | 3.2/5 | 4.5/5 | Quarterly survey on AI assistance effectiveness |
| Time to first working solution | 15 min | 5 min | Time from initial prompt to working code |

## Milestones & Timeline

| Milestone | Target Date | Status |
|---|---|---|
| PRD Draft Complete | November 3, 2025 | ✅ Complete |
| Team Training on 4 Pillars | TBD | Pending |
| Prompting Guidelines Documentation | TBD | Pending |
| Prompt Template Library Created | TBD | Pending |
| First Quality Assessment | TBD | Pending |
| Iteration and Refinement | TBD | Pending |

## Best Practices Summary

### Quick Checklist for Effective Prompts

Before submitting a prompt to GitHub Copilot, verify:

- [ ] **Content:** Have I provided enough context (tech stack, existing patterns, constraints)?
- [ ] **Intent:** Is my goal crystal clear (action verb + deliverable)?
- [ ] **Clarity:** Can someone else understand this easily?
- [ ] **Specificity:** Have I included exact names, types, and constraints?

### Template for Complex Prompts

```
**Context:** [Technology stack, existing code patterns, architectural constraints]

**Intent:** [Action verb] + [deliverable type] that [main purpose]

**Requirements:**
1. [Specific requirement with details]
2. [Specific requirement with details]
3. [Edge case or constraint]

**Technical Details:**
- Function/Class name: [exact name]
- Parameters: [types and names]
- Return type: [exact type]
- Libraries: [name and version]

**Style:**
- [Coding conventions to follow]
- [Error handling approach]
- [Documentation requirements]
```

## Examples Across Common Scenarios

### Scenario 1: Creating a New Feature

```
**Context:** Building a React e-commerce app using TypeScript, Redux Toolkit, and React Router v6.

**Intent:** Create a product search component with real-time filtering.

**Requirements:**
1. Component name: ProductSearchBar
2. Accept products array as prop (type: Product[])
3. Filter products by name and description as user types
4. Debounce search input by 300ms
5. Display filtered results in a dropdown list below input
6. Emit onProductSelect event when user clicks a result
7. Use existing styling from src/styles/searchBar.module.css

**Technical Details:**
- Use React hooks (useState, useEffect, useMemo)
- Use lodash.debounce for input debouncing
- Product interface: { id: number; name: string; description: string; price: number }
```

### Scenario 2: Debugging Existing Code

```
**Context:** Node.js API using Express. The endpoint `/api/users/:id` is returning 500 errors intermittently.

**Intent:** Debug and fix the getUserById function to handle edge cases properly.

**Current Code:**
[Include code snippet]

**Observed Behavior:**
- Works for valid user IDs
- Throws "Cannot read property 'name' of null" when user doesn't exist
- Sometimes returns 500 instead of 404

**Expected Behavior:**
- Return 404 with message "User not found" when ID doesn't exist
- Return 400 with message "Invalid ID format" for non-numeric IDs
- Return 200 with user data for valid requests
- Never return 500 errors for these cases
```

### Scenario 3: Refactoring Legacy Code

```
**Context:** Refactoring a legacy JavaScript module to modern TypeScript. Current code uses callbacks and var declarations.

**Intent:** Modernize the authentication module while preserving exact business logic.

**Current Code:**
[Include legacy code]

**Modernization Requirements:**
1. Convert to TypeScript with strict typing
2. Replace callbacks with async/await
3. Replace var with const/let
4. Add proper error handling with try/catch
5. Extract hard-coded values to constants
6. Add JSDoc comments
7. Do NOT change business logic or validation rules

**Constraints:**
- Must remain compatible with existing API consumers
- Keep function signature public API identical (input/output)
```

### Scenario 4: Writing Tests

```
**Context:** Jest + React Testing Library project. Need tests for the LoginForm component.

**Intent:** Create comprehensive unit tests for the LoginForm component covering success, error, and edge cases.

**Component Behavior:**
- Accepts onSubmit callback prop
- Has email and password input fields
- Has submit button disabled when fields are empty
- Shows validation errors below fields when invalid
- Calls onSubmit with { email, password } when valid

**Test Requirements:**
1. Test file name: LoginForm.test.tsx
2. Test cases to cover:
   - Renders all form elements
   - Submit button disabled when empty
   - Submit button enabled when fields filled
   - Shows error for invalid email format
   - Shows error for password < 8 characters
   - Calls onSubmit with correct data on valid submission
   - Prevents submission when Enter pressed on invalid form

**Style:**
- Use React Testing Library best practices (avoid testID when possible)
- Use user-event library for interactions
- Follow AAA pattern (Arrange, Act, Assert)
```

## Key Takeaways

1. **Content is King:** Always provide rich context about your technology stack, constraints, and existing patterns
2. **Intent Drives Output:** Be explicit about what you want—don't make the AI guess
3. **Clarity Prevents Confusion:** Structure your prompts logically and use precise terminology
4. **Specificity Ensures Accuracy:** Include exact names, types, values, and formats to get exactly what you need
5. **Practice Makes Perfect:** Start with the template, evaluate with the rubric, and refine your approach

## Questions for Attendees

- What challenges have you faced with vague or poorly structured prompts?
- Which of the four pillars do you find most difficult to implement consistently?
- What additional examples or scenarios would be helpful for your use cases?
- How can we integrate prompt quality checks into your team's workflow?

## Call to Action

1. **Evaluate Your Recent Prompts:** Score your last 5 prompts using the rubric—identify patterns
2. **Use the Template:** Apply the template to your next complex task
3. **Share Learnings:** Document what works well for your specific domain or tech stack
4. **Iterate and Improve:** Track your first-suggestion acceptance rate and iteration cycles over the next 2 weeks

---

**Document Version History:**

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | Nov 3, 2025 | GitHub Copilot | Initial draft demonstrating the four pillars of effective prompting |
