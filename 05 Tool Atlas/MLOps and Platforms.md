---
title: MLOps and Platforms
tags:
  - atlas/tools
  - ai/mlops
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

# MLOps and Platforms

MLOps makes data, code, models, prompts, evaluations, deployments, and decisions reproducible and operable. LLMOps adds prompt/model gateways, traces, retrieval evaluation, and agent/tool behavior, but does not remove standard software operations.

> [!abstract] AI × DevOps/cloud study path
> Use [[AI DevOps and Cloud Engineering — 2026-08-24]] as the companion lifecycle note. It connects the MLOps loop to conventional DevOps, IaC, OIDC/WIF, evaluation gates, Kubernetes/runtime choices, OTel/MCP observability, supply-chain evidence, FinOps, role ownership, and recovery.

> [!tip] Azure delivery overlay · 2026-08-24
> [[Microsoft Azure DevOps and Foundry]] is a concrete MLOps path for teams standardized on Microsoft: Azure Boards/Repos/Pipelines provide change and environment control; Foundry provides hosted agents, Toolboxes, evaluation, tracing, and runtime identities. Study [[Case - Azure DevOps Foundry Release Gate]] to rehearse the WIF → evaluation → staging → approval → production loop.

The key operational boundary is identity. The Azure Pipelines service connection provisions or deploys through WIF; the Foundry project managed identity performs platform operations; the hosted-agent identity reads only the runtime resources it needs. Do not collapse those identities into one broad secret.

> [!tip] Edge/web platform overlay · 2026-08-24
> [[Cloudflare and Vercel AI]] adds two modern operational shapes: Cloudflare Agents + Durable Objects + Workflows for durable edge state, and Vercel AI SDK 7 + WorkflowAgent + Fluid Compute for TypeScript/web agent delivery. Evaluate recovery, identity, cost, provider routing, sandboxing, and trace correlation rather than treating “serverless” as an SLO.

## Representative comparison

| Tool/platform | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| MLflow | Apache-2.0 open source; managed offerings through Databricks/others are paid | Experiment tracking, registry, evaluation, deployment metadata | Self-host operations or managed-platform coupling | [MLflow](https://mlflow.org/) · [GitHub](https://github.com/mlflow/mlflow) |
| DVC | Apache-2.0 open-source CLI and VS Code extension | Git-centered data/model versioning and pipelines | Storage/remote setup and workflow discipline | [DVC](https://dvc.org/) · [documentation](https://dvc.org/doc) |
| Kubeflow | Apache-2.0 open source | Kubernetes-native ML pipelines and multi-user platforms | Significant Kubernetes/platform engineering | [docs](https://www.kubeflow.org/docs/) · [GitHub](https://github.com/kubeflow/kubeflow) |
| Weights & Biases | Free/developer posture plus paid team/enterprise | Collaborative experiment tracking, artifacts, registry, evals | Seat/usage meters and SaaS dependence | [pricing](https://wandb.ai/site/pricing) · [docs](https://docs.wandb.ai/) |
| BentoML / BentoCloud | Apache-2.0 open-source framework plus paid managed cloud | Packaging and serving AI applications | Managed platform cost or self-host operations | [docs](https://docs.bentoml.com/) · [BentoCloud](https://www.bentoml.com/pricing) |
| KServe | Apache-2.0 open source | Kubernetes model inference standardization | Kubernetes complexity | [docs](https://kserve.github.io/website/) · [GitHub](https://github.com/kserve/kserve) |
| Databricks | Paid managed platform; Free Edition for learning | Unified lakehouse, managed MLflow, data/AI governance | Platform commitment and multi-part consumption | [pricing](https://www.databricks.com/product/pricing) · [MLflow docs](https://docs.databricks.com/aws/en/mlflow/) |
| SageMaker AI / Vertex AI / Azure Machine Learning | Paid hyperscaler platforms; trials/credits may apply | End-to-end managed ML inside an existing cloud | Breadth, configuration, and cloud lock-in | [SageMaker](https://aws.amazon.com/sagemaker/ai/pricing/) · [Vertex AI](https://cloud.google.com/vertex-ai/pricing) · [Azure ML](https://azure.microsoft.com/pricing/details/machine-learning/) |

## Selection criteria

- Artifact lineage across data, code, environment, model, prompt, index, evaluation, and approval.
- Reproducible runs, pipeline orchestration, registry/promotion, rollback, and access control.
- Batch vs realtime serving, autoscaling, canary/shadow deployment, and feature stores.
- Traditional ML plus generative AI/agent tracing and evaluation.
- Cloud/Kubernetes skills, support model, incident ownership, and portability.
- Total platform, storage, compute, network, seat, and engineering cost.

## Free-first path

1. Use Git plus environment lockfiles and a simple run manifest.
2. Add MLflow for experiments/registry and DVC only when data/artifact versioning demands it.
3. Containerize one inference service and define health, metrics, rollback, and evaluation gates.
4. Trial a managed platform with a complete cost tag/budget and deletion checklist.
5. Adopt Kubernetes-scale platforms only for demonstrated multi-team or reliability requirements.

~~~mermaid
flowchart TD
    A["Need repeatable ML lifecycle"] --> B{"Single team / modest scale?"}
    B -->|"Yes"| C["Git + MLflow + optional DVC"]
    B -->|"No"| D{"Existing cloud standard?"}
    D -->|"AWS"| E["SageMaker shortlist"]
    D -->|"Google Cloud"| F["Vertex AI shortlist"]
    D -->|"Azure"| G["Azure ML shortlist"]
    D -->|"Lakehouse"| H["Databricks shortlist"]
    D -->|"Kubernetes/control"| I["Kubeflow + KServe + open tools"]
    C --> J["Promotion gate and rollback"]
    E --> J
    F --> J
    G --> J
    H --> J
    I --> J
~~~

## Role connections

[[MLOps Engineer]], [[ML Engineer]], [[AI Platform Engineer]], [[ML Data Engineer|Data Engineer]], [[MLOps Engineer|DevOps Engineer]], and [[AI Solutions Architect]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#MLOps and platforms]].
