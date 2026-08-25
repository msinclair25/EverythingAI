---
title: Technical AI Interview Guide
type: guide
family: technical
scope: United States
level:
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, interview, technical]
cssclasses: [everything-ai]
---

# Technical AI Interview Guide

## Domains

- coding, data structures, debugging, testing, APIs, SQL, and software design;
- probability, statistics, experiment design, and metrics;
- ML framing, data/splits, algorithms, generalization, and error analysis;
- deep learning, transformers, training/adaptation, and optimization;
- RAG, agents, evaluation, security, deployment, reliability, and economics;
- research depth or systems depth according to the role.

## Design prompts

- Design a grounded support assistant with permissioned documents.
- Design an evaluation platform for model and prompt changes.
- Design a low-latency multimodal endpoint under a fixed budget.
- Design an agent that can take reversible account actions.
- Design a training-data pipeline with lineage and deletion handling.
- Diagnose a model whose offline score improves while production degrades.

For each, cover requirements, baseline, architecture, data, interfaces, evaluation, threat model, SLOs, cost, rollout, incident response, and tradeoffs.

## Research interviews

Be ready to derive objectives, critique a paper, identify assumptions, design an ablation, handle negative results, estimate uncertainty, discuss compute/data constraints, and propose a falsifiable follow-up. Explain the gap between a benchmark result and a scientific claim.

## Coding practice

Practice writing readable functions, tests, SQL, data validation, metric calculations, batching/retry logic, a retrieval baseline, and a small evaluation runner without relying entirely on frameworks. Explain complexity and failure handling.

## Role-specific guide

Use the interview section in the selected profile under [[AI Career Atlas]].

## Studio drills

Work the timed prompts in [[Technical Interview Drills]] after at least two [[Technical Studio]] cases. The drills reuse the same contracts: adaptation choice, ship-or-stop, agent permissions, capacity arithmetic, and retrieval autopsies.
