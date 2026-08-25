---
title: Financial Services and Insurance AI
type: industry-overlay
scope: United States
level: [advanced]
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-09-12
tags: [ai-careers, industry, finance, insurance]
cssclasses: [everything-ai]
---

# Financial Services and Insurance AI

> [!warning] Not legal, compliance, or credit advice
> This overlay teaches issue-spotting. Live products need the institution’s risk, compliance, legal, and model-risk partners and current regulator text.

Add model-risk discipline, independent challenge, consumer protection, fair lending/insurance questions, explanations/records, third-party risk, fraud/adversaries, and change control.

## Why this overlay exists

A chatbot that explains a fee and a model that **prices credit** are not the same job. The second has adverse-action, documentation, and often **effective challenge** by people who did not build it.

## Contexts (do not mix)

Credit underwriting/pricing, fraud/AML, trading, insurance underwriting/claims, service, document intelligence, marketing, collections, and internal productivity. Investigate ECOA/Regulation B, FCRA, fair housing, banking/securities/insurance authority, privacy, and state insurance rules **as applicable**. Do not copy a fintech tweet into a bank.

## Illegal shortcuts (teaching)

- Shipping an LLM underwriting narrative with no reason-code process.
- Training on another bank’s consumer file you do not have rights to.
- Using production labels that include the *human’s later default* as if it were known at decision time ([[Case - Split Integrity]]).
- “The vendor is SOC 2” as the entire third-party story.
- Tuning the threshold on the private fair-lending slice until it looks fine.

## Worked teaching decision

**Northline Credit — teaching scenario.** Product wants an LLM to write the “reasons” on a declined credit line, using the existing scorecard’s inputs.

Contract:

- The **scorecard** remains the decisioning model. The LLM does not change approve/deny.
- Reasons must be **faithful to the features that actually moved the score**, not a fluent story.
- Adverse-action language is a compliance template plus filled reasons — not free generation.
- Eval: 200 historical declines; two independent reviewers score “reason licensed by the scorecard.” Gate ≥ 0.95. Invented reasons = severity-1.
- Logs retain model/prompt/score versions for the record-retention clock the bank already has.

**Ship:** retrieval/template fill from the scorecard explanation payload; schema-validated reason codes ([[Structured Outputs and Contracts]]).  
**Do not ship:** an unconstrained chat that “explains the decline in a friendly way.”

If product later wants the LLM **to be** the score, that is a new model subject to the institution’s model-risk standard (SR 11-7 is the usual teaching landmark). That is a quarter, not a sprint.

## Evidence (model-risk shape)

Conceptual soundness; data lineage; outcomes vs benchmark; stability; [[Calibration]]; overrides; adverse-action/explanation; subgroup impact; challenger; backtesting; limitations; materiality/change; monitoring; **effective challenge** by a party that can say no.

## Suggested projects

- Beginner: compare fraud precision/recall under three base rates and a fixed review-staff capacity ([[Metrics That Decide]]).
- Intermediate: independent validation plan for an AI document-extraction component (not the credit model).
- Advanced: GenAI model-risk tiering and monitoring pack for customer communications — no live customer data.

## Quiz

1. Why must an LLM “reason” be licensed by the scorecard?
2. What is effective challenge?
3. Give a temporal leak in a default model.
4. When is SOC 2 not enough?

> [!question]- Answer key
> 1. Adverse-action reasons that the model did not use are a consumer-protection and records failure, not a style issue. 2. Independent people with authority to reject or limit the model. 3. Using post-decision “charged-off” fields or future bureau attributes at application time. 4. When you have not mapped *this* use, data rights, subprocessors, and residual model risk.

## Flashcards

Adverse action:: A negative credit/insurance decision that may require specific notices and reasons.

Effective challenge:: Independent review with real power to stop or limit a model.

Reason licensed by the model:: An explanation that uses features that actually drove the score.

Model-risk tiering:: Ranking uses by impact so evidence matches consequence.

## Sources

Institution/regulator requirements first. Durable landmark: [Federal Reserve SR 11-7](https://www.federalreserve.gov/supervisionreg/srletters/sr1107.htm). Verify current applicability. Accessed 2026-08-12.

Next: [[Model Risk Manager]] · [[Case - Split Integrity]]
