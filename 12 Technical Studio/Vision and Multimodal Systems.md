---
title: Vision and Multimodal Systems
aliases:
  - Computer Vision Concepts
  - VLM Multimodal
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
estimated_minutes: 40
prerequisites:
  - "[[05 Machine Learning]]"
  - "[[Embeddings and Similarity]]"
  - "[[Metrics That Decide]]"
tags:
  - technical-studio
  - concept/vision
  - concept/multimodal
  - jargon
cssclasses:
  - everything-ai
---

# Vision and multimodal systems

> [!abstract] Plain idea
> A camera is not a sentence. Pixels come from a **sensor** with a viewpoint, lighting, and a frame rate. **Computer vision** turns those pixels into a decision (is there a defect, where is the box, what does the sign say). **Multimodal** models connect vision (or audio) to language. A fluent VLM caption is not a detector, and a high mAP on a demo set is not field readiness.

## Why this concept exists

The vault has a full [[Computer Vision Engineer]] track and almost no teaching note under it. People import LLM habits: “prompt the image” and trust the prose. Vision fails for physical reasons LLMs do not have: motion blur, night, a new factory line, a camera 15° off. The jargon exists so you can name the *task*, the *box*, and the *shift* — not just “the vision model.”

## Tasks, not vibes

| Task | Output | Typical metric family |
|---|---|---|
| **Classification** | one label per image | accuracy / recall by class |
| **Detection** | boxes + labels | mAP, precision/recall at IoU |
| **Segmentation** | a class per pixel (or instance) | IoU / Dice |
| **OCR / reading** | text in the image | character/word error; field-level |
| **Tracking** | identities over time | ID switches, MOTA-style scores |
| **VLM / caption / VQA** | language conditioned on the image | task-specific; do not use BLEU as safety |

A **VLM** (vision-language model) can describe a scene. It does not automatically give you calibrated boxes, known recall on a rare defect, or a latency budget on a line camera. If the contract is “never miss a stop sign,” you usually want a detector with a slice report, not a chat API.

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **Bounding box** | A rectangle around an object. | The unit detection scores. |
| **IoU (intersection over union)** | Overlap / union of two boxes or masks. | “Did we hit the same object?” |
| **mAP** | Mean average precision across classes and IoU thresholds. | Standard detection headline; still hides slices. |
| **Anchor / query** | How some detectors propose regions. | Architecture detail; not the product. |
| **Augmentation** | Train-time crops, color jitter, flips. | Helps *some* shifts; does not replace night data. |
| **Domain / covariate shift** | New lighting, sensor, geography, season. | The #1 field failure. |
| **Camera calibration** | Intrinsics/extrinsics so pixels map to rays or meters. | Required for anything geometric. |
| **Frame / stream** | One image vs video over time. | Video has temporal bugs (flicker, ID swap). |
| **Modality** | A kind of signal: image, text, audio, depth. | “Multimodal” means more than one. |
| **Grounding (vision)** | Tying language to a region. | Different word from RAG grounding. Say which. |
| **Sensor ethics / privacy** | Faces, plates, workplaces. | Capture is a data-protection event. |

## Worked teaching numbers

> [!warning] Constructed envelope — factory defect detection.

Contract: miss rate on “critical crack” ≤ 2% (recall ≥ 0.98), false stoppages ≤ 20/hour, p95 40 ms on the edge box.

| Slice | n | Recall | False positives / hour |
|---|---:|---:|---:|
| Day, camera A (train-like) | 800 | 0.99 | 8 |
| Night, camera A | 200 | **0.86** | 11 |
| Day, new camera B | 200 | **0.81** | 30 |
| Overall | 1,200 | 0.94 | 14 |

Overall recall **looks** close to the contract. Night and camera B **fail**. Shipping on the average is how you get a 2 a.m. incident. This is the same slice lesson as [[Metrics That Decide]], with physics attached.

A VLM asked “is there a crack?” on the same night images might answer fluently and still miss 0.86 → you now have an uncalibrated yes/no with no box to audit. Use it for triage or captioning, not as the safety detector, unless you build a real eval that treats it as one.

## What to practice saying

- “Name the task: classify, detect, segment, read, or talk about the image.”
- “Show IoU threshold, slice, lighting, and camera — not only mAP.”
- “What must we abstain from when the image is dark or occluded?”
- “A VLM is a language interface to pixels, not a drop-in detector.”

## Quiz

1. Why is overall mAP or recall a weak ship gate?
2. What does IoU measure?
3. When is a VLM the wrong tool?
4. Why doesn’t train-time color jitter replace a night collect?
5. How does [[Leakage and Contamination]] show up in vision?

> [!question]- Answer key
> 1. Hard operating conditions and rare classes hide inside the average. 2. Overlap quality between a predicted region and the gold region. 3. When you need localized, high-recall, low-latency, auditable detections. 4. Jitter is a crude simulation; night has different noise, exposure, and failure modes. 5. Same scene in train and test, labels from a future inspector note, or a VLM eval set that was in pretraining.

## Flashcards

Bounding box:: A rectangle used as the detection output for an object.

IoU:: Intersection over union of two regions; a hit criterion for detection/segmentation.

mAP:: Mean average precision over classes (and usually IoU thresholds).

Domain shift:: A change in sensor, lighting, place, or time that breaks a vision model.

VLM:: A model that connects images (or video) to language.

Camera calibration:: The mapping from pixels to geometric rays or meters.

Augmentation:: Train-time synthetic variation; not a substitute for real operating data.

Modality:: A signal type such as image, text, audio, or depth.

## Transfer

- Role: [[Computer Vision Engineer]], [[Speech AI Engineer]], [[Robotics and Embodied AI Engineer]].
- Related: [[Embeddings and Similarity]], [[Calibration]], [[Case - Split Integrity]] (same split honesty, different data).
- Foundation: [[08 Generative AI Systems]].
