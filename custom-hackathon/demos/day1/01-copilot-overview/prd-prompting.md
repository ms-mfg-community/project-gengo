# Product Requirements Document (PRD): Effective Prompting for GitHub Copilot

\n\nDocument Information

\n\n**Version:** 1.0
\n\n**Author(s):** GitHub Copilot
\n\n**Date:** November 3, 2025
\n\n**Status:** Draft

\n\nExecutive Summary

This document defines the requirements and best practices for effective prompting when working with GitHub Copilot (GHCP). It demonstrates four core prompting concepts—Content, Intent, Clarity, and Specificity—that enable developers to maximize the quality and relevance of AI-generated code suggestions and responses.

\n\nProblem Statement

Developers often struggle to get precise, contextually relevant responses from AI coding assistants due to poorly structured prompts. Vague requests lead to generic solutions, while overly complex prompts without clear structure result in confusion and irrelevant outputs. A standardized approach to prompting is needed to improve productivity and code quality.

\n\nGoals and Objectives

\n\n**Primary Goal:** Establish a framework for effective prompting that maximizes GitHub Copilot's utility
\n\n**Objectives:**
\n\nDefine the four pillars of effective prompting (Content, Intent, Clarity, Specificity)
\n\nProvide actionable examples demonstrating good vs. poor prompts
\n\nEnable developers to self-assess and improve their prompt quality
\n\nReduce iteration cycles needed to achieve desired outputs

\n\nScope

\n\nIn Scope

\n\nDefinition and explanation of the four prompting concepts
\n\nPractical examples for each concept with before/after comparisons
\n\nGuidelines for combining all four concepts in a single prompt
\n\nMetrics for evaluating prompt effectiveness
\n\nCommon anti-patterns and how to avoid them

\n\nOut of Scope

\n\nGitHub Copilot API integration details
\n\nModel training or fine-tuning procedures
\n\nLanguage-specific syntax (examples will be language-agnostic where possible)
\n\nDebugging GitHub Copilot technical issues

\n\nThe Four Pillars of Effective Prompting

\n\n1. Content: Information Provided to Help GHCP Understand the Task Better

**Definition:** Content refers to all contextual information, constraints, requirements, and background knowledge included in the prompt to guide the AI's understanding.

## Key Elements

\n\n**Context:** Domain knowledge, existing code patterns, architectural constraints
\n\n**Requirements:** Functional and non-functional requirements
\n\n**Constraints:** Technology stack, libraries to use/avoid, performance requirements
\n\n**Examples:** Sample inputs/outputs, existing code snippets
\n\n**Environment:** Language version, framework version, platform (web/mobile/desktop)

## Examples

❌ **Poor Content (Insufficient Context):**

## Prompt

```

text

Create a function to validate data.

```

text
text

**Result:** `validateData.js`

```

javascript
function validateData(data) {
  if (!data) {
    return false;
  }

  return true;
}

```

text
text

## Problems with this result

\n\nNo type safety - accepts any data type
\n\nOnly checks if data exists, not what's in it
\n\nNo actual validation logic for specific fields
\n\nNo error messages or feedback
\n\nUnclear what "valid" means in this context
\n\nNo documentation or usage examples

✅ **Good Content (Rich Context):**

## Prompt

```

text

Create a TypeScript function to validate user registration data for a React application using Zod schema validation. The function should:
\n\nAccept an object with email, password, and username fields
\n\nReturn a typed validation result with error messages
\n\nUse Zod v3.22 library
\n\nFollow the existing validation pattern used in src/validators/loginValidator.ts

```

text
text

**Result:** `validateDataGood.ts` (150+ lines)

## Key highlights from the generated code

```

typescript
import { z } from "zod";

export interface ValidationResult {
  isValid: boolean;

  errors: string[];

  data?: UserRegistrationData;
}

const userRegistrationSchema = z.object({
  email: z

    .string()

    .min(1, "Email is required")

    .email("Email format is invalid"),

  password: z

    .string()

    .min(8, "Password must be at least 8 characters")

    .regex(/[A-Z]/, "Password must contain at least one uppercase letter")

    .regex(/[a-z]/, "Password must contain at least one lowercase letter")

    .regex(/\d/, "Password must contain at least one number")

    .regex(
      /[!@#$%^&*(),.?":{}|<>]/,

      "Password must contain at least one special character",
    ),

  username: z

    .string()

    .min(3, "Username must be at least 3 characters")

    .max(20, "Username must be at most 20 characters")

    .regex(/^[a-zA-Z]/, "Username must start with a letter")

    .regex(
      /^[a-zA-Z0-9_]+$/,

      "Username can only contain letters, numbers, and underscores",
    ),
});

export function validateUserRegistration(
  data: UserRegistrationData,
): ValidationResult {
  try {
    const validatedData = userRegistrationSchema.parse(data);

    return { isValid: true, errors: [], data: validatedData };
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errors = error.errors.map((err) => err.message);

      return { isValid: false, errors };
    }

    return {
      isValid: false,

      errors: ["An unexpected validation error occurred"],
    };
  }
}

```

text
text

## Benefits of this result

\n\n✅ Full TypeScript type safety with interfaces and type guards
\n\n✅ Uses Zod v3.22 library as specified
\n\n✅ Comprehensive validation rules for each field
\n\n✅ Detailed, user-friendly error messages
\n\n✅ Follows ValidationResult pattern from existing codebase
\n\n✅ Includes JSDoc documentation with usage examples
\n\n✅ Additional helper functions (type guards, safe wrapper)
\n\n✅ Professional error handling for edge cases

## Comparison

| Aspect | Poor Prompt (`validateData.js`) | Good Prompt (`validateDataGood.ts`) |

| ----------------------- | ------------------------------- | --------------------------------------- |

| **Lines of Code** | 6 lines | 150+ lines |

| **Type Safety** | ❌ None | ✅ Full TypeScript + Zod schemas |

| **Validation Logic** | ❌ Only checks existence | ✅ Field-specific validation with rules |

| **Error Messages** | ❌ None | ✅ Detailed, actionable messages |

| **Documentation** | ❌ None | ✅ Complete JSDoc with examples |

| **Library Usage** | ❌ None | ✅ Zod v3.22 as requested |

| **Pattern Consistency** | ❌ No pattern | ✅ Matches loginValidator.ts pattern |

| **Production Ready** | ❌ No | ✅ Yes |

\n\n2. Intent: The Specific Goal or Purpose of the Prompt

**Definition:** Intent is the explicit statement of what you want to achieve—the desired outcome, deliverable, or action you expect from GitHub Copilot.

## Key Elements

\n\n**Action Verb:** Create, refactor, debug, explain, optimize, test, document
\n\n**Deliverable:** Function, class, test suite, configuration file, documentation
\n\n**Outcome:** Working code, explanation, comparison, recommendation
\n\n**Success Criteria:** What "done" looks like

## Examples

❌ **Poor Intent (Vague Goal):**

```

text

Something with database connections.

```

text
text

✅ **Good Intent (Clear Goal):**

```

text

Create a reusable database connection pool manager for PostgreSQL that:
\n\nInitializes a connection pool on application startup
\n\nProvides a method to execute queries with automatic connection handling
\n\nIncludes error handling and connection retry logic
\n\nExports a singleton instance for use across the application

```

text
text

\n\n3. Clarity: Ease of Understanding

**Definition:** Clarity measures how easily GitHub Copilot (and humans) can understand your request without ambiguity or confusion.

## Key Elements

\n\n**Simple Language:** Avoid jargon when plain terms suffice
\n\n**Logical Structure:** Organize requests with clear sections or bullet points
\n\n**One Primary Task:** Focus on a single main objective per prompt
\n\n**Unambiguous Terms:** Use precise terminology without conflicting meanings
\n\n**Consistent Terminology:** Use the same terms throughout the prompt

## Examples

❌ **Poor Clarity (Confusing and Ambiguous):**

```

text

Make a thing that does stuff with the API and handles the errors but also needs to work with the other thing we talked about before and maybe use async or callbacks depending on what works better and it should probably log things too.

```

text
text

✅ **Good Clarity (Clear and Structured):**

```

text

Create an API client wrapper with the following features:

\n\nError Handling:
\n\nCatch network errors and return user-friendly messages
\n\nRetry failed requests up to 3 times with exponential backoff

\n\nAsync Implementation:
\n\nUse async/await pattern (not callbacks)
\n\nReturn Promises for all API calls

\n\nLogging:
\n\nLog all requests and responses to console in development mode
\n\nInclude timestamp and endpoint in log messages

```

text
text

\n\n4. Specificity: The Level of Detail and Precision

**Definition:** Specificity determines how detailed and precise your requirements are, providing exact constraints, formats, names, and implementation details.

## Key Elements

\n\n**Exact Names:** Variable names, function names, file names, class names
\n\n**Data Types:** Specific types (string, number, boolean, custom interfaces)
\n\n**Format Requirements:** Date formats, naming conventions, code style
\n\n**Numeric Constraints:** Max length, min value, array size, timeout values
\n\n**Technology Versions:** Library versions, language versions, framework versions
\n\n**Edge Cases:** Specific scenarios to handle or avoid

## Examples

❌ **Poor Specificity (Generic and Vague):**

```

text

Create a function to format dates nicely.

```

text
text

✅ **Good Specificity (Detailed and Precise):**

```

text

Create a TypeScript function named `formatDateForDisplay` that:
\n\nAccepts a Date object or ISO 8601 string as input
\n\nReturns a string formatted as "MMM DD, YYYY" (e.g., "Nov 03, 2025")
\n\nUses the date-fns library (v2.30.0) format function
\n\nHandles invalid dates by returning "Invalid Date"
\n\nIncludes JSDoc comments with @param and @returns tags
\n\nExport as a named export from src/utils/dateFormatter.ts

```

text
text

\n\nCombining All Four Concepts: Complete Prompt Example

\n\nPoor Prompt (Lacking All Four Pillars)

```

text

Make a login function.

```

text
text

## Analysis

\n\n❌ **Content:** No context about authentication method, technology stack, or requirements
\n\n❌ **Intent:** Unclear what "make" means—create, refactor, test, document?
\n\n❌ **Clarity:** Too vague, no structure
\n\n❌ **Specificity:** No details about implementation, return types, or error handling

\n\nExcellent Prompt (Demonstrating All Four Pillars)

```

text

**Context:** I'm building a Node.js REST API using Express and JWT authentication. The existing codebase uses bcrypt for password hashing and stores users in a PostgreSQL database via Prisma ORM.

**Intent:** Create an async login function that authenticates users and returns a JWT token.

## Requirements

\n\nFunction name: `authenticateUser`
\n\nAccept email and password as parameters (both strings)
\n\nQuery the database using Prisma to find user by email
\n\nCompare password with hashed password using bcrypt.compare()
\n\nIf authentication succeeds:
\n\nGenerate a JWT token with user ID and email in payload
\n\nToken should expire in 24 hours
\n\nReturn object: `{ success: true, token: string, userId: number }`
\n\nIf authentication fails:
\n\nReturn object: `{ success: false, error: string }`
\n\nInclude TypeScript types for return value
\n\nAdd error handling for database errors
\n\nUse environment variable JWT_SECRET for token signing

## Style

\n\nUse async/await (not callbacks)
\n\nFollow existing error handling patterns in src/middleware/errorHandler.ts
\n\nAdd JSDoc comments

```

text
text

## Analysis

\n\n✅ **Content:** Rich context about tech stack, existing patterns, and architecture
\n\n✅ **Intent:** Clear goal—create an authentication function with specific behavior
\n\n✅ **Clarity:** Well-structured with sections, numbered requirements, easy to parse
\n\n✅ **Specificity:** Exact function name, parameter types, return format, library methods, and timeout values

\n\nUser Stories / Use Cases

\n\nUser Story 1: Junior Developer Seeking Code Generation

**As a** junior developer

**I want** to provide effective prompts to GitHub Copilot

**So that** I receive production-ready code that matches my project's standards without extensive iteration

## Acceptance Criteria

\n\nDeveloper can identify missing Content, Intent, Clarity, or Specificity in their prompt
\n\nGenerated code matches project architecture and coding standards
\n\nFirst suggestion requires minimal modifications (< 20% changes)

\n\nUser Story 2: Senior Developer Refactoring Legacy Code

**As a** senior developer

**I want** to clearly communicate refactoring intent with sufficient context

**So that** GitHub Copilot suggests modern patterns while preserving business logic

## Acceptance Criteria

\n\nPrompt includes legacy code snippet for context
\n\nIntent specifies "refactor" vs "rewrite" vs "modernize"
\n\nSpecificity includes which patterns to apply and which to avoid

\n\nUser Story 3: Team Lead Establishing Prompting Standards

**As a** team lead

**I want** a framework for evaluating prompt quality

**So that** my team can consistently get high-quality suggestions and reduce review cycles

## Acceptance Criteria

\n\nTeam members can score prompts on 4-pillar scale (1-5 for each pillar)
\n\nDocumentation includes examples of good/poor prompts
\n\nPrompts with scores < 3 in any pillar are revised before submission

\n\nFunctional Requirements

| Requirement ID | Pillar | Description |

| -------------- | ----------- | -------------------------------------------------------------------------------------- |

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

\n\nNon-Functional Requirements

\n\n**Usability:** Prompts should be readable by both AI and human developers
\n\n**Maintainability:** Prompt patterns should be reusable across similar tasks
\n\n**Efficiency:** Well-structured prompts should reduce iteration cycles by 50%
\n\n**Consistency:** Team members should achieve similar results with similar prompts
\n\n**Learning Curve:** New developers should be able to write effective prompts within 1 week

\n\nPrompt Quality Scoring Rubric

Use this rubric to evaluate prompt effectiveness:

| Pillar | Score 1 (Poor) | Score 3 (Acceptable) | Score 5 (Excellent) |

| --------------- | ---------------------------------- | -------------------------------------------- | --------------------------------------------------------------------------------------------- |

| **Content** | No context or constraints provided | Basic context included (language, framework) | Rich context including tech stack, existing patterns, architecture, constraints, and examples |

| **Intent** | Vague or missing goal | Clear action verb and deliverable type | Explicit goal with success criteria and expected outcome |

| **Clarity** | Confusing, ambiguous, or rambling | Understandable with minor ambiguities | Crystal clear with logical structure and precise terminology |

| **Specificity** | Generic with no details | Some details (names or types) | Comprehensive details including names, types, formats, values, and edge cases |

## Total Score Interpretation

\n\n**16-20:** Excellent prompt—likely to produce high-quality results on first attempt
\n\n**12-15:** Good prompt—may require minor refinements
\n\n**8-11:** Acceptable prompt—will likely need iteration
\n\n**4-7:** Poor prompt—needs significant improvement before use

\n\nCommon Anti-Patterns and Solutions

\n\nAnti-Pattern 1: The "Make It Work" Prompt

❌ **Example:** "Fix this code"

## Problems

\n\nNo intent specified (debug? refactor? optimize?)
\n\nNo content about what's broken or expected behavior
\n\nNo specificity about constraints or requirements

✅ **Solution:**

```

text

Debug this TypeScript function that's throwing a "Cannot read property 'length' of undefined" error.

[Include code snippet]

Expected behavior: Function should return the length of the input array, or 0 if array is null/undefined.

```

text
text

\n\nAnti-Pattern 2: The "Do Everything" Prompt

❌ **Example:** "Create a complete authentication system with login, signup, password reset, email verification, OAuth, 2FA, session management, and admin panel"

## Problems

\n\nViolates clarity principle (too many tasks)
\n\nImpossible to complete in one interaction
\n\nLacks specificity for each feature

✅ **Solution:** Break into multiple focused prompts:

```

text

Prompt 1: Create a user registration function with email and password

Prompt 2: Create a login function with JWT token generation

Prompt 3: Create a password reset request handler

[etc.]

```

text
text

\n\nAnti-Pattern 3: The "Assumed Context" Prompt

❌ **Example:** "Add that validation we discussed earlier to the form"

## Problems

\n\nAssumes AI remembers previous conversation context
\n\nNo content about which validation or which form
\n\nUnclear intent and specificity

✅ **Solution:**

```

text

Add email format validation to the ContactForm component in src/components/ContactForm.tsx.

Requirements:
\n\nUse Zod schema validation
\n\nValidate email format using regex pattern
\n\nDisplay error message below email input field
\n\nPrevent form submission if email is invalid

```

text
text

\n\nAnti-Pattern 4: The "Jargon Overload" Prompt

❌ **Example:** "Implement a DAL with CQRS pattern using the repository pattern and UoW for the aggregate roots in the bounded context"

## Problems

\n\nViolates clarity with excessive jargon
\n\nAssumes AI interprets jargon exactly as intended
\n\nMissing specificity about actual implementation

✅ **Solution:**

```

text

Create a data access layer for the User entity with separate read and write operations:

\n\nCreate UserRepository class with:
\n\ngetById(id): User - Read single user
\n\ngetAll(): User[] - Read all users
\n\ncreate(user): void - Write new user
\n\nupdate(user): void - Update existing user

\n\nUse the repository pattern to abstract database operations
\n\nImplement unit of work pattern to manage transactions
\n\nTarget entity: User (properties: id, email, name, createdAt)

```

text
text

\n\nSuccess Criteria / KPIs

| Metric | Baseline | Target | Measurement Method |

| -------------------------------- | -------- | ------ | ----------------------------------------------- |

| First-suggestion acceptance rate | 30% | 70% | % of suggestions used without modification |

| Iteration cycles per task | 3.5 | 1.5 | Avg. number of prompt refinements needed |

| Prompt quality score | 2.5/5 | 4.0/5 | Team self-assessment using rubric |

| Developer satisfaction | 3.2/5 | 4.5/5 | Quarterly survey on AI assistance effectiveness |

| Time to first working solution | 15 min | 5 min | Time from initial prompt to working code |

\n\nMilestones & Timeline

| Milestone | Target Date | Status |

| ---------------------------------- | ---------------- | ----------- |

| PRD Draft Complete | November 3, 2025 | ✅ Complete |

| Team Training on 4 Pillars | TBD | Pending |

| Prompting Guidelines Documentation | TBD | Pending |

| Prompt Template Library Created | TBD | Pending |

| First Quality Assessment | TBD | Pending |

| Iteration and Refinement | TBD | Pending |

\n\nBest Practices Summary

\n\nQuick Checklist for Effective Prompts

Before submitting a prompt to GitHub Copilot, verify:

\n\n[ ] **Content:** Have I provided enough context (tech stack, existing patterns, constraints)?
\n\n[ ] **Intent:** Is my goal crystal clear (action verb + deliverable)?
\n\n[ ] **Clarity:** Can someone else understand this easily?
\n\n[ ] **Specificity:** Have I included exact names, types, and constraints?

\n\nTemplate for Complex Prompts

```

text

**Context:** [Technology stack, existing code patterns, architectural constraints]

**Intent:** [Action verb] + [deliverable type] that [main purpose]

## Requirements

\n\n[Specific requirement with details]
\n\n[Specific requirement with details]
\n\n[Edge case or constraint]

## Technical Details

\n\nFunction/Class name: [exact name]
\n\nParameters: [types and names]
\n\nReturn type: [exact type]
\n\nLibraries: [name and version]

## Style

\n\n[Coding conventions to follow]
\n\n[Error handling approach]
\n\n[Documentation requirements]

```

text
text

\n\nExamples Across Common Scenarios

\n\nScenario 1: Creating a New Feature

```

text

**Context:** Building a React e-commerce app using TypeScript, Redux Toolkit, and React Router v6.

**Intent:** Create a product search component with real-time filtering.

## Requirements

\n\nComponent name: ProductSearchBar
\n\nAccept products array as prop (type: Product[])
\n\nFilter products by name and description as user types
\n\nDebounce search input by 300ms
\n\nDisplay filtered results in a dropdown list below input
\n\nEmit onProductSelect event when user clicks a result
\n\nUse existing styling from src/styles/searchBar.module.css

## Technical Details

\n\nUse React hooks (useState, useEffect, useMemo)
\n\nUse lodash.debounce for input debouncing
\n\nProduct interface: { id: number; name: string; description: string; price: number }

```

text
text

\n\nScenario 2: Debugging Existing Code

```

text

**Context:** Node.js API using Express. The endpoint `/api/users/:id` is returning 500 errors intermittently.

**Intent:** Debug and fix the getUserById function to handle edge cases properly.

## Current Code

[Include code snippet]

## Observed Behavior

\n\nWorks for valid user IDs
\n\nThrows "Cannot read property 'name' of null" when user doesn't exist
\n\nSometimes returns 500 instead of 404

## Expected Behavior

\n\nReturn 404 with message "User not found" when ID doesn't exist
\n\nReturn 400 with message "Invalid ID format" for non-numeric IDs
\n\nReturn 200 with user data for valid requests
\n\nNever return 500 errors for these cases

```

text
text

\n\nScenario 3: Refactoring Legacy Code

```

text

**Context:** Refactoring a legacy JavaScript module to modern TypeScript. Current code uses callbacks and var declarations.

**Intent:** Modernize the authentication module while preserving exact business logic.

## Current Code

[Include legacy code]

## Modernization Requirements

\n\nConvert to TypeScript with strict typing
\n\nReplace callbacks with async/await
\n\nReplace var with const/let
\n\nAdd proper error handling with try/catch
\n\nExtract hard-coded values to constants
\n\nAdd JSDoc comments
\n\nDo NOT change business logic or validation rules

## Constraints

\n\nMust remain compatible with existing API consumers
\n\nKeep function signature public API identical (input/output)

```

text
text

\n\nScenario 4: Writing Tests

```

text

**Context:** Jest + React Testing Library project. Need tests for the LoginForm component.

**Intent:** Create comprehensive unit tests for the LoginForm component covering success, error, and edge cases.

## Component Behavior

\n\nAccepts onSubmit callback prop
\n\nHas email and password input fields
\n\nHas submit button disabled when fields are empty
\n\nShows validation errors below fields when invalid
\n\nCalls onSubmit with { email, password } when valid

## Test Requirements

\n\nTest file name: LoginForm.test.tsx
\n\nTest cases to cover:
\n\nRenders all form elements
\n\nSubmit button disabled when empty
\n\nSubmit button enabled when fields filled
\n\nShows error for invalid email format
\n\nShows error for password < 8 characters
\n\nCalls onSubmit with correct data on valid submission
\n\nPrevents submission when Enter pressed on invalid form

## Style

\n\nUse React Testing Library best practices (avoid testID when possible)
\n\nUse user-event library for interactions
\n\nFollow AAA pattern (Arrange, Act, Assert)

```

text
text

\n\nKey Takeaways

\n\n**Content is King:** Always provide rich context about your technology stack, constraints, and existing patterns
\n\n**Intent Drives Output:** Be explicit about what you want—don't make the AI guess
\n\n**Clarity Prevents Confusion:** Structure your prompts logically and use precise terminology
\n\n**Specificity Ensures Accuracy:** Include exact names, types, values, and formats to get exactly what you need
\n\n**Practice Makes Perfect:** Start with the template, evaluate with the rubric, and refine your approach

\n\nQuestions for Attendees

\n\nWhat challenges have you faced with vague or poorly structured prompts?
\n\nWhich of the four pillars do you find most difficult to implement consistently?
\n\nWhat additional examples or scenarios would be helpful for your use cases?
\n\nHow can we integrate prompt quality checks into your team's workflow?

\n\nCall to Action

\n\n**Evaluate Your Recent Prompts:** Score your last 5 prompts using the rubric—identify patterns
\n\n**Use the Template:** Apply the template to your next complex task
\n\n**Share Learnings:** Document what works well for your specific domain or tech stack
\n\n**Iterate and Improve:** Track your first-suggestion acceptance rate and iteration cycles over the next 2 weeks

---

## Document Version History

| Version | Date | Author | Changes |

| ------- | ----------- | -------------- | ------------------------------------------------------------------- |

| 1.0 | Nov 3, 2025 | GitHub Copilot | Initial draft demonstrating the four pillars of effective prompting |

\n
