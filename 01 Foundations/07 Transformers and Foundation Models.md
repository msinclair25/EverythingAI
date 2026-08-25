---
title: 07 Transformers and Foundation Models
aliases:
  - Transformers and Foundation Models
type: foundation
module: 7
scope: United States
level:
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_hours: 8-16
prerequisites:
  - "[[06 Deep Learning]]"
tags:
  - ai-careers
  - foundations
  - transformers
  - foundation-models
cssclasses:
  - everything-ai
---

# 07 · Transformers and Foundation Models

## Outcome

You can trace how input becomes contextual representations and generated output, distinguish pretraining from post-training and inference controls, and reason about adaptation and limitations.

## Tokens and embeddings

Text is split into **tokens**, which may be words, subwords, characters, or bytes depending on the tokenizer. Token IDs map to vectors. Position information distinguishes order. Token counts affect context capacity, latency, and cost; characters and words are not reliable token estimates across languages.

## Attention

For each position, a transformer derives query, key, and value vectors. Scaled dot-product attention is commonly expressed:

$$\text{Attention}(Q,K,V)=\text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V$$

**Self-attention** relates positions within a sequence. **Cross-attention** relates one representation to another. Multiple heads can capture different relationships. Masks control which positions may attend to which.

## Transformer block

```mermaid
flowchart LR
    X["Token + position representations"] --> A["Multi-head attention"] --> R1["Residual + normalization"] --> F["Feed-forward network"] --> R2["Residual + normalization"] --> Y["Contextual representations"]
```

Architectures may be encoder-only, decoder-only, or encoder–decoder. Exact implementation choices differ; do not assume every “transformer” behaves identically.

## Foundation model lifecycle

1. **Pretraining:** learn broad patterns, often with next-token, masked-token, contrastive, reconstruction, or multimodal objectives.
2. **Post-training:** instruction tuning, preference optimization, reinforcement or other methods shape helpfulness, format, safety, and domain behavior.
3. **Application conditioning:** system instructions, examples, retrieval, tools, and conversation state shape a particular run.
4. **Inference:** decoding settings and serving implementation select outputs.
5. **Application evaluation and monitoring:** measure the complete system under real conditions.

Post-training does not insert a perfect fact database or remove all unsafe behavior.

## Context window

The context window is the maximum usable input/output sequence budget under a model/service configuration. A longer advertised context does not guarantee equal recall across all positions, good reasoning over every item, or economical use. Context must be selected, ordered, labeled, and tested.

## Decoding

- **Greedy/low-variation decoding** favors high-probability continuations.
- **Temperature** reshapes relative token probabilities.
- **Top-p/top-k** restrict candidate tokens.
- **Beam search** explores multiple sequences and is useful for some tasks but not universally.

Decoding changes variability; it cannot turn missing knowledge into verified truth.

## Adaptation choices

| Need | First option to test | Escalate when… |
|---|---|---|
| clearer behavior | instructions, examples, schema, validation | behavior remains systematically wrong |
| current/private knowledge | retrieval or tools | task requires learned style/capability rather than supplied facts |
| domain behavior/format | PEFT or fine-tuning | evidence shows prompting/retrieval is insufficient and data rights support training |
| lower serving cost | smaller model, caching, routing, quantization | quality or hardware constraints require deeper optimization |
| new fundamental capability | training or research | cost, data, talent, and evaluation case is justified |

## Limitations to design around

- outputs optimize learned and post-trained objectives, not truth itself;
- training knowledge can be stale, incomplete, or conflicting;
- prompt sensitivity and non-determinism complicate testing;
- long context can still lose or misweight information;
- multilingual and domain behavior varies;
- memorization and data exposure may occur;
- tools increase capability and attack surface;
- benchmark gains may not transfer to your distribution.

## Quiz

1. Why is a token not the same as a word?
2. What do attention weights compute conceptually?
3. Distinguish pretraining, post-training, and application conditioning.
4. Does a larger context window guarantee better retrieval of every fact?
5. What does temperature change?
6. When is retrieval a better first test than fine-tuning?

> [!success]- Answer key
> 1. Tokenizers use model-specific pieces such as subwords, characters, or bytes, varying by language and text. 2. Content-dependent weighted combinations of value representations based on query–key compatibility. 3. Pretraining learns broad capability; post-training shapes behavior; application conditioning supplies instructions/context/tools for a run. 4. No; effective recall, position effects, reasoning, noise, and economics must be evaluated. 5. It reshapes relative next-token probabilities and therefore output variation; it does not directly verify truth. 6. When the missing capability is access to current, private, or attributable information that can be supplied at inference time.

## Flashcards

Token:: A tokenizer-defined unit mapped to an ID; it may be a word, subword, character, or byte sequence.

Self-attention:: A mechanism that creates context-dependent mixtures of representations within a sequence.

Query, key, value:: Learned projections used to score relationships and combine information in attention.

Foundation model:: A broadly trained model adaptable to many downstream tasks.

Pretraining:: Broad capability learning from large-scale data and objectives.

Post-training:: Additional training that shapes instructions, preferences, safety, format, or domain behavior.

Context window:: The sequence budget available to a model configuration; advertised length is not guaranteed effective recall.

Temperature:: A decoding control that changes the sharpness of token probabilities.

## Sources and next step

- [Attention Is All You Need](https://arxiv.org/abs/1706.03762), original transformer paper.
- [Hugging Face course](https://huggingface.co/learn), free current learning materials.
- [Stanford Foundation Model report](https://arxiv.org/abs/2108.07258), terminology and sociotechnical scope.

Next: [[08 Generative AI Systems]].
