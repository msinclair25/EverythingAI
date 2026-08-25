---
title: Foundation Model and API Providers
tags:
  - atlas/tools
  - ai/models
  - ai/apis
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

# Foundation Model and API Providers

These services provide hosted text, reasoning, multimodal, embedding, image, speech, and agent-capable models. Availability is model-, region-, account-, and safety-tier-dependent.

> [!warning] Use the live calculator
> Model catalogs, context windows, rate limits, batch discounts, cache charges, tool/search fees, and deprecations change rapidly. The table records pricing **posture**, not dollar amounts.

## Representative comparison

| Provider | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| OpenAI API | Paid usage; enterprise arrangements | Broad multimodal and agent/application development | Model snapshots, tool charges, data controls | [API pricing](https://openai.com/api/pricing/) · [docs](https://platform.openai.com/docs/) |
| Anthropic Claude API | Paid usage; enterprise | Long-form reasoning, coding, tool-using applications | Tier/rate limits and model retirement | [Claude pricing](https://claude.com/pricing) · [API docs](https://docs.anthropic.com/) |
| Google Gemini Developer API | Free tier on eligible models plus paid tiers | Multimodal prototyping through AI Studio and Google ecosystem | Free-vs-paid data treatment, preview status, grounding charges | [pricing](https://ai.google.dev/gemini-api/docs/pricing) · [docs](https://ai.google.dev/gemini-api/docs) |
| AWS Bedrock | Paid usage; enterprise AWS controls | Multi-provider choice inside AWS governance/networking | Region/model availability and separate guardrail/agent charges | [pricing](https://aws.amazon.com/bedrock/pricing/) · [docs](https://docs.aws.amazon.com/bedrock/) |
| Microsoft Foundry (formerly Azure AI Foundry) | Platform is free to explore; deployed models, agents, tools, and Azure resources are paid by their meters; enterprise | Microsoft/Azure estates, identity, networking, model catalog | Deployment type, region, quotas, preview status, ancillary services | [pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-foundry/) · [docs](https://learn.microsoft.com/en-us/azure/foundry/) |
| Google Vertex AI | Paid cloud usage; enterprise | Managed Google Cloud model and ML lifecycle | Region, quota, grounding, tuning, and endpoint costs | [generative AI pricing](https://cloud.google.com/vertex-ai/generative-ai/pricing) · [docs](https://cloud.google.com/vertex-ai/generative-ai/docs) |
| Cohere | Trial/evaluation access where offered; paid and enterprise | Enterprise language, retrieval, reranking | Trial limits and deployment terms | [pricing](https://cohere.com/pricing) · [docs](https://docs.cohere.com/) |
| Mistral AI La Plateforme | Trial/free allowance where offered; paid usage and enterprise | European-origin hosted/open-model ecosystem and efficient models | Model license differs from API terms | [pricing](https://mistral.ai/pricing) · [docs](https://docs.mistral.ai/) |

## Selection criteria

- **Task evidence:** compare models blind on the same held-out set; do not infer quality from a benchmark headline.
- **Modality and tools:** required inputs/outputs, structured output, tool calling, computer use, code execution, retrieval, and realtime behavior.
- **Lifecycle:** stable vs preview model, retirement notice, pinned snapshots, reproducibility.
- **Data controls:** retention, training use, abuse monitoring, zero-data-retention eligibility, region, deletion, and subprocessors.
- **Operations:** rate limits, batch, caching, spend limits, latency, error behavior, SLAs, and support.
- **Portability:** standard request/response interfaces help, but tool schemas and model behavior remain provider-specific.

## Free-first path

1. Define 30–100 public or synthetic examples with a rubric.
2. Use an eligible Gemini API free tier or limited playground access offered by providers.
3. Add one small open model through [[Local and Open Model Runtimes]] as a portability baseline.
4. Pay for two shortlisted hosted models only long enough to run the same evaluation.
5. Choose on total workflow quality and cost—not tokens alone.

~~~mermaid
flowchart TD
    A["Hosted model needed"] --> B{"Must remain in an existing cloud boundary?"}
    B -->|"AWS"| C["Bedrock shortlist"]
    B -->|"Azure"| D["Microsoft Foundry shortlist"]
    B -->|"Google Cloud"| E["Vertex AI shortlist"]
    B -->|"No"| F["Direct provider APIs"]
    C --> G["Run identical eval set"]
    D --> G
    E --> G
    F --> G
    G --> H{"Need local fallback or maximum control?"}
    H -->|"Yes"| I["Add open-model baseline"]
    H -->|"No"| J["Pilot with spend and safety limits"]
~~~

## Role connections

[[AI Engineer]] integrates APIs; [[Prompt and Context Engineer]] designs and evaluates interactions; [[AI Product Manager]] connects capability to user value; [[Governance, Risk, Policy and Ethics Careers|AI Governance Specialist]] assesses data/contract risk; [[AI Economics and FinOps|FinOps Analyst]] models usage economics.

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Foundation model and API providers]].
