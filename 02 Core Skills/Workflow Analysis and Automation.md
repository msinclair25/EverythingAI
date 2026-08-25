---
title: Workflow Analysis and Automation
type: skill
family: knowledge-and-operations
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, core-skills, automation, workflows]
cssclasses: [everything-ai]
---

# Workflow Analysis and Automation

Automate a controlled process, not a vague collection of tasks.

## Map first

Record trigger, actor, input/source, decision, system of record, handoff, queue, wait, exception, approval, output/destination, metric, and failure response. Measure volume, variation, cycle time, error/rework, sensitivity, and consequence.

## Choose the mechanism

| Need | Prefer |
|---|---|
| exact repeatable rules | ordinary code or rules engine |
| app-to-app movement | API/integration automation |
| uncertain text/image judgment | bounded model step + validation |
| path cannot be predetermined | narrowly scoped agent after evidence |

## Control pattern

Validate input → authorize identity/action → execute idempotently → validate output → stage/approve consequential result → write to system of record → log outcome → route exception. Define retry, timeout, duplicate, partial completion, rollback, and manual continuity.

## Quiz

1. Why map exceptions before automating? 2. When is an agent unnecessary? 3. What is a system of record? 4. Why design manual continuity?

> [!success]- Answers
> 1. Exceptions often hold the risk and hidden labor. 2. When deterministic steps/rules handle the process. 3. The authoritative source for a data object or business state. 4. Providers and automation fail; essential work needs a safe fallback.

## Flashcards

Workflow trigger:: The event or condition that starts a process.

Exception path:: Defined handling when routine rules cannot safely complete work.

System of record:: The authoritative system for a data object or transaction state.

Next: [[AI Automation Specialist]] and [[AI Business Analyst]].
