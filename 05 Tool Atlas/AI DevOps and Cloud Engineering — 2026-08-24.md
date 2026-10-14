---
title: AI DevOps and Cloud Engineering — 2026-08-24
aliases:
  - AI DevOps
  - AI Cloud Engineering
  - AI Platform and DevOps
  - DevOps for AI
type: technical-study
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
  - ai/devops
  - ai/cloud
  - ai/platform
  - ai/mlops
  - ai/sre
  - ai/security
  - ai/finops
  - ai/study
cssclasses:
  - everything-ai
source_policy: official-first
last_updated: 2026-10-13
---

# AI DevOps and Cloud Engineering — 2026-08-24

> [!info] October 13, 2026 update
> This August dossier is the baseline. [[Cloud AI Operations — October 2026]] and [[Model and Agent Lifecycle Management]] add current identity and lifecycle evidence.

> [!abstract] Why this intersection matters
> AI changes what teams ship, but cloud and DevOps determine whether that work is repeatable, secure, observable, affordable, and recoverable. This track studies both directions: **AI for DevOps** (assistive coding, infrastructure, incidents, and cost work) and **DevOps for AI** (the lifecycle that delivers models, prompts, retrieval, tools, agents, and data).

The goal is not to memorize vendor menus. The goal is to reason about a complete change from an idea in a repository to a measurable production outcome, with a human accountable for every high-impact decision.

> [!warning] Currency and scope
> Product names, previews, quotas, model availability, regions, and pricing change quickly. Claims in this note were checked against primary sources on **August 24, 2026**, for U.S. learners. Verify the linked page, region, data-processing terms, and current price before adopting a service.

## Quick route

| If your goal is… | Read first | Leave with… |
|---|---|---|
| Understand the field | [[#The two-way mental model]] and [[#Role boundaries]] | A one-sentence explanation of AI for DevOps versus DevOps for AI |
| Ship an AI workload | [[#Lifecycle: from plan to retirement]] and [[#CI/CD for AI systems]] | A release bundle, evaluation gate, identity matrix, and rollback plan |
| Choose a cloud shape | [[#Cloud and delivery landscape]] and [[#Architecture patterns]] | A scored provider/runtime decision with data, SLO, cost, and exit evidence |
| Operate safely | [[#Observability and AI SRE]], [[#Supply chain and provenance]], and [[#Security patterns for AI DevOps]] | An incident runbook, provenance check, and pause/recovery drill |
| Build a portfolio signal | [[#Project ladder]] and [[#Interview preparation]] | One measured project plus a concise architecture story |

> [!tip] Recommended sequence
> Read the mental model → write the workload record → trace one change through CI and evaluation → choose a runtime → inject a failure → explain the result in an interview. Skip vendor detail until the boundary and evidence are clear.

## The two-way mental model

| Direction | Question | Typical work | Failure if ignored |
|---|---|---|---|
| AI for DevOps | How can AI reduce toil without weakening engineering controls? | Code explanation, PR review, test generation, incident triage, log/query assistance, architecture drafts, IaC suggestions, cost anomaly investigation | Faster production of unsafe code, leaked secrets, prompt-injected workflows, automation without accountability |
| DevOps for AI | How do we deliver and operate AI systems as production software? | Data/model/prompt/tool versioning, evaluation gates, model serving, inference capacity, RAG freshness, agent permissions, traces, drift, rollback, budgets | A convincing demo that cannot be reproduced, audited, costed, secured, or recovered |
| AI platform engineering | What reusable paved road lets many teams do both safely? | Self-service templates, gateways, registries, identities, environments, policy, observability, quotas, documentation, support | A central platform that becomes a bottleneck or hides risky behavior behind a “magic” abstraction |

~~~mermaid
flowchart LR
    P["Product goal<br/>risk + SLO + budget"] --> R["Repo + work item"]
    R --> C["AI-assisted coding<br/>review + tests"]
    C --> I["CI<br/>unit / integration / eval / security"]
    I --> A["Attest<br/>SBOM + AIBOM + provenance"]
    A --> G["Registry<br/>code / image / model / prompt / tool"]
    G --> D["Deploy<br/>VM / Kubernetes / serverless / edge"]
    D --> X["AI runtime<br/>model + RAG + tools + agent"]
    X --> O["Observe<br/>OTel traces + SLO + cost + safety"]
    O --> Q{"Gate or incident?"}
    Q -->|"promote"| G
    Q -->|"rollback / pause"| D
    Q -->|"learn"| P
~~~

## What an AI cloud engineer actually does

An AI cloud engineer translates an AI workload into a set of cloud primitives and operating controls. Typical questions are:

1. What data may leave the organization, in which region, under which retention and deletion rule?
2. Is this batch, interactive inference, streaming, long-running agent work, training, or a mixed workload?
3. What are the latency, availability, recovery-time, recovery-point, throughput, quality, and cost targets?
4. Which identity invokes the model, reads retrieval data, calls a tool, writes a result, or approves a release?
5. Which artifact versions produced this output: source, image, model, prompt, tool schema, retrieval index, policy, and evaluator?
6. What evidence lets an on-call engineer distinguish a model regression from a dependency, quota, data, network, or provider incident?
7. What is the smallest safe action an agent may take automatically, and where is human approval required?

The work is systems engineering. A model is one dependency in a larger socio-technical system.

## Role boundaries

| Role | Primary boundary | AI-specific evidence |
|---|---|---|
| DevOps engineer | Delivery workflow and environment automation | Reproducible CI/CD, secure runners, protected environments, deployment and rollback |
| Cloud engineer | Network, compute, storage, identity, resilience, and cost | Landing zone, private data path, IAM, capacity plan, backup/DR, unit economics |
| Platform engineer | Reusable internal product for many teams | Golden path, APIs/templates, adoption, developer lead time, guardrails, escape hatch |
| SRE / AI SRE | Reliability and incident learning | SLOs for availability and quality, alert design, game days, error budgets, safe degradation |
| MLOps engineer | Model/data lifecycle and release | Lineage, registry, evaluation gate, canary, drift, rollback, retraining control |
| AI platform engineer | Shared AI runtime and control plane | Model gateway, tool registry, tenancy, quotas, traces, policy, capacity, versioning |
| AI security engineer | Threat model and control effectiveness | Supply-chain evidence, identity boundaries, prompt/tool/MCP tests, detection and recovery |
| AI evaluation engineer | Quality, safety, and regression measurement | Dataset/evaluator versioning, thresholds, slices, human review, release decision record |

Titles overlap. Read the job posting for ownership: one team may call a person “DevOps engineer” while expecting platform, MLOps, or security work.

## Lifecycle: from plan to retirement

### 1. Plan and classify

Before opening a cloud console, write a one-page workload record:

| Field | Example questions |
|---|---|
| User and outcome | Who needs what decision or action? What is the measurable success condition? |
| Workload shape | Batch, online, streaming, training, retrieval, agent, or mixed? Peak concurrency? |
| Data boundary | PII, PHI, financial, export-controlled, customer confidential, public, or synthetic? |
| Quality | What must be correct, grounded, safe, deterministic, explainable, or reviewed? |
| Reliability | SLI, SLO, RTO, RPO, dependency map, degradation mode, and owner? |
| Security | Identities, trust zones, secrets, network path, tool side effects, supply chain, audit? |
| Economics | Cost per request/task, GPU-hour, token, tenant, successful outcome, and monthly ceiling? |
| Exit | How can we export data, prompts, traces, weights, and policy if a provider changes terms? |

Use [[AI System Lifecycle Map]], [[AI Economics and FinOps]], [[AI Risk and Control Design]], and [[AI Threat Modeling]] to turn this record into a decision rather than a shopping list.

### 2. Code, prompts, and infrastructure

Treat all of the following as reviewable source:

- application code and tests;
- Terraform, OpenTofu, Bicep, CloudFormation, Pulumi, Helm, or Kubernetes manifests;
- system prompts, message templates, routing rules, tool schemas, and agent policies;
- retrieval chunking, embedding model, index configuration, filters, and data loaders;
- evaluation datasets, judge prompts, rubrics, thresholds, and human-review instructions;
- Dockerfiles, lockfiles, base images, runner definitions, and workflow YAML;
- model identifiers, provider parameters, safety settings, and inference server configuration.

AI can draft any of these. The repository, policy engine, test suite, and accountable reviewer decide whether they ship.

### 3. Build and test

A strong pipeline checks more than “the code compiles”:

| Gate | Questions |
|---|---|
| Unit and contract | Do functions, schemas, API versions, tool inputs, and outputs behave as promised? |
| Integration | Can the real or emulated model, retrieval store, queue, identity, and provider be reached safely? |
| Evaluation | Does the change meet quality, groundedness, safety, refusal, tool-use, and regression thresholds? |
| Security | Are secrets, dependencies, images, IaC, prompts, tools, and generated changes scanned? |
| Supply chain | Are artifacts signed or attested, dependencies resolved, and builders trusted? |
| Performance | Do latency, throughput, concurrency, tokens, GPU memory, queueing, and egress stay within budget? |
| Recovery | Can we pause, roll back, replay, restore, or route to a fallback without corrupting state? |

Run with representative synthetic data first. Never place production secrets in a prompt, notebook, CI log, or agent context merely to make a test convenient.

### 4. Release and promote

Separate the identities and approvals involved in a release:

1. The CI identity may read the repository and publish an artifact.
2. A deploy identity may update a target environment but should not be able to rewrite the artifact.
3. The runtime identity may call only the model, data, and tools it needs.
4. A human or policy engine promotes a tested artifact to a protected environment.
5. An incident identity may pause traffic or roll back, with a recorded reason and expiry.

Use immutable artifact references, environment protection rules, canary or shadow traffic, schema compatibility, and an explicit rollback plan. A model ID alone is not a release record.

### 5. Run and observe

The production unit is a workflow, not a single model call. Correlate:

- request, trace, conversation, task, and deployment identifiers;
- model/provider, prompt, tool, MCP server, retrieval index, and policy versions;
- input/output token counts, cache reads/writes, time to first token, total latency, retries, and errors;
- retrieval documents and scores, tool approvals/results, side-effect status, and human handoffs;
- CPU, memory, GPU, queue, replica, network, storage, quota, and provider saturation;
- quality, safety, drift, user feedback, cost, and energy signals.

Use content redaction, sampling, access controls, retention limits, and separate secure stores for sensitive payloads. Tracing everything is not a license to collect everything.

### 6. Learn, recover, retire

An incident review should answer:

- What changed, and which artifact or policy hash was live?
- Which signal detected it, and which signal was missing?
- Did the system fail open, fail closed, degrade, or create an irreversible side effect?
- Could an agent or human have stopped it earlier?
- What is the smallest durable fix: code, test, policy, runbook, capacity, provider route, or training?

Retirement includes revoking keys, deleting or archiving data, removing indexes and caches, preserving required evidence, communicating model/prompt deprecation, and testing that old routes are no longer reachable.

## Cloud and delivery landscape

| Surface | Current AI-assisted delivery capability | Where to practice | Cautions |
|---|---|---|---|
| Microsoft Azure DevOps + Foundry | Azure DevOps MCP can expose work items, PRs, builds, pipelines, tests, and docs. Foundry adds projects, hosted agents, tools, evaluations, traces, and deployment paths. Azure Pipelines Workload Identity Federation (WIF) avoids long-lived service-connection secrets. | [[Microsoft Azure DevOps and Foundry]], [[Case - Azure DevOps Foundry Release Gate]] | Remote Azure DevOps MCP requires an Entra-backed organization; normal DevOps, model, compute, and observability charges still apply. Keep Azure DevOps, Foundry project, and runtime identities separate. |
| AWS | Amazon Q Developer assists with code, security scans, upgrades, debugging, and AWS operations. Q for EKS console troubleshooting is read-only and console-only. CodePipeline/CodeBuild/CloudFormation/Bedrock provide delivery and runtime building blocks. | [[MLOps and Platforms]], [[Cloud Compute and Hardware]] | Check the exact Q surface, region, preview status, data processing, and IAM scope. Do not infer that a console assistant can safely run the same action through CLI or IaC. |
| Google Cloud | Gemini Cloud Assist reasons across gcloud, kubectl, and Terraform; Application Design Center turns architecture intent into visual designs and Terraform; Cloud Build supplies CI/CD; GKE, Cloud Deploy, Monitoring, and FinOps surfaces complete the path. | [[MLOps and Platforms]], [[AI Expansion Atlas — 2026-08-24]] | Gemini Cloud Assist features can be preview and may be free only during preview. Treat generated designs, commands, and remediations as proposals requiring validation and authorization. |
| GitHub | Copilot coding agents, Actions, OIDC, protected environments, artifact attestations, code scanning, and Dependabot connect code changes to cloud delivery. | [[AI Coding Tools]], [[OWASP and AI Security — 2026]] | Fork pull requests and issue text are untrusted input. A workflow that lets an agent write or approve changes can turn prompt injection into code execution or credential misuse. |
| Cloudflare | Workers AI, AI Gateway, Agents SDK, AI Search, Workflows, Durable Objects, Sandbox, and observability support edge and stateful agent paths. | [[Cloudflare and Vercel AI]], [[Case - Edge AI Platform Choice]] | Edge locality, limits, durability, model availability, egress, and provider fallback must be tested for the actual plan and region. |
| Vercel | AI SDK 7, AI Gateway, WorkflowAgent, Sandbox, Fluid Compute, and deployment previews make web/agent delivery fast. | [[Cloudflare and Vercel AI]], [[Case - Edge AI Platform Choice]] | Preview/production boundaries, sandbox isolation, spend limits, provider routing, and long-running workflow behavior need explicit tests. |

Use the official pages below rather than relying on a vendor comparison blog:

- [Azure DevOps MCP Server overview](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops)
- [Microsoft Foundry documentation](https://learn.microsoft.com/en-us/azure/foundry/)
- [Amazon Q Developer overview](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)
- [Amazon Q Developer on EKS](https://docs.aws.amazon.com/eks/latest/userguide/amazon-q-integration.html)
- [Gemini Cloud Assist](https://cloud.google.com/products/gemini/cloud-assist)
- [Cloud Build](https://cloud.google.com/build)
- [GitHub OIDC in cloud providers](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-cloud-providers)

### Provider-neutral decision rubric

Score each candidate from 0 (missing) to 3 (strong evidence):

| Dimension | Evidence to request |
|---|---|
| Data and identity | Region, retention, training use, customer-managed keys, private networking, workload identity, audit |
| Delivery | Versioned API, CI integration, approvals, canary, rollback, export, infrastructure as code |
| Runtime | Latency/throughput limits, model and tool routing, queues, state, quotas, multi-tenancy |
| Quality | Evaluation hooks, traces, prompt/model/tool version, human feedback, regression reports |
| Security | Supply-chain attestations, isolation, secret handling, abuse controls, incident response |
| Economics | Token/GPU/compute/egress/storage pricing, budgets, usage export, cost allocation, commitments |
| Team fit | Skills, docs, support, accessibility, operational burden, migration and exit path |

Do not average away a zero in identity, data protection, recovery, or high-impact safety.

## Architecture patterns

### Managed model and agent API

Use a provider-hosted model/agent with a thin application layer. This is usually the fastest path for a small team or variable workload.

- Strengths: fast start, managed scaling, integrated safety/evaluation, less GPU operations.
- Costs: provider lock-in, token/egress cost, data-processing questions, quota dependency, less low-level control.
- Required controls: provider contract review, gateway abstraction, retries/backoff, budget, redaction, fallback, and exportable evaluation evidence.

### Containerized inference on Kubernetes

Run an inference server or model workload on Kubernetes with a registry, autoscaler, and service mesh/gateway.

- Strengths: control, portability, dedicated capacity, custom batching/quantization, private network.
- Costs: GPU procurement and scheduling, upgrades, utilization, security, on-call complexity.
- Required controls: image/model provenance, node isolation, GPU quotas, readiness and liveness, queue-aware autoscaling, drain/rollback, and cost attribution.

### Serverless or edge inference

Use short-lived functions, edge workers, managed model calls, or an edge gateway for latency and proximity.

- Strengths: rapid delivery, scale-to-zero, global reach, reduced infrastructure toil.
- Costs: execution limits, cold starts, provider-specific state, egress and regional constraints, harder long-running jobs.
- Required controls: explicit state store, idempotency, timeout budget, durable workflow, regional failover, and local fallback.

### Hybrid or private AI

Keep sensitive data or inference on a private network, device, or controlled cluster while using a hosted model for non-sensitive or burst work.

- Strengths: data sovereignty, lower exposure, offline resilience, hardware specialization.
- Costs: model quality/capacity tradeoff, fleet management, update and patch burden, split observability.
- Required controls: data classification router, attested model images, offline update channel, encryption, policy test, and cloud fallback decision.

### Multi-cloud model gateway

Place routing, policy, quotas, caching, telemetry, and provider adapters behind one gateway.

- Strengths: fallback, bargaining power, consistent controls, workload-level cost and quality comparison.
- Costs: gateway blast radius, lowest-common-denominator API, prompt/provider behavior differences, duplicated features.
- Required controls: provider contract tests, capability registry, semantic response normalization, per-route budgets, circuit breakers, and an exit drill.

## Infrastructure as code with AI

AI-generated IaC is useful for scaffolding, explanation, migration drafts, and policy suggestions. It is not a trusted plan.

### Safe loop

1. Give the assistant a redacted requirement, existing module interface, provider, region, naming rules, and budget.
2. Ask for a minimal diff plus assumptions and a list of resources it did not model.
3. Run formatter, validation, static policy, security, cost, and plan checks in an isolated branch.
4. Inspect identity, network exposure, encryption, logging, backups, deletion, data egress, and blast radius.
5. Apply only through a protected pipeline with short-lived identity and a recorded approval.
6. Test the deployed state and destroy the lab resources.

| Layer | Free/open-first options | Review focus |
|---|---|---|
| Declarative IaC | OpenTofu, Terraform Community, Pulumi Community, Bicep, CloudFormation | Provider versions, state protection, secrets, drift, plan/apply separation |
| Modules and packaging | Helm, Kustomize, Jsonnet, Pulumi components | Input validation, defaults, upgrade path, ownership |
| Policy as code | OPA/Conftest, Checkov, Trivy, Kyverno | Deny public data stores, wildcard IAM, unencrypted storage, unsafe images |
| Delivery | GitHub Actions, GitLab CI, Azure Pipelines, Cloud Build, Argo CD | OIDC/WIF, protected environments, immutable references, rollback |
| Cost | OpenCost, Kubecost community, billing exports, spreadsheets | Estimate variance, idle resources, GPU commitment, egress, per-team allocation |

Never allow a coding agent to receive a cloud administrator token just because it is “only making a plan.” Plans can read secrets, enumerate sensitive resources, and be manipulated by untrusted context.

## CI/CD for AI systems

### Version the whole change

~~~yaml
release:
  source_commit: <immutable commit>
  image_digest: <OCI digest>
  model: <provider/model/version>
  prompt_bundle: <content hash>
  tool_manifest: <schema and permission hash>
  retrieval_index: <snapshot id>
  eval_set: <dataset version>
  evaluator: <judge version and rubric>
  policy_bundle: <policy hash>
  approvers: <human or policy identities>
~~~

The exact format is a team decision. The principle is that an output can be traced to the complete release bundle, not only the application commit.

### Example gate sequence

| Stage | Required evidence | Stop condition |
|---|---|---|
| Pull request | Diff, generated-code label, unit tests, secret scan, dependency review | Untrusted prompt or generated change lacks an owner |
| Build | Reproducible image, SBOM, vulnerability policy, provenance attestation | Critical vulnerability or untrusted builder |
| Evaluation | Quality/safety/groundedness/tool/latency/cost report | Threshold regression or missing slice |
| Staging | Smoke, contract, load, red-team, trace, and rollback test | No trace correlation or recovery proof |
| Promotion | Protected environment approval, immutable digest, change record | Artifact changed after approval |
| Production | Canary, SLO, budget, alert, and rollback watch | Error budget, quality, safety, or cost breach |

### Identity: OIDC and WIF

GitHub Actions OIDC and Azure Pipelines WIF exchange short-lived, signed workload identity tokens for cloud credentials. The pattern is safer than storing a long-lived cloud secret, but only if the cloud trust policy is narrow.

- Pin the issuer and expected audience.
- Bind the subject to repository, owner ID, branch, tag, environment, or workflow as appropriate.
- Require protected environments for production.
- Grant only the actions needed for that job.
- Separate build, deploy, runtime, and break-glass identities.
- Log token subject, deployment, artifact digest, and approval.
- Revisit trust claims when repositories or organizations are renamed or migrated.

The [GitHub OIDC reference](https://docs.github.com/en/actions/reference/security/oidc) notes immutable subject claims for newer or opted-in repositories; do not copy a broad subject pattern without testing it.

## AI evaluation gates

### Evaluation dimensions

| Dimension | Example measure | Release question |
|---|---|---|
| Task quality | Exact match, rubric score, pass@k, completion rate | Does it solve the intended task? |
| Groundedness | Citation precision/recall, answer-supported-by-context | Does it use allowed evidence rather than plausible invention? |
| Safety | Refusal, policy violation, jailbreak, data-exfiltration rate | Does it resist known abuse and fail safely? |
| Tool use | Correct tool, valid arguments, approval, side-effect success | Does the agent act only within its authority? |
| Reliability | Timeout, retry, fallback, queue, and dependency errors | Does the workflow meet its SLO under failure? |
| Performance | p50/p95/p99, time to first token, throughput | Is the user experience within the budget? |
| Economics | Tokens/task, GPU-hour, cache hit, cost/success | Is value improving rather than only volume? |
| Fairness and accessibility | Slice parity, language, disability, device, demographic checks | Does the system create unacceptable uneven harm? |
| Privacy | Memorization, PII leakage, retention and deletion tests | Does the release respect data policy? |
| Regression | Change from prior release by slice and scenario | Is the improvement worth the new risk? |

### Evaluation record

Keep the model, prompt, tool, policy, dataset, evaluator, seed/temperature, provider, region, date, and environment with the result. Report confidence intervals or uncertainty when sample size allows. Human review remains necessary for high-impact, novel, or adversarial cases.

### Threshold design

- A hard safety or authorization failure should block promotion even if average quality improves.
- A quality threshold must include critical slices, not only the aggregate.
- A cost threshold should measure cost per successful task, not cost per request.
- A latency threshold should include queueing and retries.
- A rollback threshold should account for delayed labels and user feedback.
- A single judge model is not ground truth; use human calibration and evaluator agreement checks.

## Observability and AI SRE

### Signal map

| Signal | Infrastructure examples | AI examples |
|---|---|---|
| Metrics | CPU/GPU, memory, queue depth, replicas, network, disk, quota | tokens, cache, TTFT, generation latency, tool success, quality score, drift, cost |
| Logs | Deployment, scheduler, admission, provider, auth, error | safety decision, evaluator verdict, tool approval, retrieval miss, fallback, human handoff |
| Traces | Request, service, queue, storage, network, dependency | model call, prompt version, retrieval, MCP transport, tool call, agent step, evaluator |
| Events | Scale, deploy, rollback, incident, policy change | model/prompt/tool/index change, guardrail, refusal, escalation, data deletion |

OpenTelemetry's GenAI conventions are still marked development and evolve rapidly. The companion MCP conventions define domain-specific spans and metrics, including client/server operation duration and session duration. Use the current [GenAI conventions](https://github.com/open-telemetry/semantic-conventions-genai) and [MCP conventions](https://github.com/open-telemetry/semantic-conventions-genai/blob/main/docs/gen-ai/mcp.md), record semantic versions, and avoid logging sensitive prompts or outputs by default.

### SLO examples

| SLO | Example target | Burn signal |
|---|---|---|
| Availability | 99.9% successful requests excluding documented client errors | Error-rate burn by route and provider |
| Latency | 95% first token under 1.5 seconds; 95% completion under 8 seconds | TTFT, queue, provider, and token-length slices |
| Quality | 98% critical-policy pass; 90% grounded-answer threshold | Online sample, delayed labels, human review |
| Tool safety | 100% high-risk actions approved; 0 unauthorized side effects | Policy denial, approval mismatch, audit gap |
| Cost | Median cost per successful task below budget | Token/GPU/egress/route and tenant attribution |

An AI SRE runbook should include a safe pause, route fallback, model rollback, index rollback, tool disablement, credential rotation, queue drain, data-protection escalation, and customer communication. “Restart the pod” is not a complete AI incident response.

## Kubernetes and cloud-native AI

Kubernetes is useful when the team needs portable scheduling, networking, identity, storage, and workload policy—not because every AI workload belongs in a cluster.

### Workload classes

- online inference: replicas, readiness, low latency, batching, autoscaling;
- asynchronous agent jobs: queue, durable state, retries, idempotency, deadlines;
- batch inference: partitioning, checkpointing, spot/preemptible capacity, output manifest;
- training/fine-tuning: gang scheduling, distributed coordination, checkpoint storage, GPU topology;
- evaluation: reproducible jobs, isolated data, parallel runs, result registry;
- retrieval ingestion: backfill, freshness, schema migration, delete propagation.

The Kubernetes v1.36 workload-aware scheduling work adds Workload/PodGroup and Job integration for coordinated distributed jobs, relevant to AI training and batch workloads. The [Kubernetes AI Gateway Working Group](https://kubernetes.io/blog/2026/03/09/announcing-ai-gateway-wg/) is exploring token-aware rate limits, payload inspection, routing, caching, and guardrails.

### Cluster checklist

1. Separate platform, tenant, and sensitive workloads with namespaces, network policies, identities, and quotas.
2. Use node/GPU labels, topology awareness, taints, and admission policy.
3. Pin image and model digests; verify signatures and provenance before admission.
4. Make queueing and backpressure visible; do not autoscale only on CPU for token workloads.
5. Keep model weights and indexes in versioned, access-controlled storage.
6. Test node/GPU loss, preemption, provider outage, checkpoint restore, and stuck-agent recovery.
7. Attribute GPU time, storage, network, and idle capacity to workload and team.

## Supply chain and provenance

AI supply chain includes source, dependencies, base image, CI runner, model weights, tokenizer, prompt bundle, retrieval data, tool server, evaluator, and deployment policy.

| Threat | Example | Control |
|---|---|---|
| Dependency poisoning | Malicious package or model plugin | Lockfiles, allowlists, scanning, provenance, review |
| Runner compromise | Workflow exfiltrates cloud token | OIDC, isolated runners, least privilege, fork restrictions |
| Model/data poisoning | Backdoor in weights or corpus | Dataset lineage, hashes, validation, signed artifacts, eval slices |
| Prompt/workflow injection | Issue text changes agent behavior | Treat all text as untrusted; separate data and instructions; approval |
| Tool/MCP compromise | Server returns deceptive schema or side effect | Registry, scopes, conformance, output validation, allowlist, trace |
| Artifact substitution | Digest or tag points to new content | Immutable references, signature verification, admission policy |
| Evidence fabrication | Generated report hides failed tests | Machine-generated evidence, independent checks, append-only audit |

Use [SLSA provenance v1.2](https://slsa.dev/spec/v1.2/provenance) concepts for builder, parameters, and resolved dependencies. GitHub's [Kubernetes admission controller](https://docs.github.com/en/actions/concepts/security/kubernetes-admissions-controller) documents a Sigstore Policy Controller route for enforcing build provenance. An AIBOM is useful when it names model, data, prompt, tool, evaluator, and policy components; it complements an SBOM rather than replacing it.

## FinOps for AI operations

AI cost crosses cloud infrastructure, model providers, SaaS seats, data stores, observability, human review, and energy. Use the [FinOps Foundation AI guidance](https://www.finops.org/framework/technology-categories/ai/) and the [2026 framework update](https://www.finops.org/insights/2026-finops-framework/) as a governance starting point.

### Unit economics

Track at least:

- dollars per request and per successful task;
- input, output, cached, and reasoning tokens;
- GPU-hour, CPU-hour, memory, storage, and egress;
- retrieval calls, reranks, vector operations, and tool calls;
- retries, fallbacks, failed jobs, human review, and idle capacity;
- tenant, product, environment, model route, and release bundle.

### Optimization levers

| Lever | Why it helps | Risk to test |
|---|---|---|
| Prompt and context reduction | Fewer input tokens and lower latency | Lost instructions or grounding |
| Caching | Avoid repeated model/retrieval work | Stale or cross-tenant data |
| Batching | Better accelerator utilization | Queue latency and per-request isolation |
| Quantization | Smaller/faster local models | Quality, safety, and hardware compatibility |
| Routing | Match simple tasks to cheaper models | Inconsistent behavior and policy gaps |
| Rate limits and budgets | Prevent runaway agents and denial-of-wallet | Legitimate work is throttled |
| Autoscaling and scheduling | Reduce idle GPU and queue time | Cold starts, starvation, noisy neighbors |
| Retrieval hygiene | Smaller, fresher, more relevant context | Missed evidence or deletion lag |

FinOps is not “use the cheapest model.” Optimize cost, quality, reliability, safety, and developer time together.

## Security patterns for AI DevOps

Connect this note to [[OWASP and AI Security — 2026]], [[MCP Deep Dive — 2026-08-24]], and [[AI Threat Modeling]].

### Minimum control stack

1. Inventory models, prompts, tools, data stores, providers, agents, workflows, and owners.
2. Classify data and block prohibited routes before the model call.
3. Use short-lived workload identity and least-privilege tool scopes.
4. Treat repository issues, tickets, logs, documents, web pages, and model output as untrusted context.
5. Validate structured output, tool arguments, URLs, file paths, SQL, shell, and infrastructure plans.
6. Isolate sandboxes and runners; restrict network and filesystem egress.
7. Scan and attest code, images, dependencies, models, prompts, and datasets.
8. Log decisions with redaction; alert on secret exposure, abnormal spend, tool escalation, and policy bypass.
9. Keep human approval for irreversible, financial, legal, employment, health, safety, or privileged actions.
10. Test pause, rollback, key rotation, evidence preservation, and customer notification.

## Free-first study stack

| Learning need | Free/open-first path | Paid / managed path to compare |
|---|---|---|
| Git and CI | GitHub/GitLab public repositories, GitHub Actions free public-runner allowance | Enterprise Actions, Azure Pipelines, GitLab Premium |
| Cloud identity | GitHub OIDC, Azure Pipelines WIF, local workload identities | Enterprise identity governance and private runners |
| IaC | OpenTofu/Terraform Community, Pulumi Community, Bicep, CloudFormation | Terraform Cloud/Enterprise, Pulumi Cloud, vendor landing-zone services |
| Containers | Docker/Podman, kind, minikube | Managed Kubernetes, private registries, GPU platforms |
| Kubernetes delivery | Helm, Kustomize, Argo CD, Flux | Managed GitOps and platform products |
| Policy/security | OPA/Conftest, Kyverno, Trivy, Checkov, Semgrep community | Wiz, Snyk, Prisma Cloud, enterprise policy suites |
| Model runtime | Ollama, llama.cpp, vLLM, Hugging Face libraries | Bedrock, Azure AI/Foundry, Vertex AI, hosted inference |
| Evaluation | pytest, promptfoo-style open tools, DeepEval-style open tools, custom rubric harness | Managed evaluation and observability platforms |
| Telemetry | OpenTelemetry, Prometheus, Grafana, Jaeger | Datadog, New Relic, Honeycomb, provider observability |
| Data and retrieval | SQLite/Postgres, DuckDB, Qdrant/Chroma/FAISS options | Managed vector databases, warehouses, search platforms |
| Load and resilience | k6, Locust, Chaos Mesh, Litmus options | Managed load, chaos, and reliability platforms |
| FinOps | Cloud billing exports, OpenCost, Kubecost community, spreadsheets | Cloud cost suites and enterprise FinOps platforms |

“Free” still means hardware, time, electricity, and operational labor have value. Use synthetic or public data and set billing alerts before connecting a cloud account.

## Study sequence

### Level 1 — Foundations (2–4 weeks)

- Linux, networking, Git, Python/shell, HTTP, JSON, containers, and SQL.
- Cloud regions/zones, IAM, storage, queues, DNS, load balancing, logs, metrics, and backups.
- Read [[03 Python SQL Git and Software Foundations]], [[13 Deployment MLOps and Economics]], and [[AI Economics and FinOps]].
- Deliverable: a tested containerized API with IaC, CI, a dashboard, a budget, and a rollback command.

### Level 2 — AI delivery (4–8 weeks)

- Model/API basics, tokens, embeddings, RAG, agents, prompts, structured output, and evaluation.
- Version prompts, models, tools, indexes, and eval data beside code.
- Add an evaluation gate and traces to the Level 1 service.
- Deliverable: a staged RAG or agent release with quality, safety, latency, cost, and rollback evidence.

### Level 3 — Platform and operations (6–12 weeks)

- Kubernetes workload types, GPU scheduling, queues, autoscaling, gateways, multi-tenancy, identity federation, and supply chain.
- Design a paved road with templates, policy, observability, quotas, support, and an escape hatch.
- Deliverable: two workloads use the platform with separate identities, cost attribution, SLOs, and a recovery drill.

### Level 4 — Senior / staff depth (ongoing)

- Multi-cloud and hybrid architecture, migration, contract/exit planning, incident leadership, FinOps, governance, and organizational design.
- Run failure injection: provider outage, bad model, poisoned document, leaked secret, runaway tool loop, GPU loss, and corrupted index.
- Deliverable: architecture decision record, threat model, cost model, postmortem, roadmap, and interview-ready narrative.

## Technical role practice

| If studying for… | Emphasize | Portfolio evidence |
|---|---|---|
| DevOps engineer | CI/CD, OIDC, environments, artifact promotion, runner security, rollback | Secure pipeline with generated-code review and a failed-release recovery |
| Cloud engineer | Landing zones, private networking, IAM, resilience, data boundary, cost | Architecture with identity matrix, DR test, and unit economics |
| Platform engineer | Golden path, self-service, templates, adoption, API design, escape hatches | Two teams deploy different AI workloads through one measured platform |
| SRE / AI SRE | SLOs, traces, incident taxonomy, burn rates, degradation, game days | Incident game day with pause, fallback, rollback, and postmortem |
| MLOps engineer | Registry, evaluation, lineage, canary, drift, retraining, model retirement | Model/agent release dossier from commit to rollback |
| AI platform engineer | Gateway, tool/MCP registry, tenancy, quotas, observability, capacity | Multi-provider gateway with trace IDs, policy, budget, and exit drill |
| AI security engineer | Threat model, supply chain, prompt/tool injection, identity, admission | Red-team report mapped to preventive, detective, and recovery controls |
| AI evaluation engineer | Dataset, evaluator, slices, thresholds, human calibration | Versioned eval harness that blocks a realistic regression |

## Project ladder

### Project 1 — AI-ready CI gate

Build a small retrieval or classification service. Ask an assistant to draft tests and IaC, then require human review, secret/dependency/IaC scans, an evaluation report, an image digest, and a protected deployment. Record what the assistant got wrong.

### Project 2 — Read-only incident copilot

Create an agent that can query synthetic logs, metrics, traces, deployment history, and runbooks. Give it read-only tools, red-team its context, require citations and a human-confirmed action plan, and measure triage time and false hypotheses.

### Project 3 — Multi-cloud model gateway

Route a small workload between two providers and a local fallback. Normalize responses, attach trace and cost metadata, enforce per-tenant budgets, inject provider failures, and publish quality/latency/cost comparisons.

### Project 4 — Kubernetes AI workload lab

Run an online inference service, an asynchronous agent job, and an evaluation batch job on a local cluster. Add quotas, node labels, queue/backpressure, OpenTelemetry, policy admission, and a simulated GPU/node failure.

### Project 5 — Secure coding agent

Let an agent open a pull request against a toy service. Treat issue text and test fixtures as untrusted. Restrict credentials, require an environment approval, scan the result, verify provenance, and demonstrate prompt-injection resistance.

### Project 6 — Platform capstone

Build a paved road with a template repository, workload identity, registry, evaluation gate, model/tool manifest, gateway, dashboard, cost allocation, incident runbook, and deprecation process. Onboard two different workloads and publish adoption and lead-time evidence.

## Interview preparation

1. How would you design a CI/CD pipeline for an agent that can call production tools?
2. What is the difference between AI for DevOps and DevOps for AI?
3. How would you prove which prompt, model, tool, and index produced a response?
4. Why is OIDC safer than a cloud access key, and what can still go wrong?
5. What would you put in an AI system's SLO?
6. How do you design a rollback when a prompt or model changes output semantics?
7. When would you choose managed inference over Kubernetes?
8. How would you prevent a coding agent from turning an issue comment into a privileged shell action?
9. What does an AIBOM add beyond an SBOM?
10. How do you evaluate an agent whose success includes a side effect?
11. Why can average benchmark quality hide a release regression?
12. What metrics reveal an AI denial-of-wallet event?
13. How would you attribute GPU cost to teams and successful outcomes?
14. What is a safe multi-cloud model-routing policy?
15. How do you keep traces useful without logging sensitive prompts?
16. How would you test index freshness and deletion propagation?
17. What should a platform team's escape hatch look like?
18. What changes when an AI workload moves from batch to online inference?
19. How would you respond to a provider outage during a high-impact workflow?
20. Describe a failure you would intentionally inject before production.

> [!tip] Interview answer pattern
> State assumptions → draw the trust/data/control planes → name identities and artifacts → define SLO/evaluation/cost gates → explain failure and rollback → identify evidence and owner.

## Quiz

1. Name the two directions in the AI/DevOps intersection and one risk for each.
2. Why should prompts, tool schemas, and evaluation datasets be treated as source?
3. What are four identities that should be separated in a release?
4. Why is an immutable image digest stronger than a mutable image tag?
5. Which evaluation failure should block promotion even when average quality improves?
6. Name three AI-specific signals that ordinary CPU dashboards miss.
7. Why is an AI trace allowed to omit prompt/output content?
8. When is Kubernetes a poor choice for an AI workload?
9. What is gang scheduling useful for?
10. Give two controls for prompt or workflow injection in CI.
11. What does SLSA provenance help a reviewer answer?
12. Why is a cost-per-request metric insufficient?
13. Name three safe AI cost levers and one risk for each.
14. What makes OIDC trust policy narrow?
15. What belongs in a model/agent release bundle?
16. Why can automatic retraining be unsafe?
17. What is a platform escape hatch?
18. What evidence distinguishes a model regression from a provider outage?
19. Why must a multi-cloud gateway run contract tests?
20. What should an AI incident runbook do besides restart a service?

> [!question]- Answer key
> 1. AI for DevOps reduces toil but may accelerate unsafe changes; DevOps for AI makes AI production-ready but adds lifecycle and operations complexity. 2. They change system behavior and must be versioned, tested, reviewed, and recovered like code. 3. CI/build, deploy, runtime, and break-glass/incident identities. 4. A digest identifies content; a tag can silently move. 5. A hard safety, authorization, privacy, or critical-slice failure. 6. Tokens, TTFT, tool success, groundedness, drift, cache hit, queue, or cost per task. 7. Payloads may contain secrets or PII; record metadata, hashes, redacted excerpts, and access-controlled secure evidence instead. 8. When a managed API or serverless path meets requirements and the team cannot justify cluster operations, or for tiny/short-lived workloads with no portability need. 9. Coordinating distributed training or batch jobs that need resources to start together. 10. Treat text as data, isolate runners, restrict tools/credentials, require approvals, and validate generated plans. 11. Which builder, parameters, dependencies, and artifact identity produced the release. 12. Success varies; include tokens, retries, tools, retrieval, GPU, egress, human review, and failed work. 13. Caching (staleness), batching (queue latency), routing (behavior drift), quantization (quality), budgets (throttling), or autoscaling (cold starts). 14. Issuer, audience, subject/repository/environment claims, branch/tag, and permissions are explicit. 15. Source/image/model/prompt/tool/index/eval/policy versions, provider/region, results, approvals, and hashes. 16. Drift may be benign, labels may lag, and a new model can regress safety or slices. 17. A documented, reviewed path for justified exceptions without forking or bypassing core controls. 18. Compare provider/route, model and release bundle, dependency health, traces, error codes, and controlled fallback results. 19. Providers differ in schemas, safety, latency, errors, and streaming; routing without compatibility evidence is unsafe. 20. Pause or degrade, route fallback, disable tools, rotate credentials, preserve evidence, communicate, and learn.

## Flashcards

AI for DevOps:: Using AI to assist coding, testing, infrastructure, incidents, and cost work while preserving engineering controls.

DevOps for AI:: Applying delivery, reliability, security, and operations discipline to models, prompts, data, retrieval, tools, and agents.

AI cloud engineer:: A systems engineer who maps AI workload needs to cloud primitives, identity, data boundaries, SLOs, capacity, cost, and recovery.

Paved road:: A supported default workflow with secure templates, guardrails, documentation, and a documented escape hatch.

Escape hatch:: A reviewed extension path for justified exceptions that does not require bypassing or forking the platform.

Release bundle:: The complete versioned set of source, image, model, prompt, tool, index, evaluator, policy, provider, and approval evidence.

Immutable artifact:: A content-addressed or otherwise protected artifact that cannot silently change after approval.

Evaluation gate:: A promotion check that measures quality, safety, groundedness, tool behavior, reliability, performance, cost, and critical slices.

Critical slice:: A subset of users, data, languages, scenarios, or risk cases where an aggregate score can hide harm.

OIDC workload identity:: Short-lived, signed identity exchange between a CI workload and a cloud provider instead of a stored long-lived secret.

WIF:: Workload Identity Federation; a mechanism that exchanges an external workload assertion for scoped cloud credentials.

Trust policy:: Cloud rules that bind an identity issuer, audience, subject, repository/environment, and permissions to a workload.

AI SRE:: Reliability engineering that includes model quality, drift, agent/tool behavior, latency, cost, safety, and recovery alongside service health.

TTFT:: Time to first token, a user-facing latency signal for streaming model responses.

Groundedness:: The degree to which an output is supported by allowed retrieved or supplied evidence.

Tool side effect:: A change outside the model, such as sending, deleting, deploying, charging, or writing data.

Circuit breaker:: A control that temporarily stops or reroutes calls after repeated failures to limit blast radius.

Backpressure:: Delaying or rejecting work when queues or dependencies are saturated instead of allowing unbounded growth.

AI gateway:: A control point for model routing, authentication, policy, quotas, caching, telemetry, and provider abstraction.

AIBOM:: An AI bill of materials that records model, data, prompt, tool, evaluator, policy, and related components.

SBOM:: A software bill of materials listing software components and dependencies.

SLSA provenance:: Verifiable evidence about an artifact's builder, parameters, dependencies, and build process.

Admission policy:: A rule that allows or rejects a workload or artifact before it enters a runtime such as Kubernetes.

Prompt injection:: Untrusted content that attempts to change an AI system's instructions or permissions.

Workflow injection:: Prompt injection aimed at CI/CD, automation, or agent orchestration so it executes attacker-controlled actions.

Denial of wallet:: Runaway AI usage that exhausts spend or quota through loops, retries, long contexts, or malicious requests.

Model drift:: A change in the relationship between inputs, outputs, or real-world behavior that can reduce performance or safety.

Index freshness:: How current a retrieval index is relative to its source data and deletion requirements.

Canary release:: A limited traffic deployment used to observe a new version before full promotion.

Shadow release:: A version receives copied inputs and produces observations without serving its output to users.

Rollback:: Returning traffic or configuration to a known-good version while preserving evidence and checking compatibility.

Contract test:: A test that verifies that a provider, tool, model, or service obeys the interface assumptions of its consumers.

Quality-adjusted cost:: Cost measured against successful, safe, acceptable outcomes rather than raw calls.

GPU utilization:: The fraction of accelerator capacity used; it is incomplete without throughput, queue time, quality, and cost.

Gang scheduling:: Starting a coordinated distributed workload only when the required resources are available together.

Model gateway fallback:: Routing to another provider, model, or local path when the primary route fails or violates a policy.

Human approval gate:: A deliberate review step before a high-risk or irreversible action is executed.

Break-glass identity:: A tightly controlled, time-limited emergency identity used for recovery and audited separately.

Data boundary:: The rule describing which data may flow to which model, provider, region, storage system, or tool.

Telemetry redaction:: Removing or masking sensitive payloads while retaining enough metadata to troubleshoot and measure.

Evidence-first incident response:: Using immutable release, trace, policy, and approval evidence to explain and recover from failure.

## Review and links

This dated note should be revisited by **November 24, 2026**, or earlier when a provider changes an API, preview, identity model, pricing rule, Kubernetes behavior, OpenTelemetry convention, or security advisory.

Continue with:

- [[MLOps Engineer]]
- [[AI Platform Engineer]]
- [[Agentic AI Engineer]]
- [[AI Evaluation Engineer]]
- [[AI Security Engineer]]
- [[Microsoft Azure DevOps and Foundry]]
- [[Cloudflare and Vercel AI]]
- [[MLOps and Platforms]]
- [[Evaluation and Observability]]
- [[AI Economics and FinOps]]
- [[OWASP and AI Security — 2026]]
- [[MCP Deep Dive — 2026-08-24]]
- [[AI Expansion Atlas — 2026-08-24]]
- [[Technical Studio]]

### Official sources checked · 2026-08-24

- [Microsoft Azure DevOps MCP Server overview](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops)
- [Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/)
- [Amazon Q Developer](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)
- [Amazon Q Developer on EKS](https://docs.aws.amazon.com/eks/latest/userguide/amazon-q-integration.html)
- [AWS CodePipeline](https://docs.aws.amazon.com/codepipeline/)
- [Gemini Cloud Assist at Next '26](https://cloud.google.com/blog/products/application-development/gemini-cloud-assist-at-next26)
- [Gemini for Google Cloud overview](https://docs.cloud.google.com/cloud-assist/overview)
- [Google Cloud DevOps](https://cloud.google.com/devops)
- [Cloud Build](https://cloud.google.com/build)
- [GitHub OIDC in cloud providers](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-cloud-providers)
- [GitHub OIDC reference](https://docs.github.com/en/actions/reference/security/oidc)
- [GitHub deployments and environments](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments)
- [GitHub secure use](https://docs.github.com/en/actions/reference/security/secure-use)
- [DORA 2025 AI-assisted software development report](https://dora.dev/research/2025/dora-report/)
- [FinOps for AI](https://www.finops.org/framework/technology-categories/ai/)
- [FinOps Framework 2026 update](https://www.finops.org/insights/2026-finops-framework/)
- [Kubernetes v1.36 workload-aware scheduling](https://kubernetes.io/blog/2026/05/13/kubernetes-v1-36-advancing-workload-aware-scheduling/)
- [Kubernetes AI Gateway Working Group](https://kubernetes.io/blog/2026/03/09/announcing-ai-gateway-wg/)
- [SLSA provenance v1.2](https://slsa.dev/spec/v1.2/provenance)
- [OpenTelemetry GenAI semantic conventions](https://github.com/open-telemetry/semantic-conventions-genai)
- [OpenTelemetry MCP semantic conventions](https://github.com/open-telemetry/semantic-conventions-genai/blob/main/docs/gen-ai/mcp.md)
- [GitHub Sigstore Policy Controller guidance](https://docs.github.com/en/actions/concepts/security/kubernetes-admissions-controller)
- [[Source Registry]]

> [!note] Study rule
> Use a free, synthetic-data lab to learn the mechanics; use paid managed services only when you can explain the data contract, identity, evaluation, cost, and exit plan.
