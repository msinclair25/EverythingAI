---
title: AI Risk and Control Design
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
tags: [ai-careers, core-skills, risk, controls]
cssclasses: [everything-ai]
---

# AI Risk and Control Design

A control changes the likelihood, impact, detectability, or response to a defined risk. A policy sentence without implementation and evidence is not yet a control.

## Risk statement

Use: **Because [cause/threat], [event] may occur in [context], affecting [people/assets/outcome], leading to [consequence].** State uncertainty and affected stakeholders. Separate inherent risk, controls, and residual risk.

## Control specification

| Element | Question |
|---|---|
| Objective | What risk outcome should change? |
| Owner/operator | Who is accountable and who performs it? |
| Trigger/frequency | When does it run? |
| Mechanism | Preventive, detective, corrective, or directive? |
| Input/evidence | What proves operation? |
| Threshold | What passes, fails, or escalates? |
| Exception | Who approves, for how long, with what compensating control? |
| Test | How will design and operating effectiveness be assessed? |

Controls span inventory, use-case approval, data access, vendor due diligence, evaluation gates, least privilege, human approval, monitoring, incident response, documentation, user recourse, and retirement.

## Quiz

1. What distinguishes a policy from an operating control? 2. Preventive vs detective? 3. What is residual risk? 4. Why expire exceptions?

> [!success]- Answers
> 1. A control has an owner, mechanism, trigger, evidence, threshold, and response. 2. Preventive reduces chance before an event; detective identifies an event/condition. 3. Risk remaining after controls. 4. Conditions change and temporary risk acceptance should not become invisible permanent bypass.

## Flashcards

Control objective:: The risk outcome a control is designed to change.

Design effectiveness:: Whether a control is suitably designed to meet its objective.

Operating effectiveness:: Whether the control actually ran as designed with sufficient evidence.

Sources: [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) and [NIST AI RMF Playbook](https://www.nist.gov/itl/ai-risk-management-framework/nist-ai-rmf-playbook), verified 2026-08-12.
