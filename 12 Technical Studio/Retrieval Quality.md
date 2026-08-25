---
title: Retrieval Quality
aliases:
  - RAG Metrics
  - Recall at K
type: technical-concept
family: technical
scope: United States
level:
  - intermediate
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 35
prerequisites:
  - "[[10 RAG and Knowledge Systems]]"
  - "[[Metrics That Decide]]"
  - "[[Context Engineering]]"
tags:
  - technical-studio
  - concept/retrieval
  - jargon
cssclasses:
  - everything-ai
---

# Retrieval quality

> [!abstract] Plain idea
> RAG is two systems glued together: a **finder** and a **writer**. If you only score the final sentence, you cannot tell which one failed. Retrieval quality asks: did we find the right span, rank it highly, pack it, and did the citation actually license the claim?

## Why this concept exists

Teams say “the model hallucinated” when the index was stale, the chunk split a table from its header, or the gold paragraph was rank 4 and never packed. Different bugs need different owners. The jargon exists to **split the pipeline** so you do not fine-tune your way out of a packing bug.

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **Corpus / collection** | The authorized documents you indexed. | If it is not in the corpus, RAG cannot know it. |
| **Chunk** | A retrieval-sized piece of a document. | Too big wastes tokens; too small loses the table. |
| **Metadata** | Fields on a chunk: effective date, tenant, ACL, title. | Filters beat “hope the embedding understands 2026.” |
| **Lexical search** | Term matching (BM25 and friends). | Wins on IDs, codes, exact phrases. |
| **Dense / vector search** | Embedding similarity. | Wins on paraphrase. Misses exact identifiers. |
| **Hybrid search** | Combine lexical + dense. | Default serious baseline. |
| **Reranker** | A more expensive model that reorders a short candidate list. | Fixes rank, costs latency. |
| **k** | How many chunks you retrieve. | Recall@k is meaningless without k. |
| **Recall@k** | Fraction of questions where the gold span is in the top k. | Finder metric. |
| **MRR / nDCG** | Ranking quality (how high the good thing sits). | Rank 4 vs rank 1 changes packing. |
| **Context-hit** | Gold span is in the **packed** prompt, not only in top-k. | The autopsy metric. |
| **Citation-supported** | Cited span contains the claim (especially numbers). | Stops decorative footnotes. |
| **Effective authority** | The document in force for this date and tenant. | Stale PDFs can be “correctly cited” and still wrong. |
| **ACL / permission filter** | Drop chunks the user must not see **before** generation. | Security, not a prompt instruction. |
| **Freshness / publish-to-searchable** | Time from source publish to successful retrieval. | Staleness SLO. |

## Worked teaching trace

Question: “2026 commuter stipend monthly maximum?” Gold: `$175` in `benefits-2026-03.pdf`.

| Layer | Result | Metric |
|---|---|---|
| Indexed? | Yes, after 11 days | Freshness **fail** |
| In top-5? | Yes, rank 4 | Recall@5 **pass**, nDCG **weak** |
| Packed? | No — 2025 filled the budget | Context-hit **fail** |
| Cited span has $130 | Yes (2025 file) | Cited-span support **pass** (misleading) |
| Effective-authority support | No | **Fail** — this is the user-visible bug |

Do not swap the model. Change filters and packing. Full walkthrough: [[Case - Retrieval Failure Autopsy]].

## A minimum RAG scoreboard

For a release, report at least:

1. recall@k on gold spans;
2. context-hit;
3. citation-supported **against effective authority**;
4. abstention on no-answer items;
5. publish-to-searchable;
6. p95 latency and token cost.

If (1) is high and (2) is low, you have a packer bug. If (2) is high and (3) is low, you have a generation/attribution bug. That split is the whole point of this note.

## What to practice saying

- “Hallucination is not a diagnosis.”
- “Show recall@k, context-hit, and authority support separately.”
- “Authorization is a pre-generation filter.”
- “I will not fine-tune a number that belongs in a document.”

## Quiz

1. Why is recall@5 not enough?
2. What does context-hit add?
3. When is lexical search better than vectors?
4. Why can citation-supported pass on a wrong answer?
5. Where should ACLs be enforced?

> [!question]- Answer key
> 1. The gold item can sit at rank 4 and never enter the prompt. 2. It checks the packed window, which is what the model actually sees. 3. Identifiers, codes, exact policy phrases. 4. The cited stale span really does contain the old number. 5. In retrieval/application code with the authenticated identity, before generation.

## Flashcards

Recall@k:: Gold evidence appears somewhere in the top k retrieved chunks.

Context-hit:: Gold evidence is present in the packed prompt.

Hybrid search:: Combining lexical and dense signals.

Reranker:: A second model that reorders a small candidate list.

Effective authority:: The in-force document for this date and tenant.

Citation-supported:: The cited span licenses the claim.

Publish-to-searchable:: Time from source publish to a successful retrieval of that version.

ACL filter:: Permission drop applied before the model sees the chunk.

## Transfer

- Next concept: [[Adaptation Methods]].
- Cases: [[Case - Retrieval Failure Autopsy]], [[Case - Prompt RAG Fine-Tune]].
- Role: [[RAG and Knowledge Engineer]].
