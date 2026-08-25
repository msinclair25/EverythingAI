---
title: AI Coding Tools
tags:
  - atlas/tools
  - ai/coding
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

# AI Coding Tools

Coding assistants span autocomplete, chat, code review, terminal agents, issue-to-PR workflows, and autonomous multi-file changes. Plan names and included model/agent usage are especially volatile.

## Representative comparison

| Tool | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| GitHub Copilot | Free plan plus paid individual/business/enterprise plans | GitHub-centered teams and broad editor support | Premium request/credit meters and Actions use | [plans](https://github.com/features/copilot/plans) · [billing docs](https://docs.github.com/en/billing/concepts/product-billing/github-copilot-billing) |
| Gemini Code Assist | Individual free access plus paid Standard/Enterprise | Google Cloud users and generous individual entry path | Enterprise feature/telemetry policy and quotas | [overview](https://developers.google.com/gemini-code-assist/docs/overview) · [pricing](https://cloud.google.com/products/gemini/pricing) |
| Amazon Q Developer | Free tier plus paid Pro | AWS development and IDE/CLI assistance | AWS account integration and transformation charges | [pricing](https://aws.amazon.com/q/developer/pricing/) · [docs](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/) |
| Cursor | Limited/free entry plan plus paid individual/team/enterprise | AI-first editor and multi-file agent workflows | Usage pools, model multipliers, code/data settings | [pricing](https://www.cursor.com/pricing) · [security](https://www.cursor.com/security) |
| Windsurf | Free/limited and paid plans | AI-native editor and agentic development | Credit/usage model and product ownership changes | [pricing](https://windsurf.com/pricing) · [docs](https://docs.windsurf.com/) |
| Claude Code | Proprietary client; access through eligible paid Claude plans, Anthropic billing, or supported enterprise cloud integrations | Terminal-centric coding and automation | Underlying model usage, permissions, data handling, and tool access | [docs](https://docs.anthropic.com/en/docs/claude-code/overview) · [official repository](https://github.com/anthropics/claude-code) |
| OpenAI Codex | Included/limited by eligible ChatGPT plans and cloud/API-related usage as documented | Parallel coding tasks and repository workflows | Plan inclusion, cloud execution, permissions, limits | [Codex](https://openai.com/codex/) · [docs](https://developers.openai.com/codex/) |

> [!warning] Treat agents like junior collaborators with credentials
> Review diffs, constrain permissions, protect secrets, run tests in isolated environments, and require human approval before deploy, merge, package publish, billing, or destructive actions.

## Selection criteria

- IDE/terminal/repository fit and supported languages.
- Context controls: exclusions, indexing, retention, training use, and admin policy.
- Agent isolation, network access, secret handling, approval gates, and audit logs.
- Quality on your actual codebase: issue completion, regression rate, test quality, security findings, and review time.
- Pricing unit: seats, premium requests, model credits, API tokens, compute, or Actions minutes.
- Enterprise needs: SSO, policy management, indemnity/IP filters, regional controls, and support.

## Free-first path

1. Use a free plan on a disposable practice repository with no secrets.
2. Build a 10-task benchmark: explanation, test generation, bug fix, refactor, dependency update, and security review.
3. Measure accepted-diff rate, regressions, time-to-review, and total usage—not generated lines.
4. Trial one editor agent and one terminal/repository agent.
5. Pay only after the workflow saves *reviewed* engineering time.

~~~mermaid
flowchart TD
    A["Coding assistance needed"] --> B{"Stay in current editor?"}
    B -->|"Yes"| C["Copilot, Gemini Code Assist, or Amazon Q"]
    B -->|"No, AI-first editor"| D["Cursor or Windsurf"]
    B -->|"Terminal / delegated task"| E["Claude Code or Codex"]
    C --> F["Run repository benchmark"]
    D --> F
    E --> F
    F --> G{"Security and review gates pass?"}
    G -->|"No"| H["Reduce permissions or change tool"]
    G -->|"Yes"| I["Pilot with usage cap"]
~~~

## Role connections

[[AI Engineer|Software Engineer]], [[AI Engineer]], [[ML Engineer]], [[MLOps Engineer|DevOps Engineer]], [[AI Threat Modeling|Application Security Engineer]], and [[AI Program Manager|Engineering Manager]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#AI coding tools]].
