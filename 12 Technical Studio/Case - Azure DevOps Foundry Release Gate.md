---
title: Case - Azure DevOps Foundry Release Gate
aliases:
  - Azure DevOps Foundry CI CD Case
  - Foundry Release Gate Case
  - Northstar Claims Agent Case
type: technical-case
family: technical
scope: United States
level:
  - intermediate
  - advanced
status: current
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
estimated_minutes: 45
tags:
  - technical-studio
  - case/azure
  - case/devops
  - case/foundry
  - skill/mlops
  - skill/evaluation
  - skill/agents
cssclasses:
  - everything-ai
---

# Case · Azure DevOps + Foundry release gate

> [!abstract] Decision
> Decide whether the Northstar Claims Agent can move from a reviewed Azure DevOps change to a production Microsoft Foundry hosted agent without confusing “the pipeline passed” with “the agent is safe, useful, authorized, and observable.”

**Roles:** [[AI Platform Engineer]] · [[MLOps Engineer]] · [[Agentic AI Engineer]] · [[AI Evaluation Engineer]]

**Study companion:** [[Microsoft Azure DevOps and Foundry]]

## Situation and contract

**Northstar Mutual — constructed teaching scenario.** Claims operations wants an assistant that can retrieve a policy, summarize submitted evidence, draft a next-step recommendation, and open a review work item. It must not approve a claim, alter a policy, or send an external payment.

The team has:

- an Azure DevOps Repo with a feature branch and pull requests;
- Azure Boards work items for acceptance criteria and risk;
- Azure Pipelines with Microsoft-hosted agents;
- a Microsoft Foundry project and a hosted agent;
- an Azure DevOps MCP connection exposed through a Foundry Toolbox;
- synthetic policy and claim documents;
- Application Insights traces for the staging agent.

Contract:

- All data in this case is synthetic. No real claimant data may enter the test tenant.
- The release must identify the commit, agent version, model deployment, Toolbox version, evaluation dataset, evaluator, identity, and rollback target.
- Reads and draft work-item creation may be automated; claim approval and external payment are out of scope.
- Production requires a protected environment approval.
- A failed quality or safety threshold stops promotion.

## Teaching envelope

> [!warning] Constructed numbers

| Quantity | Value | Why it matters |
|---|---:|---|
| Held-out task-completion threshold | 0.90 | Release quality floor |
| Groundedness threshold | 0.92 | Reduces unsupported policy summaries |
| Disallowed-action rate | 0 / 40 | No claim approvals or payment attempts |
| Staging smoke p95 latency | 8 seconds | Wiring and user-experience budget |
| Synthetic evaluation cases | 120 | Enough slices for a teaching gate, not a production benchmark |
| Production token/cost envelope | $0.08 per request | Budget signal, not a vendor quote |
| Rollback target | Prior approved agent version | Reversal must be possible without rebuilding |

## Closed-note prompt

Before reading the worked path, write:

1. Which evidence belongs in the pull request, pipeline artifact, environment approval, and post-deployment trace?
2. Which identities act at provisioning time versus runtime?
3. Which change categories require extra review?
4. What does the Azure DevOps MCP tool get to read or write?
5. What single result would stop the release even if unit tests pass?

## Current state and decision options

The first proposed pipeline runs unit tests, calls **azd deploy**, and checks that the endpoint returns HTTP 200. It uses a stored client secret and a shared production environment with no approval. The team says “we can add evaluation later.”

| Option | What it does | Why it is tempting | Why it is unsafe or incomplete |
|---|---|---|---|
| A. Bypass and secret | Deploy from main with a client secret and an endpoint smoke test | Fastest demo | Long-lived secret, no quality gate, no protected environment, weak rollback evidence |
| B. WIF plus protected environment | Use an Entra-backed WIF service connection, held-out evaluation, staging smoke test, and foundry-prod approval | Smallest complete control loop | Requires identity setup, evidence design, and approver discipline |
| C. GitHub-only shortcut | Move code and deployment to another CI system while leaving Boards and Foundry permissions informal | Familiar to one developer | Splits work traceability and can leave production access unmanaged |
| D. Agent self-approval | Let the agent read the PR and approve/deploy its own change through MCP | Looks autonomous | Confuses capability with authority and creates a circular control |

**Choose B.** Keep the system simple, but make the identity, evidence, evaluation, and approval boundaries explicit.

## Architecture

~~~mermaid
flowchart LR
    W["Boards work item<br/>outcome + risk"] --> R["Repos branch + PR"]
    R --> P["Pipelines<br/>WIF service connection"]
    P --> T["Unit, contract, security"]
    T --> E["Foundry evaluation<br/>held-out dataset"]
    E --> G{"Thresholds pass?"}
    G -->|No| X["Stop + file evidence"]
    G -->|Yes| S["foundry-staging<br/>hosted agent"]
    S --> O["Smoke request + traces"]
    O --> A{"Protected environment<br/>approval"}
    A -->|Reject| X
    A -->|Approve| D["foundry-prod<br/>agent version"]
    D --> I["App Insights + quality/cost"]
    I --> W
    M["Azure DevOps MCP<br/>read-only Toolbox"] -.-> S
~~~

## Worked reasoning

### 1. Make the release artifact inspectable

The pull request should link the Board work item and show the exact changes to prompts, tools, model deployment, **azure.yaml**, evaluation configuration, network policy, and redaction. The pipeline should publish test and evaluation results as artifacts. The approval should point to those artifacts, not to a green check with no context.

Minimum release record:

- commit SHA and PR;
- agent version and model deployment;
- Toolbox identifier and version;
- evaluation dataset hash, evaluator versions, thresholds, and score distribution;
- identity used by the pipeline and identity used at runtime;
- staging smoke-test trace;
- production environment approver;
- prior rollback version.

### 2. Separate identities

The WIF service connection authenticates Azure Pipelines for the actions it needs. The Foundry project managed identity supports platform operations. The hosted-agent identity accesses policy Search, Storage, or other runtime resources. A developer identity should not be copied into the agent, and a runtime identity should not be granted pipeline administration.

### 3. Make evaluation a gate, not a report

Run deterministic tests first. Then run the held-out evaluation against the candidate version. Fail the build if task completion is below 0.90, groundedness is below 0.92, or any disallowed action occurs. Inspect failed examples and slices; the average score is not enough. If the current azd extension differs from the repository recipe, stop and resolve the version mismatch before trusting the result.

### 4. Treat MCP and Toolbox as a permission boundary

The staging agent may retrieve work items, PR metadata, and pipeline status through a read-only Azure DevOps MCP toolset. It may draft a work item only through a separate, explicitly reviewed action path. It cannot approve a PR, modify branch policies, grant permissions, deploy production, or edit the evaluation threshold.

### 5. Use environments for the human decision

The foundry-staging environment confirms the deployed version and trace path. The foundry-prod environment carries the approval and checks. The approver reviews evaluation artifacts, failed examples, security results, cost/latency envelope, trace smoke test, and rollback target. If any evidence is missing, reject or hold the deployment.

## Release checklist

### Pull request

- [ ] Linked Board work item has outcome, owner, risk, acceptance criteria, and synthetic-data statement.
- [ ] Branch policy requires reviewers, build validation, linked work item, and comment resolution.
- [ ] Prompt, tool, identity, network, evaluator, and threshold changes are visible in the diff.
- [ ] No secrets, PATs, or client secrets appear in YAML, code, fixtures, or logs.

### Pipeline

- [ ] Service connection uses WIF or a managed identity and is restricted to approved pipelines.
- [ ] **azd --version** and installed extensions are recorded.
- [ ] Unit, contract, security, and injection tests pass.
- [ ] Evaluation dataset and evaluator versions are pinned.
- [ ] Quality and safety thresholds fail the build when missed.
- [ ] Results and failed examples are published without sensitive data.

### Staging

- [ ] Candidate agent version and Toolbox version are recorded.
- [ ] Runtime identity can read only the resources it needs.
- [ ] Smoke request passes and trace contains request, model, tool, error, and latency spans.
- [ ] Network path and outbound egress are verified.

### Production approval

- [ ] Approver is not the agent and is authorized for foundry-prod.
- [ ] Evaluation distribution, not only the mean, is reviewed.
- [ ] Cost/latency budget and safety results are within the envelope.
- [ ] Rollback version and operator are named.
- [ ] Post-deploy monitor and incident path are ready.

## Failure injects

| Injected failure | Correct response |
|---|---|
| Evaluation extension is missing on the hosted agent | Fail closed; install or pin the approved extension and rerun |
| Task completion is 0.89 with all unit tests green | Stop promotion; inspect failed slices and create a work item |
| A retrieved claim document tells the agent to approve payment | The read-only toolset and policy adapter deny the action; trace the injection |
| Pipeline can deploy staging but not production | Expected; use the protected environment approval, not a broader service connection |
| Private endpoint works but the MCP server cannot be reached | Diagnose outbound egress separately from inbound private access |
| Hosted agent can read all Storage containers | Reduce runtime RBAC; pipeline success does not justify excess data access |
| Agent tries to approve its own PR through MCP | Deny; approval is a human or policy authority outside the model |
| Smoke test returns 200 but trace has no tool spans | Stop; health is not observability and tool wiring is unverified |

## Interview drill

Answer aloud in two minutes: “Your Azure DevOps pipeline is green, but the Foundry agent’s groundedness score fell below threshold and its hosted identity can read an entire storage account. What do you do?”

Strong answer:

1. Stop promotion and preserve the candidate evidence.
2. Revoke or narrow the hosted-agent RBAC to the required container/index.
3. Inspect failed evaluation slices and compare the candidate with the prior approved version.
4. Confirm the dataset, evaluator, model, Toolbox, and command-extension versions.
5. Fix, rerun, and require a new staging trace and protected-environment approval.

## Quiz

1. Why is an HTTP 200 smoke test insufficient for an agent release?
2. Which identity should access claim data at runtime?
3. Why should the WIF service connection be pipeline-restricted?
4. What is the difference between a candidate evaluation artifact and a production trace?
5. Which changes need extra review in an AI-agent repository?
6. Why should a Toolbox version be part of the release record?
7. What should happen when the installed azd extension does not match the pipeline recipe?
8. Why is a protected environment stronger than a YAML comment?
9. What is the first safe Azure DevOps MCP toolset?
10. Name two signals that trigger rollback or hold.

> [!question]- Answer key
> 1. It proves basic endpoint wiring, not quality, safety, grounding, tool behavior, identity, or observability. 2. The least-privileged dedicated hosted-agent identity. 3. To prevent an unrelated pipeline from using deployment authority. 4. The candidate artifact is a versioned pre-release measurement; a production trace is runtime evidence used for monitoring and incidents. 5. Prompts, tools, permissions, model deployment, evals, thresholds, redaction, retention, and network policy. 6. It changes the agent’s capabilities and risk surface. 7. Fail closed, resolve and pin the extension/commands, then rerun. 8. It provides permissions, checks, history, and an authorized decision point. 9. Read-only, allowlisted MCP tools with Entra-backed identity and full tracing. 10. A failed safety/disallowed-action test, threshold miss, unexplained trace, excessive data access, or cost/latency breach.

## Flashcards

Release gate::A documented decision connecting versioned evidence and policy checks to an approved deployment.
WIF service connection::A secretless Azure DevOps federation path to an Entra identity.
Hosted-agent identity::The least-privileged runtime identity used by a Foundry hosted agent.
Project managed identity::A Foundry identity used for platform or infrastructure operations.
Held-out evaluation set::Examples excluded from tuning and used to judge a candidate release.
Toolbox version::A versioned bundle of agent tools whose change can alter capability and risk.
Protected environment::An Azure DevOps deployment target with permissions, checks, approvals, and history.
Smoke test::A small deployed request that proves wiring and basic health, not complete quality.
Trace evidence::Spans and attributes showing request, model, tool, error, latency, and policy behavior.
Disallowed-action rate::The rate at which the agent attempts or executes actions outside the contract.
Rollback target::The prior approved agent version that can be restored when the candidate fails.
MCP read-only posture::A narrow toolset that retrieves context without mutation authority.

## Suggested extension

Create the repository, pipeline, evaluation recipe, and release dossier for a new synthetic agent. Then intentionally break one control at a time: remove the WIF restriction, lower groundedness, widen Storage RBAC, hide tool traces, and grant a write MCP tool. For each break, record which policy should catch it, what evidence appears, and whether the system fails closed.

## Sources for the scenario

The scenario is constructed. Use [[Microsoft Azure DevOps and Foundry]] for the current Microsoft documentation links and the version caveat around azd evaluation commands:

- [Azure DevOps MCP Server](https://learn.microsoft.com/en-us/azure/devops/mcp-server/mcp-server-overview?view=azure-devops)
- [Foundry hosted agents](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents)
- [Foundry agent evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent)
- [Azure Developer CLI evaluation](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/azure-developer-cli-evaluation)
- [Azure Pipelines environments](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)
- [Azure Pipelines workload identity federation](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)

## Transfer

- Study the full delivery layer in [[Microsoft Azure DevOps and Foundry]].
- Compare the contract with [[Case - Agent Permissions]] and [[Case - Evaluation Harness]].
- Rehearse the ownership boundaries in [[AI Platform Engineer]], [[MLOps Engineer]], [[Agentic AI Engineer]], and [[AI Evaluation Engineer]].
- Turn the dossier into a portfolio artifact with [[Project Bank]] and [[Decision Record Template]].
- Capture the complete evidence set with [[Azure DevOps Foundry Release Dossier Template]].
