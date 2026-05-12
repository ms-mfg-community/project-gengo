# Copilot Instructions GitHub Issues

## Issue 1

- Type: Documentation
- Title: Add a root-level repository overview and navigation entrypoint
- Description: Create a clear top-level entrypoint for contributors so the guidance in `.github/copilot-instructions.md` can point to a canonical repository overview instead of scattered references.
- Acceptance Criteria: A root-level overview document exists; the instructions file links to a valid repository overview; the overview highlights major folders, active workspaces, and contributor starting points.
- Test Plan: Validate markdown links locally and confirm a new contributor can identify where to start from the overview document.
- Logging And Telemetry: None required beyond standard repository review history.
- Rollout Risk: Low, because this improves discoverability without changing runtime behavior.

## Issue 2

- Type: Documentation
- Title: Add a formal issue template file aligned with repo guidance
- Description: Create one or more GitHub issue templates that match the issue structure defined in `.github/copilot-instructions.md`.
- Acceptance Criteria: A reusable issue template exists under the repository’s GitHub configuration; the template captures Type, Title, Description, Acceptance Criteria, Test Plan, Logging And Telemetry, and Rollout Risk; the template wording matches current instruction guidance.
- Test Plan: Open a new issue draft using the template and verify all expected fields appear with usable prompts.
- Logging And Telemetry: None beyond GitHub issue history.
- Rollout Risk: Low, because the change affects contributor workflow only.

## Issue 3

- Type: Documentation
- Title: Add CODEOWNERS and ownership routing for docs, prompts, agents, and code
- Description: Implement ownership routing so review expectations described in the instructions are enforced consistently across documentation, customization assets, and source code.
- Acceptance Criteria: A `CODEOWNERS` file exists; documentation ownership differs from application or platform ownership where appropriate; routing aligns with the contributor guidance described in the instructions.
- Test Plan: Validate the syntax of the `CODEOWNERS` file and review ownership coverage for key folders such as `.github/`, `docs/`, `programming/`, `infra/`, and `scripting/`.
- Logging And Telemetry: None required.
- Rollout Risk: Medium, because review routing changes can affect contributor workflow and approval expectations.

## Issue 4

- Type: Tech debt
- Title: Audit instruction references for stale paths and outdated examples
- Description: Review `.github/copilot-instructions.md` for broken links, outdated repo references, and examples that no longer match the current repository layout or preferred workflows.
- Acceptance Criteria: All internal links resolve; high-signal examples align with live repository paths; obsolete references are removed or updated.
- Test Plan: Run markdown validation and manually verify the linked paths referenced in the instructions.
- Logging And Telemetry: None beyond review comments and change history.
- Rollout Risk: Low, because this is a documentation-alignment change.

## Issue 5

- Type: Feature
- Title: Add reusable validation workflow for documentation and customization assets
- Description: Create a CI workflow that validates markdown quality, internal links, and selected `.github` customization assets so instruction changes are verified automatically.
- Acceptance Criteria: A workflow exists that runs on relevant documentation and `.github` changes; markdown or link-validation failures block success; the workflow is documented for contributors.
- Test Plan: Trigger the workflow with both valid and intentionally broken markdown changes and verify failure behavior is correct.
- Logging And Telemetry: CI output should clearly identify the failing file and validation rule.
- Rollout Risk: Medium, because new quality gates may initially surface existing repository issues.

## Issue 6

- Type: Documentation
- Title: Publish a contributor guide for PRD-to-issue and meeting-notes workflows
- Description: Add a dedicated contributor guide that shows how to use the repository’s prompt and instruction patterns to turn meeting notes into PRDs, issues, and ADR requests.
- Acceptance Criteria: A guide exists with step-by-step usage examples; the guide references the current prompt patterns in `.github/copilot-instructions.md`; examples cover meeting notes, PRDs, and issue derivation.
- Test Plan: Review the guide for accuracy against the current instructions file and confirm the documented paths and examples exist.
- Logging And Telemetry: None required.
- Rollout Risk: Low, because the change is instructional only.

## Issue 7

- Type: ADR request
- Title: Decide governance strategy for repository-wide Copilot customization assets
- Description: Capture an architectural decision for how repository-wide Copilot instructions, prompts, agents, and skills should evolve, be versioned, and be reviewed as the repo grows.
- Acceptance Criteria: An ADR documents the ownership model, review expectations, versioning approach, and when to use instructions versus prompts, skills, or agents.
- Test Plan: Review the ADR with maintainers and verify that the resulting decision can be applied to future `.github` customization changes.
- Logging And Telemetry: Document whether governance decisions require audit trails through PR labels, CODEOWNERS, or issue metadata.
- Rollout Risk: Medium, because governance decisions will shape future contribution and maintenance workflows.
