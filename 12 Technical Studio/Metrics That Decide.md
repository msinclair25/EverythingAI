---
title: Metrics That Decide
aliases:
  - Precision Recall F1
  - Decision Metrics
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
estimated_minutes: 35
prerequisites:
  - "[[02 Math and Statistics for AI]]"
  - "[[Leakage and Contamination]]"
tags:
  - technical-studio
  - concept/metrics
  - jargon
cssclasses:
  - everything-ai
---

# Metrics that decide

> [!abstract] Plain idea
> A metric is a **compressed decision**, not a trophy. You pick it because some errors cost more than others. If you cannot say what action a number should trigger, you are decorating a slide.

## Why this concept exists

“Accuracy 91%” hides the class you care about. A claims router that is excellent on `eligibility` and blind on `appeal` can raise accuracy while delaying legally sensitive work. The jargon (precision, recall, F1, calibration) exists so you can talk about **which mistake**.

## Jargon

Imagine a binary detector: “this message is an *appeal*.”

| Term | Formula / meaning | Why it exists |
|---|---|---|
| **True positive (TP)** | Appeal, called appeal | Hits. |
| **False positive (FP)** | Not appeal, called appeal | False alarms; they waste the appeals team. |
| **False negative (FN)** | Appeal, missed | The costly miss in this teaching story. |
| **True negative (TN)** | Not appeal, not called appeal | Often huge; inflates accuracy. |
| **Accuracy** | (TP+TN) / all | Fine when classes and costs are balanced. Often a lie. |
| **Precision** | TP / (TP+FP) | “When we ring the bell, how often is it real?” |
| **Recall / sensitivity** | TP / (TP+FN) | “Of the real appeals, how many did we catch?” |
| **Specificity** | TN / (TN+FP) | “Of the non-appeals, how many did we leave alone?” |
| **F1** | Harmonic mean of precision and recall | One number when you care about both and classes are uneven. Hides which side moved. |
| **Threshold** | The cutoff that turns a score into a yes | Changing it trades precision for recall. |
| **Calibration** | Do “80%” predictions happen about 80% of the time? | Needed when a human or a policy uses the number as a probability. |
| **Slice metric** | The same metric on a subset (recent, rare, high-risk) | Averages hide the fire. |
| **Severity-weighted error** | Count misses by how bad they are | Use when one FN is worth many FPs. |

## Worked teaching numbers

> [!warning] Constructed envelope

1,000 messages. 100 are truly appeals (10% base rate).

| System | TP | FP | FN | TN | Accuracy | Precision | Recall |
|---|---:|---:|---:|---:|---:|---:|---:|
| Always “not appeal” | 0 | 0 | 100 | 900 | **0.90** | — | 0.00 |
| Prompt A | 70 | 40 | 30 | 860 | 0.93 | 0.64 | 0.70 |
| Prompt B | 85 | 120 | 15 | 780 | 0.865 | 0.41 | **0.85** |
| Prompt C | 60 | 10 | 40 | 890 | **0.95** | **0.86** | 0.60 |

If the contract is “do not miss appeals,” **B is better than C** even though C has the nicest accuracy and precision. If the contract is “do not flood a two-person appeals desk,” **C** may win. The metric follows the contract. There is no universal “better.”

Wilson-style caution: 15 vs 30 false negatives on 100 positives is a real difference in this envelope, but on 9 appeal items (the trap in [[Case - Evaluation Harness]]) you cannot tell.

## Base rate — why rare events fool people

A “99% accurate” rare-event detector can still be mostly false positives. If 1 in 1,000 messages is fraud and you flag 1% of traffic, most flags are innocent even if the detector is “good.” This is the **base-rate problem**. Always ask prevalence before celebrating precision.

## What to practice saying

- “Accuracy against what mix, and which miss is expensive?”
- “Give me appeal recall and its interval, not a headline.”
- “What threshold are you using, and who owns changing it?”
- “Is this calibrated, or just ranked?”

## Quiz

1. Compute precision if TP=20 and FP=5.
2. Compute recall if TP=20 and FN=30.
3. Why can accuracy rise while recall falls?
4. When is F1 a bad single number?
5. What extra fact do you need before interpreting precision?

> [!question]- Answer key
> 1. 20/25 = 0.80. 2. 20/50 = 0.40. 3. You can convert costly rare misses into majority-class wins. 4. When the two errors have very different costs, or you need to see which side moved. 5. Prevalence / base rate, and what a false positive costs.

## Flashcards

Precision:: Of predicted positives, the fraction that were actually positive.

Recall:: Of actual positives, the fraction you found.

False negative:: A real positive you missed; often the high-severity error.

Threshold:: The cutoff that turns a score into a decision; it trades precision for recall.

Calibration:: Predicted probabilities match observed frequencies in a defined group.

Slice metric:: The same metric on a subset that the average can hide.

Base-rate problem:: Low prevalence makes even strong detectors produce many false positives.

Severity-weighted error:: Scoring mistakes by consequence, not by count.

## Transfer

- Next concept: [[Attention, Memory, and Inference]].
- Cases: [[Case - Evaluation Harness]].
- Foundation: [[02 Math and Statistics for AI]], [[12 Evaluation Testing and Observability]].
