---
title: Embeddings and Similarity
aliases:
  - Vector Similarity
  - Cosine Similarity
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
estimated_minutes: 35
prerequisites:
  - "[[02 Math and Statistics for AI]]"
  - "[[Tokens, Context, and Cost]]"
tags:
  - technical-studio
  - concept/embeddings
  - jargon
cssclasses:
  - everything-ai
---

# Embeddings and similarity

> [!abstract] Plain idea
> An **embedding** is a list of numbers that stands in for a piece of text, an image, or a user. **Similarity** is a rule for saying two lists are “close.” Close is useful for search. Close is **not** the same as true, authorized, current, or safe.

## Why this concept exists

RAG, clustering, recommendation, and “semantic cache” all secretly mean: turn stuff into vectors, then find nearby vectors. If you treat proximity as meaning, you retrieve a 2025 policy because it *sounds* like the 2026 question, or you cache a wrong answer because the new question is nearby. The jargon exists so you can say **what space you are in** and **what closeness is allowed to decide**.

## Jargon

| Term | What it names | Common mix-up |
|---|---|---|
| **Vector / embedding** | An ordered list of numbers, e.g. 768 or 3072 floats. | It is not a definition of the document. It is a compressed view trained for some objective. |
| **Dimension** | How many numbers are in the list. | Bigger is not automatically smarter. |
| **Embedding model** | The model that *produces* vectors. Separate from the LLM that writes answers. | Swapping the chat model does not fix a bad embedding space. |
| **Dot product** | \(a\cdot b = \sum a_i b_i\). Grows with length *and* alignment. | Long vectors look “more similar” if you do not normalize. |
| **Cosine similarity** | Dot product after both vectors are length-1. Measures angle. | Still not truth. Two false sentences can be cosine-close. |
| **Euclidean / L2 distance** | Straight-line distance. Small = close. | Different ranking than cosine if lengths vary. |
| **Normalize** | Force vector length to 1. | Required before comparing cosines or using some indexes. |
| **ANN / approximate nearest neighbor** | Fast “close enough” search (HNSW, IVF, …). | Approximate: it can miss the true nearest neighbor. |
| **Metric vs score** | Distance (lower better) vs similarity (higher better). | Mixing them inverts the ranking. |
| **Semantic cache** | Reuse an answer if a new query is nearby an old one. | Nearby questions can need opposite answers (“maximum” vs “minimum”). |

## Worked teaching numbers

> [!warning] Constructed 2-D vectors so you can compute by hand.

Three queries in a toy space:

| Item | Vector | Meaning in the story |
|---|---|---|
| Q: “2026 stipend maximum” | (1.0, 0.2) | current question |
| D1: 2026 policy §4.2 | (0.9, 0.3) | gold |
| D2: 2025 policy §4.2 | (0.95, 0.15) | stale, similar wording |
| D3: parking policy | (0.1, 1.0) | off topic |

Length of Q: \(\sqrt{1^2+0.2^2}=\sqrt{1.04}\approx 1.02\).

Cosine(Q, D1) ≈ (0.9+0.06) / (1.02 × \(\sqrt{0.81+0.09}\)) ≈ 0.96 / (1.02×0.95) ≈ **0.99**

Cosine(Q, D2) ≈ (0.95+0.03) / (1.02 × \(\sqrt{0.9025+0.0225}\)) ≈ 0.98 / (1.02×0.96) ≈ **1.00**

In this envelope the **stale** doc wins cosine. That is why [[Retrieval Quality]] adds metadata (effective date) instead of trusting the embedding. Hybrid search exists because “2026” as a token is a lexical fact, not a vibe.

**Rule:** use vectors to *propose* candidates. Use filters, ranks, and authority to *decide*.

## What to practice saying

- “Similar in this embedding space, not ‘the same fact.’”
- “Which embedding model produced these vectors, and was the query embedded the same way as the docs?”
- “Show cosine *and* the metadata filter, or this ranking is incomplete.”
- “I will not semantic-cache questions whose answers flip on one word.”

## Quiz

1. Why can a 2025 PDF outrank a 2026 PDF for a “2026” question?
2. What does cosine throw away that the raw dot product keeps?
3. Why is the embedding model a separate choice from the chat model?
4. When is approximate nearest neighbor the wrong tool?
5. Why is semantic cache dangerous for policy amounts?

> [!question]- Answer key
> 1. Embeddings capture wording/topic; they do not know effective dates. 2. Vector length / magnitude. 3. They are trained for different jobs; a better writer does not fix retrieval space. 4. When you must not miss a specific identifier or a rare exact match — use lexical or exact lookup. 5. Nearby phrasings can require opposite numbers or opposite eligibility.

## Flashcards

Embedding:: A learned vector that stands in for text, images, or other objects in a similarity space.

Cosine similarity:: A score from the angle between two vectors after normalizing length.

Dot product:: Sum of paired components; mixes alignment with vector length.

Normalize:: Rescale a vector to length 1 before comparing angles.

ANN:: Approximate nearest-neighbor search; faster, not guaranteed exact.

Embedding model:: The model that produces vectors; not the same object as the answering LLM.

Semantic cache:: Reusing an answer because a new query is nearby in embedding space.

## Transfer

- Next concept: [[The Training Loop]].
- Cases: [[Case - Retrieval Failure Autopsy]], [[Case - Prompt RAG Fine-Tune]].
- Foundation: [[02 Math and Statistics for AI]], [[10 RAG and Knowledge Systems]].
