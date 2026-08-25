---
title: Security and Red Teaming
tags:
  - atlas/tools
  - ai/security
  - ai/red-teaming
status: published
type: tool-category
scope: United States
level:
  - beginner
  - intermediate
  - advanced
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
cssclasses:
  - everything-ai
source_policy: official-only
---

# Security and Red Teaming

AI security testing covers model behavior *and* the surrounding application: prompts, retrieval, tools, identity, secrets, data stores, supply chain, plugins, sandboxes, logs, and human approvals.

> [!tip] OWASP 2026 deep dive
> Use [[OWASP and AI Security — 2026]] for a full study path across the current LLM Top 10, Agentic Top 10, GenAI Data Security, secure MCP, AIBOM, COMPASS, governance, incident response, quizzes, flashcards, and projects. Work [[Case - OWASP Agentic Security Review]] after [[Case - Agent Permissions]].

> [!info] MCP protocol lab
> Use [[MCP Deep Dive — 2026-08-24]] for tool poisoning, indirect injection, OAuth issuer/audience checks, token passthrough, SSRF/DNS rebinding, path isolation, task replay, registry provenance, Inspector, and conformance practice.

> [!danger] Test only with authorization
> Red-team tools can generate harmful content, probe services, and trigger real actions or cost. Use a written scope, isolated environment, test accounts, rate/spend caps, cleanup plan, and emergency stop.

## Representative comparison

| Tool/resource | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| MITRE ATLAS | Free public knowledge base | Threat modeling and mapping adversary techniques | Reference—not an automated control | [ATLAS](https://atlas.mitre.org/) |
| OWASP GenAI Security Project | Free/open community guidance | LLM/agent application risk checklists and test planning | Guidance requires local interpretation | [project](https://genai.owasp.org/) |
| NIST AI RMF + adversarial ML guidance | Free U.S. government guidance | Risk program structure and terminology | Voluntary framework, not product certification | [AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) · [AML taxonomy](https://csrc.nist.gov/pubs/ai/100/2/e2025/final) |
| Microsoft PyRIT | MIT-licensed open source | Programmatic generative-AI risk identification/red teaming | Requires safe targets, datasets, and expert interpretation | [GitHub](https://github.com/Azure/PyRIT) · [docs](https://azure.github.io/PyRIT/) |
| NVIDIA garak | Apache-2.0 open source | Automated LLM vulnerability probing across many detectors | Scanner findings need validation | [GitHub](https://github.com/NVIDIA/garak) · [docs](https://reference.garak.ai/) |
| promptfoo | Open-source CLI plus paid cloud/enterprise | CI security/evaluation cases and provider testing | Coverage depends on attack/test design | [red-team docs](https://www.promptfoo.dev/docs/red-team/) · [pricing](https://www.promptfoo.dev/pricing/) |
| Giskard | Open-source testing library plus paid platform | LLM vulnerability scans and enterprise red-team workflows | Platform scope/pricing and finding validation | [GitHub](https://github.com/Giskard-AI/giskard) · [pricing](https://www.giskard.ai/pricing) |
| Lakera Guard | Commercial API/enterprise service; evaluation access as offered | Runtime prompt-attack/content defenses | Adds latency/cost; must test bypasses and false positives | [product](https://www.lakera.ai/lakera-guard) · [docs](https://docs.lakera.ai/) |
| OWASP FinBot CTF | Free controlled training application | Hands-on agentic security findings and mitigations | Use only inside its intended sandbox and scope | [project](https://genai.owasp.org/) |
| OWASP AIBOM Generator | Free/open tool | Model and AI supply-chain inventory in CycloneDX-aligned output | It does not replace a complete system inventory | [resource](https://genai.owasp.org/resource/owasp-aibom-generator/) |
| MCP Inspector | Free/open reference Web, CLI, and TUI tool | Inspect tools, resources, prompts, OAuth, and protocol-era behavior | Developer tool—not a production trust verdict | [reference](https://github.com/modelcontextprotocol/modelcontextprotocol/blob/main/docs/docs/2026-07-28/tools/inspector.mdx) |
| MCP Conformance | Free/open official test framework | Version-scoped client/server, wire-schema, auth, backcompat, and extension checks | Required scenarios vary by protocol version and tier | [GitHub](https://github.com/modelcontextprotocol/conformance) |

## Minimum test families

- Direct and indirect prompt injection; data/tool instruction conflicts.
- Broken authorization, cross-tenant leakage, and excessive agency.
- Secret, PII, proprietary-data, and system-prompt extraction.
- Unsafe tool arguments, command/code injection, SSRF, path traversal, and exfiltration.
- Malicious documents, images, links, connectors, packages, models, and MCP/tool servers.
- Denial of wallet/service, context flooding, retry loops, and resource exhaustion.
- Harmful, biased, deceptive, or policy-violating outputs.
- Logging/telemetry leakage and incident detection/response.

## Free-first path

1. Threat-model the data flow with MITRE ATLAS, OWASP, and NIST vocabulary.
2. Write manual abuse cases before running a scanner.
3. Run PyRIT, garak, promptfoo, or Giskard against a local/staging target.
4. Triage every finding for exploitability and business impact; retain evidence safely.
5. Buy runtime or enterprise tooling only after measuring coverage, bypass, latency, false positives, and operational fit.

~~~mermaid
flowchart TD
    A["Authorized system scope"] --> B["Threat model"]
    B --> C["Manual abuse cases"]
    C --> D["Automated probes"]
    D --> E["Validate findings"]
    E --> F{"Material risk?"}
    F -->|"Yes"| G["Mitigate in design, permissions, filters, or monitoring"]
    G --> H["Regression test"]
    H --> D
    F -->|"No"| I["Document rationale and residual risk"]
~~~

## Role connections

[[AI Threat Modeling|AI Security Engineer]], [[AI Threat Modeling|AI Red Team Specialist]], [[AI Threat Modeling|Application Security Engineer]], [[Governance, Risk, Policy and Ethics Careers|Responsible AI Lead]], [[MLOps Engineer]], and [[Governance, Risk, Policy and Ethics Careers|AI Governance Specialist]].

## Official-source record

Verified **2026-08-24**. The current OWASP 2026 LLM and Agentic Top 10, Data Security, secure MCP, AIBOM, COMPASS, and governance sources are indexed in [[OWASP and AI Security — 2026]] and [[Tool Source Registry#Security and red teaming]].
