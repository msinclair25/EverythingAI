---
title: Calibration
aliases:
  - Reliability Diagram
  - Expected Calibration Error
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
  - "[[02 Math and Statistics for AI]]"
  - "[[Metrics That Decide]]"
tags:
  - technical-studio
  - concept/calibration
  - jargon
cssclasses:
  - everything-ai
---

# Calibration

> [!abstract] Plain idea
> A model can rank cases well and still lie about *how sure* it is. **Calibration** asks: when the system says “80%,” does the event happen about 80 times in 100 comparable cases? If you use the number to escalate, price, or abstain, ranking metrics are not enough.

## Why this concept exists

Product language is full of fake probabilities: “the model is 92% confident.” That 0.92 is often just a softmax peak or a judge score. Humans treat it like a weather forecast. Calibration exists so you can test that claim, and so you know when to add an **abstain** path instead of another decimal place.

This is a different word from decoding **temperature** in [[Sampling and Decoding]]. Do not mix them.

## Jargon

| Term | What it names | Why it exists |
|---|---|---|
| **Confidence** | The number the system emits as “how sure.” | Must be defined (max softmax, judge score, ensemble vote). |
| **Reliability diagram** | Plot: predicted confidence vs observed frequency, by bucket. | The picture for “are we overconfident?” |
| **ECE (expected calibration error)** | Average gap between confidence and accuracy, weighted by bucket size. | One scalar; hides which bucket is the problem. |
| **Overconfidence** | Predicted > observed. | The usual deep-net and LLM-judge failure. |
| **Underconfidence** | Predicted < observed. | Less common; still breaks thresholds. |
| **Temperature scaling** (calibration) | Divide *classification* logits by a fitted \(T\) after training. | Recalibrates probabilities. Does not retrain. Does not pick tokens. |
| **Abstain / defer** | Refuse to decide when confidence is below a gate. | The operational use of a calibrated score. |
| **Discrimination / ranking** | Can the model put positives above negatives? (AUC) | Orthogonal: great AUC, terrible calibration is common. |
| **Proper scoring rule** | A loss that rewards honest probabilities (log loss, Brier). | Accuracy does not. |

## Worked teaching table

> [!warning] Constructed envelope — 200 predictions in four confidence buckets.

| Bucket (predicted p) | n | Mean p | Observed rate | Gap |
|---|---:|---:|---:|---:|
| 0.50–0.60 | 40 | 0.55 | 0.52 | 0.03 |
| 0.70–0.80 | 60 | 0.75 | 0.61 | **0.14** |
| 0.85–0.90 | 50 | 0.88 | 0.70 | **0.18** |
| 0.95–1.00 | 50 | 0.97 | 0.78 | **0.19** |

Accuracy can still look fine if the ranking is good. ECE is roughly the n-weighted mean gap ≈ **0.14**. If you auto-approve appeals above 0.90, you are auto-approving a bucket that is only right **78%** of the time.

**Decision:** do not use raw confidence as a gate. Either (a) fit a calibration map on a held-out set that was **not** used to train or tune prompts, or (b) replace “0.90 means approve” with a human review band, or (c) use a metric that is already a frequency (historical base rate + rule).

Never calibrate on the same items you used to edit the prompt. That is [[Leakage and Contamination]].

## What to practice saying

- “Is this number a probability or a score we named confidence?”
- “Show the reliability diagram, not a single ECE.”
- “What happens when we are in the 0.9 bucket and wrong?”
- “Decoding temperature is not calibration.”

## Quiz

1. Why is AUC not enough if you will abstain below 0.8?
2. What does a reliability diagram show?
3. Why is ECE a starting point, not a finish?
4. When is temperature scaling the wrong tool?
5. Why calibrate on a held-out set?

> [!question]- Answer key
> 1. AUC only cares about order; the 0.8 threshold needs the number to mean 80%. 2. Predicted vs observed frequency by confidence bucket. 3. It averages gaps; one dangerous high-confidence bucket can hide. 4. When the score is not a logit/softmax you control, or when you need a better model/features, not a rescaling. 5. Fitting the map on the same items you tuned is leakage; the diagram will look honest and be fake.

## Flashcards

Calibration:: Agreement between stated confidence and observed frequency in a defined group.

Reliability diagram:: A plot of predicted confidence versus observed rate by bucket.

ECE:: Size-weighted average of those bucket gaps.

Overconfidence:: Stated probability higher than the observed rate.

Temperature scaling (calibration):: Post-hoc rescaling of classification logits to improve probability meaning.

Abstain:: A designed refusal when confidence is below a gate.

Discrimination:: Ability to rank positives above negatives; not the same as calibration.

## Transfer

- Next concept: [[Quantization]].
- Cases: [[Case - Evaluation Harness]], [[Case - Agent Permissions]] (approval thresholds).
- Foundation: [[02 Math and Statistics for AI]], [[12 Evaluation Testing and Observability]].
