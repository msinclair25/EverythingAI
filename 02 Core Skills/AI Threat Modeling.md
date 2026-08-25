---
title: AI Threat Modeling
type: skill
family: trust-policy-assurance
scope: United States
level:
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, core-skills, security, threat-modeling]
cssclasses: [everything-ai]
---

# AI Threat Modeling

Threat modeling identifies how actors or failures can cross trust boundaries and what evidence will show controls work.

## Method

1. diagram data, model, user, provider, retrieval, tool, memory, logging, and human boundaries;
2. inventory assets and business/safety consequences;
3. identify actors, access, incentives, and plausible capabilities;
4. enumerate misuse and failure paths by lifecycle stage;
5. prioritize with likelihood, impact, exposure, detectability, and uncertainty;
6. design least-privilege prevention, detection, response, and recovery;
7. test abuse cases and update after architecture or incident changes.

## AI attack surfaces

Training/tuning data, model artifacts, dependency supply chain, APIs, prompts, retrieved content, embeddings/indexes, tool arguments/results, memory, generated code/content, feedback systems, model logs, and human review.

## Scenario pattern

**Actor** uses **entry point** to exploit **weakness**, causing **system behavior/asset impact**; **control** should prevent/detect/respond, verified by **test/evidence**.

Test indirect injection, exfiltration, tool escalation, cross-tenant leakage, poisoned knowledge, evasion, extraction, denial/cost exhaustion, unsafe output handling, and insider/vendor compromise as relevant.

## Quiz

1. What is a trust boundary? 2. Why include human review in the diagram? 3. What does least privilege limit? 4. When should the threat model change?

> [!success]- Answers
> 1. A point where data/control crosses different authority or trust assumptions. 2. Reviewers can receive manipulated evidence, disclose data, or lack authority/time. 3. Access, data, tools, actions, duration, and blast radius. 4. Architecture, data, users, tools, vendors, threats, incidents, or use context change.

## Flashcards

Trust boundary:: A transition between components or actors with different authority and assumptions.

Attack surface:: The set of reachable interfaces, data, components, and operations that can be exploited.

Blast radius:: The maximum scope of impact from a compromise or failure.

Sources: [NIST Adversarial ML taxonomy](https://csrc.nist.gov/pubs/ai/100/2/e2023/final) and [MITRE ATLAS](https://atlas.mitre.org/), verified 2026-08-12.
