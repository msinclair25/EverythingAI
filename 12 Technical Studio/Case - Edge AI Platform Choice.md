---
title: Case - Edge AI Platform Choice
aliases:
  - Cloudflare Vercel Platform Case
  - Edge Agent Platform Decision
  - SignalDesk AI Platform Case
type: technical-case
family: technical
scope: United States
level:
  - intermediate
  - advanced
status: current
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
estimated_minutes: 45
tags:
  - technical-studio
  - case/cloudflare
  - case/vercel
  - case/platform
  - skill/agents
  - skill/mlops
  - skill/security
cssclasses:
  - everything-ai
---

# Case · Cloudflare + Vercel platform choice

> [!abstract] Decision
> Choose a platform shape for SignalDesk, a multi-tenant AI operations assistant, without assuming that “edge” or “serverless” automatically solves state, approvals, code execution, cost, or data-boundary problems.

**Roles:** [[AI Platform Engineer]] · [[Agentic AI Engineer]] · [[MLOps Engineer]] · [[AI Security Engineer]] · [[AI Product Manager]]

**Study companion:** [[Cloudflare and Vercel AI]]

## Situation and contract

**SignalDesk — constructed teaching scenario.** A U.S. operations company wants a web assistant that can search runbooks, explain incidents, draft a change ticket, and prepare a remediation script for an operator to review. It must never execute a production change without explicit approval.

Requirements:

- Next.js web UI with streaming responses and preview deployments;
- customers in the U.S., Europe, and Asia;
- tenant-scoped conversation state and audit history;
- retrieval over synthetic runbooks with freshness and ACL metadata;
- long-running remediation planning that may wait for approval;
- generated code can be inspected and tested, but not run in production;
- model/provider failover with a trace of the actual model used;
- a monthly per-tenant budget and a global abuse limit;
- 99.9% availability target for the interactive path;
- all numbers in this case are constructed teaching values.

## Teaching envelope

> [!warning] Constructed numbers

| Quantity | Value | Why it matters |
|---|---:|---|
| Active tenants | 300 | Tenant isolation and budget dimensions |
| Interactive requests/day | 60,000 | Gateway and concurrency design |
| Long-running remediation workflows/day | 2,000 | Durable execution and approval resume |
| Interactive p95 target | 3 seconds to first token | Streaming and routing budget |
| Workflow completion target | 99% within 30 minutes | Retry, queue, and approval envelope |
| Critical-action approval rate | 100% human approved | Model cannot be authority |
| Per-tenant AI budget | $250/month | Spend attribution and blocking |
| Held-out evaluation cases | 160 | Quality, security, ACL, and recovery slices |

## Closed-note prompt

Before reading the worked path:

1. Which requirement forces a platform decision rather than a model decision?
2. Where does tenant identity bind to state, retrieval, tools, and budget?
3. Which code may be generated, and where may it execute?
4. What is the minimum useful hybrid boundary?
5. Which failure would stop launch even if the app streams quickly?

## Options

| Option | Shape | Strength | Risk or gap |
|---|---|---|---|
| A. Cloudflare-first | Workers UI/API, Agents SDK, Durable Objects, AI Search/Vectorize, AI Gateway, Workflows, Sandbox | Durable edge identity/state, network controls, search, budgets, durable workflows | More Cloudflare-specific bindings and a separate web delivery story |
| B. Vercel-first | Next.js, AI SDK 7, AI Gateway, WorkflowAgent, Sandbox, Connect, Fluid Compute | Fast web UX, TypeScript ergonomics, previews, model portability, agent approvals | Durable state and search may require additional services; edge placement is not automatic |
| C. Hybrid | Vercel UI/preview/app shell plus Cloudflare Gateway/Search/edge agent or workflow components | Uses the strongest boundary from each platform | Two control planes, cross-vendor identity, telemetry, egress, and incident complexity |
| D. Direct provider plus ordinary server | Next.js or Workers call providers directly; state/workflow built manually | Lowest initial conceptual overhead | Rebuilds routing, budgets, fallback, trace, durable execution, and sandbox controls |

**Decision: C, with a narrow boundary.** Vercel owns the web experience, preview, AI SDK 7 client/application ergonomics, and user-facing streaming. Cloudflare owns the shared gateway budget/routing layer and AI Search retrieval service. A single workflow authority owns approvals and durable side effects; do not split one workflow across both runtimes until the correlation and retry contract is proven.

If the company cannot operate two control planes, choose B and add the missing durable state, search, and budget controls explicitly. Hybrid is a decision with a cost, not a default architecture.

## Architecture

~~~mermaid
flowchart LR
    U["Tenant user"] --> V["Vercel Next.js UI"]
    V --> A["AI SDK 7 Agent"]
    A --> G["Cloudflare AI Gateway<br/>budget + route + fallback"]
    G --> M["Provider/model"]
    A --> S["Cloudflare AI Search<br/>tenant-filtered retrieval"]
    A --> W["One workflow authority<br/>approval + idempotent writes"]
    W --> X["Vercel Sandbox<br/>test generated code"]
    W --> H{"Human approval"}
    H -->|Approve| T["Create change ticket"]
    H -->|Reject| N["Record rejection"]
    V --> O["Vercel traces"]
    G --> P["Cloudflare gateway logs"]
    S --> Q["Search audit"]
    O --> C["Correlation ID + release record"]
    P --> C
    Q --> C
~~~

## Worked reasoning

### 1. Bind identity once and carry it everywhere

The authenticated tenant/user is established at the Vercel boundary. The application creates a short-lived, scoped request context containing tenant ID, user ID, allowed operation, correlation ID, and budget dimensions. The model never supplies tenant ID or an approval token.

The same context is passed to:

- Cloudflare AI Gateway metadata for spend and abuse limits;
- AI Search metadata filters and ACL checks;
- workflow state and idempotency keys;
- Vercel Sandbox job labels;
- trace attributes and evaluation examples.

### 2. Keep the workflow authority singular

The hardest cross-vendor failure is split ownership: Vercel starts a workflow, Cloudflare retries a tool, and both believe they own the side effect. Choose one durable workflow authority for approvals and external writes. Other platform components may provide models, retrieval, or isolated execution, but they return typed results and never independently commit the production change.

### 3. Separate generated code from production authority

The agent may generate a remediation script. Vercel Sandbox runs it against synthetic fixtures or a read-only staging environment. The output is a diff, test result, and risk summary. A human reviews the diff. Only a separate approved deployment system can change production, and the agent never receives production credentials.

### 4. Evaluate the route, not only the answer

The held-out set includes:

- correct tenant retrieval and cross-tenant denial;
- stale or conflicting runbooks;
- prompt injection in a runbook;
- model/provider fallback;
- tool timeout and duplicate delivery;
- approval rejection and resume;
- malicious generated code;
- budget exhaustion and abuse rate limiting;
- trace correlation across Vercel, Gateway, Search, Sandbox, and Workflow.

The release gate fails on any cross-tenant retrieval, production execution attempt, missing approval, lost workflow state, or untraceable model/provider route.

### 5. Explain the cost of hybrid

Hybrid adds:

- two sets of credentials and plan limits;
- cross-vendor latency and egress;
- two log/trace surfaces;
- two incident/support paths;
- possible data residency mismatch;
- harder local reproduction.

The choice is justified only if the durable edge/search/gateway controls create measurable value against those costs.

## Release checklist

- [ ] Tenant and user identity bind outside the model.
- [ ] Gateway metadata carries a stable tenant, user, application, and correlation ID.
- [ ] AI Search enforces tenant ACLs and freshness filters.
- [ ] Only one workflow authority owns approvals and external writes.
- [ ] Generated code runs only in an isolated Sandbox/staging boundary.
- [ ] Production credentials are unavailable to model, sandbox, and preview.
- [ ] Provider/model fallback is evaluated for quality, safety, tool support, and cost.
- [ ] Per-tenant budgets and global abuse limits are tested.
- [ ] Cross-vendor traces join on the correlation ID.
- [ ] Rollback and deletion procedures cover both platforms.

## Failure injects

| Injected failure | Correct response |
|---|---|
| Gateway falls back to a model that cannot call the required tool | Detect capability mismatch, route to a compatible model, or return a safe unavailability state |
| AI Search returns a document from another tenant | Deny the response, alert, preserve evidence, and stop release |
| Vercel preview contains a production connector | Revoke connector, quarantine preview, and enforce environment-scoped credentials |
| Workflow resumes after approval with changed tool arguments | Revalidate the arguments and approval binding before continuing |
| Sandbox can reach production database | Remove network/credential path; sandbox must fail closed |
| Tenant exceeds budget through retries | Gateway spend limit blocks or safely downgrades; record the reason |
| Cloudflare logs and Vercel traces cannot be joined | Stop launch until correlation and retention are fixed |
| Generated remediation script passes tests but changes an unsafe file | Human diff review and policy deny; tests are evidence, not authority |

## Interview drill

Answer in two minutes: “Why did you choose a hybrid Cloudflare/Vercel design, and what would make you reject it?”

Strong answer:

1. Start from requirements: Next.js preview/streaming plus durable edge search/gateway controls.
2. Keep the boundary narrow: Vercel owns web/app experience; Cloudflare owns gateway/search.
3. Choose one workflow authority for approval and side effects.
4. Bind tenant identity and correlation once, then propagate it.
5. Reject hybrid if the team cannot operate two control planes, prove cross-vendor traces, or maintain a clean exit plan.

## Quiz

1. Why is a platform choice not the same as a model choice?
2. What does a Durable Object add to a Cloudflare Agent?
3. Why use WorkflowAgent or Workflows for the remediation path?
4. Why should the model never supply tenant ID?
5. What is the danger of split workflow authority?
6. Why is a fallback model not automatically safe?
7. What is the Sandbox allowed to return?
8. Which signal proves cross-tenant retrieval failed?
9. Why are gateway spend limits different from application budgets?
10. What is the minimum useful hybrid boundary?

> [!question]- Answer key
> 1. The platform controls runtime, identity, state, routing, security, and operations; the model is only one dependency. 2. Durable identity/state and event-driven execution for an agent instance. 3. It survives interruption, retries, delayed approval, and long-running work. 4. Bind it from authenticated context so the model cannot cross tenant boundaries. 5. Retries and approvals can duplicate or disagree about a side effect. 6. The fallback can differ in tool support, quality, safety, cost, or data behavior. 7. Typed test output, diff, logs, and risk summary—not production mutations. 8. A retrieval/eval case with a document whose tenant ACL does not match the request. 9. A gateway can enforce provider/model/request spend centrally; the application still needs business budgets and successful-task economics. 10. One platform owns the web/app path and the other owns one measurable shared control such as gateway or search, with a single workflow authority.

## Flashcards

Durable edge identity::A persistent per-agent or per-tenant identity/state boundary at the edge.
AI Gateway fallback risk::Availability may improve while model quality, tools, safety, cost, or data handling change.
Workflow authority::The single runtime responsible for approvals, retries, and external side effects.
Tenant binding::Associating authenticated tenant/user context with retrieval, tools, state, budget, and traces outside the model.
Sandbox output::A typed artifact such as diff, test result, log, or risk summary—not authority to mutate production.
Hybrid platform tax::Additional identity, latency, egress, telemetry, support, and incident complexity from two platforms.
AI Search ACL test::A retrieval case proving that a tenant cannot receive another tenant’s document.
Correlation ID::A stable identifier that joins Vercel traces, gateway logs, search audit, sandbox runs, and workflow records.

## Transfer

- Read [[Cloudflare and Vercel AI]] and compare the two study paths.
- Revisit [[Case - Agent Permissions]] for capability versus authority.
- Use [[Case - Azure DevOps Foundry Release Gate]] to compare a cloud release gate with an edge/web platform choice.
- Build the capstone from the [[Project Bank]] and record the decision in [[Decision Record Template]].
