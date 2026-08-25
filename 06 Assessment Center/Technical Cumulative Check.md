---
title: Technical Cumulative Check
aliases:
  - Builder Cumulative Exam
  - Studio Final Check
type: assessment
family: technical
scope: United States
level:
  - intermediate
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 45
tags:
  - technical-studio
  - assessment
cssclasses:
  - everything-ai
---

# Technical cumulative check

> [!abstract] Outcome
> Closed-note check across the frozen 16 concepts. **16/20** to pass. Write one sentence on every miss before you reopen the note. This is not a credential.

Sit this after week 3 of [[Builder 4-Week Syllabus]], or after any eight concepts plus two cases.

## Rules

1. No notes, no glossary, no answer key.
2. Numbers: show enough arithmetic that a reviewer can recompute.
3. “It depends” without naming the contract is a miss.

## Questions

1. A user question is 40 tokens. System 180, retrieval 1,400, history 900, completion 220. About what fraction of the bill is *not* the question?
2. Why is a random **row** split dangerous on 8,000 tickets from 1,100 customers?
3. TP=20, FP=5, FN=30. Compute precision and recall.
4. Name the three parts of p95 TTFT people forget when they quote a kernel speed.
5. What is a completion reserve?
6. Who is the principal for `issue_credit` authorization — the model or the session user?
7. Recall@5 passes, context-hit fails. Which layer is broken?
8. When is PEFT the *wrong* first intervention for a monthly-changing handbook?
9. Two documents have cosine 0.99 and 1.00 with the query; the 1.00 doc is superseded. What must you add besides the embedding score?
10. Train loss is still falling at epoch 12; held-out F1 peaked at epoch 5. What do you ship?
11. Give two stop conditions for an agent that are not “the user is happy.”
12. Why is a system-prompt refund cap not a control?
13. What does decoding temperature **not** do?
14. A 0.97-confidence bucket is correct 78% of the time. May you auto-approve above 0.95? Why?
15. After W4 PTQ, citation-supported@gold drops 0.80 → 0.71. The SLO allowed −2 points. Ship?
16. Overall defect recall is 0.94; night recall is 0.86 against a 0.98 contract. Ship?
17. Define held-out in one sentence that mentions *editing*.
18. Name one illegal-at-arrival feature on a closed ticket.
19. Hybrid search combines which two families?
20. Calibration temperature scaling vs decoding temperature — one contrast.

## Scoring

1 point each. 16–17 pass with restudy of misses. 18–20 pass clean. Below 16: restudy the missed concept notes; retake after one sleep with the questions in a new order (cover the key and rewrite two items yourself).

> [!question]- Answer key
> 1. (180+1400+900+220)/2740 ≈ 0.985, or “about 96–99% is scaffolding; the question is ~1.5%.” 2. The same customer leaks into both sides (identity leakage). 3. P=20/25=0.80; R=20/50=0.40. 4. Queueing, prefill, admission wait. 5. Tokens you refuse to fill with input so generation can finish. 6. The authenticated session user; bind account_id in the adapter. 7. Packing / ranking into the window, not retrieval@k. 8. When the gap is current attributable knowledge that HR still owns — PEFT becomes a second source of truth. 9. Effective-date / authority filter (and pack current first). 10. The epoch-5 checkpoint, not the last weights. 11. Max steps, token/dollar budget, policy deny, tool-error budget, human cancel. 12. Untrusted context can override it; the model is not a policy engine. 13. Add facts or verify truth. 14. No — that bucket is badly overconfident; the number is not a probability you can gate on. 15. No. −9 points fails the contract; treat W4 as a new model that failed the harness. 16. No. The contract is on the critical slice, not the average. 17. Cases not used to edit the model, prompt, retrieval, or thresholds for this decision. 18. `days_to_close`, `agent_resolution_code`, closer notes. 19. Lexical (term) and dense (embedding). 20. Decoding T reshapes next-token sampling; calibration T rescales classification confidence after the fact.

## Afterward

Miss map → concept note:

| Items | Open |
|---|---|
| 1, 5 | [[Tokens, Context, and Cost]] |
| 2, 17, 18 | [[Leakage and Contamination]], [[Case - Split Integrity]] |
| 3 | [[Metrics That Decide]] |
| 4 | [[Attention, Memory, and Inference]] |
| 6, 11, 12 | [[Structured Outputs and Contracts]], [[The Agent Loop]], [[Untrusted Context and Injection]] |
| 7, 9, 19 | [[Retrieval Quality]], [[Embeddings and Similarity]] |
| 8 | [[Adaptation Methods]] |
| 10 | [[The Training Loop]] |
| 13 | [[Sampling and Decoding]] |
| 14, 20 | [[Calibration]] |
| 15 | [[Quantization]] |
| 16 | [[Vision and Multimodal Systems]], [[Case - Vision Field Slice]] |

Continue: [[Technical Interview Drills]] or a role in [[Technical AI Careers]].
