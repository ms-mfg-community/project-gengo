# BankOps Kickoff Notes

Date: 2026-04-15  
Attendees: Priya (PO), Marco (site reliability), Leah (platform), Nina (fraud operations lead), workshop facilitator

## Raw Notes

- Need something small for the demo but it should feel like a real banking flow, not a toy todo app.
- Events come from banking channels and core systems, probably already normalized, but someone said older integrations still send inconsistent field names.
- We only need one endpoint for the workshop. Maybe `POST /transactions` is enough.
- Unusual transaction amount is the easiest signal to explain live. Velocity checks or location anomalies can come later if there is time.
- If a transaction looks suspicious, we should create a fraud review case quickly, maybe under 2 seconds end to end.
- SRE wants a correlation ID on every step because audit reviews were painful last quarter.
- No PII. No full account numbers. No customer names. Keep it sanitized.
- Audit log cannot be editable after the fact. For the workshop, append-only in memory is probably okay.
- Need a demo path where nothing triggers too, not every transaction should become a fraud case.
- A customer notification stub would be nice, but we do not need to call a real service.
- There was debate about whether to support multiple banks or just one demo tenant. I think we should keep `bank_id` in the payload anyway.
- Someone asked if risk score comes from upstream or is computed here. No answer yet.
- We should show how Copilot helps turn this into issues, not just code.
- Include standards docs because the team keeps saying "we should standardize" without writing anything down.
- Need PR template to force test evidence and acceptance-criteria mapping.
- Codeowners should route docs to facilitators and app code to platform/backend owners.
- Maybe use FastAPI because it is readable and live coding is faster.
- Keep persistence in memory. No database setup during the workshop.
- Need a sample ADR for transaction schema versioning because upstream contracts always drift.

## Constraints And Non-Functional Notes

- Demo must fit in 90 minutes.
- Local setup should be under 5 minutes on a clean laptop.
- Logs should be structured enough to explain without bringing in a full observability stack.
- CI must run formatting, linting, and tests.
- No auto-merge. Human review remains required.

## Open Questions

- Do we want to reject unknown transaction types or store them without action?
- Should risk score influence case priority directly or only help with notifications?
- What is the retention story for audit entries outside this workshop demo?
- Will notification stubs live in the same service or be split later?
