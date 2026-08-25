---
title: Data and Notebooks
tags:
  - atlas/tools
  - data/notebooks
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

# Data and Notebooks

Notebooks combine executable code, narrative, visualization, and results. They are excellent for exploration and teaching; production work needs environment pinning, tests, version control, data lineage, and a path out of hidden notebook state.

## Representative comparison

| Tool | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| Project Jupyter / JupyterLab | BSD-licensed open source | Local, portable notebook fundamentals | You operate environments and collaboration | [Jupyter](https://jupyter.org/) · [JupyterLab docs](https://jupyterlab.readthedocs.io/) |
| VS Code Jupyter | Free tooling; extension source published under Microsoft license | Notebook-to-code workflow in VS Code | Extension/cloud service terms differ | [docs](https://code.visualstudio.com/docs/datascience/jupyter-notebooks) · [GitHub](https://github.com/microsoft/vscode-jupyter) |
| Google Colab | Free hosted tier plus paid subscriptions/compute | Fast browser GPU/TPU learning and sharing | Dynamic quotas, availability, idle limits | [FAQ](https://research.google.com/colaboratory/faq.html) · [plans](https://colab.research.google.com/signup) |
| Kaggle Notebooks | No-fee hosted notebooks with quota-bound accelerators | Public datasets, competitions, reproducible learning | Quotas, internet/session constraints, public ecosystem | [docs](https://www.kaggle.com/docs/notebooks) · [terms](https://www.kaggle.com/terms) |
| Deepnote | Free entry plan plus paid team/enterprise | Collaborative data notebooks and app publishing | Seat/compute/AI allowances | [pricing](https://deepnote.com/pricing) · [docs](https://deepnote.com/docs) |
| Hex | Free entry plan plus paid team/enterprise and compute meters | Collaborative analytics, data apps, SQL/Python | Platform and compute cost/lock-in | [pricing](https://hex.tech/pricing/) · [docs](https://learn.hex.tech/) |
| Databricks Free Edition / platform | Free Edition for learning; paid managed platform | Lakehouse-centered data/ML collaboration | Platform complexity and cloud consumption | [Free Edition](https://www.databricks.com/product/faq/community-edition) · [pricing](https://www.databricks.com/product/pricing) |

## Selection criteria

- Local vs hosted execution and required accelerators.
- Reproducible environments, package pinning, secrets, and data mounts.
- Real-time collaboration, comments, review, Git integration, scheduling, and apps.
- SQL/data warehouse connections and data residency.
- Quotas, idle shutdown, egress, storage persistence, and background execution.
- Export to standard notebook/script formats and migration ease.

## Free-first path

1. Learn with local JupyterLab and a small public CSV.
2. Use Colab or Kaggle only when a hosted accelerator or shareable environment helps.
3. Put environment files and reusable functions in version control.
4. Trial collaborative platforms with synthetic data and one real team workflow.
5. Pay when collaboration, governed data access, scheduling, or reliable compute—not novelty—justifies it.

~~~mermaid
flowchart TD
    A["Notebook task"] --> B{"Sensitive data or custom environment?"}
    B -->|"Yes"| C["Local Jupyter or approved enterprise platform"]
    B -->|"No"| D{"Need free hosted accelerator?"}
    D -->|"Yes"| E["Colab or Kaggle"]
    D -->|"No"| F{"Need live team collaboration?"}
    F -->|"Yes"| G["Deepnote, Hex, or Databricks"]
    F -->|"No"| H["JupyterLab or VS Code"]
    C --> I["Pin environment and version code"]
    E --> I
    G --> I
    H --> I
~~~

## Role connections

[[Data Scientist - AI ML|Data Scientist]], [[Data Scientist - AI ML|Data Analyst]], [[ML Engineer]], [[AI ML Research Scientist|AI Research Scientist]], [[ML Data Engineer|Analytics Engineer]], and [[AI Trainer and Educator|AI Educator]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Data and notebooks]].
