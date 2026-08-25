---
title: 10 RAG and Knowledge Systems
aliases:
  - RAG and Knowledge Systems
type: foundation
module: 10
scope: United States
level:
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_hours: 7-14
prerequisites:
  - "[[04 Data Foundations]]"
  - "[[09 Prompt Context and Tool Use]]"
tags:
  - ai-careers
  - foundations
  - rag
  - knowledge-systems
cssclasses:
  - everything-ai
---

# 10 · RAG and Knowledge Systems

## Outcome

You can explain a retrieval-augmented generation pipeline, separate retrieval from answer quality, and choose controls for authority, freshness, permissions, and citations.

## Why RAG

RAG retrieves information at request time and supplies it to a generator. It is often preferred when knowledge is private, current, attributable, or frequently changed. It does not guarantee a correct answer and does not automatically teach the base model new parameters.

## Pipeline

```mermaid
flowchart LR
    S["Authorized sources"] --> P["Parse + normalize"] --> C["Chunk + metadata"] --> I["Index"] --> Q["Query understanding"] --> R["Retrieve"] --> K["Rerank + filter"] --> X["Assemble context"] --> G["Generate"] --> V["Verify + cite"] --> F["Feedback + refresh"]
```

## Retrieval choices

- **Lexical retrieval** matches terms and excels with identifiers and exact language.
- **Dense/vector retrieval** matches embedding similarity and can capture semantic relatedness.
- **Hybrid retrieval** combines signals.
- **Reranking** applies a more expensive relevance model to a candidate set.
- **Graph/structured retrieval** follows entities, relationships, tables, or database queries.
- **Routing** chooses sources or retrieval strategies from query intent.

Do not assume vector search is always required.

## Ingestion decisions

**Parsing** preserves headings, tables, lists, page locations, and document identity. **Chunking** sets the unit indexed and retrieved. Small chunks improve specificity but may lose context; large chunks add noise and consume context. Metadata can include source, owner, date, version, section, jurisdiction, product, confidentiality, and access groups.

Keep stable source IDs so generated citations resolve to the exact material used.

## Authority and conflict

Rank or filter sources by authority, applicability, and freshness—not relevance score alone. When sources conflict, the system should surface the conflict or apply an explicit policy. A highly similar obsolete policy is still wrong.

## Permissions

Apply access control **before or during retrieval**, not only after generation. The index and caches must preserve document/section permissions and tenant boundaries. Logs, embeddings, previews, and citations can leak protected content even when the final answer is filtered.

## Evaluation decomposition

| Layer | Questions |
|---|---|
| Corpus | Is the needed authoritative information present, current, and permitted? |
| Retrieval | Did relevant evidence appear in the candidate set? At what rank? |
| Context | Did filtering/chunking preserve enough evidence without conflict or noise? |
| Generation | Is each claim supported by supplied evidence? |
| Citation | Does the reference resolve and entail the claim? |
| Task/user | Can the user complete the real task safely and efficiently? |

Use labeled queries with expected sources, adversarial documents, permission tests, no-answer cases, and changing-policy cases. Common retrieval metrics include recall@k, precision@k, mean reciprocal rank, and normalized discounted cumulative gain; none alone measures final answer usefulness.

## Failure modes

- missing or stale source;
- poor parsing of tables, scans, or layout;
- chunk loses qualifications or exceptions;
- vocabulary mismatch or incorrect query rewrite;
- irrelevant but similar passage outranks authority;
- indirect prompt injection in a document;
- generator ignores, misreads, or overextends evidence;
- fabricated or misplaced citation;
- permission leakage;
- feedback loop rewards confident wording rather than support.

## Quiz

1. Why might lexical search outperform vector search?
2. What tradeoff does chunk size create?
3. Why must authority be separate from relevance?
4. Where should access control be enforced?
5. Distinguish retrieval recall from grounded answer quality.
6. Name two RAG tests beyond ordinary relevance queries.

> [!success]- Answer key
> 1. Exact identifiers, rare terms, legal language, and names can be matched better lexically. 2. Small chunks improve focus but lose surrounding context; large chunks preserve context but add noise/cost. 3. A relevant passage may be obsolete, unofficial, or inapplicable. 4. Before/during retrieval and throughout index, cache, context, log, and citation handling. 5. Retrieval recall asks whether needed evidence appears; grounding asks whether generated claims are actually supported. 6. Permission isolation, stale/conflicting sources, injection documents, no-answer cases, table parsing, and citation entailment are examples.

## Flashcards

RAG:: Retrieving information at inference time and supplying it to a generator.

Lexical retrieval:: Matching based on terms and token statistics.

Dense retrieval:: Matching using vector representations and a similarity function.

Hybrid retrieval:: Combining lexical, dense, structured, or other retrieval signals.

Reranker:: A model or method that reorders a candidate set using richer relevance scoring.

Chunking:: Choosing the unit of content indexed and retrieved.

Recall at k:: The share of relevant items found among the first k results, under the task's labeling definition.

Grounded claim:: A claim whose content is supported by identified evidence supplied to the system.

## Sources and next step

- [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/abs/2005.11401), original RAG research.
- [NIST Generative AI Profile](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf), verified 2026-08-12.

Next: [[11 Agents and Automation]].
