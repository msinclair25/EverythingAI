---
title: Knowledge Architecture
type: skill
family: knowledge-and-operations
scope: United States
level:
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, core-skills, knowledge-management, ontology]
cssclasses: [everything-ai]
---

# Knowledge Architecture

Knowledge architecture makes concepts, sources, authority, relationships, and lifecycle legible to people and AI systems.

## Layers

- **information architecture:** navigation, labels, findability;
- **taxonomy:** controlled categories and hierarchy;
- **thesaurus/controlled vocabulary:** preferred terms, synonyms, broader/narrower/related terms;
- **ontology:** formal concepts, properties, relations, constraints;
- **knowledge graph:** entities and relations instantiated as data;
- **content governance:** ownership, authority, version, review, retention, and access.

## Design sequence

Start from user questions and decisions. Inventory authoritative sources and owners. Model terms and relationships with domain experts. Assign stable identifiers and synonym rules. Define versioning, deprecation, conflicts, and provenance. Test search/retrieval with real queries, then monitor zero-result, wrong-authority, stale, and permission failures.

Avoid building an elegant ontology that does not improve a decision or retrieval task. Generated metadata accelerates work but needs evaluation against domain meaning.

## Quiz

1. Taxonomy vs ontology? 2. Why use stable IDs? 3. What is source authority? 4. Why test with user questions?

> [!success]- Answers
> 1. Taxonomy primarily categorizes; ontology formally represents concepts, properties, relations, and constraints. 2. Names change and synonyms collide; stable IDs preserve reference. 3. The defined standing of a source for a claim/context. 4. Architecture exists to improve findability, interpretation, and decisions—not merely internal neatness.

## Flashcards

Controlled vocabulary:: Governed preferred terms and variants for consistent description and retrieval.

Ontology:: A formal model of concepts, properties, relationships, and constraints.

Knowledge graph:: Data represented as entities and relationships, often using an ontology or schema.

Next: [[Taxonomist and Ontology Specialist]], [[Knowledge Manager]], and [[RAG and Knowledge Engineer]].
