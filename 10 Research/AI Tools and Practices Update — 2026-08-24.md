---
title: AI Tools and Practices Update — 2026-08-24
aliases:
  - August 24 2026 AI Tools Update
  - 2026-08-24 Technical AI Update
type: research-update
family: technical
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
  - research/update
  - tools
  - technical
  - ai-careers
cssclasses:
  - everything-ai
source_policy: official-first
---

# AI Tools and Practices Update — 2026-08-24

> [!abstract] What this note does
> This is the living technical update layer for [[Everything AI]]. It translates current primary documentation into studyable decisions: what changed, which free and paid paths to compare, what evidence a practitioner should produce, and how each technique maps to technical roles. The update is U.S.-focused and was checked on **August 24, 2026**. Product availability, plan limits, model names, and regional features can change after this date.

Use this note with [[Technical Role Deep Dive Framework]], [[AI Tool Atlas]], [[Tool Selection and Access Guide]], [[Evaluation and Observability]], and the technical role profiles in [[Technical AI Careers]]. For a dated tool comparison, open [[Tool Atlas — 2026-08-24 Update]].

## What changed since the August 12 baseline

| Signal | Current practice to learn | Why it matters for a job |
|---|---|---|
| Interoperability | The official MCP roadmap says the 2026-07-28 specification release moved Tasks into an extension, added multi-round-trip requests, and strengthened authorization with issuer validation, issuer-bound credentials, Client ID Metadata Documents, and stable enterprise-managed authorization. Study [[MCP Deep Dive — 2026-08-24]] alongside the source links. | Tool connectivity is becoming an identity, permission, and lifecycle problem—not merely a prompt trick. Learn to review a server card, auth flow, scopes, and audit trail. |
| Agent instrumentation | OpenAI Agents SDK tracing records model generations, tool calls, handoffs, guardrails, and custom events by default; its testing utilities can exercise orchestration in memory without provider calls. | Agent engineers and evaluators are expected to explain *what happened* and to test workflow logic separately from model behavior. |
| Stateful model APIs | Google’s Interactions API is documented as generally available from June 2026 and recommended for new projects; it exposes conversation state, execution steps, background work, tools, and structured output. | Learn to choose stateful versus stateless execution, set retention intentionally, and measure cache and latency effects. |
| Context economics | Gemini’s current caching guide (last updated August 17, 2026) documents explicit TTL-based caching and recommends it when the same large context is reused. | Cost and latency are architecture inputs. A good engineer can show a cache-hit baseline and explain deletion/retention implications. |
| Managed evaluation | Microsoft Foundry’s current agent-evaluation guide uses a test dataset, rubric evaluator, built-in safety/risk evaluators, and workflow integration; some features have regional restrictions. | Evaluation is becoming a release gate with evidence, not a final demo. Know dataset versions, evaluator versions, thresholds, and region constraints. |
| Azure delivery evidence | Azure DevOps environments, WIF service connections, branch policies, and the Azure DevOps MCP Server now form a useful delivery/control surface alongside Foundry hosted agents, Toolboxes, traces, and azd evaluation gates. | Azure technical roles must be able to explain identity separation, read-only MCP, protected promotion, versioned evals, and rollback—not only deploy an endpoint. |
| AI × DevOps/cloud engineering | AI-assisted coding, IaC, incident, and FinOps work now needs to connect to DevOps-for-AI lifecycle controls: versioned prompts/models/tools, evaluation gates, OIDC/WIF, protected environments, Kubernetes/runtime controls, OTel traces, provenance, and unit economics. | Study [[AI DevOps and Cloud Engineering — 2026-08-24]] for the complete lifecycle, cloud comparison, role map, project ladder, interview prep, quiz, and flashcards. |
| Edge/web AI runtimes | Cloudflare’s current Agents, Workflows, AI Gateway, Workers AI, and AI Search stack emphasizes durable edge identity, routing, retrieval, and control. Vercel’s AI SDK 7, AI Gateway, WorkflowAgent, Sandbox, Connect, and Fluid Compute stack emphasizes TypeScript/web agent delivery. | Platform and agent roles must compare state, approvals, sandboxing, provider routes, cost, recovery, data locality, and exit—not just time to first demo. |
| Open serving | vLLM’s current documentation covers single-instance serving, production deployment, and training/fine-tuning paths; its live serve reference was updated August 24, 2026. | Open-model roles need serving economics: batching, memory, concurrency, quantization, load tests, and rollback—not only model selection. |
| TEVV | NIST announced the TEVV-Athlon framework on August 7, 2026 and requested input on the initial public draft of NIST AI 200-2 through October 6, 2026. | Trustworthy AI work increasingly asks for test, evaluation, verification, and validation evidence tied to intended use and impact. |
| Telemetry vocabulary | OpenTelemetry’s GenAI semantic-conventions work now has a dedicated repository covering LLM, MCP, and provider-specific spans, metrics, and events. | Portable telemetry reduces vendor lock-in and lets platform, evaluation, security, and product teams share the same trace vocabulary. |
| OWASP AI security | OWASP’s current 2026 work now separates LLM application risks from agentic risks and adds data-security, secure-MCP, AIBOM, governance, solutions-landscape, and incident-response resources. | AI security work must connect prompt/context risks to identity, tools, memory, inter-agent communication, supply chain, human approval, and recovery. Study [[OWASP and AI Security — 2026]] and [[Case - OWASP Agentic Security Review]]. |
| Next-wave technical domains | [[AI Expansion Atlas — 2026-08-24]] adds interoperability/identity, AI SRE, on-device/private AI, provenance, reasoning compute, document intelligence, privacy, infrastructure sustainability, coding agents, physical AI, AI for science, and realtime interaction. | These domains turn a model skill into a production capability and create evidence paths for platform, security, evaluation, research, and product roles. |

Primary references are listed at the end of this note. Treat the table as a study map, not a promise that every feature is available on every U.S. plan or region.

## The current tool and app map

The free path is a learning and proof-of-concept route. It may still require a laptop, a local GPU, cloud credits, or a payment method. The paid path is where managed retention, scale, support, governance, and collaboration usually appear. Compare a complete workflow rather than a model price.

| Capability | Free or open learning path | Paid or managed path | What to prove before adopting |
|---|---|---|---|
| Hosted models and agent APIs | Provider free tiers, local mocks, and the [[Foundation Model and API Providers]] comparison | OpenAI, Anthropic, Google, Microsoft Foundry, AWS Bedrock, or Vertex AI contracts | Quality on a fixed set, data retention, structured-output validity, rate limits, and exit plan |
| Agent orchestration | Plain Python/TypeScript, OpenAI Agents SDK, LangGraph, Pydantic AI, Google ADK, or Microsoft Agent Framework | Managed traces, durable execution, hosted agent services, and enterprise identity | State transitions, retries, idempotency, approval gates, and trace completeness |
| Tool connectivity | MCP SDKs and local stdio servers on synthetic data | Authenticated HTTP MCP, enterprise-managed authorization, API gateways, or native cloud tools | Scope boundaries, token audience, prompt-injection resistance, auditability, and revocation |
| Retrieval and knowledge | pgvector, Chroma, Qdrant, SQLite FTS, and a small local corpus | Pinecone, Weaviate, Zilliz, Elastic, managed Postgres, or cloud search | Recall@k, groundedness, ACL enforcement, freshness, deletion, and citation coverage |
| Evaluation and tracing | pytest assertions, promptfoo, Phoenix, Langfuse, DeepEval, and OpenTelemetry locally | LangSmith, Arize, Braintrust, W&B Weave, Foundry, or provider dashboards | Dataset/version lineage, judge calibration, redaction, sampling, retention, and CI gates |
| Azure DevOps + Foundry delivery | Azure DevOps free tier, local azd project, synthetic data, read-only MCP, pytest, and OpenTelemetry | Azure Pipelines WIF, protected environments, Foundry hosted agents/Toolboxes, App Insights, and managed evaluators | PR-to-release traceability, identity boundaries, evaluation gate, approval evidence, and rollback |
| Cloudflare + Vercel AI platforms | Workers AI, Agents samples, Vercel AI SDK, local mocks, synthetic data, and small previews | AI Gateway, AI Search, Durable Objects/Workflows, WorkflowAgent, Sandbox, Connect, Fluid Compute | Cross-platform contract, route/fallback identity, state recovery, sandbox isolation, budget, and trace correlation |
| Open-model inference | Ollama, llama.cpp, MLX, or a free notebook runtime | vLLM/SGLang on rented GPUs, managed inference endpoints, or dedicated clusters | p50/p95 latency, time-to-first-token, throughput, GPU memory, quantization quality, and rollback |
| Data and feedback | Label Studio, CVAT, Argilla, doccano, and a spreadsheet rubric | Labelbox, Scale, Prodigy, Snorkel, or enterprise annotation operations | Inter-rater agreement, adjudication, PII handling, label drift, and representative sampling |
| Workflow automation | n8n, Dify, Flowise, Langflow, scripts, and GitHub Actions | Zapier, Make, Pipedream, Power Automate, or a managed integration platform | Replayability, rate limits, secrets, duplicate delivery, human approval, and cost per completed task |

> [!tip] Selection shortcut
> If you cannot describe the input contract, output contract, failure policy, evidence, and owner, you are not ready to choose a tool. Prototype the boundary first with a small, exportable artifact.

## Eight practices that transfer across technical roles

### 1. Contract-first behavior

Write the system contract before the prompt. Define accepted inputs, output schema, citations or evidence requirements, allowed tools, refusal conditions, human approval points, and retry semantics. Validate model output in code. For actions, make operations idempotent and attach a request or idempotency key so a timeout cannot create a duplicate side effect.

Study drill:

1. Take one vague request such as “summarize this ticket and update the CRM.”
2. Split it into a read-only extraction contract and a separately authorized write contract.
3. Add a schema, a missing-field behavior, an approval rule, and a replay test.
4. Record one example of a safe refusal and one example of a tool error.

### 2. Evaluation before optimization

Create a versioned dataset before changing a model, prompt, retriever, tool, or framework. Start with deterministic checks (schema, exact fields, citations, tool arguments), then task metrics, safety cases, human rubrics, and system metrics. Keep a small “golden” set and a larger exploratory set. A judge model is a measurement instrument: calibrate it against blinded domain ratings and test for position, reference-answer, and model-version bias.

Minimum release card:

| Field | Example evidence |
|---|---|
| Intended task | 80 representative U.S. support tickets, not a hand-picked demo |
| Quality threshold | 90% valid schema; 85% task adherence; 95% citation presence |
| Safety threshold | 0 critical policy violations; all high-risk actions require approval |
| Operational budget | p95 latency under 8 seconds; cost under $0.04 per task |
| Regression policy | Block release if any critical case regresses or if the confidence interval crosses the threshold |

### 3. Trace the whole run, then redact

Capture a stable run or trace ID, workflow/version, model and model settings, prompt/template version, tool name and version, retrieval query and source IDs, latency, token usage, cache hits, retries, approvals, errors, and final outcome. Do not automatically capture sensitive prompts, tool payloads, audio, or documents. Use field-level redaction, access controls, sampling, retention limits, and a documented reason for every captured field. The OpenAI Agents SDK explicitly warns that its default spans can include sensitive input/output; this is a configuration and governance decision, not a free observability feature.

### 4. Treat protocols as security boundaries

For an MCP HTTP server, learn the authorization flow rather than copying a connection string. The MCP authorization specification describes OAuth 2.1, metadata discovery, dynamic client registration, and authorization-code or client-credentials choices. The 2026 roadmap emphasizes issuer and audience validation, issuer-bound credentials, and enterprise-managed authorization. Use least-privilege scopes, short-lived tokens, PKCE for public clients, server allowlists, tool-level approval, and revocation. Never pass a token through to a downstream service merely because a model asked for it.

### 5. Make retrieval inspectable

Store source URI, title, version/date, owner, access-control label, chunk ID, and ingestion timestamp with every retrievable unit. Measure retrieval separately from answer generation: recall@k or hit rate, rank quality, citation precision, groundedness, abstention, and freshness. Test adversarial documents containing instructions, poisoned metadata, duplicated passages, stale policy, and unauthorized content. A fluent answer with the wrong source is a retrieval failure, not a language-quality success.

### 6. Engineer cost and latency as budgets

Measure time-to-first-token, p50/p95 end-to-end latency, queue time, model time, tool time, input/output tokens, cache-hit rate, retries, and cost per successful task. Route simple work to a smaller model, batch non-urgent evaluation, cache stable context only when retention is acceptable, and set explicit timeouts. Compare cost per *successful* task, not cost per call. A cheap model that requires human rework can be the expensive choice.

### 7. Serve open models like production systems

Before deploying an open model, record its weight and software licenses, tokenizer, context limit, quantization method, hardware fit, memory headroom, batching behavior, concurrency target, safety controls, and rollback artifact. Load-test realistic prompt lengths and output lengths. Compare a baseline model against the quantized candidate on the same quality and safety set. vLLM can be an efficient serving layer, but it does not remove the need for capacity planning, observability, or incident response.

### 8. Release evidence, not screenshots

Package a README, system diagram, model and data provenance, evaluation set and results, threat model, operational runbook, cost/latency table, accessibility notes, known limitations, and a rollback plan. Keep a change log that distinguishes model changes, prompt changes, tool changes, data/index changes, and infrastructure changes. This is the artifact that lets an interviewer, reviewer, or future teammate understand what you actually did.

~~~mermaid
flowchart LR
    N["Need and intended use"] --> C["Contract and permissions"]
    C --> D["Data, model, retrieval, or tool design"]
    D --> B["Build an inspectable artifact"]
    B --> T["Trace, measure, and redact"]
    T --> E["Evaluate quality, safety, and cost"]
    E --> G{"Release gate"}
    G -->|Pass| O["Operate, monitor, and review"]
    G -->|Fail| F["Classify failure and revise one variable"]
    F --> C
    O --> R["Incident, drift, or feedback evidence"]
    R --> C
~~~

## Role-specific technique map

The roles below are the technical work surfaces already covered in [[Technical AI Careers]]. For each role, study the shared practices above and produce the evidence in the last column.

| Role family | Roles | Current technique to practice | Evidence artifact |
|---|---|---|---|
| Research and adaptation | [[AI ML Research Scientist]], [[Applied Scientist]], [[Research Engineer]] | Reproducible experiments, ablations, confidence intervals, data/version lineage, and explicit limits on generalization | Experiment log, preregistered hypothesis, ablation table, and failure analysis |
| Modeling and learning systems | [[ML Engineer]], [[Data Scientist - AI ML]], [[NLP Engineer]], [[Computer Vision Engineer]], [[Speech AI Engineer]] | Baselines, leakage checks, calibration, multimodal data contracts, error slices, and deployment-aware metrics | Training/evaluation report with slices, calibration plot, and model card |
| Data and feedback | [[ML Data Engineer]], [[Synthetic Data Engineer]] | Dataset contracts, provenance, deduplication, synthetic-data validation, inter-rater agreement, and label-drift monitoring | Dataset card, sampling plan, adjudication log, and quality dashboard |
| Application and knowledge systems | [[AI Engineer]], [[LLM Engineer]], [[RAG and Knowledge Engineer]] | Structured outputs, retrieval quality, citation coverage, tool boundaries, caching, and graceful abstention | Small RAG or API app with trace export, eval set, and source-level citations |
| Agent workflows | [[Agentic AI Engineer]] | Explicit state machine, handoffs, retries, idempotency, human approval, tool permissions, and in-memory orchestration tests | Workflow diagram, failure-injection tests, approval matrix, and replay log |
| Platform and operations | [[MLOps Engineer]], [[AI Platform Engineer]], [[Inference and Performance Engineer]] | OpenTelemetry-compatible traces, SLOs, capacity models, p95 budgets, autoscaling, canaries, rollback, WIF, protected environments, and versioned azd evals | Load-test report, SLO dashboard, deployment manifest, identity matrix, evaluation artifact, and incident runbook |
| Edge/web AI delivery | [[AI Platform Engineer]], [[Agentic AI Engineer]], [[MLOps Engineer]], [[AI Security Engineer]] | Compare Durable Object/Workflow recovery with WorkflowAgent, gateway controls, AI Search/Vectorize retrieval, Sandbox/Connect scopes, and provider fallback behavior | Platform decision matrix, recovery replay, threat model, cost/latency table, and exit plan |
| Hardware and acceleration | [[AI Hardware and Accelerator Engineer]] | Memory/throughput modeling, kernel or compiler profiling, quantization tradeoffs, and representative workload benchmarks | Benchmark notebook, roofline-style analysis, and cost-per-successful-task table |
| Assurance and security | [[AI Evaluation Engineer]], [[AI Red Teamer]], [[AI Security Engineer]], [[AI Safety and Alignment Researcher]] | TEVV plans, adversarial test generation, prompt-injection and tool-abuse cases, judge calibration, and risk-to-control mapping | Test plan, threat model, red-team report, residual-risk register, and release gate |
| Embodied systems | [[Robotics and Embodied AI Engineer]] | Simulation-to-real gap, sensor/data contracts, safety envelopes, latency budgets, and human override behavior | Scenario matrix, replayable simulation, safety case, and field-test log |

## A two-hour study loop

Use this whenever a tool, framework, or role feels too abstract.

1. **Orient (10 min):** Write the job-to-be-done, actor, data boundary, and irreversible action.
2. **Read primary docs (20 min):** Find the official quickstart, limits, security/retention page, and one API reference.
3. **Sketch the loop (10 min):** Draw inputs → model/retrieval/tools → outputs → evaluator → operator.
4. **Build a no-cost slice (35 min):** Use synthetic data, a local runtime, a mock model, or a free tier. Keep the artifact exportable.
5. **Break it (20 min):** Inject malformed output, stale context, unauthorized data, duplicate delivery, timeout, and prompt injection.
6. **Measure (15 min):** Record at least one quality, safety, latency, and cost/usage metric.
7. **Explain (10 min):** Write a one-page decision record: why this tool, what failed, what would change your mind.

> [!warning] “Latest” is not the same as “best”
> New APIs and tools can have preview status, regional restrictions, unstable SDKs, changing terms, or hidden operational work. Prefer a boring, testable boundary over an impressive demo. Re-open official pricing, license, privacy, retention, and security pages immediately before spending money or sending sensitive data.

## Practical tips and techniques

- Keep one hypothesis per change. If you change the model, prompt, retriever, and evaluator at once, you cannot explain the result.
- Use a “failure vocabulary”: schema failure, retrieval miss, grounding error, tool error, authorization failure, policy violation, timeout, drift, or human-UX failure.
- Store the evaluator version next to the score. A score without its rubric, dataset, and judge model is not reproducible evidence.
- Start with the smallest permission that lets the task work. Expand only after a failing example proves the need.
- Add a human gate before irreversible actions, even if the model’s confidence looks high.
- Prefer stable IDs over filenames for documents, tools, traces, and evaluation cases.
- Separate “can the model answer?” from “should the system answer?” and from “may the system act?”
- Test happy paths, boundary cases, adversarial cases, and recovery paths. Production failures usually occur between components.
- When comparing vendors, export the same trace fields, dataset, and score rubric to each candidate.
- For portfolio work, write what you would *not* deploy and why. Good judgment is part of technical competence.

## Knowledge check

Answer without looking back, then use the key.

1. Why should an agent’s read operation and write operation often have separate contracts?
2. Name four pieces of evidence that belong in a production trace.
3. What is the difference between a retrieval miss and a grounding error?
4. Why is an LLM-as-judge score not automatically truth?
5. Give two controls for an authenticated HTTP MCP server.
6. Which metrics expose a cost or latency regression that average latency can hide?
7. What should be compared when validating a quantized open model?
8. What does TEVV stand for, and why is it broader than a demo?
9. Name one reason to choose a local/open path and one reason to choose a managed path.
10. What makes a technical portfolio artifact more credible than a screenshot?

### Answer key

1. Reading is usually lower risk and can be automated; writing creates side effects and should have its own validation, authorization, idempotency, and approval rules.
2. Examples: trace/run ID, model/version, prompt version, tool calls, retrieval source IDs, latency, tokens, cache hits, retries, approvals, errors, or redacted outcome.
3. A retrieval miss means the right evidence was not returned; a grounding error means the answer does not faithfully use the evidence that was returned.
4. The judge can have position, rubric, reference-answer, prompt, and model-version bias; calibrate against blinded human ratings and inspect disagreements.
5. Examples: OAuth 2.1 with PKCE, metadata discovery, least-privilege scopes, issuer/audience validation, short-lived tokens, allowlists, or revocation.
6. p95/p99 latency, time-to-first-token, queue/tool/model time, retry rate, cache-hit rate, and cost per successful task.
7. Same task and safety set, prompt lengths, hardware, concurrency, latency/throughput, memory, and quality—not just a single benchmark score.
8. Test, Evaluation, Verification, and Validation; it asks whether the system meets intended goals and constraints in realistic use, including impacts and failure modes.
9. Local/open can improve control, learning, and portability; managed can provide scale, support, identity, governance, and lower operational burden.
10. A reproducible artifact includes scope, data/model provenance, metrics, failures, threat model, cost/latency, limitations, and a rollback or operating plan.

## Flashcards

What is the first artifact to write before a model prompt?::A system contract covering inputs, outputs, tools, refusals, approvals, retries, and side effects.
Why separate read and write tools?::Write tools can create irreversible side effects, so they need stronger authorization, validation, idempotency, and approval controls.
What does a trace ID enable?::It lets teams correlate a complete workflow across model calls, tools, retrieval, approvals, retries, and errors.
What is a retrieval miss?::The retriever failed to return the relevant evidence.
What is a grounding error?::The answer is unsupported or contradicted by the evidence that was retrieved.
Why version an evaluation dataset?::To make score changes attributable and comparisons reproducible after code, prompt, model, or tool changes.
What is a cache-hit metric useful for?::It shows whether repeated context is actually reducing latency or input cost.
Name two MCP authorization controls.::OAuth 2.1/PKCE, metadata discovery, least-privilege scopes, issuer/audience validation, short-lived tokens, or revocation.
What should a quantization benchmark include?::Quality and safety on representative cases plus memory, throughput, latency, concurrency, and rollback evidence.
What is TEVV?::Test, Evaluation, Verification, and Validation.
Why use OpenTelemetry GenAI conventions?::They provide a shared vocabulary for LLM, tool, MCP, and provider telemetry across platforms.
What is a credible portfolio release card?::A reproducible summary of intended use, provenance, tests, metrics, limitations, risks, costs, and rollback.

## Suggested projects

### Beginner — Local evidence-backed RAG slice

Use 20 public U.S. government or standards documents and a local runtime such as Ollama, llama.cpp, or a free notebook. Build a small index with source IDs and dates. Return an answer only when the retrieved evidence clears a simple threshold. Deliver a README, source manifest, five retrieval tests, five answer tests, a citation-coverage score, and three documented failures.

### Intermediate — MCP approval gateway

Build a local MCP server with two read-only tools and one write-like tool that only produces a dry-run change. Add OAuth-shaped mock claims or a scope map, an allowlist, request IDs, approval state, and replay protection. Inject prompt-injection text into a retrieved document and show that the tool boundary holds. Deliver an authorization matrix, threat model, trace sample, and recovery test.

### Advanced — Provider-neutral agent evaluation harness

Implement one workflow with two model providers or one hosted provider plus vLLM. Emit OpenTelemetry-compatible spans for model, retrieval, tool, and evaluator steps. Run a fixed dataset with deterministic checks, a calibrated rubric, a red-team slice, and a latency/cost budget. Compare the providers on quality, safety, p95 latency, cache hits, and cost per successful task. Deliver a versioned eval recipe, dashboard or exported traces, and a rollback recommendation.

### Role capstone — TEVV release dossier

Choose one technical role from the table above. Produce a system card, data card, threat model, test matrix, evaluation results, operational SLOs, accessibility notes, and a one-page “do not deploy yet” decision. Ask a peer to challenge your assumptions. This dossier is interview material as well as study evidence.

## Official sources checked 2026-08-24

- [Model Context Protocol roadmap](https://blog.modelcontextprotocol.io/posts/mcp-roadmap/) — 2026-07-28 specification changes, Tasks extension, and authorization priorities.
- [MCP authorization specification](https://modelcontextprotocol.io/specification/2025-03-26/basic/authorization) — OAuth, metadata discovery, and implementation requirements.
- [OpenAI Agents SDK tracing](https://openai.github.io/openai-agents-python/tracing/) — default traces, sensitive-data controls, and spans.
- [OpenAI Agents SDK testing](https://openai.github.io/openai-agents-python/testing/) — deterministic provider-neutral orchestration tests.
- [Google Gemini Interactions API](https://ai.google.dev/gemini-api/docs/interactions-overview) — state, execution steps, tools, background work, and structured output.
- [Google Gemini context caching](https://ai.google.dev/gemini-api/docs/generate-content/caching) — explicit TTL, cost, deletion, and usage metadata.
- [Microsoft Foundry agent evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent) — datasets, rubric evaluators, safety evaluators, and regional limits.
- [Microsoft Foundry observability](https://learn.microsoft.com/en-us/azure/foundry/concepts/observability) — traces, evaluators, lifecycle stages, and monitoring.
- [Azure DevOps MCP Server](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops), [pipeline environments](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops), and [WIF service connections](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops) — current delivery and identity controls.
- [Foundry hosted agents](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents), [Toolboxes/MCP](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/model-context-protocol), and [azd evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/azure-developer-cli-evaluation) — runtime, tool, and evaluation boundaries.
- [Cloudflare Workers AI](https://developers.cloudflare.com/workers-ai/), [AI Gateway](https://developers.cloudflare.com/ai-gateway/features/), [Agents](https://developers.cloudflare.com/agents/), [AI Search](https://developers.cloudflare.com/ai-search/), and [Agents with Workflows](https://developers.cloudflare.com/agents/concepts/workflows/) — edge AI runtime and control surfaces.
- [Vercel AI SDK 7](https://vercel.com/changelog/ai-sdk-7), [AI Gateway](https://vercel.com/docs/ai-gateway), [Sandbox](https://vercel.com/docs/sandbox), [Vercel Functions](https://vercel.com/docs/functions), and [Connect](https://vercel.com/connect) — web/TypeScript agent runtime and infrastructure.
- [vLLM usage and deployment docs](https://docs.vllm.ai/en/latest/usage/) and [serve reference](https://docs.vllm.ai/en/latest/cli/serve/) — inference, deployment, and current serving controls.
- [NIST TEVV-Athlon framework](https://www.nist.gov/artificial-intelligence/ai-research/tevv-athlon-framework-evaluating-ai-systems) — August 7, 2026 announcement and draft AI 200-2 input period.
- [OpenTelemetry GenAI semantic conventions](https://github.com/open-telemetry/semantic-conventions-genai) — LLM, MCP, and provider-specific telemetry conventions.

> [!note] Review trigger
> Recheck this note by **2026-11-24**, or sooner when a provider changes a model/API, an MCP specification release changes authorization semantics, a major runtime changes maintenance status, or a U.S. policy/contract requirement affects the intended use.
