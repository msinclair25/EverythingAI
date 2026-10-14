---
title: MCP Contract Testing and Upgrade Readiness
type: study-guide
scope: United States
level: [intermediate, advanced]
status: current
as_of: 2026-10-13
last_verified: 2026-10-13
review_by: 2026-11-13
tags: [mcp, testing, identity, interoperability]
cssclasses: [everything-ai]
---

# MCP Contract Testing and Upgrade Readiness

> [!abstract] Outcome
> Explain why an MCP server that responds successfully can still be incompatible, unsafe, or operationally unreliable. Build a contract matrix before declaring an upgrade complete.

Read [[MCP Deep Dive — 2026-08-24]] first. The [official July 28, 2026 release](https://blog.modelcontextprotocol.io/posts/2026-07-28/) confirms the baseline already discussed there: stateless core, multiple round-trip requests, cacheable lists, and authorization extensions. This October note adds engineering practice; it does **not** invent an October protocol version. Client, server, SDK, and extension versions must be checked separately.

## What a protocol contract does—and does not—promise

A wire contract defines messages and negotiated capabilities. It does not tell you whether a user may approve an invoice, whether a tool result is truthful, or whether a duplicate request may cause another payment. Those belong to application authorization, data trust, and transaction semantics.

| Layer | Question | Example failure |
|---|---|---|
| Transport | Can the peers exchange messages correctly? | Proxy buffering changes streaming behavior |
| Protocol | Do version and capability assumptions agree? | Client assumes an extension the server does not offer |
| Schema | Do names, types, and required fields match? | Renamed argument breaks a stored workflow |
| Identity | Is this the intended caller and audience? | Token issued for a different resource is accepted |
| Authorization | May that caller perform this action here? | Valid user can read another tenant's object |
| Transaction | What happens on retry or partial failure? | An operation executes twice |
| Content | How is returned text treated? | A tool result is promoted into privileged instructions |

## Build the test matrix

These are recommended study tests, not a claim that the protocol mandates every application policy below.

| Test family | Positive control | Negative or failure case | Required evidence |
|---|---|---|---|
| Compatibility | Supported client/server pair | Unsupported version or extension | Explicit result and documented fallback |
| Tool discovery | Authorized caller sees intended tools | Unauthorized or stale cached catalog | Cache partition/invalidation behavior |
| Argument contract | Valid typed input | Missing, oversized, unexpected, or semantically invalid input | Rejection before side effect |
| Identity | Correct token/audience | Expired, wrong-audience, missing identity | Denial without secret leakage |
| Tenant isolation | Read owned synthetic record | Request another tenant's record | Resource-level denial |
| Retry | Repeat idempotent read | Timeout after a write may have committed | One effect or explicit reconciliation |
| Cancellation | Cancel before execution | Cancel during a side effect | Defined outcome; no false success message |
| Content trust | Ordinary tool result | Result asks for extra credentials or policy changes | No promotion to authority |
| Observability | Trace successful operation | Error plus retry plus cancellation | Correlation without sensitive payload dumps |

Use mocks or a local synthetic server first. Never probe someone else's MCP endpoint or use real credentials in an adversarial portfolio test without permission.

## Worked ambiguity: the timeout after commit

A synthetic `create_ticket` operation commits ticket T-104. The response is lost. The client retries. A developer proposes “just retry three times” because the tool is schema-valid.

**Better contract:** bind a stable operation identifier to the authenticated caller and intended action. Store or reconcile the outcome. A retry with the same identifier returns the original result or a clear pending status; a different action must not silently reuse that identifier. For an external API without idempotency support, you may need a reconciliation workflow or human review rather than pretending exactly-once execution exists.

Protocol statelessness does not mean your business operation has no durable state. Likewise, application state does not justify assuming a removed legacy protocol session still exists. Name the layer.

## Upgrade dossier

1. Record the old and candidate client, server, SDK, transport, and extension versions.
2. List actual capabilities used—not every capability mentioned in documentation.
3. Freeze synthetic fixtures and expected authorization outcomes.
4. Run compatibility and failure tests against both versions.
5. Review changed tool descriptions, schemas, and discovered permissions as executable risk, not cosmetic text.
6. Canary with defined error/latency/side-effect stop conditions.
7. Document rollback compatibility for persisted application state and cached tool catalogs.

## A useful readiness rubric

Score each area 0 = absent, 1 = described, 2 = demonstrated: compatibility, identity, authorization, retries, content trust, and recovery. A total score is a study aid, not certification. Any demonstrated cross-tenant access or unauthorized write blocks release even if the other areas score well.

## Quiz and answers

1. **Can a valid token authorize every object?** No; identity and resource authorization differ.
2. **Does stateless core forbid application storage?** No; protocol and business-state layers differ.
3. **Why test cached tool lists?** Permissions and schemas can change while a client holds stale information.
4. **Does a cancelled request prove the action did not execute?** No; cancellation may arrive after commit.
5. **Why pin an SDK separately from protocol version?** SDK implementation and protocol support are different release surfaces.

## Flashcards

MCP conformance versus business safety::Correct protocol behavior does not establish authorization or harmless side effects.
Capability negotiation::Determining which features peers actually support before relying on them.
Timeout ambiguity::A missing response does not reveal whether the operation committed.
Reconciliation::Checking durable external state to determine the outcome of an uncertain operation.
Tool-catalog drift::A client's cached tool metadata diverging from the current server contract or permissions.
Application state versus protocol state::Business records and transaction history are distinct from transport/protocol session mechanisms.

## Interview and suggested project

**Interview:** describe the lost-response scenario without promising exactly-once behavior you cannot guarantee.

**Project:** write a 12-test contract dossier for a synthetic read/create-ticket server, including timeout-after-commit, cross-tenant access, stale catalog, and malicious tool-result text. Show expected and observed outcomes. Paid hosting is optional and unnecessary for the core exercise.
