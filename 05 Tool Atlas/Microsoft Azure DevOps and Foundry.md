---
title: Microsoft Azure DevOps and Foundry
aliases:
  - Azure DevOps and Microsoft Foundry
  - Azure AI Foundry DevOps
  - Azure Agent CI CD
type: tool-category
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: current
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
tags:
  - atlas/tools
  - microsoft
  - azure
  - azure-devops
  - foundry
  - ai/agents
  - ai/mlops
cssclasses:
  - everything-ai
source_policy: official-first
last_updated: 2026-10-13
---

# Microsoft Azure DevOps and Foundry

> [!info] October 13, 2026 update
> Use [[Cloud AI Operations — October 2026]] for the current Foundry maturity matrix and Azure DevOps WIF migration scope. Retain this note for the full architecture and exercises.

> [!abstract] The capability
> Azure DevOps supplies the work, code, review, pipeline, package, test, and environment-control system. Microsoft Foundry supplies the model, agent, tool, evaluation, trace, and hosted-agent control plane. Together they form a path from **a work item and risk claim → reviewed change → repeatable evaluation → approved deployment → observable operation → a new work item**.

This note is a study guide, not a vendor endorsement. It focuses on Azure DevOps Services and Microsoft Foundry as documented for U.S. users on **August 24, 2026**. Plan limits, preview status, region support, model availability, and command syntax can change. Read [[AI Tools and Practices Update — 2026-08-24]] for provider-neutral principles, then use [[AI DevOps and Cloud Engineering — 2026-08-24]] for the provider-neutral cloud/DevOps lifecycle and [[MLOps and Platforms]], [[Agent and Orchestration Frameworks]], [[Evaluation and Observability]], and [[AI Platform Engineer]] for adjacent depth.

## What each product owns

| Surface | Azure DevOps | Microsoft Foundry | Evidence to produce |
|---|---|---|---|
| Plan the work | Azure Boards work items, backlogs, iterations, queries, dashboards | Project/agent requirements, risk and evaluation claims | A work item with intended use, owner, acceptance criteria, and risk |
| Change the system | Azure Repos, branches, pull requests, reviews, branch policies | Agent instructions, tools, model deployment, azure.yaml, infrastructure/config | A reviewed PR linked to the work item and a versioned agent/config change |
| Build and test | Azure Pipelines YAML, agents, tasks, artifacts, test results | Local/deployed agent tests, smoke tests, evaluation datasets, graders | Reproducible CI logs, test results, evaluation recipe, and threshold |
| Release | Environments, approvals/checks, deployment history, pipeline permissions | Agent versions/endpoints, project RBAC, guardrails, toolbox versions | An approved deployment with a known version and rollback target |
| Operate | Pipeline history, work-item traceability, audit, feeds | Traces, conversations, Application Insights, quality/safety metrics | Trace IDs, latency/tokens/errors, quality score, incident/runbook |
| Connect tools | Azure DevOps MCP Server, REST/CLI, service connections | Foundry Toolboxes, MCP, OpenAPI, Azure AI Search, Web Search, Code Interpreter, A2A | Least-privilege tool manifest, auth path, approval policy, audit evidence |

## The end-to-end loop

~~~mermaid
flowchart LR
    W["Work item: outcome and risk"] --> B["Branch and PR"]
    B --> C["CI: unit, contract, security, and eval checks"]
    C --> S{"Quality gate"}
    S -->|Fail| F["Failure evidence and new work item"]
    F --> B
    S -->|Pass| D["Deploy Foundry staging agent"]
    D --> E["Smoke, integration, and trace checks"]
    E --> A{"Environment approval"}
    A -->|Hold or reject| F
    A -->|Approve| P["Deploy production version"]
    P --> O["Operate: traces, App Insights, quality, cost"]
    O --> F
~~~

The diagram is the mental model to carry into any Microsoft-heavy AI job. A green build is not a release by itself. The release gate should answer: *which version was evaluated, on which data, with which grader, under which identity, and who authorized the environment?*

## The Foundry mental model

### Account, project, and data plane

- A Foundry account is the Azure resource boundary. A project is the collaboration and data-plane boundary where models, agents, connections, tools, evaluations, and traces are organized.
- Azure Resource Manager (ARM) permissions and Foundry data-plane permissions are different. A broad Azure Contributor role does not automatically grant every data-plane operation.
- Microsoft documentation distinguishes a project managed identity used for platform/infrastructure operations from a dedicated hosted-agent identity used at runtime. Grant the least privilege required to each.
- A hosted agent receives a dedicated endpoint and identity at deployment. External Azure resources such as Storage, Key Vault, Search, or databases need explicit RBAC for the agent identity.

### Prompt agents, hosted agents, and external code

| Choose | When it fits | Main ownership |
|---|---|---|
| Prompt agent | You need a fast Foundry-managed configuration with instructions, model, tools, and evaluation | Foundry project, instructions, tools, evals, and access |
| Hosted agent | You need custom Python/C# code, a container/runtime boundary, custom libraries, or framework choice | Repository, container/source, azure.yaml, deployment, identity, and operations |
| External agent plus Foundry observability/evaluation | You already run on another framework/cloud but want shared traces or evaluation | Your runtime and identity; Foundry as connected evaluation/monitoring control plane |

Hosted agents can use Foundry-managed tools through a Toolbox MCP endpoint. A Toolbox can bundle tools and be versioned; promote a tested default version rather than changing the endpoint behind production without evidence.

### Tools and Toolboxes

Foundry tool choices include Code Interpreter, Web Search, File Search, Azure AI Search, OpenAPI, MCP servers, and agent-to-agent connections. Treat a toolbox like a production dependency:

1. Record its version and tool list.
2. Expose only the tools needed for the task.
3. Separate read-only retrieval from write-like actions.
4. Test malformed arguments, timeouts, duplicate delivery, stale data, and prompt injection.
5. Require approval for consequential actions.
6. Trace tool calls and keep a rollback path to the prior toolbox version.

The Azure DevOps MCP Server is available as a Foundry catalog entry in preview. It can expose selected Azure DevOps tools through Foundry, but preview features and tool coverage can change. Start with read-only toolsets and validate the data boundary before allowing updates.

### MCP connection shapes

For a remote Azure DevOps MCP connection, the client points at the organization endpoint and completes Entra OAuth. The organization placeholder is not a secret; the user or workload still needs normal Azure DevOps permissions.

~~~json
{
  "servers": {
    "azure-devops-readonly": {
      "type": "http",
      "url": "https://mcp.dev.azure.com/CONTOSO-ORG",
      "headers": {
        "X-MCP-Toolsets": "repos,wit,pipelines",
        "X-MCP-Readonly": "true"
      }
    }
  }
}
~~~

For local development, use the official local server and a current Node runtime, then authenticate through the supported client flow. Keep local configuration outside the repository if it contains credentials or organization-specific settings. In either shape:

- allowlist the smallest toolset, such as work-item and build read operations;
- bind the organization/project/repository context outside the model when possible;
- do not place PATs or OAuth tokens in prompts, fixtures, YAML, or screenshots;
- record client, server, toolset, identity, and result status in the trace;
- treat write tools as a separate capability with a separate approval and rollback path.

> [!warning] Client compatibility changes
> The current remote-server page lists clients that can use Entra OAuth and clients that still need the local server because of dynamic-registration limitations, including Codex, Claude Desktop, Claude Code, and Cursor. Check the client matrix before designing a team-wide connection.

## The Azure DevOps mental model

### Repos and branch policies

Protect the main release branch with pull requests, minimum reviewers, linked work items, comment resolution, build validation, status checks, and path-based reviewers where appropriate. Keep the branching strategy simple: feature branch → PR → validated merge → pipeline.

For AI systems, add explicit policy checks for:

- changes to prompts, system instructions, tool manifests, azure.yaml, eval.yaml, model deployment configuration, or network policy;
- changes that widen permissions or add a new MCP/OpenAPI tool;
- changes to evaluation datasets, graders, thresholds, or judge models;
- changes to retention, logging, or redaction behavior.

Do not let an AI assistant approve its own branch-policy change. The Azure DevOps MCP Server can gather repository, PR, work-item, and build context, but the current documentation says to use the web portal or Azure DevOps CLI for direct branch-policy changes.

### Pipelines and agents

Azure Pipelines runs jobs on Microsoft-hosted, self-hosted, scale-set, or managed DevOps Pools agents. Microsoft-hosted agents are fresh per job, which improves isolation but means dependencies, caches, and credentials must be deliberate. Pin task major versions and keep build logic in reviewed scripts/templates rather than long inline blocks.

The AzureCLI@2 task runs Azure CLI commands through a configured Azure Resource Manager service connection. Prefer workload identity federation (WIF) with an app registration or managed identity; avoid long-lived client secrets and PATs. Restrict which pipelines may use a service connection.

### Environments and checks

Use separate Azure DevOps environments such as foundry-dev, foundry-staging, and foundry-prod. Environments provide deployment history, commit/work-item traceability, resource health, permissions, and manual approval checks. Restrict pipeline permissions so an arbitrary pipeline cannot deploy to production. An approval should name the evidence the approver must inspect: eval run, security result, cost budget, trace smoke test, and rollback version.

### Secrets and variables

- Do not put API keys, PATs, client secrets, or connection strings in YAML.
- Prefer WIF or managed identity for Azure access.
- Store residual secrets in Azure Key Vault or authorized variable groups.
- Map secrets into environment variables; do not echo them or pass them on command lines.
- Treat pipeline logs, artifacts, test outputs, traces, and evaluation datasets as potentially sensitive.

## The current azd and Foundry workflow

The Azure Developer CLI (azd) is the shortest path from a Foundry agent template to a repeatable Azure deployment. Microsoft documentation is in transition: the current evaluation extension documents **azd ai eval init** and **azd ai eval run start**, while older hosted-agent guidance documents **azd ai agent eval generate**, **run**, **update**, **list**, and **show**. Treat the installed azd version and extensions as part of the build input.

| Goal | Current learning path | Evidence |
|---|---|---|
| Scaffold | **azd ai agent init** | A repository with **azure.yaml**, source, infrastructure, and an explicit agent name |
| Authenticate | **azd auth login**, **azd auth status** | The developer or build identity is visible and has only required access |
| Provision | **azd provision** or **azd up** | Foundry account/project, dependencies, identity, and role assignments exist |
| Run locally | **azd ai agent run** or framework-native local command | A local smoke test and a captured trace |
| Invoke locally | **azd ai agent invoke --local** | A repeatable request/response fixture without production credentials |
| Deploy | **azd deploy** or **azd up** | A named agent version is deployed to the intended project |
| Verify | **azd ai agent show** plus a deployed invoke | Endpoint, version, identity, health, and trace evidence |
| Initialize evaluation | Current extension: **azd ai eval init**; older page: **azd ai agent eval generate** | Versioned dataset, evaluator configuration, and thresholds |
| Run evaluation | Current extension: **azd ai eval run start**; older surface: **azd ai agent eval run** | Run ID, scores, failures, and a pass/fail decision |
| Gate a build | Current extension supports **--fail-on** | CI stops when a selected metric is below its threshold |
| Maintain the recipe | Edit **evals/azure.eval.yaml** and artifacts, then use **azd ai eval create**, **list**, **show**, and **run output list** | The team can identify the installed extension and schema before editing automation |

> [!warning] Command surface is versioned
> Before copying a pipeline, run **azd --version** and **azd extension list --installed**. Install the current evaluation extension only when the project permits it, and pin the command surface in the README. A pipeline that silently mixes the older agent-eval commands with the newer evaluation extension is not reproducible.

The useful study question is not “which command is correct?” It is: *what artifact does this command create, which identity performs it, and how is the result linked to the commit and release environment?*

## Azure DevOps pipeline skeleton

This is a teaching skeleton, not a copy-paste production pipeline. Replace service-connection, variable-group, environment, project, and command names with values from the target tenant. Keep the evaluation command behind a version check because Microsoft’s azd evaluation extension is evolving.

~~~yaml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: ubuntu-latest

variables:
  - group: foundry-northstar-nonsecret
  - name: AZD_ENV_NAME
    value: northstar-staging
  - name: AZURE_SERVICE_CONNECTION
    value: sc-foundry-wif

stages:
  - stage: Validate
    displayName: Unit, security, and evaluation checks
    jobs:
      - job: validate
        steps:
          - checkout: self
            fetchDepth: 1
          - script: |
              python -m pip install -r requirements.txt
              pytest -q
            displayName: Unit and contract tests
          - task: AzureCLI@2
            displayName: Inspect azd and run the evaluation gate
            inputs:
              azureSubscription: $(AZURE_SERVICE_CONNECTION)
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                azd --version
                azd extension list --installed
                azd env select "$(AZD_ENV_NAME)"
                azd ai eval create
                azd ai eval run start --eval northstar-eval --fail-on pass-rate=0.90

  - stage: DeployStaging
    displayName: Deploy the evaluated version to staging
    dependsOn: Validate
    condition: succeeded()
    jobs:
      - deployment: deploy_staging
        environment: foundry-staging
        strategy:
          runOnce:
            deploy:
              steps:
                - checkout: self
                - task: AzureCLI@2
                  inputs:
                    azureSubscription: $(AZURE_SERVICE_CONNECTION)
                    scriptType: bash
                    scriptLocation: inlineScript
                    inlineScript: |
                      azd env select "$(AZD_ENV_NAME)"
                      azd deploy
                      azd ai agent show

  - stage: Production
    displayName: Approved production promotion
    dependsOn: DeployStaging
    condition: succeeded()
    jobs:
      - deployment: deploy_production
        environment: foundry-prod
        strategy:
          runOnce:
            deploy:
              steps:
                - checkout: self
                - task: AzureCLI@2
                  inputs:
                    azureSubscription: $(AZURE_SERVICE_CONNECTION)
                    scriptType: bash
                    scriptLocation: inlineScript
                    inlineScript: |
                      azd env select "northstar-prod"
                      azd deploy
                      azd ai agent show
~~~

Improve the skeleton by adding an artifact upload for the evaluation run, a smoke-test request against the deployed endpoint, a rollback command or prior agent-version reference, and a cost/latency budget check. The production environment should carry the approval and checks; putting an approval comment in YAML is not equivalent to an environment control.

## Identity, security, and networking

| Actor | Identity boundary | Minimum useful access |
|---|---|---|
| Developer | Entra user or developer CLI identity | Local project read, deploy only in a sandbox, no standing production secret |
| Azure Pipelines | WIF-backed service connection or managed identity | Provision/deploy the named resources; access only from approved pipelines |
| Project managed identity | Foundry account/project infrastructure identity | The platform operations it needs, not arbitrary data access |
| Hosted-agent identity | Dedicated runtime identity for the agent | Read/write only to the external resources the agent actually uses |
| Environment approver | Entra user/group with environment permission | Approve or reject after inspecting evaluation, security, cost, and rollback evidence |

Foundry networking options range from public egress to private endpoints, bring-your-own VNet, and managed VNet designs. A private endpoint protects a service boundary; it does not automatically make every outbound call private. Document both inbound access and outbound egress for model endpoints, Storage, Key Vault, Search, registries, MCP servers, and telemetry.

For the Azure DevOps MCP Server, the remote server uses Entra-backed authentication and is intended for Azure DevOps organizations; it does not provide a separate shortcut around project permissions. The local server is useful for controlled development and requires a current Node runtime. Start with read-only toolsets, allowlist the tools in the Toolbox, log every call, and require a human or policy gate before work-item, branch, pull-request, or pipeline mutations.

## Evaluation and observability

### Evaluation levels

| Level | What it catches | Release use |
|---|---|---|
| Unit and contract tests | Deterministic code, schemas, parsers, permission helpers | Every PR |
| Local integration | Tool adapters, mocked identity, retries, timeouts | Every PR or nightly |
| Deployed integration | Real endpoint, RBAC, network path, model/tool wiring | Staging deployment |
| Structured evaluation | Quality, groundedness, relevance, task completion, safety, tool behavior | Required quality gate |
| Production monitoring | Drift, failures, latency, token/cost envelope, abuse, incidents | Continuous operation and rollback signal |

Foundry evaluations can target an agent, model, dataset, response set, or captured traces. Use synthetic or simulated conversations for broad coverage before deployment, a held-out release set for the gate, and sampled real traces after deployment. Version **eval.yaml**, datasets, rubrics, judge-model configuration, and thresholds together; a score without the dataset and evaluator version is not a reproducible result.

Instrument the agent with OpenTelemetry or the Foundry SDK and connect traces to Application Insights or the selected Foundry observability surface. Redact secrets and personal information before traces or evaluation datasets leave the runtime. Define retention, access, sampling, and deletion rules. A useful release artifact includes the commit SHA, agent/toolbox version, model deployment, identity, dataset hash, evaluator versions, score distribution, failed examples, and approver.

## Free-first and paid paths

| Capability | Free-first practice | Paid or managed path |
|---|---|---|
| Boards, Repos, PRs | Azure DevOps free tier for a small team; synthetic work items and sample repos | Larger user count, parallel jobs, private package feeds, enterprise governance |
| Pipelines | Microsoft-hosted free parallelism where eligible; local lint/test before consuming minutes | More parallel jobs, self-hosted or managed pools, private networking, larger artifacts |
| Foundry development | Local agent code, small test models, mocked tools, short synthetic datasets | Managed model deployments, hosted agents, Search/Storage/Key Vault, App Insights ingestion |
| Evaluation | Local fixtures, open-source metrics, small held-out set | Hosted evaluators, judge-model calls, large datasets, continuous monitoring |
| Azure DevOps MCP | Local read-only server and small test organization | Remote/Foundry Toolbox use with normal Azure DevOps and model/tool execution costs |
| Security | Entra identities, WIF, branch policies, environment approvals | Private endpoints, firewalls, dedicated pools, SIEM, compliance evidence and retention |

Free-first does not mean production-free. It means use a test tenant, public synthetic data, small model calls, and reversible resources until the workflow and evidence are correct. Never use customer secrets to learn the integration.

## Study sequence

### Beginner

1. Create a Board work item with an outcome, risk, acceptance criteria, and test data boundary.
2. Create a Repo branch and PR with a minimal agent or API change.
3. Run tests in a Microsoft-hosted pipeline and read the logs.
4. Deploy a tiny Foundry prompt or hosted agent to a sandbox.
5. Explain the difference between a project managed identity and a hosted-agent identity.

### Intermediate

1. Add WIF to an Azure Resource Manager service connection.
2. Add staging and production environments with approvals and pipeline permissions.
3. Capture traces and build a held-out evaluation set.
4. Add a Toolbox with one read-only MCP tool and a malformed-input test.
5. Make the evaluation command fail the build when a threshold is missed.

### Advanced

1. Design private networking and egress for a hosted agent with Search, Key Vault, Storage, and a private MCP service.
2. Create a versioned agent/toolbox promotion strategy with rollback.
3. Use Azure DevOps MCP to summarize delivery state while keeping write tools disabled.
4. Analyze quality, safety, latency, and cost together instead of optimizing one score.
5. Produce an audit-ready release dossier from work item to trace to approval.

## Interview preparation

- Draw the path from a work item to a deployed Foundry agent and name the artifact at every arrow.
- Explain why a green unit-test build does not prove an agent is safe or useful.
- Compare WIF, managed identity, PATs, and client secrets; state what you would remove first from a legacy pipeline.
- Explain why environment approvals belong in Azure DevOps controls and not only in a prompt or YAML comment.
- Distinguish an ARM permission from a Foundry data-plane permission.
- Explain how you would prevent an agent from approving its own pull request or changing its own branch policy.
- Design a read-only Azure DevOps MCP integration, then list the controls needed before enabling a write tool.
- Explain why private endpoints and private egress are separate decisions.
- Name the evidence needed to reproduce an evaluation score six weeks later.
- Diagnose a pipeline that passes locally but fails in a Microsoft-hosted agent with missing tools, identity, or network access.

## Knowledge check

1. What is the main difference between Azure DevOps and Foundry in the delivery loop?
2. Why should a hosted agent usually have a dedicated runtime identity?
3. What does WIF remove compared with a client-secret service connection?
4. Name three branch-policy checks that matter for an AI-agent repository.
5. Why are Azure DevOps environments more than a deployment label?
6. What is the current azd evaluation command surface, and what older surface may still appear?
7. What should be versioned with an evaluation threshold?
8. Why is a Toolbox treated as a production dependency?
9. Does a Foundry private endpoint guarantee private outbound egress?
10. What is the safest first posture for Azure DevOps MCP?
11. Which evidence should an approver inspect before production?
12. What is the difference between a staging smoke test and a structured evaluation?

### Answer key

1. Azure DevOps governs work, change, CI/CD, review, and environments; Foundry governs models, agents, tools, evaluation, traces, and hosted runtime.
2. It keeps runtime data access separate from provisioning and developer access, making least privilege and revocation practical.
3. WIF removes the need to store and rotate a long-lived client secret for the federation path.
4. Pull-request review, linked work item, build validation, status checks, comment resolution, or path-based reviewers are valid examples.
5. They provide deployment history, permissions, traceability, resource checks, and approval gates.
6. The newer extension uses **azd ai eval init** and **azd ai eval run start**; older documentation uses **azd ai agent eval generate/run/update/list/show**.
7. The dataset or dataset hash, rubric/evaluator versions, judge model, schema, code commit, and score distribution.
8. It changes what the agent can do and can introduce permission, prompt-injection, availability, and data-exfiltration risk.
9. No. Inbound private access and outbound egress must be designed and verified separately.
10. Read-only tools, a narrow allowlist, Entra-backed identity, complete tracing, and no mutation tools.
11. Evaluation results and failed examples, security and network checks, cost/latency budget, trace smoke test, exact version, and rollback target.
12. A smoke test proves wiring and basic health for a known request; a structured evaluation measures behavior across a versioned dataset and rubric.

## Flashcards

What does Azure DevOps own in an AI delivery loop?::Work planning, source control, review, CI/CD, artifacts, tests, and environment controls.
What does Foundry own in the same loop?::Models, agents, tools, evaluations, traces, and hosted-agent runtime surfaces.
Why use a dedicated hosted-agent identity?::To separate runtime data access from project provisioning and developer permissions.
What does WIF mean in Azure Pipelines?::Workload identity federation, a secretless trust path between the pipeline service connection and Entra.
What is an Azure DevOps environment?::A protected deployment target with history, permissions, checks, and traceability.
What should a PR policy require for agent changes?::Review, linked work item, build validation, and extra scrutiny for tools, prompts, permissions, evals, and network changes.
What is the current azd eval init command?::The current evaluation extension command that initializes an evaluation recipe; verify the installed extension before scripting it.
What is the older azd agent eval generate command?::An older documented command surface for generating an evaluation configuration.
Why version a dataset hash?::So a score can be reproduced against the exact examples that produced it.
What is a Foundry Toolbox?::A versioned bundle of tools exposed to an agent, often through MCP or other connections.
What is the safest first Azure DevOps MCP posture?::Read-only access with an allowlisted toolset and full tracing.
What does OpenTelemetry add?::Portable traces and spans for requests, model calls, tool calls, errors, and latency.
Why are hosted-agent and project-managed identities different?::The project identity supports platform operations; the hosted-agent identity acts at runtime.
What is a release gate?::A documented decision that connects evaluated evidence and policy checks to an approved deployment.
Why is private egress a separate decision from a private endpoint?::A private endpoint controls access to a service boundary; outbound calls still require an explicit network path and policy.

## Suggested projects

### Beginner — DevOps-to-Foundry release map

Use synthetic customer-support data. Create a Board work item, Repo branch, PR, test pipeline, Foundry sandbox agent, and a staging environment. Deliver a one-page map that names the owner, identity, artifact, and rollback target at each step.

### Intermediate — WIF-protected Foundry pipeline

Build a hosted-agent or prompt-agent deployment with a WIF service connection, protected foundry-staging and foundry-prod environments, a versioned held-out evaluation, and a failing threshold. Demonstrate that removing the environment approval prevents production deployment.

### Advanced — Azure DevOps MCP plus Foundry Toolbox

Create a read-only Azure DevOps MCP integration that retrieves work items, PR status, and pipeline runs. Wrap it in a Foundry Toolbox, test prompt injection and stale data, trace each call, and add a human-approved path for any future write tool.

### Capstone — Production-ready release dossier

Design a regulated-but-synthetic claims agent with private networking, Key Vault, Search, WIF, branch policies, hosted-agent identity, evaluation gates, App Insights traces, incident runbook, cost envelope, and rollback. Submit the repo, pipeline, threat model, evaluation report, and an interview-style architecture defense.

Use [[Azure DevOps Foundry Release Dossier Template]] to make the evidence inspectable.

## Official sources checked 2026-08-24

- [Azure DevOps MCP Server overview](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops)
- [Remote Azure DevOps MCP Server](https://learn.microsoft.com/en-us/azure/devops/mcp-server/remote-mcp-server?view=azure-devops)
- [Hosted agents in Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents)
- [Deploy a hosted agent](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/deploy-hosted-agent)
- [Azure Developer CLI evaluation extension](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/azure-developer-cli-evaluation)
- [Foundry agent evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent)
- [Foundry tracing setup](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/trace-agent-setup)
- [Foundry networking options](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/networking-options)
- [Foundry hosted-agent permissions](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agent-permissions)
- [Foundry Toolboxes and MCP tools](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/tools/model-context-protocol)
- [Azure Pipelines environments, approvals, and checks](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)
- [Azure Pipelines workload identity federation](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)
- [Azure Repos branch policies](https://learn.microsoft.com/en-us/azure/devops/repos/git/branch-policies?view=azure-devops)
- [AzureCLI@2 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-cli-v2?view=azure-pipelines)
- [Azure Developer CLI Azure Pipelines integration](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/pipeline-azure-pipelines)

> [!note] Review trigger
> Re-check Foundry hosted-agent lifecycle, Azure DevOps MCP preview status, azd evaluation extension syntax, model/tool availability, plan limits, and regional networking guidance by **2026-11-24**.
