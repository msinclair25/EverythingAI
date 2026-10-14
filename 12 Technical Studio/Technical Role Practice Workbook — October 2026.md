---
title: Technical Role Practice Workbook — October 2026
type: workbook
scope: United States
level: [beginner, intermediate, advanced]
status: current
as_of: 2026-10-13
last_verified: 2026-10-13
review_by: 2026-11-13
tags: [technical-studio, career/technical, portfolio, interview]
cssclasses: [everything-ai]
---

# Technical Role Practice Workbook — October 2026

> [!abstract] Understand the work, not just the title
> For your role, explain the decision you own, produce an inspectable artifact, and defend it against a failure case. These are original learning exercises—not a claim that every employer uses the same responsibilities or interview format.

Pair your role profile with [[October 2026 Research Refresh]]. Read [[Model and Agent Lifecycle Management]], [[Cloud AI Operations — October 2026]], and one new case before choosing an artifact.

## Three levels of evidence

- **Beginner:** explain a worked example and recompute its numbers. Label assumptions and define the jargon in ordinary language.
- **Intermediate:** compare two candidate designs with synthetic or properly licensed data, a baseline, and a held-out evaluation.
- **Advanced:** add failure injection, operational limits, privacy/security boundaries, uncertainty, recovery, and a defensible go/no-go decision.

Progress is not measured by how many APIs you call. A small honest result is stronger evidence than an impressive demo whose data, permissions, and failure modes you cannot explain.

## Model and application engineering

| Role | Decision you own in this exercise | Artifact to produce | Reviewer challenge |
|---|---|---|---|
| [[AI Engineer]] | Whether a provider migration preserves the product contract | Paired evaluation and release memo | Which regression blocks release despite a better mean? |
| [[ML Engineer]] | Whether a model change generalizes to deployment data | Split manifest, baseline, slice report | What happens under training/serving skew? |
| [[LLM Engineer]] | Prompt/retrieval/adaptation tradeoff under a budget | Ablation table and exact configuration | What evidence rules out a simpler intervention? |
| [[Agentic AI Engineer]] | What the agent may remember and execute | State machine, action policy, replay tests | What survives a crash or malicious memory write? |
| [[RAG and Knowledge Engineer]] | Whether retrieved evidence is relevant and authorized | Retrieval/generation error decomposition | Can a revoked document still appear in cache? |
| [[NLP Engineer]] | Whether routing or extraction works across language slices | Label guide, confusion matrix, abstention curve | Does valid structure conceal wrong meaning? |
| [[Computer Vision Engineer]] | Whether field performance matches test performance | Lighting/device/site slices and threshold rationale | Which false negative is operationally unacceptable? |
| [[Speech AI Engineer]] | Whether streaming speech quality supports the workflow | Accent/noise/latency slices and interruption tests | Does low word error rate hide a critical entity error? |
| [[Robotics and Embodied AI Engineer]] | When uncertain perception must stop action | Simulated safety envelope and recovery policy | How do you prevent language output bypassing a controller? |

## Data and research

| Role | Decision you own in this exercise | Artifact to produce | Reviewer challenge |
|---|---|---|---|
| [[Data Scientist - AI ML]] | Whether a routing improvement is real and useful | Paired analysis, uncertainty, business-impact memo | What changed in the denominator or case mix? |
| [[ML Data Engineer]] | Whether records and features are traceable and deletable | Lineage map, schema checks, deletion test | Can one poisoned source contaminate several derived stores? |
| [[Synthetic Data Engineer]] | Whether synthetic examples improve held-out real-task performance | Provenance, deduplication, utility/privacy assessment | Did the generator leak evaluation examples into training? |
| [[Applied Scientist]] | Which hypothesis explains the measured gain | Controlled ablation and error analysis | What alternative explanation remains? |
| [[AI ML Research Scientist]] | Whether a claimed contribution survives fair comparison | Reproducible experiment and compute-normalized baseline | Are tuning budgets and selection procedures comparable? |
| [[Research Engineer]] | Whether an experiment can be reliably reproduced | Environment, data/version manifest, restart test | Can another person reproduce the result without your machine? |
| [[AI Safety and Alignment Researcher]] | Whether a safety intervention generalizes beyond known tests | Threat model, held-out attacks, utility tradeoff | Did the evaluator reward refusal while missing harmful actions? |

## Infrastructure, measurement, and security

| Role | Decision you own in this exercise | Artifact to produce | Reviewer challenge |
|---|---|---|---|
| [[MLOps Engineer]] | Whether model/prompt/data changes can be safely released | Versioned gate, canary, recovery record | What if the old endpoint is already retired? |
| [[AI Platform Engineer]] | Which identity and capacity defaults teams inherit | Tenant contract, quotas, negative tests | Can a valid caller select another user's delegated identity? |
| [[Inference and Performance Engineer]] | Which batching/routing policy meets quality and tail latency | Load model, p95/p99, cost per successful task | Do retries create more load than the rejected traffic? |
| [[AI Hardware and Accelerator Engineer]] | Which resource limits dominate the workload | Memory/bandwidth/compute budget and measured bottleneck | Is the optimization useful end to end or only in a kernel? |
| [[AI Evaluation Engineer]] | Whether a score can justify a release decision | Dataset, grader version, disagreement and slice report | What breaks when the hosted evaluation service disappears? |
| [[AI Security Engineer]] | Whether identity, tool, memory, and egress controls hold | Threat-to-control-to-test matrix | Which enforcement point exists outside the model? |
| [[AI Red Teamer]] | Whether a realistic attack crosses a defined boundary | Authorized synthetic scenario, control evidence, remediation retest | Was it a proposed action, blocked attempt, or actual effect? |

## Cross-role handoff exercise

A support agent misroutes a high-risk request, calls a tool, and persists the result. The user then receives the same wrong recommendation next week.

1. The **application/agent engineer** identifies the state and action contract.
2. The **evaluation/data team** decomposes routing, retrieval, generation, and persistence errors.
3. The **security team** determines whether authority or data boundaries were crossed.
4. The **platform/MLOps team** contains the affected capability and repairs release/recovery controls.
5. The **product/domain owner** decides the acceptable service mode and user communication.

Do not assign the entire incident to “the model team.” Write each handoff as an input, expected output, owner, and acceptance criterion.

## Four-week study sprint

| Week | Study work | Evidence |
|---|---|---|
| 1 | Explain your role, inputs, outputs, and boundaries | One-page role map plus a glossary of ten terms |
| 2 | Work one case and compare two designs | Checkable calculations and failure analysis |
| 3 | Propose a small portfolio project | Dataset rights, baseline, metrics, negative tests, scope |
| 4 | Defend a decision in a mock interview | Ten-minute explanation, evidence appendix, honest limitations |

This is a learning schedule, not a promise of employability in four weeks. Background prerequisites vary widely, especially for research, robotics, and accelerator roles.

## Assessment rubric

Score 0–2 each: problem definition, correct mechanism, evidence quality, risk boundaries, operational recovery, and communication. **10/12** is a suggested study checkpoint, not a credential. Rework any answer that fabricates measurements, hides data leakage, or treats a model output as authorization regardless of total score.

## Quiz and answers

1. **What distinguishes a role artifact from a tool demo?** A decision, owner, measurable contract, and failure evidence.
2. **Why use a baseline?** To establish whether added complexity improves the task.
3. **Why record failed approaches?** They explain the decision and constrain exaggerated claims.
4. **Can reading this workbook certify job readiness?** No; readiness requires applied evidence, prerequisites, and the employer's actual scope.

## Flashcards

Role boundary::The decisions and outcomes a role owns, including explicit handoffs to others.
Portfolio evidence::Inspectable artifacts connecting a problem, method, result, limitation, and decision.
Ablation::Changing or removing a component to test whether it contributes to the result.
Failure decomposition::Separating error sources so interventions target the actual cause.
Evidence honesty::Clearly distinguishing measured results, constructed examples, assumptions, and untested claims.
Operational ownership::Responsibility for deployment behavior, monitoring, failure handling, and recovery after the demo.
