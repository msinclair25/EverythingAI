---
title: AI Glossary
type: glossary
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2027-02-12
tags: [ai-careers, glossary]
cssclasses: [everything-ai]
---

# AI Glossary

Short definitions. If a term is doing real work in a design review, open the linked concept or foundation note and learn *why* the word exists.

## A–B

**Accuracy** — (TP+TN) / all cases. Easy to game when classes or costs are unbalanced. See [[Metrics That Decide]].

**Adaptation** — Changing prompts, retrieval, tools, or weights so a base model serves a specific job. See [[Adaptation Methods]].

**Agent** — a system in which a model helps choose and sequence actions toward a goal using tools and state. Definitions vary. See [[11 Agents and Automation]].

**Application conditioning** — request-time instructions, retrieved context, and tools. Not a weight update.

**Artificial intelligence (AI)** — umbrella term for machine-based systems producing outputs such as predictions, recommendations, content, decisions, or actions for human-defined objectives.

**Attention** — a weighted mix of other token representations for the current position. See [[Attention, Memory, and Inference]].

**Base-rate problem** — low prevalence makes even a “good” detector produce many false positives.

**Batching / continuous batching** — serving several generations together so the GPU stays busy; usually lowers per-user speed at high load.

**Benchmark** — a defined task set and scoring procedure used to compare behavior; transfer to real use must be established.

**Bounding box** — a rectangle used as a detection output. See [[Vision and Multimodal Systems]].

**Bound argument** — a tool parameter filled from session or policy, ignoring the model. See [[Structured Outputs and Contracts]].

## C–D

**Calibration** — agreement between stated confidence and observed frequency in a defined group. See [[Calibration]]. Not the same as a quantization calibration set.

**Chunk** — a retrieval-sized piece of a document. Size is a design choice.

**Citation-supported** — the cited span actually licenses the claim, especially numbers.

**Completion / output tokens** — tokens the model generates. Often priced higher than input. See [[Tokens, Context, and Cost]].

**Context engineering** — selecting, labeling, ordering, and budgeting everything in the model window. See [[Context Engineering]].

**Context-hit** — the gold span is present in the *packed* prompt, not only in the retrieved set. See [[Retrieval Quality]].

**Context window** — the model configuration's token/sequence budget; not a guarantee of effective recall.

**Confused deputy** — trusted code using its own privilege to serve a hostile request. See [[Untrusted Context and Injection]].

**Contamination** — evaluation items or answers influencing training, prompting, or selection so the score stops estimating the real world. See [[Leakage and Contamination]].

**Contract** — agreed shape, meaning, and errors at a component boundary.

**Cosine similarity** — score from the angle between two vectors after normalizing length. Not truth. See [[Embeddings and Similarity]].

**Data drift** — change in data distribution over time; a warning signal, not automatic proof of performance failure.

**Data leakage** — illegitimate information contamination that makes development/evaluation unrealistically favorable.

**Decision time** — the moment the system must act; later fields are illegal in the model. See [[Case - Split Integrity]].

**Decode** — generating later tokens one by one using the KV cache.

**Deep learning** — representation learning with multilayer neural networks.

**Distillation** — training a smaller model to mimic a larger one.

## E–H

**ECE** — expected calibration error: size-weighted average gap between confidence and observed rate. See [[Calibration]].

**Effective authority** — the document that is in force for this date and tenant.

**Embedding** — learned vector representation used for similarity or downstream tasks.

**Epoch** — one pass through the training set. See [[The Training Loop]].

**Evaluation** — systematic evidence collection and analysis about behavior for a decision, population, and criteria.

**False negative / false positive** — missed real case / false alarm. Costs are not equal. See [[Metrics That Decide]].

**F1** — harmonic mean of precision and recall. Hides which side moved.

**Fine-tuning** — additional parameter training that adapts a pretrained model. Prefer the more specific term (SFT, PEFT, preference) when you can.

**Foundation model** — a broadly trained model adaptable to many downstream tasks.

**Generative AI** — models and systems producing new content or structured output conditioned on input.

**Gradient** — local direction of increase of the loss; updates usually move the other way. See [[The Training Loop]].

**Greedy decoding** — always emit the current highest-scoring token. Can still be false. See [[Sampling and Decoding]].

**Grounding** — connecting generation to supplied evidence or tool data. It does not guarantee correctness. In vision, “grounding” can also mean tying language to a region — say which.

**Hallucination** — common but imprecise term for unsupported or incorrect generated content; prefer a specific failure category (stale authority, packing miss, fabrication).

**Held-out set** — cases not used to edit the system for the decision they judge.

**Human in/on the loop** — a human performs a defined review/intervention or oversight role; specify authority and timing.

**Hybrid search** — combining lexical (term) and dense (embedding) retrieval.

## I–M

**Idempotency** — repeating an operation has the same intended effect as doing it once.

**IoU** — intersection over union of two regions; a hit criterion for detection/segmentation.

**Inference** — using a trained model to produce output. Contrast with training.

**Inter-token latency** — time between subsequent generated tokens.

**KV cache** — stored attention keys and values for tokens already seen, so decode does not recompute the prompt.

**Large language model (LLM)** — a large neural language model, usually transformer-based, trained to model/generate token sequences.

**Learning rate** — step size of a weight update.

**Lexical search** — term-matching retrieval (e.g. BM25). Strong on identifiers.

**LoRA / PEFT** — parameter-efficient fine-tuning: train a small extra or selected set of weights.

**Lost-in-the-middle** — relevant items in the center of a long context are underused.

**mAP** — mean average precision over classes (and usually IoU thresholds) in detection.

**Machine learning (ML)** — AI methods that learn behavior from data or experience.

**Model** — a learned computational component, distinct from the complete system.

**MLOps** — practices and platforms for controlled ML delivery, operation, monitoring, and change.

**Multimodal** — processing or generating across multiple data modalities.

## N–R

**nDCG / MRR** — ranking metrics: how high the relevant item sits, not only whether it appears.

**Ontology** — formal model of concepts, properties, relationships, and constraints.

**Overfitting** — training performance much better than honest held-out performance. See [[The Training Loop]].

**Packing policy** — the rule for what stays in the window when tokens run out.

**Post-training** — weight updates after pretraining that shape behavior (SFT, preference, RL).

**Precision** — of predicted positives, how many were actually positive.

**Prefill** — processing the prompt to build the KV cache; usually sets unloaded TTFT.

**Preference optimization** — training from “A is better than B” signals (DPO and related methods).

**Private eval** — a slice hidden from authors and used as a release gate.

**Prompt injection** — adversarial instructions manipulating a model system directly or through processed content.

**Prompting** — supplying instructions/examples to shape a model interaction. A subset of context engineering.

**Provenance** — evidence about origin and transformation history.

**PTQ / QAT** — post-training quantization vs quantization-aware training. See [[Quantization]].

**Publish-to-searchable** — time from source-of-truth publish to a successful retrieval of that version.

**RAG** — retrieval-augmented generation; retrieves information at inference and supplies it to a generator.

**Recall** — of actual positives, how many you found. Also **recall@k** in retrieval: gold span in the top k.

**Red teaming** — authorized adversarial exploration to discover failures or abuse paths. Not a prevalence estimate.

**Reinforcement learning** — learning policies from reward signals in sequential interaction.

**Reranker** — a second, usually heavier model that reorders a short candidate list.

**Responsible AI** — organizational practices for developing/using AI with defined accountability and trustworthiness/impact objectives; not a single universally standardized role or score.

## S–Z

**Quantization** — storing weights or activations in fewer bits. Quality must be re-measured. See [[Quantization]].

**Schema** — machine-checked description of allowed fields, types, and constraints.

**Second source of truth** — adapted weights that silently disagree with the living document store.

**Semantic cache** — reusing an answer because a new query is nearby in embedding space. Dangerous when one word flips the answer.

**SFT** — supervised fine-tuning on input–desired-output examples.

**Slice metric** — the same metric on a meaningful subset; averages can hide it.

**Structured output** — model output constrained or validated against a schema.

**Synthetic data** — artificially generated data intended to approximate properties of real or simulated data; it requires utility, bias, privacy, and provenance validation.

**Temperature (decoding)** — sharpness knob on the next-token distribution; not a factuality control. See [[Sampling and Decoding]]. Distinct from calibration temperature scaling.

**Temporal leakage** — using information from after the decision time.

**Threshold** — cutoff that turns a score into a yes/no; it trades precision for recall.

**Time to first token (TTFT)** — delay from request arrival to the first streamed token, including queueing.

**Top-p / nucleus** — sample from the smallest token set whose probabilities sum to p.

**Token** — tokenizer-defined unit such as a word piece, character, or byte sequence. See [[Tokens, Context, and Cost]].

**Tokenizer** — the model-specific rules that turn text into token IDs.

**Trajectory** — the sequence of states, proposals, and results for one agent run. See [[The Agent Loop]].

**Training** — adjusting model parameters using data/experience and an objective.

**Transformer** — attention-centered neural architecture used across language, vision, audio, and multimodal systems.

**Untrusted output** — default stance: treat model text like attacker-controlled input until validated.

**VLM** — vision-language model; a language interface to pixels, not automatically a detector. See [[Vision and Multimodal Systems]].

**Vector database/search** — system optimized to store and retrieve vector representations by similarity, usually with metadata filtering.

**Working context** — the context you can actually offer at the target concurrency without running out of memory.

See [[Technical Skills Hub]] for taught concepts and [[Foundations Hub]] for the broader map.
