---
title: Productivity and Research
tags:
  - atlas/tools
  - ai/productivity
  - ai/research
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

# Productivity and Research

General assistants can draft, analyze files, search, reason, create media, and operate connected tools. Research tools can accelerate discovery and synthesis, but every consequential claim still needs source inspection.

## Representative comparison

| Tool | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| ChatGPT | Free plus paid individual/business/enterprise tiers | General multimodal work, analysis, research, creation, tools | Feature/model limits and workspace data controls | [pricing](https://openai.com/chatgpt/pricing/) · [privacy](https://openai.com/enterprise-privacy/) |
| Claude | Free plus paid individual/team/enterprise tiers | Long documents, writing, research, analysis, artifacts | Usage limits, connectors, research availability by plan | [pricing](https://claude.com/pricing) · [privacy](https://privacy.anthropic.com/) |
| Gemini | Free consumer access plus paid Google AI/Workspace tiers | Google ecosystem, multimodal tasks, research | Consumer vs Workspace data terms and plan limits | [Google AI plans](https://one.google.com/about/google-ai-plans/) · [Workspace pricing](https://workspace.google.com/pricing.html) |
| NotebookLM | Free access plus higher limits/features through eligible Google plans/workspaces | Source-grounded study, synthesis, audio/video over a selected corpus | Source quality, quota, sharing and workspace controls | [NotebookLM](https://notebooklm.google/) · [help](https://support.google.com/notebooklm/) |
| Perplexity | Free plus paid individual/enterprise tiers | Web research with linked sources and model choice | Citation correctness, source coverage, premium limits | [pricing](https://www.perplexity.ai/enterprise/pricing) · [help](https://www.perplexity.ai/help-center/) |
| Microsoft Copilot | Free consumer access plus paid consumer/Microsoft 365/enterprise offerings | Microsoft ecosystem and workplace assistance | License boundary, grounding/connectors, organizational policy | [Copilot plans](https://www.microsoft.com/microsoft-copilot/for-individuals) · [Microsoft 365 Copilot](https://www.microsoft.com/microsoft-365-copilot/pricing/enterprise) |
| Elicit | Free entry plus paid plans | Literature search, screening, extraction, systematic-review assistance | Database coverage and extraction accuracy | [pricing](https://elicit.com/pricing) · [support](https://support.elicit.com/) |
| Consensus | Free entry plus paid plans | Question-driven academic search and synthesis | Coverage, study quality, generated summaries | [pricing](https://consensus.app/pricing/) · [help](https://help.consensus.app/) |
| Zotero | AGPL open-source app; free storage allowance plus paid storage | Citation library, PDFs, metadata, reproducible source management | Sync storage and metadata cleanup | [Zotero](https://www.zotero.org/) · [storage](https://www.zotero.org/storage) |
| Obsidian | Free app license for current permitted uses; optional paid Sync/Publish/commercial services | Local knowledge base and durable Markdown notes | Plugin security, sync/backup, collaboration | [pricing](https://obsidian.md/pricing) · [help](https://help.obsidian.md/) |

> [!warning] A citation is not verification
> Open the source, confirm it supports the exact claim, identify the publication/version/date, and prefer primary sources. Generated bibliographies may contain nonexistent or mismatched references.

## Selection criteria

- General creation vs source-bounded synthesis vs scholarly search vs citation management.
- Source controls, citation granularity, browsing date, and export.
- File formats/context limits, code execution, connectors, and collaboration.
- Consumer vs business data treatment, training use, retention, deletion, SSO, and audit.
- Accessibility, mobile/offline needs, local storage, and knowledge portability.
- Subscription, premium search/research quota, storage, connector, and team-seat costs.

## Free-first path

1. Keep the authoritative notes and bibliography in Obsidian + Zotero.
2. Use NotebookLM for a bounded public-source packet and a free general assistant for ideation.
3. Use Elicit/Consensus for discovery, then retrieve and read the original papers.
4. Create a claim-evidence table with URL/DOI, quote/paraphrase, date, and confidence.
5. Pay for higher limits, business privacy/admin, connectors, collaboration, or specialist databases.

~~~mermaid
flowchart TD
    A["Knowledge-work task"] --> B{"Bounded source packet?"}
    B -->|"Yes"| C["NotebookLM or assistant with supplied files"]
    B -->|"No, web discovery"| D["Perplexity/general deep research"]
    B -->|"No, scholarly literature"| E["Elicit or Consensus"]
    C --> F["Open and verify every cited source"]
    D --> F
    E --> F
    F --> G["Store notes in Obsidian and citations in Zotero"]
    G --> H["Human synthesis and decision"]
~~~

## Role connections

[[AI Business Analyst|AI Research Analyst]], [[Knowledge Architecture|Knowledge Manager]], [[AI Business Analyst|Business Analyst]], [[Prompt and Context Engineer]], [[AI Trainer and Educator|AI Trainer]], [[AI Content Designer|Technical Writer]], and nearly every role in the vault.

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Productivity and research]].
