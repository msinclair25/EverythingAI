---
title: Context Engineering
aliases:
  - Context Design
  - Prompt Budgeting
type: technical-concept
family: technical
scope: United States
level:
  - intermediate
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 30
prerequisites:
  - "[[09 Prompt Context and Tool Use]]"
  - "[[Tokens, Context, and Cost]]"
tags:
  - technical-studio
  - concept/context
  - jargon
cssclasses:
  - everything-ai
---

# Context engineering

> [!abstract] Plain idea
> The model can only use what you put in the window, in the order you put it, under the budget you have left. **Context engineering** is the job of selecting, transforming, labeling, and ordering that material so the next decision is possible. It is larger than “writing a clever prompt.”

## Why this concept exists

Once models got good enough, quality stopped being “pick a better adjective in the system prompt.” Failures moved to:

- the right policy never entered the window;
- three conflicting policies entered and the model averaged them;
- a tool dump blew the budget;
- history contained an old, wrong number the model repeated.

The term exists to name **information logistics**, not copywriting. Prompting is one input. Retrieval, tools, state, and memory are the others.

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **System / developer instructions** | Standing rules for this application. | Stable policy. Still not a security control. |
| **User turn** | What the human just said. | The only part amateurs budget for. |
| **State / memory** | Durable facts about the user, ticket, or session. | So you do not re-ask; also a privacy surface. |
| **Retrieved evidence** | Documents or records fetched for this question. | How current/private knowledge enters. |
| **Tool result** | Output of a function the model requested. | Often huge and messy; must be summarized or schema-cut. |
| **Few-shot examples** | Worked input→output samples in the prompt. | Teach format; can contaminate or steal budget. |
| **Packing policy** | The rule for what stays when tokens run out. | Without one, truncation is random. |
| **Labeling / fencing** | Tags like `SOURCE id=… effective=2026-03-01`. | Models mishandle undifferentiated blobs. |
| **Lost-in-the-middle** | Relevant items in the center of a long context get used less. | Why “just paste more” backfires. |
| **Context poisoning** | Untrusted content in the window that steers the model. | Same family as indirect prompt injection. |

## A packing order that matches a contract

Teaching default for a policy assistant (see [[Case - Prompt RAG Fine-Tune]]):

1. Hard instructions + output schema (small, first).
2. **Effective** evidence, highest authority first.
3. User question (repeat near the end if the window is long).
4. History, clipped.
5. Optional extra retrieval.
6. Completion reserve.

Never pack by raw similarity score alone. Similarity does not know “this PDF is superseded.”

## Worked teaching numbers

Window = 4,000 tokens. Reserve 300 for the answer and 250 for instructions.

**Fill budget:** 3,450.

| Candidate | Tokens | Keep? |
|---|---:|---|
| 2026 effective policy §4.2 | 420 | Yes — authority |
| 2025 superseded §4.2 | 400 | No — unless user asked “last year” |
| Parking policy (high score, wrong doc) | 380 | No |
| Ticket state (account, locale) | 80 | Yes |
| Last 12 chat turns | 1,800 | Clip to 400 |
| Tool: full invoice PDF dump | 6,000 | Summarize to 200 or refuse |

If you naively concatenate “top-5 similar chunks,” you recreate [[Case - Retrieval Failure Autopsy]].

## What to practice saying

- “What is the packing policy when we run out?”
- “Show me the actual prompt tokens from the trace, not the template.”
- “Untrusted retrieved text is data, not instructions.”
- “I will spend tokens on authority before I spend them on history.”

## Quiz

1. How is context engineering different from prompting?
2. Why label retrieved spans with effective dates?
3. What should happen to a 6,000-token tool dump in a 4,000 window?
4. Why can more retrieved chunks reduce quality?
5. Why are prompt instructions not a permission system?

> [!question]- Answer key
> 1. Prompting is the instruction text; context engineering is the whole window: evidence, state, tools, order, budget. 2. So the model and the filters can prefer the in-force document. 3. Summarize, schema-cut, or refuse — do not silently truncate. 4. They evict or bury the gold span and add conflicts. 5. Untrusted content can override them; authority is enforced in application code.

## Flashcards

Context engineering:: Selecting, labeling, ordering, and budgeting everything that occupies the model window.

Packing policy:: The rule for what stays when the token budget is exceeded.

Fencing:: Labeling untrusted or sourced text so it is treated as data.

Lost-in-the-middle:: Relevant content in the center of a long window is underused.

Context poisoning:: Untrusted window content that steers model behavior.

Completion reserve:: Tokens kept free so generation can finish.

State:: Durable session or user facts included on later turns.

## Transfer

- Next concept: [[Structured Outputs and Contracts]].
- Cases: [[Case - Retrieval Failure Autopsy]], [[Case - Prompt RAG Fine-Tune]].
- Role: [[Prompt and Context Engineer]], [[AI Engineer]], [[RAG and Knowledge Engineer]].
