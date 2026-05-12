# BankOps GitHub Issues

## Issue 1

- Type: Feature
- Title: Add `POST /transactions` intake endpoint
- Description: Create the initial workshop API endpoint that accepts sanitized transaction requests and returns a processing response with correlation metadata.
- Acceptance Criteria: Valid requests are accepted; malformed requests are rejected with clear validation errors; every response includes a correlation ID.
- Test Plan: API tests for accepted and rejected requests, including missing-field and invalid-shape payloads.
- Logging And Telemetry: Emit a correlation ID and request outcome for every processed transaction.
- Rollout Risk: Low, because the first endpoint is isolated and backed by in-memory behavior.

## Issue 2

- Type: Feature
- Title: Implement suspicious-transaction evaluation rule
- Description: Add the initial fraud decision rule that flags transactions based on unusual transaction amount for the workshop scenario.
- Acceptance Criteria: Suspicious transactions trigger case creation eligibility; non-suspicious transactions remain accepted without creating a fraud case.
- Test Plan: Unit and API tests for triggering and non-triggering transaction examples.
- Logging And Telemetry: Record the decision result, rule identifier, and correlation ID in audit details.
- Rollout Risk: Medium, because this establishes core business behavior for the demo.

## Issue 3

- Type: Feature
- Title: Create in-memory fraud case store
- Description: Persist fraud review cases in memory with identifiers, transaction linkage, tenant context, and status details suitable for demo inspection.
- Acceptance Criteria: Each triggered transaction creates exactly one fraud case with the expected fields and source linkage.
- Test Plan: Verify case creation count, field population, and source transaction association.
- Logging And Telemetry: Include fraud case ID and `bank_id` in relevant audit and workflow records.
- Rollout Risk: Low, because the implementation remains workshop-scoped and non-persistent.

## Issue 4

- Type: Feature
- Title: Add append-only audit trail for transaction processing
- Description: Record intake, evaluation, and downstream actions in an append-only in-memory audit log.
- Acceptance Criteria: Each accepted transaction produces audit records for ingestion and decision flow; audit entries cannot be mutated after creation.
- Test Plan: Assert audit entry counts, ordered actions, and immutable append-only behavior after processing requests.
- Logging And Telemetry: Standardize audit fields such as `action`, `outcome`, `correlation_id`, and `details`.
- Rollout Risk: Medium, because the audit trail is central to workshop trust and explainability.

## Issue 5

- Type: Feature
- Title: Add sanitized notification stub for flagged transactions
- Description: Simulate downstream notification behavior for suspicious transactions without calling a real messaging or customer-contact system.
- Acceptance Criteria: Triggered transactions create exactly one notification stub entry; non-triggered transactions do not.
- Test Plan: Verify stub record creation for suspicious flows and no-op behavior for clean flows.
- Logging And Telemetry: Carry correlation ID and fraud case linkage into the stubbed notification record.
- Rollout Risk: Low, because the notification path is simulated and isolated from external systems.

## Issue 6

- Type: Feature
- Title: Support legacy field normalization and payload sanitization
- Description: Add a normalization layer for approved legacy field names while enforcing sanitized handling of account and customer data.
- Acceptance Criteria: Supported legacy aliases are translated into the canonical request shape; prohibited PII fields are not logged or persisted in clear form.
- Test Plan: Add request-shape tests for legacy aliases and assertions that logs or audit entries exclude prohibited sensitive fields.
- Logging And Telemetry: Capture normalization outcomes without exposing raw sensitive values.
- Rollout Risk: Medium, because schema translation and privacy handling affect correctness and compliance.

## Issue 7

- Type: Feature
- Title: Add CI and contributor workflow standards for the workshop app
- Description: Introduce formatting, linting, test automation, and contributor-facing standards that support the workshop service lifecycle.
- Acceptance Criteria: CI runs formatting, linting, and automated tests; repository guidance reflects the required developer workflow.
- Test Plan: Validate the CI definition and confirm the documented local commands match the automated checks.
- Logging And Telemetry: CI output is sufficient; no additional runtime telemetry required.
- Rollout Risk: Low, because this improves consistency without altering runtime fraud behavior.

## Issue 8

- Type: Tech debt
- Title: Define correlation and structured-audit conventions
- Description: Align implementation and documentation around required correlation ID propagation and the minimum structured audit fields for workshop flows.
- Acceptance Criteria: Standards documentation defines required correlation behavior, mandatory audit fields, and response expectations.
- Test Plan: Review the documentation and confirm response payloads and audit records expose the documented fields.
- Logging And Telemetry: This issue establishes the baseline telemetry contract for the demo.
- Rollout Risk: Low, because it clarifies behavior rather than expanding runtime scope.

## Issue 9

- Type: ADR request
- Title: Decide transaction schema versioning and unknown-type handling
- Description: Capture an architecture decision for schema versioning, legacy field aliases, and how the service should behave when it receives unknown transaction types.
- Acceptance Criteria: ADR follow-up records the decision, tradeoffs, and recommended behavior for versioning and unsupported transaction types.
- Test Plan: None for the initial ADR request; downstream implementation issues can add tests after the decision is made.
- Logging And Telemetry: Document whether unsupported or unknown transaction types should still appear in audit and operational summaries.
- Rollout Risk: Medium, because contract decisions can affect compatibility and future extensibility.
