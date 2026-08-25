---
title: Model Training and Fine-Tuning
tags:
  - atlas/tools
  - ai/training
  - ai/fine-tuning
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

# Model Training and Fine-Tuning

Fine-tuning changes model behavior by training on examples. It is appropriate when prompting, retrieval, tools, or deterministic code cannot reliably produce the desired behavior—and when you can create clean training data plus a separate held-out evaluation set.

## Representative comparison

| Tool/service | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| PyTorch | BSD-style open source | General deep-learning training foundation | You assemble higher-level workflow | [PyTorch](https://pytorch.org/) · [GitHub](https://github.com/pytorch/pytorch) |
| Hugging Face Transformers + PEFT + TRL | Apache-2.0 open-source libraries | Supervised tuning, adapters/LoRA, preference/alignment workflows | Model licenses and training expertise | [training docs](https://huggingface.co/docs/transformers/training) · [PEFT](https://huggingface.co/docs/peft/) · [TRL](https://huggingface.co/docs/trl/) |
| Unsloth | Open-source tooling plus commercial offerings where listed | Memory-efficient fine-tuning on constrained GPUs | Supported model/hardware matrix changes quickly | [docs](https://docs.unsloth.ai/) · [GitHub](https://github.com/unslothai/unsloth) |
| Axolotl | Apache-2.0 open source | Configuration-driven LLM post-training | Configuration and GPU operations complexity | [docs](https://docs.axolotl.ai/) · [GitHub](https://github.com/axolotl-ai-cloud/axolotl) |
| Lightning AI | Open-source Lightning libraries; hosted free/paid compute plans | Structured training and managed development environments | Cloud credits/compute and platform workflow | [pricing](https://lightning.ai/pricing) · [docs](https://lightning.ai/docs/pytorch/stable/) |
| OpenAI fine-tuning | Paid managed training and inference on eligible models | API-based behavior customization without GPU operations | Provider/model eligibility, data and per-stage cost | [guide](https://platform.openai.com/docs/guides/fine-tuning) · [pricing](https://openai.com/api/pricing/) |
| AWS SageMaker AI | Paid managed cloud platform; free-tier eligibility varies | Enterprise training, tuning, pipelines in AWS | Infrastructure breadth and consumption complexity | [pricing](https://aws.amazon.com/sagemaker/ai/pricing/) · [docs](https://docs.aws.amazon.com/sagemaker/) |
| Vertex AI training/tuning | Paid Google Cloud usage | Managed tuning and custom training in GCP | Region/model and accelerator charges | [pricing](https://cloud.google.com/vertex-ai/pricing) · [docs](https://cloud.google.com/vertex-ai/docs/training/overview) |

## Selection criteria

- Is the gap knowledge (prefer RAG), deterministic logic (prefer code), or behavior/style (fine-tuning may help)?
- Data consent, rights, provenance, representativeness, deduplication, toxicity, and PII.
- Base model license, supported tuning method, context, hardware, and export rights.
- Full training vs LoRA/QLoRA/adapters vs managed fine-tuning.
- Held-out task, safety, bias, memorization, and regression evaluation.
- Training, checkpoint storage, experiment tracking, serving, and future retraining cost.

## Free-first path

1. Prove the baseline with prompting/RAG and freeze a held-out evaluation set.
2. Curate a tiny high-quality public/synthetic dataset; never evaluate on training examples.
3. Fine-tune a small permitted model with PEFT/TRL, Unsloth, or Axolotl on owned hardware or quota-bound notebook compute.
4. Compare against the untuned model blind, including safety and general-capability regressions.
5. Use managed training only when data controls, scale, reliability, or team operations justify it.

~~~mermaid
flowchart TD
    A["Model underperforms"] --> B{"Missing current/private knowledge?"}
    B -->|"Yes"| C["Use RAG"]
    B -->|"No"| D{"Rule can be coded?"}
    D -->|"Yes"| E["Use deterministic code/tool"]
    D -->|"No"| F{"Repeated behavior/style gap with good examples?"}
    F -->|"No"| G["Improve prompt, UX, or model choice"]
    F -->|"Yes"| H["Small adapter tune"]
    H --> I["Held-out quality, safety, and memorization eval"]
    I --> J{"Clear gain?"}
    J -->|"No"| K["Do not deploy tune"]
    J -->|"Yes"| L["Version, register, monitor, rollback"]
~~~

> [!warning] Training is a data product
> A large noisy dataset can be worse than a small reviewed one. Preserve source, consent/license, transformations, exclusions, and reviewer decisions for every record.

## Role connections

[[ML Engineer]], [[AI ML Research Scientist|AI Research Scientist]], [[Applied Scientist]], [[ML Data Engineer|AI Data Specialist]], [[Human Feedback Operations|RLHF Specialist]], and [[MLOps Engineer]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Model training and fine-tuning]].
