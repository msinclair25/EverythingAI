---
title: Tool Selection and Access Guide
tags:
  - atlas/tools
  - decision-guide
status: published
type: guide
scope: United States
level:
  - beginner
  - intermediate
  - advanced
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
cssclasses:
  - everything-ai
source_policy: official-only
---

# Tool Selection and Access Guide

Choose tools from requirements, not popularity. A strong selection process produces a written scorecard, a reproducible test, and an exit plan.

## The eight-question screen

| Dimension | Ask before testing |
|---|---|
| Outcome | What measurable job must improve, and what is the current baseline? |
| Data | What classifications enter prompts, files, logs, traces, or training sets? |
| Quality | Which accuracy, groundedness, latency, style, and refusal thresholds matter? |
| Control | Must it work offline, in a U.S. region, in a VPC, or on owned hardware? |
| Integration | Which languages, APIs, identity systems, data stores, and export formats are required? |
| Operations | Who owns monitoring, incident response, upgrades, evaluation, and rollback? |
| Economics | What are the unit, seat, storage, egress, support, and human-review costs at expected volume? |
| Exit | Can prompts, data, traces, embeddings, model artifacts, and workflows be exported? |

~~~mermaid
flowchart TD
    A["Define task and baseline"] --> B["Classify data and risk"]
    B --> C{"Can public or synthetic data test it?"}
    C -->|"No"| D["Obtain security/legal approval first"]
    C -->|"Yes"| E["Test free or open option"]
    D --> E
    E --> F["Run fixed evaluation set"]
    F --> G{"Meets acceptance thresholds?"}
    G -->|"No"| H["Change configuration or shortlist"]
    H --> F
    G -->|"Yes"| I["Estimate total cost at 1x, 10x, 100x"]
    I --> J["Review terms, controls, accessibility, and exit"]
    J --> K["Time-boxed pilot with monitoring"]
~~~

## A simple weighted scorecard

Score each candidate from 1–5. Set weights *before* seeing results.

| Criterion | Example weight | Evidence |
|---|---:|---|
| Task quality on held-out examples | 30% | Blind rubric or automated metric plus human review |
| Security, privacy, and administration | 20% | Official security docs, contract, configuration test |
| Reliability and latency | 15% | Repeated load test including failures |
| Total cost of ownership | 15% | Volume model including labor and review |
| Integration and portability | 10% | Prototype plus export/restore test |
| Accessibility and user experience | 5% | Keyboard/screen-reader/user testing |
| Vendor/project viability and support | 5% | Release cadence, support terms, incident channels |

> [!example] Acceptance gate
> “At least 92% rubric pass rate, no critical security finding, p95 latency under the workflow threshold, complete audit log, and successful export/restore” is testable. “Best AI” is not.

## Free-first ladder

1. **Learn the concept locally:** small public dataset, Jupyter, open-source libraries, and a small local model when hardware allows.
2. **Prototype on a free tier:** use synthetic data, strict spend limits, and a fixed evaluation set.
3. **Pay only for the bottleneck:** stronger model, managed GPU, collaboration, compliance control, or support.
4. **Enterprise only when requirements justify it:** SSO/SCIM, contractual privacy, audit, private networking, data residency, indemnity, procurement, or guaranteed support.

## “Free” traps to check

- The software is free but GPU, storage, backup, engineering, patching, and monitoring are not.
- A free hosted plan may permit provider training or have different retention terms.
- Open weights may restrict commercial use, derivatives, users, fields of use, or redistribution.
- Credits expire, exclude certain models, or require a card.
- Agentic actions, premium models, search grounding, connectors, and API access may use separate meters.
- A plan may be free for individuals but not teams, contractors, or commercial deployment.

## Minimum proof-of-concept record

- task, owner, date, product/version/plan, model/version, region;
- test data provenance and classification;
- prompts/configuration and source commit;
- success, failure, safety, bias, and accessibility cases;
- latency and cost units;
- security and privacy review;
- export/rollback result;
- decision, expiry date, and reviewer.

See [[Evaluation and Observability]], [[Security and Red Teaming]], and [[Governance and Compliance]].
