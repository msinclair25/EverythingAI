---
title: 08 Generative AI Systems
aliases:
  - Generative AI Systems
type: foundation
module: 8
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_hours: 6-12
prerequisites:
  - "[[01 AI Systems and Vocabulary]]"
  - "[[07 Transformers and Foundation Models]]"
tags:
  - ai-careers
  - foundations
  - generative-ai
cssclasses:
  - everything-ai
---

# 08 · Generative AI Systems

## Outcome

You can compare major generative modalities, distinguish generation from retrieval and verification, and design a workflow that preserves human control, provenance, and evaluation.

## What generation does

Generative models estimate structure in training data and produce new samples or sequences conditioned on input. Common families include:

- **autoregressive models:** generate successive tokens or other units;
- **diffusion/flow-style models:** transform noise or an initial state toward a sample;
- **encoder–decoder models:** map one representation to another;
- **adversarial and latent-variable models:** remain useful in specialized settings;
- **multimodal models:** connect two or more of text, image, audio, video, code, sensor data, and action.

Product names change; these mechanisms and workflow questions transfer.

## Modality map

| Modality | Common work | Evaluation must include |
|---|---|---|
| Text | drafting, extraction, translation, synthesis | factuality, coverage, citations, style, harmful content |
| Code | completion, transformation, tests, explanation | correctness, security, dependencies, maintainability, license concerns |
| Image/design | ideation, generation, editing | brief adherence, artifacts, consistency, provenance, rights, representation |
| Video/avatar | storyboards, synthesis, localization | temporal consistency, identity/consent, disclosure, lip sync, safety |
| Audio/speech/music | transcription, synthesis, sound/music | intelligibility, speaker similarity/consent, timing, rights, misuse |
| Structured data | extraction, classification, synthetic records | schema validity, field accuracy, distribution and privacy risks |

## A controlled generation workflow

```mermaid
flowchart LR
    B["Brief + constraints"] --> I["Authorized inputs"] --> G["Generate alternatives"] --> V["Validate"] --> H["Human selection/edit"] --> P["Provenance + publish"] --> M["Monitor feedback"]
```

**Validation** must match the artifact: execute code, calculate extracted fields, inspect citations, compare audio, review frames, or test with users. “Looks plausible” is rarely enough.

## Grounding and attribution

A model can produce a correct-looking statement without a traceable basis. Improve trust by:

- supplying authoritative source material through retrieval or tools;
- requiring source identifiers tied to retrieved passages;
- verifying that citations support each claim, not merely that URLs exist;
- separating quoted/source-derived content from model inference;
- refusing or escalating when evidence is insufficient.

Grounding reduces some errors but can fail through poor retrieval, malicious documents, outdated sources, context conflict, or unsupported synthesis.

## Control patterns

- clear instructions, exclusions, audience, and success criteria;
- reference examples and structured schemas;
- constrained generation or tool validation;
- checkpoints before external action or publication;
- versioned prompts, model/configuration, and source sets;
- content credentials, metadata, or production records where relevant;
- approved-data boundaries and retention controls.

## Rights and provenance in the United States

The U.S. Copyright Office states that purely AI-generated material is not copyrightable; protection depends on sufficient human-authored expression and is assessed case by case. Prompting alone does not automatically establish authorship, while human selection, arrangement, modification, or perceptible human-authored input may matter. Training-data and digital-replica questions are distinct. Keep records of human contributions, inputs, permissions, and edits, and obtain qualified advice for consequential uses.

See [[Creative AI Provenance and Rights]] and the [Copyright Office AI initiative](https://www.copyright.gov/ai/), verified 2026-08-12.

## Failure modes

- unsupported or fabricated facts and citations;
- prompt injection or hidden instructions in supplied content;
- sensitive-data disclosure and memorization;
- stereotyped, exclusionary, or unsafe output;
- inconsistency across variations, scenes, voices, or long artifacts;
- unauthorized likeness, trademark, confidential, or copyrighted input/output;
- automation bias: humans approving because output looks polished;
- cost and latency escalation from unnecessary model size or context.

## Quiz

1. Distinguish generation, retrieval, and verification.
2. Why is “citation included” insufficient evidence?
3. Name two controls that matter before a model can publish or act externally.
4. Why should code generation be evaluated differently from prose drafting?
5. Does prompting alone automatically make AI output copyrightable in the U.S.?
6. Give two ways multimodal systems add risk beyond text-only generation.

> [!success]- Answer key
> 1. Generation creates output from learned/conditioned patterns; retrieval locates stored material; verification tests claims or behavior against evidence. 2. The citation may be invented, irrelevant, outdated, or fail to support the specific claim. 3. Human approval, permission checks, schema/rule validation, sandboxing, spending limits, and destination confirmation are examples. 4. Code has executable correctness, security, dependency, and license consequences and should be tested and reviewed. 5. No. The Copyright Office says authorship depends on sufficient human-created expression under case-specific analysis. 6. Identity/likeness misuse, temporal inconsistency, cross-modal injection, hidden audio/image instructions, provenance difficulty, or biometric data exposure.

## Flashcards

Generative AI:: Models and systems that create content or structured output based on learned patterns and supplied conditions.

Autoregressive generation:: Producing a sequence one element at a time conditioned on preceding context.

Diffusion generation:: Producing a sample through iterative denoising or related transformations.

Multimodal model:: A model that processes or generates across more than one data modality.

Grounding:: Connecting generation to supplied evidence, data, or tool results.

Attribution:: Linking a claim or artifact to its source or contribution record.

Provenance:: Evidence about the origin and transformation history of content or data.

Automation bias:: Over-trusting an automated output or recommendation because it appears authoritative.

## Sources and next step

- [NIST Generative AI Profile, NIST AI 600-1](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf), verified 2026-08-12.
- [U.S. Copyright Office AI initiative and multipart report](https://www.copyright.gov/ai/), verified 2026-08-12.

Next: [[09 Prompt Context and Tool Use]].
