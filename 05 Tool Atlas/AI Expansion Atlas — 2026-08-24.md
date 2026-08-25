---
title: AI Expansion Atlas — 2026-08-24
aliases:
  - AI Expansion Areas
  - Next AI Domains
  - AI Capability Expansion Atlas
type: hub
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: current
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
tags:
  - ai-careers
  - ai/platform
  - ai/security
  - ai/research
  - ai/learning-path
cssclasses:
  - everything-ai
source_policy: official-first
---

# AI Expansion Atlas — 2026-08-24

> [!abstract] Why this atlas exists
> The vault already covers foundations, RAG, agents, evaluation, security, multimodal AI, robotics, synthetic data, governance, industries, and major cloud platforms. This atlas adds the cross-cutting areas that increasingly determine whether an AI system works outside a demo: interoperability, reliability, local execution, provenance, reasoning economics, document intelligence, privacy, infrastructure sustainability, coding agents, physical AI, scientific discovery, and realtime interaction.

Use this page as a map, not as a replacement for the deeper notes. The delivery-and-operations companion is [[AI DevOps and Cloud Engineering — 2026-08-24]]. The interoperability deep dive is [[MCP Deep Dive — 2026-08-24]]. The companion security dossier is [[OWASP and AI Security — 2026]] and the worked assessment is [[Case - OWASP Agentic Security Review]].

## The expanded AI system

~~~mermaid
flowchart TB
    D["Data, documents, sensors, users"] --> M["Models and multimodal encoders"]
    M --> R["Reasoning, retrieval, memory, and tools"]
    R --> A["Agents, workflows, and inter-agent protocols"]
    A --> X["Execution: cloud, edge, device, robot, browser"]
    X --> O["Outputs, decisions, actions, and media"]
    O --> E["Evaluation, observability, security, provenance"]
    E --> D
    P["People, policy, accessibility, and governance"] -.-> A
    P -.-> X
    C["Cost, latency, energy, and reliability envelope"] -.-> M
    C -.-> X
~~~

The useful question is not “Which model is best?” It is “Which system boundary, evidence, and operating constraints make this task safe and valuable?”

## Twelve areas to add to an AI career study plan

| Area | What to understand | Primary roles | First artifact |
|---|---|---|---|
| Agent interoperability, identity, and trust | MCP, A2A, agent cards, delegation, task state, authorization, discovery, conformance | [[Agentic AI Engineer]], [[AI Platform Engineer]], [[AI Security Engineer]], [[MLOps Engineer]] | [[MCP Deep Dive — 2026-08-24]]; MCP server plus A2A client with signed identity and trace IDs |
| AI reliability, incident response, and AI SRE | SLOs, drift, change control, field monitoring, incident taxonomy, rollback, kill switches | [[AI Platform Engineer]], [[MLOps Engineer]], [[AI Evaluation Engineer]], [[AI Security Engineer]] | [[AI DevOps and Cloud Engineering — 2026-08-24]]; incident game day and production runbook |
| On-device, edge, and private AI | NPUs, local models, split inference, offline behavior, privacy, updates, hardware-aware evaluation | [[AI Engineer]], [[ML Engineer]], [[Inference and Performance Engineer]], [[AI Platform Engineer]] | Same feature routed local-first and cloud-fallback |
| Provenance, authenticity, and AI supply chain | C2PA, model/data lineage, AIBOM, licenses, attestations, synthetic-data disclosure | [[AI Security Engineer]], [[ML Data Engineer]], [[AI Governance Specialist]], [[AI Product Manager]] | Dataset-to-output provenance chain |
| Reasoning systems and inference-time compute | Test-time scaling, verifiers, search, routing, process/outcome evidence, cost-quality trade-offs | [[LLM Engineer]], [[AI Evaluation Engineer]], [[Inference and Performance Engineer]], [[Applied Scientist]] | Fixed-budget reasoning benchmark |
| Document intelligence and knowledge extraction | OCR, layout, tables, forms, document VQA, structured extraction, citation fidelity | [[RAG and Knowledge Engineer]], [[Computer Vision Engineer]], [[ML Data Engineer]], [[AI Engineer]] | Evidence-grounded document pipeline |
| Privacy-preserving and confidential AI | Differential privacy, federated learning, TEEs, private retrieval, inversion and membership attacks | [[AI Security Engineer]], [[ML Engineer]], [[AI Compliance and Privacy Specialist]], [[Applied Scientist]] | Privacy threat model and utility/privacy curve |
| Infrastructure economics, energy, and sustainability | Memory, batching, accelerators, capacity, unit cost, carbon, water, data-center constraints | [[AI Platform Engineer]], [[Inference and Performance Engineer]], [[MLOps Engineer]], [[AI Product Manager]] | Quality/cost/latency/energy decision record |
| AI-native software engineering and coding agents | Repository context, plans, tests, CI, code review, tool scopes, secure supply chain, developer outcomes | [[AI Engineer]], [[Agentic AI Engineer]], [[AI Security Engineer]], [[AI Product Manager]] | Sandboxed coding agent with regression evidence |
| Physical AI, world models, and simulation | Perception, world prediction, action models, simulation, sim-to-real, embodied safety | [[Robotics and Embodied AI Engineer]], [[Computer Vision Engineer]], [[AI ML Research Scientist]], [[AI Safety and Alignment Researcher]] | Simulated task with safety envelope and transfer report |
| AI for science and verified discovery | Active learning, uncertainty, formal verification, reproducibility, lab and simulation loops | [[Applied Scientist]], [[AI ML Research Scientist]], [[Research Engineer]], [[Data Scientist - AI ML]] | Reproducible discovery notebook with expert checks |
| Realtime voice, video, and interactive agents | Streaming, WebRTC, VAD, turn-taking, interruption, diarization, live vision, consent | [[Speech AI Engineer]], [[Conversation Designer]], [[AI UX and Product Designer]], [[AI Engineer]] | Realtime assistant with latency and consent budget |

## 1. Agent interoperability, identity, and trust

### Mental model

MCP is primarily a model-to-tool and model-to-context connection layer. A2A is an agent-to-agent collaboration layer. Identity and authorization answer who is calling, on whose behalf, with which capability and budget. A protocol does not automatically make an integration safe: the server, client, identity provider, tool policy, and audit trail still need to be designed.

### Study questions

- What does an agent card advertise, and what must remain out of discovery metadata?
- How do delegated user permissions differ from the agent's service identity?
- Which tasks may be asynchronous, resumable, cancellable, or human-approved?
- How are tool descriptions, versions, schemas, and dependencies pinned and attested?
- What happens when a remote agent lies, disappears, replays a task, or returns a valid-looking artifact?

### Free-first and paid tools

Use the MCP SDKs, local HTTP services, JSON Schema, OAuth test providers, OpenTelemetry, and a small synthetic tool set first. Managed agent gateways, enterprise identity, policy enforcement, and commercial agent registries become useful when there are many teams, tenants, or external partners.

### Project

Build two narrow agents: a read-only policy researcher and a deterministic policy checker. Connect them over A2A, expose one MCP retrieval server, issue short-lived delegated credentials, sign an agent card, and record a trace for discovery, task, tool, approval, and artifact events.

## 2. AI reliability, incident response, and AI SRE

AI SRE treats probabilistic behavior as an operating concern. Define a service-level objective for the user outcome, not only uptime: grounded-answer rate, safe-action rate, approval burden, latency, cost, and recovery time. Monitor model, prompt, retrieval, tool, data, policy, and workflow changes as separate dimensions.

Study pre-deployment evidence, canary releases, shadow traffic, drift, judge calibration, field studies, incident severity, customer notification, rollback, kill switches, and post-incident learning. Keep a model/system version with every trace. A fluent answer can be a reliability failure if it causes an incorrect or irreversible action.

### Project

Run a synthetic support agent through a deploy, provider outage, stale index, tool timeout, prompt change, cost spike, and unsafe-output incident. Produce an on-call runbook, dashboard specification, incident timeline, root-cause analysis, rollback choice, and regression set.

## 3. On-device, edge, and private AI

On-device AI trades model size and capability for privacy, offline resilience, predictable latency, and reduced cloud dependence. Learn hardware-aware quantization, memory pressure, thermal limits, model packaging, secure update, local retrieval, fallback routing, and how an OS update can change a system model.

Design three modes: local-only, local-preferred with cloud fallback, and cloud-only. Each mode needs a separate evaluation set because privacy, latency, context size, tool support, and failure behavior differ.

### Project

Ship a local-first document summarizer with a cloud fallback. Measure quality, latency, battery/energy proxy, token cost, data exposure, and behavior when the device is offline or the local model is unavailable.

## 4. Provenance, authenticity, and AI supply chain

Provenance is the evidence of where data, models, prompts, tools, and outputs came from and what changed. Teach content credentials, signed manifests, dataset versions, model hashes, dependency inventories, licenses, training-data statements, human edits, and disclosure of synthetic or transformed media.

Treat an AI system as a supply chain: base model, adapter, tokenizer, data, embedding model, vector index, prompt, tool package, runtime, container, and policy. An AI Bill of Materials (AIBOM) makes that chain searchable during procurement and incident response.

### Project

Create an AIBOM for a small open model and retrieval application. Verify hashes, capture licenses, sign the release, attach evaluation evidence, generate a Content Credential for one output, then simulate a compromised dependency and identify affected deployments.

## 5. Reasoning systems and inference-time compute

Reasoning quality is not the same as a hidden chain of thought. Study observable plans, tool traces, intermediate artifacts, verifiers, search, self-consistency, reranking, routing, and external checks. Compare more test-time compute with a larger model, a better retriever, a deterministic solver, or a human review step.

Measure success, error severity, calibration, latency, token/compute budget, and judge agreement. A system that improves accuracy by spending ten times as much may be a worse product; a system that is cheaper but fails on rare high-impact slices may be unsafe.

### Project

Benchmark three strategies on a fixed set: direct answer, budgeted reasoning plus verifier, and tool-assisted solution. Report quality by slice, cost, p95 latency, abstention, and the failure that reverses the choice.

## 6. Document intelligence and knowledge extraction

Document AI is the bridge between messy enterprise evidence and a reliable knowledge system. Learn OCR, layout and reading order, tables, forms, handwriting, charts, document VQA, field confidence, schema validation, citation spans, redaction, versioning, and deletion. RAG quality is bounded by ingestion quality.

A robust pipeline preserves page, section, table, bounding-box, source, effective date, access label, and extraction confidence. It can abstain when a scan is unreadable or a field is ambiguous.

### Project

Build a synthetic claims-document pipeline that extracts fields, cites page regions, rejects low-confidence values, applies document ACLs, and measures extraction accuracy separately from answer quality.

## 7. Privacy-preserving and confidential AI

Learn the difference between policy privacy and technical privacy. Technical tools include data minimization, de-identification, differential privacy, federated learning, secure aggregation, trusted execution environments, confidential GPUs, private retrieval, and encrypted or split inference. Threats include membership inference, model inversion, reconstruction, linkage, prompt leakage, and cross-tenant memory.

For every privacy claim, state the protected population, attacker, auxiliary information, trust assumptions, measurable guarantee, utility cost, and failure response.

### Project

Compare centralized training, federated training, and a synthetic-data baseline on a toy sensitive dataset. Plot utility, privacy budget, communication cost, attack success, and operational complexity.

## 8. Infrastructure economics, energy, and sustainability

AI systems consume more than model tokens: storage, vector operations, retrieval, tool calls, GPU reservation, egress, observability, human review, and incident response all belong in the unit-cost model. Capacity planning includes memory bandwidth, batching, concurrency, queueing, cold starts, accelerator availability, and regional placement.

Add energy and water proxies to design reviews. Choose a model or platform with evidence about quality, cost, latency, availability, data locality, energy, and exit cost rather than chasing a single benchmark.

### Project

Create a three-provider routing policy for a synthetic workload. Optimize for a stated quality floor, p95 latency, monthly budget, and energy proxy. Include a fallback and show how the decision changes when demand doubles.

## 9. AI-native software engineering and coding agents

Coding agents combine repository context, planning, file edits, shell tools, tests, package installation, and deployment. Study the difference between code completion, code review, issue-to-PR automation, and autonomous repository changes. Secure the agent like a privileged developer: isolate execution, scope credentials, restrict network, require review, verify diffs, and run tests in clean environments.

Measure developer outcomes rather than lines of generated code: accepted change rate, escaped defects, test quality, review time, rollback rate, security findings, and cognitive load.

### Project

Build a sandboxed issue-to-patch agent on a toy repository. Require a plan, signed diff, tests, dependency scan, reviewer approval, and rollback. Add adversarial issue text and a malicious README to test indirect injection.

## 10. Physical AI, world models, and simulation

Physical AI must perceive, predict, act, and remain safe under sensor noise, partial observability, latency, and contact with the world. Study world models, action policies, teleoperation data, synthetic trajectories, simulation, sim-to-real gaps, embodiment-specific evaluation, geofencing, and emergency stops.

Do not treat a successful simulator run as evidence of real-world safety. Report the environment, sensor distribution, action limits, failure recovery, and transfer uncertainty.

### Project

Train or configure a simulated warehouse agent, introduce lighting and friction shifts, compare policy robustness, and write a transfer-readiness gate with human override and stop conditions.

## 11. AI for science and verified discovery

Scientific AI is a workflow, not a chatbot. Combine domain constraints, experiment design, simulation, uncertainty, data provenance, reproducible computation, expert review, and a mechanism for falsification. Learn active learning, surrogate models, inverse problems, neuro-symbolic methods, formal verification, and lab/field safety.

### Project

Choose a public climate, materials, biology, or mathematics dataset. Build a reproducible hypothesis-to-test loop with a baseline, uncertainty intervals, negative results, expert review, and a clear boundary between suggestion and verified finding.

## 12. Realtime voice, video, and interactive agents

Realtime systems add timing and social risks. Learn streaming transport, WebRTC, voice activity detection, diarization, turn-taking, interruption, barge-in, endpointing, jitter, audio/video synchronization, live vision, consent, identity, and escalation. Evaluate the whole interaction, not just word error rate.

Track time-to-first-audio, end-of-turn latency, interruption recovery, transcription accuracy by speaker/accent/noise slice, unsafe action rate, disclosure/consent failures, and user repair effort.

### Project

Build a consent-aware voice assistant for a synthetic service desk. Add interruption, uncertain transcription, speaker change, tool approval, recording disclosure, and a safe handoff to a human.

## Study by level

### Beginner

1. Explain what each area adds beyond a basic model call.
2. Draw data, identity, model, tool, human, and evidence boundaries.
3. Use public or synthetic data only; record one quality metric, one operational metric, and one risk metric.
4. Complete the flashcards and the [[OWASP and AI Security — 2026]] beginner sections.

### Intermediate

1. Build two implementations with different runtimes or trust assumptions.
2. Add a held-out evaluation set, failure injection, structured logs, and a rollback path.
3. Compare free/local and managed/paid paths on quality, cost, privacy, latency, and portability.
4. Write a one-page decision record and map risks to controls and owners.

### Advanced

1. Operate a multi-tenant, multimodal, tool-using system across cloud, edge, and device.
2. Prove recovery under restart, replay, dependency compromise, stale data, and human rejection.
3. Produce an AIBOM, threat model, incident runbook, energy/cost envelope, and independent evaluation.
4. Defend the architecture in an interview using evidence rather than vendor preference.

## Knowledge check

1. What problem does A2A solve that MCP does not primarily solve?
2. Why is an agent card not an authorization decision?
3. Name three AI-specific SRE signals beyond uptime.
4. What changes when a device model is updated by the operating system?
5. What does an AIBOM make easier during an incident?
6. Why can more inference-time compute be a product regression?
7. Why must document extraction be evaluated separately from answer generation?
8. What is the difference between a privacy policy and a differential-privacy guarantee?
9. Name four terms that belong in an AI unit-cost model besides tokens.
10. Why should a coding agent run in a sandbox with scoped credentials?
11. Why is a simulator score not proof of physical-world safety?
12. Which realtime voice metric captures the user experience better than word error rate alone?

### Answer key

1. A2A standardizes agent discovery, task exchange, and collaboration; MCP primarily standardizes tool/context connections.
2. It describes capabilities; authorization still requires authenticated identity, policy, scope, consent, and runtime enforcement.
3. Examples: grounded-answer rate, unsafe-action rate, p95 latency, cost per successful task, approval burden, drift, recovery time, and incident rate.
4. Behavior, context limits, tool calling, safety behavior, latency, and prompt compatibility can change; re-evaluate and version the runtime.
5. Model/data/tool/dependency provenance, affected deployments, licenses, hashes, and evidence needed for containment and recovery.
6. It can increase latency, cost, energy, queueing, and abandonment while helping only a narrow slice.
7. Extraction errors can create bad evidence even when the language model writes a fluent answer; the pipeline needs separate diagnostics.
8. A policy states intended handling; differential privacy provides a mathematical bound under specified assumptions and a privacy budget.
9. Storage, retrieval, tool calls, egress, GPU reservation, observability, human review, and incidents are examples.
10. A compromised prompt or dependency should not inherit a developer's filesystem, network, secrets, or production privileges.
11. Real environments add sensor noise, distribution shift, latency, contact, and unmodeled failures; transfer evidence is required.
12. End-of-turn latency, interruption recovery, repair effort, consent failures, and safe-action rate.

## Flashcards

What is A2A?::An agent-to-agent protocol for discovery, task exchange, collaboration, and artifacts across frameworks or vendors.
What is MCP?::A protocol for connecting model applications to external tools, data, prompts, and context providers.
What is an AI SLO?::A measurable service-level objective for an AI outcome such as groundedness, safe action, latency, cost, or recovery.
What is an AI incident?::A harmful, policy-violating, insecure, materially misleading, or operationally damaging AI-system event requiring response.
What is on-device AI?::Inference or learning performed on a user device or local edge hardware rather than only in a remote cloud.
What is split inference?::Routing or dividing an AI task between local and remote execution according to capability, privacy, latency, or cost.
What is an AIBOM?::An AI Bill of Materials describing models, data, adapters, dependencies, tools, runtimes, and related provenance.
What is C2PA?::A standard for cryptographically verifiable media provenance and Content Credentials.
What is inference-time compute?::Additional computation used during a request for search, reasoning, verification, reranking, or tool use.
What is a verifier?::A deterministic, learned, or human check that evaluates a candidate answer or action against a contract.
What is document intelligence?::Extracting structured, searchable, and cited meaning from documents, layouts, tables, forms, and images.
What is differential privacy?::A mathematical privacy guarantee that limits how much an output changes when one individual's data is added or removed.
What is a TEE?::A trusted execution environment designed to isolate code and data from parts of the host system.
What is AI unit cost?::The total cost to produce an acceptable task outcome, including model, tools, storage, infrastructure, monitoring, and human work.
What is sim-to-real?::The transfer of a policy or model from simulation to a physical environment with measured gaps and safety controls.
What is VAD?::Voice activity detection, which estimates when speech starts and stops in an audio stream.
What is a coding agent?::A model-driven developer system that can inspect repositories, edit code, run tools, and propose or execute changes.
What is provenance?::Evidence of where an asset came from, what ingredients and transformations produced it, and who or what signed the record.
What is a kill switch?::A tested control that rapidly disables a model, tool, route, workflow, or action class when risk exceeds a threshold.
What is an evidence boundary?::The point where a claim must be supported by a trace, artifact, test, human review, or external source rather than model fluency.
What is a private AI threat model?::A description of the protected data, attacker, trust assumptions, privacy guarantee, utility cost, and response path.
What is a world model?::A learned or engineered model that predicts relevant states, observations, or consequences of actions in an environment.
What is citation fidelity?::Whether a cited source actually supports the claim and points to the correct passage or region.
What is portability evidence?::A tested ability to move prompts, data, models, traces, indexes, workflows, and contracts to another runtime.

## Suggested portfolio projects

1. **Protocol bridge:** MCP retrieval plus A2A collaboration with identity, authorization, and trace correlation.
2. **AI SRE game day:** Deploy, break, detect, contain, roll back, and write the incident report for a synthetic agent.
3. **Local/cloud router:** Compare device and cloud modes with privacy, latency, cost, quality, and update evidence.
4. **Provenance chain:** Generate an AIBOM, sign a release, attach C2PA output provenance, and simulate dependency compromise.
5. **Reasoning budget benchmark:** Compare direct, verified, and tool-assisted strategies under the same compute budget.
6. **Document evidence pipeline:** Extract, cite, authorize, abstain, and evaluate a synthetic document corpus.
7. **Privacy lab:** Compare centralized, federated, and private synthetic-data strategies with attack tests.
8. **Sustainable serving card:** Select a routing policy under quality, cost, latency, capacity, and energy constraints.
9. **Secure coding agent:** Sandbox an issue-to-patch workflow and test malicious repository content.
10. **Sim-to-real readiness review:** Evaluate a physical-AI policy under shifted simulated conditions and define transfer gates.
11. **Verified discovery notebook:** Run a reproducible scientific hypothesis loop with uncertainty and expert review.
12. **Consent-aware realtime agent:** Build a voice/video interaction with interruption, disclosure, safe handoff, and latency evidence.

## Official sources checked 2026-08-24

- [Model Context Protocol 2026-07-28 specification update](https://blog.modelcontextprotocol.io/posts/2026-07-28/)
- [Model Context Protocol roadmap](https://blog.modelcontextprotocol.io/posts/mcp-roadmap/)
- [Google developer guide to agent protocols and A2A](https://developers.googleblog.com/developers-guide-to-ai-agent-protocols/)
- [Linux Foundation Agent Name Service announcement](https://www.linuxfoundation.org/press/linux-foundation-announces-intent-to-launch-agent-name-service-establish-trusted-identity-infrastructure-for-ai-agents)
- [NIST challenges to monitoring deployed AI systems](https://www.nist.gov/news-events/news/2026/03/new-report-challenges-monitoring-deployed-ai-systems)
- [NIST security considerations for AI agents](https://www.nist.gov/publications/summary-analysis-responses-request-information-regarding-security-considerations-ai)
- [Apple WWDC26 machine-learning guide](https://developer.apple.com/wwdc26/guides/machine-learning/)
- [C2PA specifications](https://spec.c2pa.org/specifications/specifications/2.2/index.html)
- [Linux Foundation DocLang working group](https://www.linuxfoundation.org/press/lf-ai-data-foundation-launches-doclang-specification-working-group-to-advance-an-open-standard-for-ai-native-documents)
- [IEA Key Questions on Energy and AI](https://www.iea.org/reports/key-questions-on-energy-and-ai)
- [NVIDIA Cosmos 3 physical AI](https://developer.nvidia.com/blog/develop-physical-ai-reasoning-world-and-action-models-with-nvidia-cosmos-3)

> [!note] Review trigger
> Re-check protocol versions, agent identity standards, on-device OS/model behavior, C2PA and AIBOM formats, document standards, inference economics, hardware limits, physical-AI safety guidance, and realtime APIs by **2026-11-24**.
