---
title: Azure DevOps Foundry Release Dossier Template
aliases:
  - Foundry Release Dossier
  - Azure Agent Release Evidence Template
type: template
scope: United States
level:
  - intermediate
  - advanced
status: current
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
tags:
  - ai-careers
  - template
  - azure
  - azure-devops
  - foundry
  - ai/mlops
cssclasses:
  - everything-ai
---

# Azure DevOps + Foundry release dossier — {{release}}

> [!abstract] Purpose
> Capture the evidence needed to decide whether an Azure DevOps change can promote a Microsoft Foundry agent. This is a release record and study artifact, not a substitute for tenant policy or an approved change-management process.

**Study companion:** [[Microsoft Azure DevOps and Foundry]] · [[Case - Azure DevOps Foundry Release Gate]]

## Release identity

- Release name:
- Date / timezone:
- Owner:
- Business owner:
- Risk owner:
- Azure DevOps organization / project / repository:
- Board work item:
- Pull request:
- Commit SHA:
- Agent name / version:
- Foundry account / project / region:
- Model deployment:
- Toolbox / MCP server / version:
- Candidate and rollback versions:
- Status: proposed | staging | approved | rejected | rolled back
- Review by:

## Contract and boundaries

- Intended users:
- Intended task:
- Allowed reads:
- Allowed writes:
- Prohibited actions:
- Human approval points:
- Synthetic/public data statement:
- Latency envelope:
- Cost envelope:
- Safety and privacy requirements:
- Accessibility or recourse requirements:

## Architecture

~~~mermaid
flowchart LR
    W["Work item"] --> P["PR + branch policy"]
    P --> C["Pipeline + WIF"]
    C --> E["Eval + security checks"]
    E --> S["Foundry staging"]
    S --> A["Environment approval"]
    A --> R["Foundry production"]
    R --> T["Traces + monitors"]
    T --> W
~~~

Describe data flow, model calls, retrieval, tools, MCP/Toolbox boundaries, network path, and human operations. Mark every irreversible side effect.

## Identity and access matrix

| Actor | Identity | Resource | Allowed operations | Evidence / owner |
|---|---|---|---|---|
| Developer |  |  |  |  |
| Azure Pipelines | WIF service connection or managed identity |  |  |  |
| Foundry project | Project managed identity |  |  |  |
| Hosted agent | Dedicated runtime identity |  |  |  |
| Approver | Entra user/group |  |  |  |
| MCP client / Toolbox |  |  |  |  |

## Change and review evidence

- [ ] Board work item has outcome, owner, acceptance criteria, risk, and test-data boundary.
- [ ] PR has minimum reviewers, linked work item, build validation, comment resolution, and status checks.
- [ ] Prompt, model, tool, Toolbox, evaluator, threshold, identity, network, and redaction changes are identified.
- [ ] No PAT, API key, client secret, or connection string is committed.
- [ ] Branch policy or environment policy was not changed by the agent being released.

## Pipeline and evaluation

- Azure DevOps pipeline:
- Agent pool:
- **azd --version**:
- Installed azd extensions:
- Service connection:
- Environment:
- Evaluation file / dataset / hash:
- Evaluator and judge model versions:
- Thresholds:
- Run ID:
- Artifact links:

| Gate | Result | Evidence | Owner / follow-up |
|---|---|---|---|
| Unit and contract tests |  |  |  |
| Security and injection tests |  |  |  |
| Evaluation quality |  |  |  |
| Disallowed-action rate |  |  |  |
| Cost and latency budget |  |  |  |
| Staging smoke and trace |  |  |  |

> [!warning] Command-surface check
> Record the installed azd extension and command surface. Current guidance uses **azd ai eval init** and **azd ai eval run start**; older material may use **azd ai agent eval** commands. Do not mix them without a pinned version and a successful dry run.

## MCP and Toolbox review

- Server URL / transport:
- Remote or local:
- Entra OAuth or PAT path:
- Toolsets:
- Individual tools:
- Read-only header or policy:
- Write tools disabled?:
- Prompt-injection tests:
- Malformed-argument tests:
- Timeout / retry / duplicate-delivery tests:
- Trace and audit fields:
- Rollback / version pin:

## Staging evidence

- Deployed agent version:
- Runtime identity:
- Network and egress verification:
- Smoke request / expected result:
- Trace ID:
- Tool spans present:
- Redaction verified:
- App Insights / monitoring link:

## Production decision

**Decision:** approve | hold | reject | rollback

**Approver:**

**Evidence reviewed:**

- [ ] Evaluation score distribution and failed examples
- [ ] Safety, privacy, security, and injection results
- [ ] Identity and least-privilege matrix
- [ ] Network and egress checks
- [ ] Cost / latency envelope
- [ ] Staging smoke trace
- [ ] Rollback target and operator

**Rationale:**

## Post-deploy monitoring and rollback

- Quality signal and threshold:
- Safety / abuse signal:
- Latency / availability SLO:
- Cost or token budget:
- Trace sampling / retention:
- Alert owner:
- Incident path:
- Rollback command or version:
- Data compensation / idempotency plan:
- Review date:

## Interview transfer

- What did the pipeline prove?
- What did it not prove?
- Which identity boundary mattered most?
- Which failed example would reverse this decision?
- What would you simplify for a small team?
- What would you add for a regulated workload?

## Sources

- [[Microsoft Azure DevOps and Foundry]]
- [Azure DevOps MCP Server](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops)
- [Azure Pipelines environments](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)
- [Azure Pipelines workload identity federation](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)
- [Foundry hosted agents](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents)
- [Foundry agent evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent)
- [Foundry tracing setup](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/trace-agent-setup)
