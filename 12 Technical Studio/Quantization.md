---
title: Quantization
aliases:
  - INT8 FP16 Quantization
  - Lower Precision Inference
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
  - "[[Attention, Memory, and Inference]]"
  - "[[The Training Loop]]"
  - "[[Metrics That Decide]]"
tags:
  - technical-studio
  - concept/quantization
  - jargon
cssclasses:
  - everything-ai
---

# Quantization

> [!abstract] Plain idea
> **Quantization** stores weights (and sometimes activations) with fewer bits so the model uses less memory and can run faster. You are throwing away numeric detail on purpose. Quality must be *re-measured* on the task you care about. A lower perplexity drop does not mean the stipend number still comes out right.

## Why this concept exists

Serving talks as if “INT8” were free speed. Bits are a **quality–memory–latency** trade. Rare tokens, long-tail classes, and tool-calling schemas are where the missing bits show up. The jargon exists so you can say *what* was quantized, *how* it was calibrated, and *which* eval moved — not just “we quantized it.”

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **Precision / dtype** | How a number is stored (FP32, FP16/BF16, INT8, INT4, FP8…). | Memory and math throughput follow this. |
| **Weight-only quantization** | Compress stored weights; compute in higher precision. | Common first step; activations still fat. |
| **Activation quantization** | Also compress the live tensors during the forward pass. | Harder; more speed, more quality risk. |
| **Calibration set** (quant) | A small sample used to choose scales/zero-points. | Not the same as ML “calibration” in [[Calibration]]. |
| **Scale / zero-point** | The map from integer bins back to real values. | Bad scales clip important weights. |
| **PTQ** | Post-training quantization: compress a finished model. | Fast. Quality can drop. |
| **QAT** | Quantization-aware training: train *as if* low precision. | Slower; sometimes recovers quality. |
| **Perplexity** | How surprised the model is by a text corpus. | Easy to quote; not your product metric. |
| **Outlier features** | A few activation channels with huge range. | They wreck naive INT8; special kernels exist because of them. |
| **KV-cache quantization** | Store the [[Attention, Memory, and Inference]] cache in fewer bits. | Big memory win at concurrency; can hurt long-context quality. |

## Worked teaching trade

> [!warning] Constructed envelope — same family as [[Case - Serving Capacity]].

| Build | Weights | KV bits | Teaching GPU mem | p95 TTFT | Citation-supported@gold | Schema-valid JSON |
|---|---|---:|---:|---:|---:|---:|
| BF16 baseline | 16 | 16 | 40 GiB (tight) | 0.9 s | **0.80** | 0.97 |
| W8A16 PTQ | 8 | 16 | 28 GiB | 0.7 s | 0.79 | 0.96 |
| W4A16 PTQ | 4 | 16 | 18 GiB | 0.6 s | **0.71** | 0.88 |
| W8 + KV8 | 8 | 8 | 22 GiB | 0.65 s | 0.77 | 0.94 |

Contract from the serving case: quality within **−2 points** of 0.80, and JSON must stay reliable.

- W8A16: **allowed** to try in staging (−1 point, schema holds, memory headroom).
- W4A16: **reject** (−9 points and schema breaks). The latency win is real and irrelevant.
- KV8: maybe, if long-context and tool slices still pass; do not take the memory win on the average only.

**Rule:** every precision change is a new model as far as the eval harness is concerned. Rerun the private slice, the schema tests, and a long-context pack. See [[Case - Evaluation Harness]].

## What to practice saying

- “Which tensors, how many bits, PTQ or QAT, what calibration set?”
- “Show task slices, not only perplexity.”
- “Does the JSON/tool schema still validate?”
- “KV-cache bits are a separate decision from weight bits.”

## Quiz

1. Why can perplexity look fine after INT4 while a policy assistant fails?
2. What is PTQ vs QAT?
3. Why is a quantization “calibration set” easy to contaminate?
4. When is KV-cache quantization the first lever?
5. Why treat a quantized checkpoint as a new model?

> [!question]- Answer key
> 1. Perplexity averages next-token surprise; rare amounts, names, and schema tokens can collapse without moving the average much. 2. PTQ compresses after training; QAT trains with the quantization in the loop. 3. If you pick scales on eval items, you hide the drop you will see in production. 4. When concurrency is memory-bound by the cache, not by weight size. 5. Because quality, latency, and failure modes all changed; the old gate does not transfer.

## Flashcards

Quantization:: Representing weights or activations with fewer bits to save memory or compute.

PTQ:: Post-training quantization of an already-trained model.

QAT:: Training that simulates low precision so the model adapts to it.

Weight-only quantization:: Compress stored weights; compute in higher precision.

KV-cache quantization:: Storing attention keys/values in fewer bits to cut working memory.

Calibration set (quant):: Sample used to choose numeric scales — not probability calibration.

Outlier features:: Activation channels with extreme range that break naive low-bit maps.

## Transfer

- Next concept: [[Vision and Multimodal Systems]].
- Case: [[Case - Serving Capacity]] (apply this after the napkin).
- Roles: [[Inference and Performance Engineer]], [[LLM Engineer]].
