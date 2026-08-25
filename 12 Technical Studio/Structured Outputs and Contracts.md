---
title: Structured Outputs and Contracts
aliases:
  - Schema Validation
  - Tool Contracts
type: technical-concept
family: technical
scope: United States
level:
  - beginner
  - intermediate
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 30
prerequisites:
  - "[[03 Python SQL Git and Software Foundations]]"
  - "[[09 Prompt Context and Tool Use]]"
tags:
  - technical-studio
  - concept/contracts
  - jargon
cssclasses:
  - everything-ai
---

# Structured outputs and contracts

> [!abstract] Plain idea
> A model emits text. Software needs **objects**: a label, an amount, a tool name, a JSON body. A **contract** is the agreed shape and meaning at a boundary. You validate the text against the contract in trusted code. You never let prose be the last authority for a side effect.

## Why this concept exists

Demos look like chat. Products look like APIs, databases, and money movement. If you parse model text with hope — “it usually returns JSON” — you get:

- missing fields on Tuesdays;
- `"fifty"` instead of `50`;
- a tool call for the wrong account;
- a retry that double-refunds.

The jargon exists so engineers can talk about **boundaries** the way they already do for HTTP APIs.

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **Schema** | A description of allowed fields, types, and constraints. | So “valid” is a test, not a vibe. |
| **Structured output** | Model text constrained or validated to a schema. | Turns a generator into an unreliable form-filler you can check. |
| **Contract** | Agreed request/response/error semantics between two components. | Same idea as an API contract; the model is just a messy producer. |
| **Validation** | Checking the object before use. | Catch bad types, extra fields, out-of-range amounts. |
| **Coercion** | Quietly changing `"50"` → 50. | Convenient and dangerous if you coerce `account_id`. |
| **Retry with repair** | On invalid output, resend the error and ask once. | Bounded; infinite repair loops are a cost attack. |
| **Fallback** | Deterministic path after the model fails the contract. | The product still works. |
| **Idempotency** | Repeating the request does not create a second side effect. | Timeouts will happen. |
| **Bound argument** | A field overwritten from session/policy, ignoring the model. | See [[Case - Agent Permissions]]. |
| **Untrusted output** | Default stance: treat model text like user input. | It can contain injection, not just typos. |

## Worked teaching example

You want `issue_credit`.

**Bad:** model returns `Sure! I issued $50 to account 9981.` The app regexes `$50`. No id check. No idempotency key. A retry issues $100.

**Contract:**

```json
{
  "type": "object",
  "required": ["amount_usd", "reason_code"],
  "properties": {
    "amount_usd": { "type": "number", "minimum": 0.01, "maximum": 25 },
    "reason_code": { "enum": ["goodwill", "fee_reversal"] }
  },
  "additionalProperties": false
}
```

Application then:

1. validate;
2. **overwrite** `account_id` from the session;
3. derive idempotency key;
4. run policy (velocity, kill switch);
5. execute or send to approval.

The model never sees a field it is not allowed to set. Invalid JSON → one repair retry → fallback “open a case instead.”

## What to practice saying

- “Show me the schema and who validates it.”
- “Which fields are bound, not model-supplied?”
- “What happens on the second delivery of the same key?”
- “Prose is for humans; the ledger is for money.”

## Quiz

1. Why validate even if the vendor offers ‘JSON mode’?
2. What is a bound argument?
3. Why is `additionalProperties: false` useful?
4. When is coercion of a number acceptable vs dangerous?
5. Why must credits be idempotent?

> [!question]- Answer key
> 1. JSON mode can still omit fields, break constraints, or include extra keys; it is not a policy engine. 2. A parameter set from session or policy, ignoring the model. 3. It rejects unexpected fields that might smuggle ids or flags. 4. Coercing display amounts may be fine; coercing identifiers or approval tokens is not. 5. Timeouts and retries would otherwise pay twice.

## Flashcards

Schema:: A machine-checked description of allowed structure and constraints.

Structured output:: Model output constrained or validated against a schema.

Contract:: Agreed shape, meaning, and errors at a component boundary.

Bound argument:: A tool field filled from trusted state, not from the model.

Idempotency:: Repeating an operation does not create an extra side effect.

Untrusted output:: Model text treated like attacker-controlled input until checked.

Repair retry:: One bounded attempt to fix invalid structured output.

Fallback:: A deterministic path when the model fails the contract.

## Transfer

- Next concept: [[Retrieval Quality]].
- Cases: [[Case - Agent Permissions]], [[Case - Prompt RAG Fine-Tune]].
- Foundation: [[03 Python SQL Git and Software Foundations]].
