---
title: Case - Split Integrity
aliases:
  - Leakage Split Case
  - Ticket Classifier Split
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
  - case/leakage
  - skill/evaluation
cssclasses:
  - everything-ai
---

# Case · Split integrity — why 0.94 is not ready

> [!abstract] Decision
> A ticket classifier looks excellent. Decide whether the split is honest enough to ship, and what you would rebuild before touching the model.

**Roles:** [[ML Engineer]] · [[AI Evaluation Engineer]] · [[Data Scientist - AI ML]]
**Concepts:** [[Leakage and Contamination]] · [[The Training Loop]] · [[Metrics That Decide]]

## Situation and contract

**Northline Credit — teaching scenario.** A model routes inbound messages to `eligibility`, `billing`, `appeal`. Data science reports **held-out accuracy 0.94** after three days of training. Product wants it in the queue Friday.

You own the split and the gate. Wrong `appeal` routes delay a legally sensitive process (same cost story as [[Case - Evaluation Harness]]).

Contract:

- The model may use only fields known when the ticket **arrives**.
- No customer’s history from *after* arrival.
- Appeal recall is the safety metric; accuracy is not the gate.
- If the split is dirty, you do not “tune more.” You rebuild the evidence.

## Teaching envelope

> [!warning] Constructed numbers

| Quantity | Value | Why it matters |
|---|---:|---|
| Tickets | 8,000 | 18 months |
| Unique customers | 1,100 | Many repeats |
| Split used | random 80/20 **rows** | Same customer on both sides |
| Customers in both train and “test” | 640 / 1,100 | Identity leakage |
| Feature `agent_resolution_code` | present | Assigned **after** the ticket is closed |
| Feature `days_to_close` | present | Not known at arrival |
| Reported test accuracy | 0.94 | Headline |
| Appeal recall on that test | 0.71 | Already short of a 0.90 teaching gate |
| Accuracy if you drop post-arrival features | 0.81 | Honest-er |
| Accuracy on a **time** split (train first 14 months, test last 4) with arrival-only features | **0.73** | The number that should scare the room |
| Near-duplicate subject lines crossing the random split | 220 pairs | Contamination |

The 0.94 is a mixture of leaked future fields, customer memorization, and duplicates. It is not a production estimate.

## Closed-note prompt

Write:

1. Which features are illegal at decision time?
2. What split would you accept?
3. What metric is the gate?
4. Do you ship, hold, or rebuild?
5. What would make 0.73 shippable later?

## Worked path

### 1. Decision time

Arrival-time legal fields: channel, subject, body, authenticated product line, locale.  
Illegal: `agent_resolution_code`, `days_to_close`, anything written by the closer, any comment timestamped after `created_at`.

If a feature is only known because a human already solved the ticket, it is target-ish leakage. That is why accuracy jumped.

### 2. The split is the first bug

A random **row** split on a customer-repeat dataset trains and tests on the same people. The model learns “this account always bills,” not “this text is billing.”

Required rebuild:

```text
unit: customer (or thread), not row
cutoff: created_at < 2026-04-01 → train
         next 6 weeks → dev
         last 6 weeks → private test
no customer id in more than one split
near-dup hash cannot cross splits
features: arrival-time only
```

Until that exists, **there is no held-out set**. There is a rehearsal.

### 3. Metric

Accuracy 0.94 with appeal recall 0.71 fails the contract even if the split were clean. After the honest time split, 0.73 accuracy is not automatically a disaster — it is the first *real* baseline. Compare it to a keyword/`appeal` rule before celebrating a neural net.

### 4. Decision

**Do not ship. Do not fine-tune.** Rebuild the dataset and split. Report:

- arrival-only feature list;
- customer-level time split sizes;
- appeal recall + interval on private test;
- a simple non-ML baseline on the same split.

If honest appeal recall is still < 0.90, the intervention is better labels, more appeal examples, or a different product design (human default for appeal-like text) — not another epoch. See [[The Training Loop]].

### 5. Reversal

You would only reopen a model change after the split is clean *and* a non-ML baseline is beaten on the private slice by more than noise.

## Inspectable artifact

```text
# split_spec.yaml — teaching
unit: customer_id
decision_time_field: created_at
allowed_features: [channel, subject, body, product_line, locale]
forbidden_features: [agent_resolution_code, days_to_close, closer_notes]
train: created_at < 2026-04-01
dev: 2026-04-01 ≤ created_at < 2026-05-13
private_test: created_at ≥ 2026-05-13
constraints:
  - customer_id appears in exactly one split
  - near_dup_hash does not cross splits
gate:
  appeal_recall_min: 0.90
  beat_keyword_baseline: true
ship: false  # until rebuilt
```

## Failure modes and reversal test

- Time split with a product launch in the test window only → mix shift, not model genius or failure.
- Hashing near-dups too aggressively drops all short subjects → recall looks worse than production.
- Keeping `customer_id` as a feature after a customer split → you just moved the leak into the model.

## Quiz

1. Why is a random row split wrong here?
2. Name two features that are illegal at arrival.
3. Why can 0.73 honest accuracy be more useful than 0.94 dirty accuracy?
4. What unit should the split use?
5. When may you touch the model again?

> [!question]- Answer key
> 1. Repeat customers leak identity-specific patterns into both sides. 2. Resolution codes and days-to-close (or any post-close note). 3. It estimates the job you will actually run. 4. Customer or thread, with a time cutoff, plus a near-dup rule. 5. After a clean split, a baseline, and a private-slice miss that is clearly a modeling gap.

## Flashcards

Decision time:: The moment the system must act; later fields are illegal.

Unit of split:: The entity (customer, thread, patient) that must not cross train and test.

Identity leakage:: The same real-world entity appearing on both sides of a split.

Post-outcome feature:: A field created by solving the case; using it is leakage.

Honest baseline:: A simple rule evaluated on the same clean split as the model.

## Transfer

- Interview: add this to [[Technical Interview Drills]] drill 6 (offline up, production down) as the data-side twin.
- Concepts: [[Leakage and Contamination]], [[The Training Loop]].
- Portfolio: do not submit this case; rebuild a public dataset with an explicit split spec.
