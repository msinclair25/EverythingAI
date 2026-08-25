---
title: Free-First Tool Paths
type: visual-map
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, tools, visual-map]
cssclasses: [everything-ai]
---

# Free-First Tool Paths

```mermaid
flowchart TD
    A{"What do you need to learn?"}
    A -->|"AI/ML code"| C["Python · VS Code/VSCodium · Jupyter · Git · PyTorch/scikit-learn"]
    A -->|"Models locally"| L["Ollama/llama.cpp · compatible open-weight model · inspect license"]
    A -->|"RAG/search"| R["PostgreSQL + pgvector or open search/vector stack · local documents"]
    A -->|"Agents/workflows"| W["Plain code/state machine first · open framework if complexity earns it"]
    A -->|"Evaluation"| E["Versioned cases + Python/pytest + open eval/observability tools"]
    A -->|"Creative"| M["Open image/audio/video editors + free tiers/local models where terms fit"]
    A -->|"Automation"| N["Native app rules or open workflow tool · add model only to uncertain steps"]
    A -->|"Governance"| G["Markdown/spreadsheet inventory + NIST templates · enterprise GRC when scale/integration justify"]
    C --> P{"What forces a paid/enterprise step?"}
    L --> P
    R --> P
    W --> P
    E --> P
    M --> P
    N --> P
    G --> P
    P -->|"No"| F["Keep free path; document constraints"]
    P -->|"Scale · support · collaboration · security · compliance · proprietary capability"| X["Compare paid options using Tool Selection and Access Guide"]
```

## Principles

1. Learn the workflow on a free/open/local option when practical.
2. Learn a second implementation so your skill is not a button sequence.
3. Use paid products when their evidence supports a real need: capability, integration, governance, support, reliability, or scale.
4. Free tiers have limits and can change; verify current terms and data use.
5. “Open” can describe weights, code, data, or license separately.

Continue at [[AI Tool Atlas]].
