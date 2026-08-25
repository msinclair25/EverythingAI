---
title: Governance and Compliance
tags:
  - atlas/tools
  - ai/governance
  - ai/compliance
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

# Governance and Compliance

Governance tools help inventory AI use, assign ownership, assess risk, map controls, collect evidence, monitor behavior, manage incidents, and report decisions. No platform makes an organization compliant by itself.

> [!warning] U.S. legal landscape
> This is operational education, not legal advice. Federal agency rules, sector obligations, procurement terms, and state/local laws can apply simultaneously and change quickly. Counsel and accountable business owners must interpret requirements for the actual use case.

## Frameworks and representative platforms

| Tool/resource | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| NIST AI Risk Management Framework | Free U.S. government framework, playbook, and profiles | Common vocabulary and voluntary risk program baseline | Requires organization-specific controls/evidence | [AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) · [playbook](https://airc.nist.gov/airmf-resources/playbook/) |
| NIST Generative AI Profile | Free U.S. government companion profile | Generative-AI risks and actions mapped to AI RMF | Guidance, not certification | [NIST AI 600-1](https://doi.org/10.6028/NIST.AI.600-1) |
| ISO/IEC 42001 | Paid standard; implementation/audit/certification services separate | AI management system certification path | Standard text and certification require budget/expertise | [ISO page](https://www.iso.org/standard/81230.html) |
| MLflow Model Registry | Apache-2.0 open source; managed versions paid | Technical model/version lineage and promotion | Not a complete governance/GRC system | [registry docs](https://mlflow.org/docs/latest/ml/model-registry/) |
| IBM watsonx.governance | Paid managed/software offering and enterprise | Model/use-case governance, risk, compliance, monitoring | Platform integration and contract cost | [pricing](https://www.ibm.com/products/watsonx-governance/pricing) · [docs](https://www.ibm.com/docs/en/watsonx/w-and-w/2.2.0?topic=watsonxgovernance) |
| Microsoft Purview + Microsoft Foundry governance | Paid Microsoft services; Foundry platform exploration is free while consumed products/resources have their own meters | Microsoft data governance, compliance, and Azure AI estate | Multiple products/licenses and configuration scope | [Purview pricing](https://azure.microsoft.com/pricing/details/purview/) · [Foundry](https://learn.microsoft.com/en-us/azure/foundry/what-is-foundry) |
| AWS Audit Manager + Bedrock Guardrails | Paid cloud usage; trials/allowances where listed | Evidence and runtime safeguards in AWS | Cloud-specific controls and separate meters | [Audit Manager pricing](https://aws.amazon.com/audit-manager/pricing/) · [Bedrock pricing](https://aws.amazon.com/bedrock/pricing/) |
| Google Cloud Model Armor / Vertex AI governance | Paid cloud usage; free preview/allowance only where current page says | Prompt/response protection and governed GCP AI | Product/region/feature availability and cloud coupling | [Model Armor pricing](https://cloud.google.com/security-command-center/pricing#model_armor) · [Responsible AI](https://cloud.google.com/responsible-ai) |
| Credo AI | Paid enterprise platform | Cross-functional AI inventory, risk, policy, evidence | Sales-led procurement and integration effort | [platform](https://www.credo.ai/platform) |
| OneTrust AI Governance | Paid enterprise platform | AI governance integrated with privacy/data/GRC workflows | Broad platform implementation and contract cost | [solution](https://www.onetrust.com/solutions/ai-governance/) |

## Minimum viable governance system

| Record | Minimum fields |
|---|---|
| AI inventory | owner, purpose, users, model/vendor/version, data, integrations, status |
| Impact/risk assessment | affected people, rights/safety impact, misuse, likelihood/severity, mitigations |
| Approval | accountable approver, conditions, evidence, expiry/review date |
| Evaluation | dataset/version, metrics, subgroup results, safety tests, limitations |
| Deployment | environment, access, monitoring, human oversight, rollback, incident route |
| Change log | prompt/model/data/tool/index/vendor changes and reapproval trigger |
| Incident | detection, impact, containment, notification, remediation, lessons |

## Selection criteria

- Inventory and workflow flexibility across purchased, embedded, and internally built AI.
- Control/framework mappings plus ability to add U.S. federal, state, sector, and contract requirements.
- Evidence automation without losing human accountability.
- Model/data lineage, evaluation, monitoring, incident, and third-party-risk integrations.
- SSO/SCIM, roles, audit, retention, legal hold, export, APIs, and reporting.
- Separation between vendor assertions, internal evidence, auditor evidence, and legal conclusions.

## Free-first path

1. Use NIST AI RMF/Playbook to create an inventory and risk-tiering spreadsheet or Markdown template.
2. Link each high-risk control to an owner, implementation, evidence artifact, test, and review date.
3. Use Git/MLflow/issue tracking to preserve technical lineage and approvals.
4. Pilot a commercial platform only after the workflow and required reports are understood.
5. Buy for scale, integrations, evidence collection, access control, auditability, or certification—not for a “compliant AI” badge.

~~~mermaid
flowchart TD
    A["Proposed AI use"] --> B["Inventory and owner"]
    B --> C["Impact and risk assessment"]
    C --> D{"Risk accepted with controls?"}
    D -->|"No"| E["Redesign, restrict, or reject"]
    D -->|"Yes"| F["Implement and test controls"]
    F --> G["Document approval and limitations"]
    G --> H["Deploy with monitoring and human oversight"]
    H --> I{"Material change or incident?"}
    I -->|"Yes"| C
    I -->|"No"| J["Scheduled review"]
    J --> C
~~~

## Role connections

[[Governance, Risk, Policy and Ethics Careers|AI Governance Specialist]], [[Governance, Risk, Policy and Ethics Careers|Responsible AI Lead]], [[Governance, Risk, Policy and Ethics Careers|AI Risk Manager]], [[Governance, Risk, Policy and Ethics Careers|AI Compliance Analyst]], [[AI Risk and Control Design|Privacy Engineer]], [[Governance, Risk, Policy and Ethics Careers|Model Risk Manager]], and [[AI Assurance Evidence|Internal Auditor]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Governance and compliance]].
