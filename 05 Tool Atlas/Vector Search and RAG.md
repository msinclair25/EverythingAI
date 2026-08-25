---
title: Vector Search and RAG
aliases:
  - Vector, Search, and RAG Tools
tags:
  - atlas/tools
  - ai/rag
  - data/vector-search
status: published
type: tool-category
scope: United States
level:
  - beginner
  - intermediate
  - advanced
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
cssclasses:
  - everything-ai
source_policy: official-only
---

# Vector Search and RAG

Retrieval-augmented generation (RAG) retrieves evidence before generation. A vector database is only one component: ingestion, parsing, chunking, metadata, permissions, keyword search, reranking, citations, freshness, and evaluation often matter more.

## Representative comparison

| Tool | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| pgvector | PostgreSQL-licensed open source; hosting costs separate | Existing PostgreSQL estates and moderate-scale semantic search | Operational scaling and specialized features | [GitHub](https://github.com/pgvector/pgvector) |
| Qdrant | Apache-2.0 open source; cloud free-tier/paid/enterprise | Self-host or managed vector search with filtering | Separate operational responsibility when self-hosted | [pricing](https://qdrant.tech/pricing/) · [docs](https://qdrant.tech/documentation/) |
| Weaviate | BSD-3-Clause open source; managed paid/enterprise with trial/free posture as listed | Hybrid search and managed/self-host flexibility | Platform-specific schema/operations | [pricing](https://weaviate.io/pricing) · [docs](https://docs.weaviate.io/) |
| Milvus / Zilliz Cloud | Apache-2.0 open source; managed cloud free-tier/paid | Large-scale distributed vector workloads | More infrastructure complexity self-hosted | [Milvus](https://milvus.io/) · [Zilliz pricing](https://zilliz.com/pricing) |
| Pinecone | Hosted free starter/evaluation posture plus paid/enterprise | Serverless managed vector search | Hosted-only lock-in and usage dimensions | [pricing](https://www.pinecone.io/pricing/) · [docs](https://docs.pinecone.io/) |
| Chroma | Apache-2.0 open-source core; managed cloud plans vary | Local prototypes and developer-friendly retrieval | Validate production scale/operations for workload | [GitHub](https://github.com/chroma-core/chroma) · [cloud](https://www.trychroma.com/pricing) |
| Elasticsearch | Source-available/free Basic features plus paid subscriptions/cloud | Hybrid lexical/vector search in existing Elastic estates | Licensing and cluster complexity | [subscriptions](https://www.elastic.co/subscriptions) · [vector search docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/knn-search.html) |

## Selection criteria

- Retrieval quality on your corpus: recall@k, ranking, citation support, and answer correctness.
- Hybrid lexical/vector search, metadata filters, reranking, sparse vectors, and multi-tenancy.
- Document-level authorization and deletion propagation.
- Update latency, index rebuild strategy, backups, and disaster recovery.
- Embedding dimensionality, storage, read/write units, replicas, egress, and idle cost.
- Region/private networking, encryption, audit, and compliance requirements.
- Export format and the cost of re-embedding/re-indexing.

## Free-first path

1. Start with 20–50 representative documents and 30 answerable/unanswerable questions.
2. Build a lexical baseline before adding embeddings.
3. Try pgvector or Chroma locally; add a reranker only after measuring retrieval errors.
4. Compare one managed free tier using the same corpus and queries.
5. Pay for scale, uptime, administration, or security controls only after the retrieval design works.

~~~mermaid
flowchart TD
    A["Need retrieval"] --> B{"Already use PostgreSQL?"}
    B -->|"Yes, moderate scale"| C["Start with pgvector"]
    B -->|"No / specialized need"| D{"Self-host required?"}
    D -->|"Yes"| E["Qdrant, Weaviate, Milvus, Chroma, or Elastic"]
    D -->|"No"| F["Managed Qdrant, Weaviate, Zilliz, Pinecone, or Elastic"]
    C --> G["Test lexical + vector + reranking"]
    E --> G
    F --> G
    G --> H["Enforce document permissions and deletion"]
~~~

> [!tip] Evaluate retrieval separately
> Log which chunks were retrieved and whether the answer was present. A fluent final answer can hide a retrieval failure.

## Role connections

[[LLM Engineer|RAG Engineer]], [[AI Engineer]], [[LLM Engineer|Search Engineer]], [[ML Data Engineer|Data Engineer]], [[Knowledge Architecture|Knowledge Manager]], and [[AI Assurance Evidence|AI Evaluation Engineer]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Vector search and RAG]].
