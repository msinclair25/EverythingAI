---
title: Cloudflare and Vercel AI
aliases:
  - Cloudflare AI and Vercel AI
  - Edge AI Platforms
  - Cloudflare Vercel Agent Platforms
type: tool-category
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
  - atlas/tools
  - cloudflare
  - vercel
  - ai/agents
  - ai/platform
  - ai/mlops
  - ai/inference
cssclasses:
  - everything-ai
source_policy: official-first
last_updated: 2026-10-13
---

# Cloudflare and Vercel AI

> [!info] October 13, 2026 update
> Continue with [[Case - Routing Quality and Capacity]] for current admission-control and Python-classifier examples, quality gates, retry budgets, and free-first practice.

> [!abstract] The capability
> Cloudflare and Vercel are both moving beyond “host a web app.” Cloudflare is assembling an edge-native AI runtime: serverless inference, gateway controls, durable agent identity/state, managed search, MCP, browser and sandbox tools, and durable Workflows. Vercel is assembling a web-native AI application and agent stack: AI SDK 7, multi-provider AI Gateway, approvals, durable WorkflowAgent runs, isolated Sandbox execution, secure Connect credentials, and Fluid Compute.

This note teaches what each platform is actually good at, where the boundaries are, what is free-first versus paid/managed, and how to choose without treating a product launch as proof of production readiness. It is U.S.-focused and reflects official documentation checked on **August 24, 2026**. See [[AI DevOps and Cloud Engineering — 2026-08-24]] for the provider-neutral cloud/DevOps lifecycle, then [[AI Tools and Practices Update — 2026-08-24]], [[Agent and Orchestration Frameworks]], [[MLOps and Platforms]], and [[Evaluation and Observability]] for adjacent concepts.

## The high-level difference

| Question | Cloudflare | Vercel |
|---|---|---|
| Center of gravity | Global edge network, Workers runtime, Durable Objects, network/security services | Frontend and full-stack application platform, Next.js, preview deployments, serverless/Fluid Compute |
| AI model path | Workers AI models plus AI Gateway routing to Cloudflare or third-party providers | AI SDK provider abstraction plus AI Gateway routing to hundreds of models/providers |
| Agent runtime | Agents SDK backed by Durable Objects: durable identity, state, sessions, WebSockets, schedules, SQL, MCP, Workflows | AI SDK 7 agents, approvals, WorkflowAgent durability, harness adapters, Vercel Workflow and Sandbox |
| Retrieval | AI Search managed indexing/search; Vectorize for custom vector databases; R2/D1/KV storage | Application-owned retrieval plus provider integrations, databases, Vercel Connect, and AI Gateway embeddings |
| Code execution | Cloudflare Sandbox or Browser tools through the Agents ecosystem | Vercel Sandbox isolated Linux microVMs for untrusted or AI-generated code |
| Key platform advantage | Global placement, durable per-agent identity, integrated network/security controls | Fast TypeScript/web UX, model portability, previews, agent tooling, and deployment ergonomics |
| Main trade-off | Cloudflare-specific runtime/bindings and account configuration | Vercel/Node/ESM/runtime constraints and dependence on external model providers |

The correct comparison is not “which brand has the better model?” Neither platform is primarily a frontier-model laboratory. Both are trying to make AI application delivery easier by owning more of the runtime, routing, security, state, deployment, and developer experience around models.

## Shared AI application loop

~~~mermaid
flowchart LR
    U["User or event"] --> W["Web/API edge"]
    W --> G{"AI control layer"}
    G --> M["Model/provider"]
    G --> T["Tools, retrieval, or code"]
    T --> S["State and durable work"]
    M --> O["Structured output"]
    S --> O
    O --> V["Eval, trace, cost, safety"]
    V --> R{"Release or runtime policy"}
    R -->|Allow| U
    R -->|Hold or deny| H["Human / policy / retry"]
    C["Cloudflare: Workers + DO + AI Gateway"] -.-> G
    D["Vercel: AI SDK + Gateway + Workflow"] -.-> G
~~~

Every platform still needs an application contract: input schema, output schema, tool permissions, identity binding, retry and timeout policy, evaluation set, trace policy, cost envelope, and rollback or compensation path.

## Cloudflare: what it is doing with AI

### 1. Workers AI: serverless inference on the edge

Workers AI runs machine-learning models on Cloudflare’s network through Workers, Pages, or the Cloudflare API. The current overview lists 50+ open-source models and a serverless, pay-for-use posture. It supports text, embeddings, vision, image, speech, audio, and other model categories depending on the model catalog.

Workers AI is useful when:

- an application already runs on Workers and wants inference without operating GPUs;
- requests need global placement or short paths to end users;
- a team wants open-model options without managing a serving cluster;
- the model catalog and per-request limits fit the task;
- the team wants to combine inference with R2, D1, KV, Durable Objects, Vectorize, or AI Search.

Do not assume “serverless GPU” means unlimited capacity, every model, or zero latency. Measure cold behavior, regional placement, queueing, model support, output quality, and the cost of a successful task.

### 2. AI Gateway: the model control plane

Cloudflare AI Gateway is a control layer in front of Cloudflare and third-party models. Current documentation covers analytics and logging, caching, rate limiting, retries and fallbacks, dynamic routing, spend limits, guardrails, DLP, BYOK, and unified billing. Its REST API can route multiple modalities and provider APIs through one Cloudflare endpoint.

Use AI Gateway to:

1. centralize provider/model credentials and request metadata;
2. observe model, latency, token, error, and cost behavior;
3. cache safe repeated requests;
4. cap requests or dollars by model, user, team, or application;
5. route or fall back without changing every application;
6. add consistent content moderation or DLP controls;
7. preserve an exit path through provider-compatible APIs and BYOK.

The gateway is not an evaluation system by itself. A fallback can preserve availability while silently changing quality, safety, tool support, or data residency. Record which provider/model actually served the request and evaluate the fallback path too.

### 3. Agents SDK: durable, stateful agent instances

Cloudflare Agents are built around an Agents SDK runtime backed by Durable Objects. The current runtime provides durable identity, state, embedded SQL, WebSockets, HTTP/SSE, scheduling, queues, fibers, MCP clients, and Workflows. An agent can sleep and wake on events while preserving its state and identity.

The mental model:

| Agent concern | Cloudflare primitive |
|---|---|
| One durable identity per user, tenant, device, or task | Durable Object-backed Agent instance |
| Conversation/session state | Agent state and embedded SQL |
| Live interaction | WebSockets, HTTP streaming, or channel adapters |
| Delayed or recurring work | Schedules, queues, or Workflows |
| Tool use | MCP client, Browser, Sandbox, AI Search, Payments, or custom tools |
| Approval | Workflow approval methods or application policy |
| Global reach | Workers deployment and edge routing |

Agents are a fit for chat, collaboration, live operations, and moderate-length task turns. For work that must survive retries, wait for external events, or run through many steps, pair the Agent with a Workflow rather than placing all logic in one request handler.

### 4. Workflows: durable multi-step execution

Cloudflare Workflows provide persisted steps, automatic retries and recovery, long event waits, and human approval. The official Agents guidance distinguishes:

- **Agents:** real-time communication, state, sessions, WebSockets, and interactive turns;
- **Workflows:** run-to-completion processing, durable steps, retries, pauses, approvals, and external events;
- **Agent + Workflow:** an interactive front end that starts durable background work and receives progress or approval outcomes.

Use a durable step for an external side effect. Make it idempotent, give it a stable key, and ensure a retry cannot duplicate payment, email, ticket creation, or data mutation.

### 5. AI Search and Vectorize: retrieval choices

Cloudflare AI Search is a managed search primitive for applications and agents. It can connect a website, R2 bucket, or uploaded documents; continuously index content; filter metadata; combine keyword and semantic retrieval; expose a built-in MCP endpoint; and provide UI/search components. Its built-in vector index is powered by Vectorize.

Vectorize remains useful when the team needs direct control of vector indexes, namespaces, metadata, ingestion, or retrieval logic. AI Search is the faster managed path; Vectorize is the lower-level composition path.

> [!warning] AutoRAG terminology
> Current Cloudflare AI Search documentation says previous AutoRAG REST endpoints are no longer recommended. Learn the current AI Search APIs and migration path rather than copying an older AutoRAG tutorial.

### 6. Tools: Browser, Sandbox, MCP, and Payments

The Agents platform exposes tool categories beyond model calls:

- **Browser:** controlled browser automation or page interaction;
- **Sandbox:** isolated code execution for agent tasks;
- **AI Search:** retrieval and a built-in MCP endpoint;
- **MCP:** external tools and service integrations;
- **Payments:** payment capabilities where the application explicitly chooses to add them.

The model should propose actions; the application and tool adapter enforce authorization. Treat Browser and Sandbox outputs as untrusted. Use allowlists, network controls, timeouts, resource limits, output size limits, trace IDs, and human approval for consequential actions.

### 7. Cloudflare code shape

This teaching sketch shows Workers AI routed through an AI Gateway binding. It is intentionally incomplete: credentials, input validation, authentication, abuse controls, and evaluation still belong in the application.

~~~typescript
export interface Env {
  AI: Ai;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const input = await request.json<{ prompt?: string }>();
    if (!input.prompt || input.prompt.length > 4000) {
      return new Response("invalid input", { status: 400 });
    }

    const result = await env.AI.run(
      "@cf/meta/llama-3.1-8b-instruct",
      { prompt: input.prompt },
      {
        gateway: {
          id: "learning-gateway",
          skipCache: false,
          cacheTtl: 300
        }
      }
    );

    return Response.json(result);
  }
};
~~~

The important study questions are: what authenticates the caller, which gateway served the request, whether caching is safe for this prompt, what model fallback is allowed, and where the trace and usage data go.

## Cloudflare pricing and free-first path

Current Workers AI pricing documentation (checked August 18, 2026) describes a 10,000-Neuron daily free allocation and $0.011 per 1,000 Neurons above that on Workers Paid. Workers Paid has a $5 monthly minimum; selected frontier models require a paid plan or prepaid AI Gateway credits. Verify pricing before budgeting because model catalogs, allocation, and plan eligibility change.

| Learning need | Free-first path | Paid/managed path |
|---|---|---|
| Learn Workers | Workers Free, Wrangler, synthetic requests, local Miniflare-style tests where supported | Workers Paid, larger limits, production routing, paid Durable Objects |
| Try inference | Workers AI free allocation, small open models, mocked model adapter | Workers Paid, prepaid AI Gateway credits, frontier models, higher limits |
| Learn retrieval | Small R2 corpus, AI Search trial-sized data, Vectorize test index | Larger AI Search/Vectorize corpus, production retention and usage |
| Learn agents | Agents SDK sample, Durable Object state, local test harness | Global deployment, larger object counts, Workflows, Browser/Sandbox tools |
| Learn control | AI Gateway analytics, rate limits, cache, synthetic metadata | Spend limits, guardrails, DLP, BYOK, enterprise logging and policy |

Never put customer documents into a learning account. Use public or synthetic data and delete test resources after measuring them.

## Vercel: what it is doing with AI

### 1. AI SDK 7: from model calls to agent platform

Vercel’s AI SDK 7 release (June 25, 2026) expands the TypeScript SDK from generation and chat primitives into a broader agent platform. The current release highlights tool approvals, durable **WorkflowAgent** execution, timeouts, sandbox support, provider files and skills, MCP Apps, harness adapters, multimodal APIs, and first-class telemetry.

AI SDK 7 is valuable when the team wants:

- a TypeScript-first API that normalizes many model providers;
- streaming UI and tool calls in Next.js, React, Vue, Svelte, or Node;
- structured output and typed tool contracts;
- explicit approval policies for higher-risk tools;
- durable, resumable agent runs;
- a common interface around other agent harnesses;
- OpenTelemetry-compatible traces across model, tool, embedding, reranking, and step events.

Current migration constraints matter: AI SDK 7 requires Node.js 22+ and ESM imports. Pin the Node version, package versions, and migration codemod in CI before upgrading.

### 2. AI Gateway: provider portability with governance

Vercel AI Gateway provides a unified endpoint for hundreds of models. It supports AI SDK, OpenAI Chat Completions, OpenAI Responses, Anthropic Messages, and OpenResponses-compatible calls. The current docs describe one key, provider routing, fallbacks, embeddings, spend monitoring, and no token markup; providers still charge according to their terms.

Current controls include:

- provider ordering and allowlists;
- model fallback;
- spend monitoring and budgets;
- routing rules that rewrite traffic or deny unapproved models;
- API keys, OIDC tokens, and BYOK;
- one trace and usage surface across providers.

The gateway is a control plane, not a guarantee of model equivalence. A routed model may differ in tool behavior, context limits, refusal style, latency, or data handling. Make provider/model identity part of the evaluation record.

~~~typescript
import { generateText } from "ai";
import { gateway } from "@ai-sdk/gateway";

const result = await generateText({
  model: gateway("anthropic/claude-sonnet-4.6"),
  prompt: "Summarize this synthetic incident.",
  providerOptions: {
    gateway: {
      order: ["anthropic", "bedrock"],
      only: ["anthropic", "bedrock"]
    }
  }
});
~~~

### 3. WorkflowAgent: durable, resumable agent work

AI SDK 7’s **WorkflowAgent** runs the agent loop inside a durable workflow. It persists execution state between steps so an agent can survive deploys, process restarts, interruptions, and delayed approvals. It supports streaming, tools, typed runtime/tool context, lifecycle callbacks, timeout budgets, and provider-executed approval resumption.

Use a normal in-memory agent for a short request-response turn. Use WorkflowAgent or Vercel Workflow when:

- a task can run longer than a request window;
- the agent needs to wait for a user or operator;
- a tool call may retry after a transient failure;
- a deployment must not erase work already completed;
- you need a durable audit trail of step transitions.

Durability does not make side effects automatically safe. Put external writes inside idempotent workflow steps, persist the request key, and revalidate approval and tool arguments when resuming.

### 4. Vercel Sandbox: run untrusted code away from production

Vercel Sandbox is an ephemeral Linux microVM for untrusted or AI-generated code. It is designed for code agents, playgrounds, previews, file edits, development servers, and user-provided scripts. The current product guidance emphasizes isolation from production environment variables, databases, network access, privilege escalation, and runaway resource use.

Use Sandbox when the product must execute code. Do not run model-generated code directly inside a Vercel Function or on a developer laptop. Set runtime, timeout, CPU, memory, filesystem, network, package, and output limits; capture logs; and delete the sandbox when the task is complete.

### 5. Connect and Chat SDK: agent boundaries around real systems

Vercel Connect supplies short-lived access to third-party services through OAuth or API-key connectors. This keeps an agent from holding a broad permanent secret and makes a connector an explicit integration boundary. Chat SDK helps expose an agent in Slack, Teams, and other chat surfaces.

Neither feature removes the need for authorization. Bind the connected account to the user, tenant, and permitted action; narrow scopes; log the target and result; and require approval for writes.

### 6. Fluid Compute and long-running AI work

Vercel Functions on Fluid Compute handle concurrent I/O-bound work, scale instances dynamically, and pause CPU billing while waiting on external services such as model calls. Current Vercel documentation also describes longer-running functions for Pro and Enterprise, while the Workflow path remains the better fit for durable multi-step work that must resume after interruption.

Measure active CPU, provisioned memory, invocation duration, model wait time, concurrency, stream completion, and cost. A function that spends most of its time waiting on a model can be memory-bound rather than CPU-bound.

## Vercel pricing and free-first path

Vercel Hobby is free and includes personal projects, Git integrations, previews, and base functions. AI Gateway is documented as available on all plans, but provider usage, higher-tier capabilities, Sandbox duration/resources, observability retention, and Fluid Compute usage can be metered or plan-dependent.

| Learning need | Free-first path | Paid/managed path |
|---|---|---|
| Learn AI SDK | Local Node project, open-source AI SDK, provider free tiers, mocked tools | Team repositories, private deployments, support, enterprise controls |
| Learn AI Gateway | Small synthetic requests, BYOK, one model and one fallback | Unified billing, spend controls, routing rules, higher limits, enterprise governance |
| Learn agents | In-memory Agent, Next.js preview, typed tools, approval UI | WorkflowAgent, Vercel Workflow, persistent production operation |
| Execute code safely | Local mock or small Sandbox experiment with synthetic code | Longer Sandbox durations, more vCPUs, private projects, production observability |
| Connect services | One test OAuth connector and read-only scope | Team connectors, short-lived credentials, multiple services, audit/support |
| Operate | Base Observability and logs, manual evaluation | Observability Plus/Enterprise, longer retention, alerts, tracing integrations |

Keep provider keys, OIDC tokens, connector secrets, and model-generated code out of Git, prompts, screenshots, and client bundles.

## Cloudflare versus Vercel: decision matrix

| Decision | Prefer Cloudflare when | Prefer Vercel when | Evidence to collect |
|---|---|---|---|
| Global request path | Users are globally distributed and the Worker/edge path reduces latency or centralizes security | The application is already a Vercel/Next.js product and preview/deployment velocity dominates | Region-aware p50/p95, cold behavior, data locality, and egress |
| Stateful agents | Each user, tenant, or task needs durable identity/state close to edge events | The team wants TypeScript agent primitives and can use WorkflowAgent for durable runs | Recovery test after deploy/restart and concurrent-session test |
| Model routing | Cloudflare network controls, Workers AI, AI Gateway, rate limits, DLP, and gateway spend budgets are central | One endpoint, model portability, provider ordering, AI SDK integration, and Vercel OIDC are central | Provider/model route, fallback output, cost, trace, and failure behavior |
| Retrieval | AI Search or Vectorize plus R2 is a natural fit | The app already owns a database/search layer and needs AI SDK embeddings or Connect | Recall, freshness, ACLs, deletion, citation coverage, and ingestion cost |
| Code execution | Cloudflare Agents tools and Sandbox fit an edge-hosted agent | Vercel Sandbox microVMs, previews, and AI code-generation UX fit the product | Isolation, network policy, resource limits, package installation, logs |
| Long-running work | Cloudflare Workflows with Agent callbacks and event waits fit the state machine | Vercel WorkflowAgent or Workflow fits a TypeScript/web team | Replay, retry, approval resume, idempotency, and audit |
| Security/network | Cloudflare Access, WAF, DLP, rate limits, network controls, and edge policy are the primary need | Vercel project/environment controls, OIDC, Connect, Sandbox, and frontend security are the primary need | Threat model, auth boundaries, secret flow, abuse controls, and incident path |
| Team ergonomics | The team already knows Workers, Wrangler, Durable Objects, and Cloudflare bindings | The team already knows Next.js, React, Vercel previews, and TypeScript | Time to first evidence, on-call ownership, portability, and exit plan |

### A practical rule

Choose the platform that makes the *hardest non-model boundary* easiest to test:

- durable identity and edge state → start with Cloudflare;
- web UX, provider switching, and TypeScript agent ergonomics → start with Vercel;
- untrusted code execution → compare both Sandbox designs, not marketing claims;
- regulated or high-impact actions → choose the platform with the clearer identity, audit, approval, network, and rollback evidence for your tenant.

## Using both together

A hybrid can be sensible when a Vercel application owns the UI and deployment experience while Cloudflare owns a globally distributed gateway, search, or durable edge component. It can also be a trap: every boundary adds identity, telemetry, cost, data residency, retry, and incident complexity.

~~~mermaid
flowchart LR
    U["Browser / chat channel"] --> V["Vercel app + AI SDK"]
    V --> O["Vercel OIDC or scoped connector"]
    O --> C["Cloudflare AI Gateway"]
    C --> M["Workers AI or external provider"]
    V --> W["Cloudflare Agent / Workflow"]
    W --> Q["AI Search / Vectorize / R2"]
    C --> T["Unified logs, budgets, fallback"]
    V --> E["Vercel traces and preview"]
    T --> E
~~~

If you build this pattern, document:

1. which platform is the system of record for user identity;
2. where prompts, documents, embeddings, traces, and logs are stored;
3. how model/provider credentials cross the boundary;
4. how retries avoid duplicate side effects;
5. which platform owns the release gate and rollback;
6. how a provider outage degrades the user experience;
7. how the system is deleted or migrated.

## Role mapping

| Role | Cloudflare depth | Vercel depth | Portfolio evidence |
|---|---|---|---|
| [[AI Platform Engineer]] | Workers, bindings, Durable Objects, AI Gateway controls, edge routing, tenancy | Functions, Fluid Compute, OIDC, project environments, AI Gateway policy | Platform comparison, identity map, SLO/cost model, rollback |
| [[MLOps Engineer]] | Workers AI model/version limits, gateway routing, Workflows, trace and cost budgets | AI SDK version pinning, WorkflowAgent, CI previews, model/provider evaluation | Reproducible release pipeline and provider fallback test |
| [[Agentic AI Engineer]] | Agents SDK, state/session, MCP, Browser/Sandbox, Agent + Workflow | AI SDK 7 tools/approvals, WorkflowAgent, HarnessAgent, Sandbox, Connect | Agent state machine, approval policy, failure replay, trace export |
| [[AI Evaluation Engineer]] | Gateway fallback/route quality, AI Search retrieval, durable trace/eval slices | Provider/model routing, SDK telemetry, tool approvals, Sandbox behavior | Cross-platform evaluation set with provider/model identity |
| [[AI Security Engineer]] | Access, WAF, DLP, rate/spend limits, tool/network controls | OIDC, Connect scopes, Sandbox isolation, project/environment controls | Threat model, abuse cases, secret-flow and isolation tests |
| [[LLM Engineer]] | Workers AI model catalog, gateway routing, AI Search/Vectorize, edge latency | AI SDK provider normalization, structured output, embeddings, AI Gateway | Model selection card, quality/cost/latency table, exit plan |
| [[AI Product Manager]] | Global latency, tenant isolation, usage budgets, durable workflows | Preview velocity, UX streaming, chat integrations, model portability | Product requirement with risk, cost, data, and support choices |

## Study sequence

### Beginner

1. Explain the difference between a model provider, an inference runtime, a gateway, an agent runtime, a workflow engine, and a sandbox.
2. Build the same structured-output request with Workers AI and AI SDK.
3. Draw the state and identity boundary for a one-user chat agent.
4. Run only public or synthetic data and record cost, latency, and failure behavior.
5. Compare a direct provider call with a gateway-routed call.

### Intermediate

1. Add a read-only tool with schema validation and explicit approval for writes.
2. Build Cloudflare Agent + Workflow and Vercel WorkflowAgent versions of the same long-running task.
3. Add AI Gateway caching, rate/spend limits, model fallback, and route identity.
4. Add AI Search or Vectorize retrieval and measure recall, freshness, ACL, and citation behavior.
5. Run generated or user-provided code only in a sandbox with resource and network controls.

### Advanced

1. Design a hybrid Vercel/Cloudflare deployment with one identity authority and one trace correlation ID.
2. Compare provider fallback quality, cost, latency, tool compatibility, and data-handling terms.
3. Prove workflow recovery after deploy, restart, duplicate delivery, delayed approval, and provider outage.
4. Threat-model MCP, Browser, Connect, Sandbox, AI Search, and payment-like actions.
5. Produce an exit plan that can move the model, gateway, search index, runtime, and workflow without losing audit evidence.

## Interview preparation

- In one minute, explain why Cloudflare and Vercel are AI application platforms rather than simply model vendors.
- Compare Cloudflare Agents backed by Durable Objects with Vercel WorkflowAgent.
- Explain why a gateway fallback can preserve availability but still violate a quality or safety contract.
- Describe how you would stop an agent from running generated code in the production function.
- Explain why AI SDK 7’s Node 22 and ESM requirements belong in the release plan.
- Compare AI Search with a hand-built Vectorize/R2 retrieval path.
- Identify the identity boundary for a Vercel app calling a Cloudflare gateway.
- Explain how spend limits differ from rate limits.
- Design a read-only MCP tool path, then name the controls required before enabling writes.
- State the evidence needed to choose between edge placement and frontend/deployment ergonomics.
- Explain how you would test a model/provider fallback for tool calls and structured outputs.
- Name the rollback target for a workflow that has already completed some side effects.

## Knowledge check

1. What is Cloudflare’s center of gravity in AI?
2. What is Vercel’s center of gravity in AI?
3. Why do Cloudflare Agents require Durable Objects?
4. When should an Agent be paired with a Workflow?
5. What does Cloudflare AI Gateway control?
6. What is the current AI Search relationship to Vectorize?
7. What breaking runtime requirements matter for AI SDK 7?
8. What problem does Vercel WorkflowAgent solve?
9. Why is Vercel Sandbox safer than running model-generated code in a Function?
10. What is the risk of an AI Gateway fallback?
11. Which identity or credential should a connector expose to an agent?
12. What must be measured in a Cloudflare/Vercel platform comparison?

### Answer key

1. Edge deployment, Workers, Durable Objects, network/security controls, serverless inference, search, and durable agent infrastructure.
2. TypeScript/web application delivery, AI SDK primitives, provider abstraction, AI Gateway, workflows, sandboxing, and deployment/preview ergonomics.
3. Durable Objects provide the durable identity and state model behind agent instances.
4. When work is multi-step, long-running, retryable, event-driven, or waiting for human approval.
5. Routing, provider/model access, analytics, logging, caching, rate limits, retries, fallbacks, spend limits, guardrails, DLP, and BYOK/unified billing.
6. AI Search is the managed search layer; its built-in vector index is powered by Vectorize, while Vectorize can also be used directly for custom retrieval.
7. Node.js 22+ and ESM imports, plus package/version migration and telemetry changes.
8. Durable, resumable agent execution across deploys, restarts, interruptions, and delayed approvals.
9. It runs untrusted code in an isolated ephemeral microVM with resource, network, filesystem, and credential boundaries.
10. It can change model behavior, tool support, latency, cost, data handling, or safety while the service still appears available.
11. A short-lived, least-privileged, user/tenant-bound credential or token, never a broad permanent secret.
12. Quality, tool/structured-output compatibility, latency, cost, concurrency, recovery, identity, data locality, observability, and exit/rollback.

## Flashcards

What is Cloudflare Workers AI?::Serverless model inference on Cloudflare’s network, accessed from Workers, Pages, or the API.
What is Cloudflare AI Gateway?::A control plane for AI routing, logging, caching, rate limiting, fallbacks, spend, guardrails, DLP, and billing.
What backs a Cloudflare Agent?::A Durable Object-backed Agents SDK runtime with durable identity and state.
When should Cloudflare Agents use Workflows?::For durable multi-step, retryable, event-driven, or approval-bound work.
What is Cloudflare AI Search?::A managed search primitive with automated indexing, metadata filters, hybrid retrieval, and a built-in MCP endpoint.
What is Vectorize?::Cloudflare’s lower-level vector database for custom indexes, namespaces, metadata, and retrieval composition.
What is Vercel AI SDK 7?::A TypeScript agent/application SDK with tools, approvals, durable WorkflowAgent, harnesses, multimodal APIs, and telemetry.
What is Vercel AI Gateway?::A unified multi-provider endpoint with routing, fallbacks, spend monitoring, BYOK/OIDC, and no token markup.
What is WorkflowAgent?::A Vercel durable agent that persists execution between workflow steps and can resume after interruption or approval.
What is Vercel Sandbox?::An ephemeral isolated Linux microVM for untrusted or AI-generated code.
What is Vercel Connect?::A scoped connector layer that gives agents short-lived access to third-party services.
What does Fluid Compute optimize?::Concurrent I/O-bound Function work, dynamic scaling, and CPU/memory efficiency.
Why version AI SDK 7 runtime requirements?::Node 22+ and ESM requirements can break local, CI, and production builds.
Why test fallbacks?::A fallback can preserve uptime while changing quality, safety, tools, cost, or data handling.
What is an edge-native agent?::An agent whose runtime, identity, state, and request path are designed for global edge execution.
What is a durable side effect?::An external mutation wrapped in an idempotent persisted step so retries cannot duplicate it.
What is a gateway model identity?::The provider/model actually selected to serve a request, recorded for cost, trace, and evaluation.
What is a platform exit plan?::A tested path to export data, prompts, traces, indexes, workflow state, and contracts to another runtime.

## Suggested projects

### Beginner — Two-platform structured-output benchmark

Build one synthetic support classifier twice: once with a Cloudflare Worker and Workers AI, once with Vercel AI SDK. Use the same JSON schema, 40-case dataset, error taxonomy, latency measurement, and cost log. Write which platform made validation and deployment clearer.

### Intermediate — Durable agent parity test

Implement the same human-approval claims workflow with Cloudflare Agents + Workflows and Vercel AI SDK 7 WorkflowAgent. Inject restarts, timeouts, duplicate delivery, stale state, rejected approval, and provider fallback. Compare recovery evidence and side-effect safety.

### Advanced — Gateway and retrieval control plane

Build a synthetic knowledge agent using Cloudflare AI Gateway, AI Search or Vectorize, and a Vercel AI SDK client. Add model routing rules, spend limits, read-only MCP, source ACLs, trace correlation, fallback evaluations, and a provider/runtime exit plan.

### Capstone — Edge/web AI platform decision dossier

Choose Cloudflare-first, Vercel-first, or hybrid for a multi-tenant U.S. application. Deliver a threat model, data-flow diagram, identity matrix, model/provider comparison, cost/latency envelope, evaluation report, workflow recovery test, rollback plan, and a two-minute architecture defense.

## Official sources checked 2026-08-24

### Cloudflare

- [Workers AI overview](https://developers.cloudflare.com/workers-ai/)
- [Workers AI pricing](https://developers.cloudflare.com/workers-ai/platform/pricing/)
- [AI Gateway features](https://developers.cloudflare.com/ai-gateway/features/)
- [AI Gateway REST API](https://developers.cloudflare.com/ai-gateway/usage/rest-api/)
- [AI Gateway spend limits](https://developers.cloudflare.com/ai-gateway/features/spend-limits/)
- [Cloudflare Agents overview](https://developers.cloudflare.com/agents/)
- [Agents API](https://developers.cloudflare.com/agents/runtime/agents-api/)
- [Agents with Workflows](https://developers.cloudflare.com/agents/concepts/workflows/)
- [Cloudflare AI Search](https://developers.cloudflare.com/ai-search/)
- [AI Search vector search](https://developers.cloudflare.com/ai-search/configuration/indexing/vector-search/)
- [Cloudflare Workers pricing](https://developers.cloudflare.com/workers/platform/pricing/)

### Vercel

- [AI SDK 7 release](https://vercel.com/changelog/ai-sdk-7)
- [AI SDK 7 technical overview](https://vercel.com/blog/ai-sdk-7)
- [Vercel AI Gateway](https://vercel.com/docs/ai-gateway)
- [AI Gateway provider options](https://vercel.com/docs/ai-gateway/models-and-providers/provider-options)
- [AI Gateway routing rules](https://vercel.com/changelog/ai-gateway-routing-rules)
- [AI Gateway authentication and BYOK](https://vercel.com/docs/ai-gateway/authentication-and-byok)
- [Vercel Sandbox](https://vercel.com/docs/sandbox)
- [Vercel AI agent guide](https://vercel.com/kb/guide/ai-gateway-and-ai-sdk)
- [Vercel Functions](https://vercel.com/docs/functions)
- [Fluid Compute](https://vercel.com/docs/fluid-compute)
- [Vercel Functions long-running support](https://vercel.com/changelog/vercel-functions-can-now-run-up-to-30-minutes)
- [Vercel Connect](https://vercel.com/connect)
- [Vercel Observability](https://vercel.com/docs/observability)

> [!note] Review trigger
> Re-check Cloudflare Workers AI model catalog/pricing, AI Search versus AutoRAG migration guidance, Agents SDK and Workflow APIs, Vercel AI SDK major versions, AI Gateway routing/terms, Sandbox limits, Function duration, provider support, and plan boundaries by **2026-11-24**.
