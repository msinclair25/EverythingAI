---
title: Leakage and Contamination
aliases:
  - Data Leakage
  - Eval Contamination
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
  - "[[04 Data Foundations]]"
  - "[[05 Machine Learning]]"
tags:
  - technical-studio
  - concept/leakage
  - jargon
cssclasses:
  - everything-ai
---

# Leakage and contamination

> [!abstract] Plain idea
> A score is only evidence if the test did not already see the answer. **Leakage** is when information from outside the legitimate training or tuning context sneaks in. **Contamination** is the special case where evaluation items (or their answers) influenced development, so the score stops estimating the real world.

## Why this concept exists

Almost every embarrassing “it worked in the notebook” story is leakage. The model, the prompt, or the human quietly used information that production will not have: a future timestamp, the label column, the same ticket that was used to word the prompt, a Wikipedia paragraph that was in pretraining and also in the benchmark.

Without this idea you cannot trust a demo, a leaderboard, or your own Friday metric.

## Jargon

| Term | What it names | Why the word exists |
|---|---|---|
| **Split** | A deliberate partition of examples into train / development / test (or eval). | So each set has a job: learn, tune, judge. |
| **Held-out set** | Examples **not** used to edit the model, prompt, retrieval, or thresholds for this decision. | “Test set” is often abused. Held-out names the *rule*, not the folder. |
| **Development / tuning set** | Examples you are allowed to look at while changing things. | Looking is a form of training. |
| **Leakage** | Illegitimate extra information that makes the task easier than production. | The model is “cheating” even if you did not mean to cheat. |
| **Target leakage** | A feature that is a disguised form of the label (or is only known after the decision). | Classic: using “paid_off” to predict “will default.” |
| **Temporal leakage** | Training or tuning on events that happen after the decision time. | Time travel. Common in logs and RAG indexes. |
| **Train–test contamination** | The same or near-duplicate items appear on both sides. | Near-duplicates are enough. |
| **Benchmark contamination** | Public eval items were in pretraining, fine-tuning, or prompt examples. | Why public leaderboards can flatter foundation models. |
| **Private eval** | A slice hidden from authors so they cannot overfit it. | The only honest gate once a public set has been stared at. |

## Worked teaching example

> [!warning] Constructed envelope

You have 1,000 labeled support tickets.

**Bad split (random rows):** 800 train, 200 test. Many customers appear in both. The model learns “this account always bills” instead of the text. Test accuracy **0.93**.

**Time split:** train on January–March, test on April. Accuracy **0.78**. That drop is information. The 0.93 was leakage plus seasonality.

**Prompt contamination:** the team writes Prompt B while looking at 120 tickets, then reports 0.91 on those same 120. That is not an eval. Those 120 are now `dev`. See [[Case - Evaluation Harness]].

**RAG temporal leak:** the index contains next month’s policy PDF. The assistant “predicts” a stipend that has not been published to employees. That is not intelligence; it is a future document in the index.

## A split you can defend

```text
decision_time: when the system must act
allowed_features: only fields known at decision_time
train: older than cutoff
dev: after train, visible to authors
public_eval: after dev, authors may see aggregate scores
private_eval: never shown to authors; used only for the gate
identity_rule: no customer / doc / thread crossing the cut
duplicate_rule: near-dup hash cannot cross the cut
```

If you cannot write those lines, you do not have an evaluation. You have a rehearsal.

## What to practice saying

- “What did the system know at decision time?”
- “Who has seen these items?”
- “Show me the private slice.”
- “A rising dev score with a flat private score is overfitting, not progress.”

## Quiz

1. Why is a random row split dangerous for customer tickets?
2. Distinguish leakage from ordinary overfitting.
3. Why hide a private eval from prompt authors?
4. Give a temporal leak in a RAG system.
5. Why are near-duplicates a contamination problem?

> [!question]- Answer key
> 1. The same person, account, or thread can appear on both sides, leaking identity-specific patterns. 2. Overfitting memorizes allowed training data; leakage uses information that should not be available at all. 3. Otherwise they tune wording until the gate is memorized. 4. An unpublished or future-dated policy is searchable when the user question is about today. 5. Paraphrases and copies let the model recognize the item instead of the task.

## Flashcards

Held-out set:: Cases not used to edit the system for the decision they judge.

Leakage:: Illegitimate information that makes development or eval easier than production.

Target leakage:: A feature that encodes the label or is only known after the decision.

Temporal leakage:: Using information from after the decision time.

Contamination:: Eval items or answers influencing training, prompting, or selection.

Private eval:: A hidden slice used as a gate so authors cannot overfit it.

Decision time:: The moment the system must act; features after that are illegal.

## Transfer

- Next concept: [[Metrics That Decide]].
- Cases: [[Case - Evaluation Harness]], [[Case - Prompt RAG Fine-Tune]].
- Foundation: [[05 Machine Learning]], [[04 Data Foundations]].
