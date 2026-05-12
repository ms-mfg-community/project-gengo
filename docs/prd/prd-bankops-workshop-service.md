# Product Requirements Document: BankOps Workshop Service

## 1. Document Information

**Version:** 1.0  
**Status:** Draft  
**Date:** 2026-04-16  
**Source:** [BankOps kickoff notes](../meeting-notes/2026-04-kickoff.md)

## 2. Executive Summary

BankOps is a workshop-ready banking demo service that ingests transaction events, evaluates whether a fraud review case should be created, and records an append-only audit trail. The experience should feel like a realistic banking workflow while remaining small enough to build, explain, and run during a 90-minute session.

## 3. Problem Statement / Context

The workshop needs a compact but credible banking scenario instead of a generic sample application. The service must demonstrate how transaction events from banking channels and core systems can drive a fraud review workflow, how auditability is preserved across the request flow, and how Copilot can help convert planning artifacts into implementation assets such as issues, standards documentation, templates, and architecture records.

## 4. Goals and Objectives

- Deliver a small but realistic banking demo for workshop use.
- Ingest transaction events through a single workshop-friendly API.
- Demonstrate both a suspicious-transaction path and a no-action path.
- Create a fraud review case for suspicious transactions in under 2 seconds end to end.
- Preserve auditability through correlation IDs and append-only audit records.
- Keep local setup lightweight enough to complete in under 5 minutes on a clean laptop.
- Show how Copilot can support not only code generation but also backlog and documentation creation.

## 5. Scope

### 5.1 In Scope

- A single initial ingestion endpoint, expected to be `POST /transactions`
- Transaction-event intake from banking channels and core systems
- An initial suspicious-transaction rule based on unusual transaction amount
- A no-trigger path where valid transactions do not create a fraud case
- In-memory persistence for workshop simplicity
- Append-only in-memory audit logging
- Structured logging suitable for walkthrough and explanation
- A notification stub that simulates downstream customer or operations notification behavior
- Documentation and governance assets required for team collaboration

### 5.2 Out of Scope

- Database setup for the workshop
- Real notification service integration
- Full fraud-modeling coverage beyond the initial rule set
- Velocity checks, location anomalies, and other advanced signals in the first slice
- Automatic merge workflows
- Production-grade audit retention implementation

## 6. Functional Requirements

- FR-1: The service shall expose a single workshop endpoint for transaction ingestion.
- FR-2: The service shall accept transaction payloads from banking channels and core systems.
- FR-3: The service shall retain `bank_id` in the payload to preserve tenant context for future expansion.
- FR-4: The service shall support an initial suspicious-transaction rule based on unusual transaction amount.
- FR-5: The service shall support a no-trigger path where a valid transaction does not create a fraud review case.
- FR-6: The service shall create a fraud review case when trigger conditions are met.
- FR-7: The service shall complete the trigger-to-case path in under 2 seconds for the workshop scenario.
- FR-8: The service shall include a correlation ID throughout request processing and audit records.
- FR-9: The service shall maintain an append-only audit log for all relevant workflow steps.
- FR-10: The service shall sanitize input, logs, and stored data so that no PII is captured, including full account numbers and customer names.
- FR-11: The service shall tolerate older upstream field naming inconsistencies through a normalization layer or equivalent translation step.
- FR-12: The service shall include a notification stub that demonstrates downstream behavior without calling a real external service.
- FR-13: The project shall demonstrate how Copilot can transform workshop planning into issues, standards documentation, templates, and implementation artifacts.

## 7. Non-Functional Requirements

- NFR-1: The full demo shall fit within a 90-minute workshop.
- NFR-2: Local setup on a clean laptop shall complete in under 5 minutes.
- NFR-3: Logs shall be structured enough to explain system behavior without introducing a full observability stack.
- NFR-4: CI shall run formatting, linting, and tests.
- NFR-5: Human review shall remain required, and auto-merge shall not be enabled.
- NFR-6: Audit entries shall be non-editable after creation.
- NFR-7: The application shall remain small and readable enough to support live coding and explanation.

## 8. Risks and Assumptions

### 8.1 Assumptions

- FastAPI is the preferred framework because it is readable and works well for live workshop coding.
- Upstream transaction payloads are usually normalized, though some legacy integrations may emit inconsistent field names.
- In-memory persistence is acceptable for the workshop even though it does not represent a production retention strategy.
- A single-tenant demo is sufficient for the first workshop iteration, while still carrying `bank_id` for future extensibility.

### 8.2 Risks

- Upstream schema drift may complicate payload validation and event normalization.
- Unclear ownership of risk score calculation may block prioritization and case-routing decisions.
- Advanced fraud signals deferred out of scope may limit the perceived realism of the demo if not clearly framed.
- In-memory audit storage may create confusion if workshop participants mistake it for a production-ready approach.

## 9. Open Questions

- Should unknown transaction types be rejected or stored without action?
- Should risk score be computed by this service or supplied upstream?
- Should risk score influence case priority directly or only inform notifications?
- What should the audit-retention approach be outside the workshop demo?
- Should notification stubs remain inside the same service or be split into a separate component later?

## 10. Implementation Guidance

- Use FastAPI for the workshop service.
- Start with a single `POST /transactions` endpoint.
- Model unusual transaction amount as the first supported fraud signal.
- Defer velocity checks, location anomalies, and additional heuristics until after the initial workshop slice.
- Keep persistence and audit storage in memory to avoid environment setup overhead.
- Ensure every request and audit event carries a correlation ID.
- Implement a normalization layer for approved legacy field aliases so older integrations do not break the demo.
- Keep all logs sanitized and avoid writing sensitive account or customer information.

## 11. Testing Requirements

- Include automated tests for both suspicious and non-suspicious transaction paths.
- Verify that suspicious transactions create a fraud review case.
- Verify that valid non-suspicious transactions do not create a case.
- Verify correlation ID propagation across request handling and audit logging.
- Verify that sanitized logging and audit behavior do not capture prohibited PII fields.
- Verify that older field-name variants are normalized correctly when supported.
- Include CI checks for formatting, linting, and tests.

## 12. Required Follow-Up Artifacts

- Standards document capturing agreed engineering and collaboration conventions
- Pull request template requiring test evidence and acceptance-criteria mapping
- CODEOWNERS configuration routing documentation to facilitators and application code to platform or backend owners
- Sample ADR covering transaction schema versioning and contract drift
- Seed issues derived from the PRD to support implementation planning

## 13. Success Criteria

- A workshop participant can run the service locally in under 5 minutes.
- The demo successfully shows both a fraud-case-creation flow and a no-action flow.
- Correlation IDs and append-only audit records are visible and explainable throughout the flow.
- No prohibited PII appears in payload handling, logs, or audit entries.
- CI enforces formatting, linting, and tests before merge.
- The resulting assets include not only code guidance but also issues, standards, and architecture follow-up items.
