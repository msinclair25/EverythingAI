---
title: Evaluation and Observability
tags:
  - atlas/tools
  - ai/evaluation
  - ai/observability
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
---

# Evaluation and Observability

Evaluation asks whether an AI system is good enough; observability explains what happened in development and production. Effective programs combine deterministic checks, task metrics, human rubrics, adversarial cases, trace review, and business outcomes.

> [!tip] Foundry delivery overlay · 2026-08-24
> [[Microsoft Azure DevOps and Foundry]] connects Foundry evaluations to Azure Pipelines gates, hosted-agent traces, and protected Azure DevOps environments. Foundry evaluation targets can include an agent, model, dataset, responses, or traces. Version the dataset, rubric, evaluator, threshold, model, agent/toolbox, and command extension together.

> [!tip] Edge/web delivery overlay · 2026-08-24
> [[Cloudflare and Vercel AI]] teaches why gateway fallbacks, AI Search ACLs, Durable Object/Workflow recovery, AI SDK provider routing, WorkflowAgent approvals, Sandbox isolation, and cross-vendor trace correlation all belong in the evaluation set.

## Representative comparison

| Tool | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| promptfoo | Open-source CLI plus paid cloud/enterprise offerings | CI regression tests, red teaming, provider comparisons | You must design valid tests and graders | [docs](https://www.promptfoo.dev/docs/) · [pricing](https://www.promptfoo.dev/pricing/) |
| Arize Phoenix / Arize AX | Open-source self-hosted Phoenix; free cloud entry plus paid plans | Local-first tracing/evals with managed upgrade path | Cloud ingestion/retention plan limits | [pricing](https://arize.com/pricing) · [Phoenix docs](https://arize.com/docs/phoenix) |
| LangSmith | Free developer entry plus paid/enterprise | Tracing, datasets, experiments, evals, especially LangChain/LangGraph | Platform units, retention, ecosystem coupling | [pricing](https://www.langchain.com/pricing) · [docs](https://docs.langchain.com/langsmith/home) |
| Langfuse | Open-source/self-host option plus free/paid cloud | Provider-neutral LLM tracing, prompts, evals | Self-host responsibility or cloud limits | [pricing](https://langfuse.com/pricing) · [docs](https://langfuse.com/docs) |
| Braintrust | Free entry plus paid/enterprise | Dataset-driven experiments, scorers, prompt management, production logs | SaaS workflow and usage meters | [pricing](https://www.braintrust.dev/pricing) · [docs](https://www.braintrust.dev/docs) |
| Weights & Biases Weave | Open-source SDK with free/paid W&B platform posture | Evals and tracing alongside ML experiments | Platform/seat/usage considerations | [Weave](https://weave-docs.wandb.ai/) · [W&B pricing](https://wandb.ai/site/pricing) |
| DeepEval / Confident AI | Open-source framework plus managed platform | Python test-style LLM evaluation and CI | Metric validity and managed-service dependency | [DeepEval](https://deepeval.com/docs/getting-started) · [Confident AI pricing](https://www.confident-ai.com/pricing) |

## Build an evaluation stack in layers

| Layer | Examples |
|---|---|
| Contract | JSON/schema validity, required citation, tool arguments, refusal policy |
| Task | Exact match, classification F1, retrieval recall, groundedness, rubric |
| Safety | Prompt injection, harmful output, PII, bias, misuse, excessive agency |
| System | Latency, error/retry rate, token/tool cost, cache hit, availability |
| Human | Blind pairwise preference, domain-expert rubric, accessibility/usability |
| Business | Resolution rate, review time, conversion, escalation, loss avoided |

## Selection criteria

- Offline/CI evaluation, online monitoring, or both.
- Trace standard and ability to redact, sample, export, and set retention.
- Dataset/version support, human annotation, custom scorers, and statistical comparison.
- Model-judge controls: calibration, position bias, reference answers, and judge drift.
- Agent/tool/retrieval visibility and causal debugging.
- Access control, tenancy, region, SSO, audit, and cost allocation.

## Free-first path

1. Create a versioned CSV/JSONL evaluation set and plain-language rubric.
2. Add deterministic assertions in the normal test suite.
3. Use promptfoo, Phoenix, Langfuse, Weave, or DeepEval locally.
4. Compare automated scores with blinded human ratings.
5. Pay for collaboration, retention, production monitoring, or governance after the test design is trustworthy.

~~~mermaid
flowchart LR
    A["Versioned dataset"] --> B["Candidate system"]
    B --> C["Deterministic checks"]
    B --> D["Task and safety metrics"]
    B --> E["Human rubric"]
    B --> F["Trace, latency, and cost"]
    C --> G{"Release gate"}
    D --> G
    E --> G
    F --> G
    G -->|"Pass"| H["Canary and monitor"]
    G -->|"Fail"| I["Diagnose and revise"]
    I --> B
~~~

> [!warning] A judge model is evidence, not truth
> Validate LLM-as-judge scores against domain experts and test sensitivity to prompt, ordering, model version, and reference-answer quality.

## Role connections

[[AI Assurance Evidence|AI Evaluation Engineer]], [[MLOps Engineer]], [[AI Assurance Evidence|AI Quality Assurance Engineer]], [[Data Scientist - AI ML|Data Scientist]], [[AI Product Manager]], and [[Governance, Risk, Policy and Ethics Careers|Responsible AI Lead]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Evaluation and observability]].
