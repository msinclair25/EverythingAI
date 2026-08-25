---
title: Technical Interview Drills
aliases:
  - Technical AI Interview Drills
  - Studio Interview Drills
type: assessment
family: technical
scope: United States
level:
  - intermediate
  - advanced
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
estimated_minutes: 90
tags:
  - technical-studio
  - interview
  - assessment
cssclasses:
  - everything-ai
---

# Technical interview drills

> [!abstract] Outcome
> Practice the same decisions as [[Technical Studio]] under interview pressure. Speak for 8–12 minutes, then grade with the rubric in [[How to Study a Technical Case]]. This note thickens [[Technical AI Interview Guide]] with worked answers; it does not replace role-specific questions.

Work closed-note. Record yourself if you can. Do not open the model answer until you have stated a contract, baseline, metric, risk, and rollback.

## Drill 1 — Adaptation choice · 10 minutes

**Prompt.** “Employees keep getting the wrong commuter stipend. Would you prompt-tune, add RAG, or fine-tune?”

**Strong answer shape**

- Restate the contract: current authorized policy, citations, abstain, latency.
- Ask what the misses are. If they are current numbers, the gap is knowledge.
- Baseline: current prompt-only, measured on held-out cases.
- RAG first when knowledge is private, changing, and must be attributed.
- Fine-tune only for stable behavior/format after retrieval is adequate.
- Name a slice: recently updated policies.
- Rollback: return retrieved spans and a human ticket.

**Weak answer.** Names a vendor, starts with LoRA, or says “we’ll do all three.”

Worked depth: [[Case - Prompt RAG Fine-Tune]].

## Drill 2 — Ship or stop · 10 minutes

**Prompt.** “Prompt B is 0.91 accurate vs 0.84. Do we ship Friday?”

**Strong answer shape**

- Ask what decision, what population, whether the 0.91 set was used to edit.
- Separate accuracy from the costly slice (appeals, safety, money).
- Demand held-out + uncertainty + human agreement.
- LLM-judge is shadow until calibrated.
- Hold if those are missing. Offer a 3-day labeling plan, not a vibe.

**Weak answer.** “91% is good” or “let’s A/B in prod with no rollback.”

Worked depth: [[Case - Evaluation Harness]].

## Drill 3 — Agent refund · 12 minutes

**Prompt.** “Design an agent that can issue goodwill credits.”

**Strong answer shape**

- Capability ≠ authority. Principal is the authenticated user.
- Bind account id from the session. Prompt caps are not controls.
- Action classes: read / ticket / money, with caps, velocity, idempotency.
- Human approval above a low automatic threshold.
- Eval: injection corpus, cross-account, duplicate credit, traces.
- Kill switch for write tools.

**Weak answer.** “We’ll put the limit in the system prompt and add a critic agent.”

Worked depth: [[Case - Agent Permissions]].

## Drill 4 — Capacity napkin · 12 minutes

**Prompt.** “40 concurrent streams, 1,200-token prompts, 200-token answers, p95 TTFT 800 ms. One GPU. Go.”

**Strong answer shape**

- Write formulas: prefill ≈ tokens / prefill_rate; decode ≈ tokens / per-seq rate at batch; KV ≈ seqs × tokens × bytes.
- p95 TTFT includes queue.
- Advertised max context ≠ working context at concurrency.
- Name the binding constraint before spending money.
- Quality gate sits beside latency. A fast wrong model fails the contract.

**Weak answer.** Quotes a blog tokens/s number and ignores memory and queueing.

Worked depth: [[Case - Serving Capacity]].

## Drill 5 — Wrong citation · 10 minutes

**Prompt.** “It cited the PDF but the number is wrong. Is the model hallucinating?”

**Strong answer shape**

- Decompose: indexed? retrieved? packed? used? licensed by the *effective* doc?
- Distinguish cited-span support from current-authority support.
- Check freshness SLO and stale-rank.
- Fix authority filters and packing before swapping models.
- Add the item to a private eval slice.

**Weak answer.** “Turn temperature down” or “fine-tune the correct number in.”

Worked depth: [[Case - Retrieval Failure Autopsy]].

## Drill 6 — Offline up, production down · 10 minutes

**Prompt.** “Offline eval improved. Complaints went up. Diagnose.”

**Strong answer shape**

- Training/eval contamination or mix shift.
- Slice that production cares about was not in the offline set.
- Latency/timeouts change the user-visible system.
- Retrieval corpus or permissions drifted.
- Judge/model family shared bias with the system under test.
- Plan: compare production traces to offline items; freeze a new private set; do not keep tuning against the rising score.

**Weak answer.** “Need a bigger model.”

Related: [[12 Evaluation Testing and Observability]], [[Case - Evaluation Harness]].

## Drill 7 — Build vs buy serving · 8 minutes

**Prompt.** “Should we self-host the 8B or keep the hosted API?”

**Strong answer shape**

- Decision factors: data rights, quality vs teacher, SLO, idle cost, talent, vendor exit.
- Run the capacity napkin and the quality set **before** buying GPUs.
- Self-host when control, cost at scale, or data residency dominates *and* quality clears the gate.
- Stay hosted when quality/calendar dominate or occupancy is low.
- Require an exit path either way (schemas, traces, evals not vendor-locked).

Related: [[Case - Serving Capacity]], [[13 Deployment MLOps and Economics]].

## Drill 8 — Research vs engineering evidence · 8 minutes

**Prompt.** “This paper beats the baseline by 3 points. Should we adopt the method?”

**Strong answer shape**

- What is the claim, the split, the compute, the ablations?
- Does the paper’s distribution match our task?
- What would falsify the claim in *our* harness?
- Implementation risk and operational cost.
- A 3-point paper gain that ignores serving and safety is not a roadmap.

Related: [[AI ML Research Scientist]], [[Research Engineer]], [[Technical Role Deep Dive Framework]].

## Drill 9 — Dirty 0.94 · 10 minutes

**Prompt.** “Random 80/20 split, accuracy 0.94, ship Friday?”

**Strong answer shape**

- Ask the unit (customer vs row) and decision time.
- Name illegal post-outcome features.
- Demand a time split and a private slice.
- Accuracy is not the gate if appeal misses are costly.
- Hold and rebuild the dataset. Do not tune.

**Weak answer.** “Add dropout and train longer.”

Worked depth: [[Case - Split Integrity]].

## Drill 10 — Lower the temperature · 6 minutes

**Prompt.** “Users say it hallucinates. Should we set temperature to 0?”

**Strong answer shape**

- Temperature changes variety, not knowledge.
- Greedy can still emit a fluent wrong number.
- Ask whether the fact should come from retrieval or a tool.
- For JSON, use a schema, not T.
- Name decoding settings on every eval.

**Weak answer.** “Temperature 0 makes it factual.”

Worked depth: [[Sampling and Decoding]], [[Adaptation Methods]].

## Self-score

Use the 12-point rubric in [[How to Study a Technical Case]]. After each drill, write one sentence you would *not* say next time.

## Coding companion

If the loop includes a coding screen, practice these without a framework:

- schema-validate a model response and retry once;
- compute precision/recall/F1 from a list of pairs;
- write a retrieval recall@k helper;
- implement an idempotency key and a replay-safe credit function;
- SQL: latest effective policy row for a given date.

Readable tests matter more than cleverness. See [[03 Python SQL Git and Software Foundations]].

## Continue

Return to [[Technical AI Interview Guide]] for domain coverage, then pick a project from [[Project Bank]] that produces original numbers.
