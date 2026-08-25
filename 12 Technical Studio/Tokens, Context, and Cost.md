---
title: Tokens, Context, and Cost
aliases:
  - Tokens and Context
  - Token Economics
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
  - "[[01 AI Systems and Vocabulary]]"
  - "[[07 Transformers and Foundation Models]]"
tags:
  - technical-studio
  - concept/tokens
  - jargon
cssclasses:
  - everything-ai
---

# Tokens, context, and cost

> [!abstract] Plain idea
> A language model does not read “words.” It reads **tokens** — pieces of text from a tokenizer. Every token you send or generate costs time, memory, and usually money. The **context window** is the budget of tokens the model can see in one call. Most production surprises are budget surprises.

## Why this concept exists

People quote character counts, page counts, or “we put the whole PDF in the prompt.” Those are not the unit the model or the invoice uses. Two English sentences can be 20 tokens or 80, depending on the tokenizer, language, and whitespace. If you cannot estimate tokens, you cannot estimate:

- whether the evidence will even fit;
- time to first token and decode time;
- monthly spend;
- how much retrieval you can afford to pack.

## Jargon

| Term | What it names | Common mix-up |
|---|---|---|
| **Tokenizer** | The rules that split text into IDs. Each model family has its own. | “Words ≈ tokens.” False, especially for code, URLs, and non-English. |
| **Token** | One ID the model consumes or emits. | A token is not a meaning unit. It is a compression unit. |
| **Context window** | Max tokens of input + output the configuration allows. | Advertised 128k does not mean the model uses position 1 and position 120,000 equally well. |
| **Prompt / input tokens** | What you send: instructions, history, retrieved chunks, tool results. | People forget history and tool dumps dominate the bill. |
| **Completion / output tokens** | What the model generates. | Output is often priced higher than input. |
| **Context packing** | Choosing and ordering what occupies the window. | “More context is more better.” Extra tokens can crowd out the gold span. See [[Context Engineering]]. |
| **Truncation** | Cutting text when the budget is exceeded. | Silent truncation is a bug. The system should know what it dropped. |

## Worked teaching numbers

> [!warning] Constructed envelope
> Token counts are teaching estimates, not a vendor tokenizer. Recompute with a real tokenizer before using this in a plan.

A support reply:

```
System: 180 tokens
User question: 40 tokens
Retrieved 4 chunks × 350 tokens: 1,400
Chat history (6 turns): 900
Completion target: 220
```

**Total billed this call (approx):** 180 + 40 + 1,400 + 900 + 220 = **2,740 tokens**.

The question was 40 tokens. **96% of the bill is scaffolding.** If you cut history to 300 and retrieve 2 chunks instead of 4, the call drops to 180+40+700+300+220 = **1,440 tokens** — about half — *if* retrieval quality still hits the gold span.

Teaching cost: $0.50 / million input tokens, $1.50 / million output tokens.

| Piece | Tokens | Teaching USD |
|---|---:|---:|
| Input 2,520 | 2,520 | 0.00126 |
| Output 220 | 220 | 0.00033 |
| One call |  | **0.00159** |

At 12,000 questions/month: 12,000 × 0.00159 ≈ **$19** if every call looks like this. That looks cheap — until you add retries, tool loops (each step re-sends the window), a 10× more expensive model, or 20k-token dumps. An agent that takes 8 steps can turn $19 into $150+ without anyone “changing the model.”

## Why the window is a design object

If the window is 8,000 tokens and you pack 7,900 of retrieval plus a 200-token answer, the last retrieved chunk never arrives. That is the failure in [[Case - Retrieval Failure Autopsy]]: the right document was retrieved and then **truncated out**.

Rule: reserve a **completion reserve** (here 220–300 tokens) and a **instruction reserve** before you fill the rest with evidence. Pack **effective authority first**, not “highest embedding score first.”

## What to practice saying

- “Tokens, not pages.”
- “The question is cheap; the context is the product.”
- “Advertised context is a maximum, not a quality guarantee.”
- “I will not quote a monthly cost without a token budget per call and a step count.”

## Quiz

1. Why is “the PDF is 12 pages” a bad capacity estimate?
2. Name three things besides the user sentence that consume tokens.
3. Why might output tokens dominate cost even when they are fewer?
4. What is a completion reserve?
5. How can adding more retrieved chunks make the answer worse?

> [!question]- Answer key
> 1. Pages are not tokens; density, language, tables, and the tokenizer change the count by large factors. 2. System instructions, history, retrieved chunks, tool results, schemas. 3. Vendors often price output higher; long answers and retries multiply it. 4. Tokens you refuse to fill with input so the model can actually finish. 5. They can evict the gold span or drown it in conflicting text.

## Flashcards

Token:: A tokenizer-defined ID. It is what the model and the invoice count.

Tokenizer:: The model-specific rules that turn text into token IDs.

Context window:: The token budget for one model call; advertised length ≠ effective recall.

Input tokens:: Instructions, history, retrieved text, and tool results sent to the model.

Output tokens:: Tokens the model generates. Often priced higher than input.

Completion reserve:: Input budget left empty so the answer can finish without truncation.

Silent truncation:: Dropping tokens without recording what was lost; a common production defect.

## Transfer

- Next concept: [[Leakage and Contamination]].
- Cases: [[Case - Serving Capacity]], [[Case - Retrieval Failure Autopsy]].
- Glossary: [[AI Glossary]].
