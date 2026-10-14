---
title: AI Change Impact Review Template
type: template
scope: United States
status: current
as_of: 2026-10-13
last_verified: 2026-10-13
review_by: 2026-11-13
tags: [template, change-management, evaluation]
cssclasses: [everything-ai]
---

# AI Change Impact Review Template

Use with [[Model and Agent Lifecycle Management]], [[MCP Contract Testing and Upgrade Readiness]], or a technical studio case. Replace placeholders; do not present unexecuted tests as results.

## Change identity

- Owner and reviewer:
- Affected service, tenant scope, and business workflow:
- Requested and resolved model/API/SDK/tool versions:
- Primary source URL, announcement date, checked date:
- Deprecation/read-only/shutdown dates, if distinct:
- Feature maturity, region, and account eligibility:
- What was verified; what remains uncertain:

## Contract and boundaries

- User outcome and non-goals:
- Data classes, permitted destinations, and retention:
- Caller identity and resource/action authorization:
- Persistent state, schema compatibility, and deletion:
- Latency, cost, capacity, and quality constraints:
- Independent safe mode if the old service disappears:

## Evidence

| Test or comparison | Dataset/fixture version | Expected result | Observed result | Owner |
|---|---|---|---|---|
| Baseline and candidate quality | | | Not run | |
| High-risk slices | | | Not run | |
| Schema and interface compatibility | | | Not run | |
| Identity and cross-tenant denial | | | Not run | |
| Timeout, retry, and duplicate effects | | | Not run | |
| State restore and clean-session replay | | | Not run | |
| Capacity and fallback | | | Not run | |

## Release decision

- Go / conditional go / no-go:
- Evidence supporting the decision:
- Regressions, uncertainty, and residual risk:
- Canary audience, duration, and stop conditions:
- Rollback/recovery owner and tested procedure:
- User/support/procurement communication:
- Next review and removal of obsolete dependencies:

## Honesty check

- [ ] Synthetic data and hypothetical costs are labeled.
- [ ] No secrets, private customer data, or unauthorized test targets appear.
- [ ] A vendor recommendation is not presented as independent validation.
- [ ] Proposal, blocked attempt, execution, and observed effect are separated.
- [ ] “Not tested” is visible wherever evidence is missing.
