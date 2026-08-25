---
title: AI Tool Atlas
aliases:
  - Tool Atlas
tags:
  - atlas/tools
  - hub
status: published
type: hub
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
---

# AI Tool Atlas

Use this atlas to choose a tool class, shortlist products, and run a small proof of concept before committing money or sensitive data. It is a curated map of representative tools available to U.S. users—not an endorsement or an exhaustive directory.

> [!warning] Pricing and availability change often
> Access labels were checked against official product, documentation, license, and pricing pages on **August 12, 2026**. A “free tier” may have quotas, feature restrictions, training/data-use terms, or require a payment method. Follow each official link immediately before purchasing.

> [!tip] Current addendum · 2026-08-24
> Read [[Tool Atlas — 2026-08-24 Update]] for the current shortlist, free/open versus managed routes, a 90-minute proof-of-concept protocol, and a reusable tool decision card. Technical practices and role evidence live in [[AI Tools and Practices Update — 2026-08-24]].
>
> For the Microsoft delivery path, use [[Microsoft Azure DevOps and Foundry]] and the worked [[Case - Azure DevOps Foundry Release Gate]]. It covers Azure DevOps MCP, Foundry hosted agents, WIF, environments, evaluation gates, traces, and rollback.
>
> For edge/web AI platforms, use [[Cloudflare and Vercel AI]] and the worked [[Case - Edge AI Platform Choice]]. It compares Workers AI, AI Gateway, Agents, AI Search, Workflows, AI SDK 7, WorkflowAgent, Sandbox, Connect, and Fluid Compute.
>
> For the expanded technical domains, use [[AI Expansion Atlas — 2026-08-24]]. For the interoperability path, use [[MCP Deep Dive — 2026-08-24]]. For the security path, use [[OWASP and AI Security — 2026]] and [[Case - OWASP Agentic Security Review]].
>
> For the delivery and operations intersection, use [[AI DevOps and Cloud Engineering — 2026-08-24]]. It connects AI-assisted DevOps with DevOps for AI: cloud architecture, IaC, CI/CD, identity federation, evaluation gates, Kubernetes, OpenTelemetry, supply chain, FinOps, roles, and portfolio projects.

## Start here

1. Read [[Tool Selection and Access Guide]].
2. Choose the category that matches the job-to-be-done.
3. Start with the note's free-first path.
4. Compare on a representative task and fixed evaluation set.
5. Record security, privacy, accessibility, IP, support, and exit requirements before production use.

~~~mermaid
flowchart TD
    A["What are you trying to do?"] --> B{"Use a model or build one?"}
    B -->|"Use"| C{"Local control required?"}
    C -->|"Yes"| D["Local and Open Model Runtimes"]
    C -->|"No"| E["Foundation Model and API Providers"]
    B -->|"Build or adapt"| F{"Need training?"}
    F -->|"Yes"| G["Model Training and Fine-Tuning"]
    F -->|"No"| H{"Need a workflow or agent?"}
    H -->|"Agent code"| I["Agent and Orchestration Frameworks"]
    H -->|"Visual automation"| J["Automation and No-Code"]
    G --> K["MLOps and Platforms"]
    I --> L["Evaluation and Observability"]
    J --> L
    L --> M["Security and Red Teaming"]
    M --> N["Governance and Compliance"]
~~~

## Categories

| Need | Atlas note | Typical roles |
|---|---|---|
| Hosted general-purpose models and APIs | [[Foundation Model and API Providers]] | [[AI Engineer]], [[Prompt and Context Engineer]], [[AI Product Manager]] |
| Private/offline or self-hosted inference | [[Local and Open Model Runtimes]] | [[ML Engineer]], [[AI Platform Engineer|AI Infrastructure Engineer]] |
| Code completion, review, and agents | [[AI Coding Tools]] | [[AI Engineer]], [[AI Engineer|Software Engineer]] |
| Stateful agents, tools, and workflows | [[Agent and Orchestration Frameworks]] | [[AI Engineer]], [[Agentic AI Engineer]] |
| Analysis environments and notebooks | [[Data and Notebooks]] | [[Data Scientist - AI ML|Data Scientist]], [[AI ML Research Scientist|AI Research Scientist]] |
| Retrieval, semantic search, and memory | [[Vector Search and RAG]] | [[LLM Engineer|RAG Engineer]], [[AI Engineer]] |
| Adapt or align model behavior | [[Model Training and Fine-Tuning]] | [[ML Engineer]], [[AI ML Research Scientist|AI Research Scientist]] |
| Track, deploy, register, and operate models | [[MLOps and Platforms]] | [[MLOps Engineer]], [[ML Engineer]] |
| AI × DevOps and cloud engineering delivery and operations | [[AI DevOps and Cloud Engineering — 2026-08-24]] | DevOps/cloud engineer, [[AI Platform Engineer]], [[MLOps Engineer]], SRE/AI SRE |
| Azure DevOps + Foundry delivery | [[Microsoft Azure DevOps and Foundry]] | [[AI Platform Engineer]], [[MLOps Engineer]], [[Agentic AI Engineer]], [[AI Evaluation Engineer]] |
| Edge/web AI application platforms | [[Cloudflare and Vercel AI]] | [[AI Platform Engineer]], [[Agentic AI Engineer]], [[MLOps Engineer]], [[AI Security Engineer]], [[AI Product Manager]] |
| Expanded AI domains: protocols, reliability, device, provenance, reasoning, documents, privacy, sustainability, coding agents, physical AI, science, realtime | [[AI Expansion Atlas — 2026-08-24]] | [[AI Engineer]], [[Agentic AI Engineer]], [[AI Platform Engineer]], [[MLOps Engineer]], [[AI Security Engineer]], [[AI ML Research Scientist]] |
| MCP protocol, servers, clients, transports, OAuth, conformance, and operations | [[MCP Deep Dive — 2026-08-24]] | [[Agentic AI Engineer]], [[AI Platform Engineer]], [[AI Security Engineer]], [[MLOps Engineer]], [[AI Evaluation Engineer]] |
| Measure quality, traces, drift, and cost | [[Evaluation and Observability]] | [[AI Assurance Evidence|AI Evaluation Engineer]], [[MLOps Engineer]] |
| Probe abuse paths and vulnerabilities | [[Security and Red Teaming]] | [[AI Threat Modeling|AI Security Engineer]], [[AI Threat Modeling|AI Red Team Specialist]] |
| OWASP LLM, agentic, data, MCP, supply-chain, and incident controls | [[OWASP and AI Security — 2026]] | [[AI Security Engineer]], [[AI Red Teamer]], [[Agentic AI Engineer]], [[AI Evaluation Engineer]], [[MLOps Engineer]] |
| Create and review training/evaluation data | [[Data Labeling and Human Feedback]] | [[ML Data Engineer|AI Data Specialist]], [[Human Feedback Operations|RLHF Specialist]] |
| Connect business apps with low/no code | [[Automation and No-Code]] | [[AI Automation Specialist]], [[AI Program Manager|AI Operations Manager]] |
| Generate and edit still visuals | [[Image and Design]] | [[AI Image and Graphic Creator|Generative AI Designer]], [[Generative AI Creative Director|AI Creative Director]] |
| Generate, edit, translate, or avatarize video | [[Video and Avatars]] | [[AI Video Producer]], [[AI Trainer and Educator|Instructional Designer]] |
| Speech, transcription, voice, and music | [[Audio Speech and Music]] | [[Conversation Designer|Conversational AI Designer]], [[AI Audio and Music Specialist|AI Audio Producer]] |
| General assistance and source-grounded research | [[Productivity and Research]] | [[AI Business Analyst|AI Research Analyst]], [[Knowledge Architecture|Knowledge Manager]] |
| Inventory, evidence, risk, policy, and controls | [[Governance and Compliance]] | [[Governance, Risk, Policy and Ethics Careers|AI Governance Specialist]], [[Governance, Risk, Policy and Ethics Careers|Responsible AI Lead]] |
| GPUs, accelerators, hosting, and capacity | [[Cloud Compute and Hardware]] | [[AI Platform Engineer|AI Infrastructure Engineer]], [[MLOps Engineer]] |

## Access legend

| Label | Meaning in this atlas |
|---|---|
| **Open source** | Source is published under an identified license. Hosting, support, model weights, and third-party services can still cost money. |
| **Open weights** | Model weights are downloadable under their own license; this does **not** automatically mean OSI open source or unrestricted commercial use. |
| **Free** | A usable no-fee product or self-hosted software is offered; you still supply hardware and labor where applicable. |
| **Free tier / trial** | A limited hosted allowance or time-limited evaluation exists; quotas and eligibility can change. |
| **Paid** | Subscription, usage-based billing, credit consumption, or paid compute is the normal production posture. |
| **Enterprise** | Contract, sales-assisted, private deployment, governance, indemnity, or enhanced support options are offered. |

## Cross-cutting rules

> [!tip] Free-first does not mean risk-free
> Use public or synthetic data during learning. Treat prompts, uploads, logs, generated media, embeddings, and traces as data flows. Confirm retention, training use, deletion, region, subprocessors, accessibility, and commercial-use terms before using employer or client data.

- Separate **model quality** from the quality of retrieval, tools, prompts, and UX.
- Price a complete workflow: model tokens, tool calls, storage, vector operations, egress, GPU idle time, seats, observability, and human review.
- Prefer exportable artifacts and standard interfaces when switching costs matter.
- Require regression tests before changing a model, prompt, index, runtime, or provider.
- Keep a human approval gate for high-impact, irreversible, financial, legal, hiring, health, or safety actions.

## Research provenance

The official-source ledger is [[Tool Source Registry]]. Research conventions and caveats are in [[Tool Atlas Research Method]].
