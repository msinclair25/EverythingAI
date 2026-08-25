---
title: Case - Vision Field Slice
aliases:
  - Night Camera Slice Case
  - Vision Ship or Stop
type: technical-case
family: technical
scope: United States
level:
  - intermediate
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 35
tags:
  - technical-studio
  - case/vision
cssclasses:
  - everything-ai
---

# Case · Vision field slice — the average is a lie

> [!abstract] Decision
> A crack detector’s overall recall looks close to the contract. Night and a new camera fail. Decide whether to ship, and what evidence would reverse you.

**Roles:** [[Computer Vision Engineer]] · [[AI Evaluation Engineer]] · [[ML Engineer]]
**Concepts:** [[Vision and Multimodal Systems]] · [[Metrics That Decide]] · [[Calibration]]

## Situation and contract

**Northline Operations — teaching scenario.** A line-side camera flags “critical crack” on stamped parts. A missed crack can ship a bad part. A false stoppage idles the line.

Contract (safety owner signed):

- Recall on **critical crack** ≥ **0.98** on every operating slice you claim to support.
- False stoppages ≤ **20 / hour**.
- p95 ≤ **40 ms** on the edge box.
- If a slice is unsupported, the system must **abstain** (divert to human) rather than silently run.

Product wants to enable nights and camera B because “overall recall is 0.94.” A teammate suggests “just prompt a VLM on the night frames.”

## Teaching envelope

> [!warning] Constructed numbers — same family as the vision concept note.

| Slice | n | Recall | FP / hour | p95 ms |
|---|---:|---:|---:|---:|
| Day, camera A (train-like) | 800 | 0.99 | 8 | 28 |
| Night, camera A | 200 | **0.86** | 11 | 30 |
| Day, new camera B | 200 | **0.81** | 30 | 27 |
| Overall | 1,200 | 0.94 | 14 | 28 |

IoU hit threshold: 0.5. Night labels: two raters, agreement 0.79 (borderline). Camera B: 40 of 200 images are a different resolution than train.

VLM spot-check (teaching): 40 night frames, “is there a crack?” vs gold — 28/40 agree. No boxes. No latency number on the edge box.

## Closed-note prompt

Write:

1. Which slices may you enable?
2. Is 0.94 a ship metric?
3. What do you do at night and on camera B tonight?
4. Is the VLM an allowed replacement for the detector?
5. What would reverse a hold on nights?

## Worked path

### 1. Enable only what you measured and passed

Day + camera A meets recall, FP, and latency. **Enable that slice only.** Write the operating envelope on the system card: indoor day, camera A, firmware X.

### 2. Overall 0.94 is not the contract

The contract is **per claimed slice** at 0.98. Mixing 800 easy frames with 400 failing frames is how averages hide the 2 a.m. miss. Same lesson as appeal recall in [[Case - Evaluation Harness]].

### 3. Abstain on unsupported slices

Tonight: if the time-of-day or camera-id is night or B, **do not run the detector as a gate**. Divert to human or stop the feature. Shipping 0.86 recall on critical cracks is a process-safety decision, not an ML tweak.

Camera B also blows the FP budget (30 > 20). Even if recall were fixed, the line would stop too often.

### 4. Reject the VLM substitution

The contract needs localized, high-recall, timed, auditable detections. A 28/40 caption check has no box, no IoU, no edge p95, no slice n that can estimate 0.98. A VLM may draft a review UI later. It is not the detector.

### 5. What would enable nights

- A night collect with agreement ≥ 0.85 and a private slice.
- Recall ≥ 0.98 **on that slice** (interval that does not collapse under n).
- FP/hour and p95 still in contract.
- Retrain or domain-adapt with real night frames; color jitter is not a substitute.
- Calibration of the detector score if you use it to abstain (see [[Calibration]]).

Until then, **hold** nights and camera B.

## Inspectable artifact

```text
# operating_envelope.yaml — teaching
enable:
  - {lighting: day, camera: A, firmware: 2026.03, recall_min: 0.98}
abstain:
  - {lighting: night, action: human_divert}
  - {camera: B, action: human_divert}
forbidden_substitutes: [vlm_yes_no_without_boxes]
review_trigger: any slice recall < 0.98 or fp_per_hour > 20
```

## Failure modes and reversal test

- You “fix” nights by lowering the score threshold and FP/hour explodes.
- Camera B is “close enough” because marketing already printed the brochure.
- Night labels were done by one tired rater — 0.86 may be label noise; still do not ship on faith.

## Quiz

1. Why doesn’t overall 0.94 satisfy a 0.98 slice contract?
2. What must the system do on an unsupported slice?
3. Give two reasons the VLM spot-check is not a detector eval.
4. Why is camera B a different problem than night?
5. What evidence enables nights?

> [!question]- Answer key
> 1. The average is dominated by the train-like day slice. 2. Abstain / human divert — not silently infer. 3. No boxes/IoU, tiny n, no edge latency, not a 0.98-capable sample. 4. New sensor/resolution (domain shift) plus FP budget already failed. 5. Night-specific labeled private slice, agreement, recall/FP/latency on that slice.

## Flashcards

Operating envelope:: The lighting, sensor, and firmware you actually measured and enable.

Slice contract:: A quality bar that must hold on each claimed condition, not only overall.

Abstain (vision):: Divert or refuse when the image is outside the envelope.

Domain shift (camera):: A new sensor, mount, or lighting that breaks a trained detector.

VLM substitution:: Using a caption model as if it were a timed, localized detector.

## Transfer

- Concept: [[Vision and Multimodal Systems]].
- Interview: treat as a slice-metric drill (same shape as drill 2).
- Role: [[Computer Vision Engineer]] advanced project — do not submit this envelope as if you measured it.
