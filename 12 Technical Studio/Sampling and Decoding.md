---
title: Sampling and Decoding
aliases:
  - Temperature
  - Top-p Top-k
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
  - "[[07 Transformers and Foundation Models]]"
  - "[[Tokens, Context, and Cost]]"
tags:
  - technical-studio
  - concept/decoding
  - jargon
cssclasses:
  - everything-ai
---

# Sampling and decoding

> [!abstract] Plain idea
> After the model scores the next token, **decoding** picks which token actually appears. That knob changes *variety*, not *knowledge*. Lowering temperature cannot insert a stipend amount that is not in the weights or the window. It can only make the model more stubborn about whatever it already believes.

## Why this concept exists

“Just turn the temperature down” is the most common fake factuality fix in interviews and Slack. Decoding exists because language is not one path: you need a way to choose among high-scoring next tokens. The jargon names those choosers so you can say what you changed when output got more repetitive, more random, or more wrong in a new way.

## Jargon

| Term | What it names | Common mix-up |
|---|---|---|
| **Logits** | Raw scores for each vocabulary item, before softmax. | Not probabilities yet. |
| **Softmax** | Turns logits into a probability distribution over the next token. | A high probability is still “likely under the model,” not “true.” |
| **Greedy decoding** | Always pick the current top token. | Deterministic-ish; can be bland and still wrong. |
| **Temperature \(T\)** | Divide logits by \(T\) before softmax. \(T<1\) sharpens; \(T>1\) flattens. | Not a truth dial. Not the same thing as **temperature scaling** in [[Calibration]]. |
| **Top-k** | Keep only the \(k\) highest-probability tokens, then sample. | Small \(k\) ≈ near-greedy. |
| **Top-p / nucleus** | Keep the smallest set whose probabilities sum to \(p\), then sample. | Adapts the set size; 0.9 is a common teaching default, not a law. |
| **Seed** | Fixes the random number generator. | Same seed + same inputs ≈ same sample. Different hardware can still drift. |
| **Beam search** | Keep several partial sequences and expand the best. | Useful for some structured tasks; not the default for chat. |
| **Repetition / presence penalty** | Extra score pressure against repeating tokens. | Can fix loops; can also block legal repeats (“2026 2026 policy”). |

## Worked teaching distribution

> [!warning] Constructed three-token vocabulary so the arithmetic is visible.

Logits for the next token: `stipend=2.0`, `refund=1.0`, `banana=0.0`.

Softmax at \(T=1\):

\[
p \propto e^{2},\; e^{1},\; e^{0} \approx 7.39,\; 2.72,\; 1.00
\]

Share: **0.67 / 0.24 / 0.09**.

At \(T=0.5\) (sharper): logits become 4.0, 2.0, 0.0 → ≈ **0.87 / 0.12 / 0.02**.

At \(T=2.0\) (flatter): 1.0, 0.5, 0.0 → ≈ **0.51 / 0.31 / 0.18**.

If the *correct* next token is a number that is **not in this distribution at all**, no \(T\) will invent it. You need retrieval, a tool, or different weights. See [[Adaptation Methods]].

If you need a JSON field to be one of three enums, do not “hope greedy is enough.” Use a [[Structured Outputs and Contracts]] schema. Decoding is the wrong control.

## What to practice saying

- “Temperature changes the shape of the next-token distribution. It does not add facts.”
- “I will report \(T\), top-p, and whether the run was sampled, when I quote an eval.”
- “For money or labels, I constrain the schema, not the temperature.”
- “A single lucky sample is not a quality metric; repeat the draw.”

## Quiz

1. What does \(T < 1\) do to the next-token distribution?
2. Why can greedy decoding still be factually wrong?
3. When is top-p a better first knob than temperature?
4. Why must an eval name the decoding settings?
5. Decoding vs calibration “temperature” — what is different?

> [!question]- Answer key
> 1. It sharpens: more mass on already-likely tokens. 2. The top token can be a fluent falsehood. 3. When you want to drop the long tail of nonsense without collapsing to one token. 4. Because sampled systems are random variables; unreplicated scores are not comparable. 5. Decoding \(T\) reshapes generation. Calibration temperature (see [[Calibration]]) rescales *confidence scores* after the fact and does not pick tokens.

## Flashcards

Decoding:: The rule that turns next-token scores into an actual token.

Temperature (decoding):: A sharpness knob on the next-token distribution; not a factuality control.

Greedy decoding:: Always emit the current highest-scoring token.

Top-p / nucleus:: Sample from the smallest set of tokens whose probabilities sum to p.

Top-k:: Sample only from the k highest-scoring tokens.

Logits:: Unnormalized next-token scores, before softmax.

Softmax:: Map logits to a probability distribution over the vocabulary.

## Transfer

- Next concept: [[Calibration]].
- Cases: [[Case - Evaluation Harness]] (repeat sampled runs), [[Case - Prompt RAG Fine-Tune]].
- Foundation: [[07 Transformers and Foundation Models]].
