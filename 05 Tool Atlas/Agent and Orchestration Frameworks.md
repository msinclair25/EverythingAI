---
title: Agent and Orchestration Frameworks
tags:
  - atlas/tools
  - ai/agents
  - ai/orchestration
status: published
type: tool-category
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
last_updated: 2026-10-13
---

# Agent and Orchestration Frameworks

> [!info] October 13, 2026 update
> Check [[Model and Agent Lifecycle Management]] and [[Cloud AI Operations — October 2026]] for hosted-service retirement and feature-maturity boundaries.

Agent frameworks coordinate model calls, tools, memory/state, handoffs, durable execution, and human approvals. A framework is not a substitute for a defined workflow, evaluation set, permissions model, or failure policy.

> [!tip] Platform runtime overlays · 2026-08-24
> Cloudflare Agents use Durable Object-backed durable identity/state and pair with Workflows for retryable, approval-bound work. Vercel AI SDK 7 adds tool approvals, durable WorkflowAgent execution, sandbox support, harness adapters, and OpenTelemetry-compatible telemetry. Compare both in [[Cloudflare and Vercel AI]] and [[Case - Edge AI Platform Choice]]. For Microsoft hosted agents and Toolboxes, see [[Microsoft Azure DevOps and Foundry]].

## Representative comparison

| Framework | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| OpenAI Agents SDK | MIT-licensed open source; model/tool usage paid separately | Lightweight Python/TypeScript agents, handoffs, tracing | Provider coupling and external service costs | [docs](https://openai.github.io/openai-agents-python/) · [GitHub](https://github.com/openai/openai-agents-python) |
| LangGraph | MIT-licensed open source; LangSmith managed plans are free-tier/paid/enterprise | Explicit state graphs, durable and human-in-loop workflows | Operational stack and LangSmith metering | [docs](https://docs.langchain.com/oss/python/langgraph/overview) · [pricing](https://www.langchain.com/pricing) |
| Google Agent Development Kit | Apache-2.0 open source; model/cloud usage separate | Code-first multi-agent apps, Google ecosystem, multiple languages | Deployment/runtime and model charges | [docs](https://google.github.io/adk-docs/) · [GitHub](https://github.com/google/adk-python) |
| Microsoft Agent Framework | MIT-licensed open source; Azure services paid separately | Microsoft/Azure and Semantic Kernel/AutoGen migration path | Release maturity and API changes | [docs](https://learn.microsoft.com/agent-framework/) · [GitHub](https://github.com/microsoft/agent-framework) |
| LlamaIndex | MIT-licensed open-source framework; LlamaCloud paid/free-tier posture varies | Data-centric agents, indexing, retrieval workflows | Managed-service consumption and ingestion design | [docs](https://docs.llamaindex.ai/) · [LlamaCloud pricing](https://www.llamaindex.ai/pricing) |
| Pydantic AI | MIT-licensed open source; Logfire/model services separate | Typed Python agents and structured application code | Smaller integration surface than broad suites | [docs](https://ai.pydantic.dev/) · [GitHub](https://github.com/pydantic/pydantic-ai) |
| CrewAI | MIT-licensed open-source framework plus paid/enterprise platform | Role-based multi-agent workflow prototyping | Abstraction can obscure control flow and cost | [docs](https://docs.crewai.com/) · [pricing](https://www.crewai.com/pricing) |
| Cloudflare Agents SDK | Open-source SDK; Workers/Durable Objects/AI usage free-tier and paid | Stateful realtime agents on Cloudflare Workers | Platform-specific runtime and service meters | [docs](https://developers.cloudflare.com/agents/) · [pricing](https://developers.cloudflare.com/workers/platform/pricing/) |

> [!warning] Autonomy multiplies failure modes
> Tool errors, prompt injection, stale state, duplicate actions, retry storms, and excessive permissions can turn a model error into a real-world incident. Make actions idempotent, least-privileged, observable, bounded, and reversible where possible.

## Selection criteria

- Deterministic workflows vs model-decided planning.
- Durable state, checkpoints, retries, timeout, idempotency, and resume behavior.
- Human approval and escalation support.
- Tool protocol support, sandboxing, secret isolation, and authorization.
- Provider portability and typed/validated structured output.
- Native tracing/evaluation and OpenTelemetry interoperability.
- Deployment target, concurrency, queueing, realtime transport, and background jobs.

## Free-first path

1. Implement one tool and one linear workflow in plain Python/TypeScript.
2. Add an open-source framework only when state, branching, handoffs, or durability requires it.
3. Use a local model or provider free tier on synthetic data.
4. Test injected instructions, tool failures, duplicate delivery, timeouts, and approval denial.
5. Adopt managed orchestration/observability after operational needs are measured.

~~~mermaid
flowchart TD
    A["Need an agent?"] --> B{"Would fixed code/workflow solve it?"}
    B -->|"Yes"| C["Use ordinary code or automation"]
    B -->|"No"| D{"Complex branching and durable state?"}
    D -->|"Yes"| E["Graph/workflow framework"]
    D -->|"No"| F["Lightweight agent SDK"]
    E --> G{"Platform runtime already chosen?"}
    F --> G
    G -->|"Cloudflare / Azure / Google"| H["Evaluate native SDK"]
    G -->|"Portable"| I["Evaluate LangGraph, LlamaIndex, Pydantic AI, CrewAI"]
    H --> J["Add evals, approvals, traces, and limits"]
    I --> J
~~~

## Role connections

[[Agentic AI Engineer]], [[AI Engineer]], [[AI Engineer|Software Engineer]], [[AI Solutions Architect]], [[MLOps Engineer]], and [[AI Threat Modeling|AI Security Engineer]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Agent and orchestration frameworks]].
