---
title: OWASP and AI Security — 2026
aliases:
  - OWASP AI Security
  - OWASP GenAI Security
  - OWASP LLM and Agentic Top 10
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
  - ai/security
  - ai/red-teaming
  - ai/agents
  - ai/supply-chain
  - ai/governance
cssclasses:
  - everything-ai
source_policy: official-first
---

# OWASP and AI Security — 2026

> [!abstract] The point of this dossier
> OWASP is not a certification, a scanner, or a substitute for a system threat model. It is an open, practitioner-led vocabulary for turning AI failure modes into attack scenarios, controls, tests, evidence, owners, and residual risk. This dossier explains how to use the current OWASP GenAI Security Project work across LLM applications, agentic systems, data, MCP, supply chain, red teaming, governance, and incident response.

This is a U.S.-focused study note with official OWASP sources checked on **August 24, 2026**. Pair it with [[AI Threat Modeling]], [[Security and Red Teaming]], [[Untrusted Context and Injection]], [[Case - Agent Permissions]], and [[Case - OWASP Agentic Security Review]].

## The 2026 OWASP map

| OWASP layer | What it covers | When to use it |
|---|---|---|
| **LLM Top 10 2026** | The model as a component inside an application | Chat, RAG, generation, classification, embeddings, model APIs, and downstream sinks |
| **Agentic Top 10 2026** | The model as an actor that plans, calls tools, holds memory, delegates, and causes effects | Autonomous or semi-autonomous agents, workflows, MCP/A2A, multi-agent systems |
| **GenAI Data Security 2026** | Training, fine-tuning, prompts, retrieval, embeddings, memory, outputs, and data governance | Any system crossing data trust domains |
| **Secure MCP guidance** | Authentication, authorization, sessions, tool schemas, deployment, and chained tool risk | MCP servers, clients, registries, and third-party connectors |
| **AIBOM initiative** | AI supply-chain transparency and component inventory | Procurement, deployment, incident response, model/tool changes |
| **Red-team and solutions landscapes** | Test design, vendor/tool evaluation, and lifecycle coverage | Selecting tests or security products; measuring gaps |
| **COMPASS and governance** | Threat prioritization, adoption, governance, and operational decisions | Program owners, CISOs, product leaders, and risk committees |

> [!warning] Boundary rule
> If a model only returns text, begin with the LLM Top 10. The moment its output controls tools, memory, credentials, other agents, code execution, or external side effects, add the Agentic Top 10. Most real systems need both.

~~~mermaid
flowchart LR
    U["User / event"] --> I["Input, retrieval, media, tool output"]
    I --> L["Model or multimodal encoder"]
    L --> P["Plan, output, memory write, or tool call"]
    P --> G{"Deterministic policy gate"}
    G -->|allow| T["Tool, code, API, agent, or renderer"]
    G -->|hold| H["Human approval / review"]
    G -->|deny| N["No-op, safe response, or quarantine"]
    T --> O["External effect / artifact"]
    O --> E["Trace, evidence, monitor, incident"]
    E --> R["Regression, rollback, rotate, or retire"]
    R --> I
    X["OWASP + NIST + ATLAS + AIBOM"] -.-> G
    X -.-> E
~~~

The core principle is architectural: do not try to build a model that can never be fooled. Build the surrounding system so that a fooled model cannot reach secrets, high-impact actions, or unbounded resources without deterministic controls.

## OWASP LLM Top 10 for 2026

The current OWASP page identifies the 2026 guide as the latest community-driven LLM application guide. The release expands cross-modal, supply-chain, fine-tuning, memory, and generated-code coverage, and maps risks to NIST, MITRE ATLAS, CWE, and the Agentic Top 10.

| ID | Risk | What fails | Minimum evidence |
|---|---|---|---|
| LLM01:2026 | Prompt Injection | Untrusted input changes model behavior or downstream interpretation | Direct, indirect, multimodal, memory, and adaptive attack matrix |
| LLM02:2026 | Sensitive Information Disclosure | The system reveals data, context, secrets, or private application information | Cross-tenant, secret-canary, log, retrieval, and output tests |
| LLM03:2026 | Excessive Agency | The application grants too much functionality, permission, or autonomy | Tool/action matrix, policy tests, approval and replay evidence |
| LLM04:2026 | Supply Chain | A model, data, package, tool, plugin, or dependency is untrusted or compromised | Hashes, signatures, AIBOM, provenance, dependency and license review |
| LLM05:2026 | Data and Model Poisoning | Training, tuning, feedback, retrieval, or model artifacts are manipulated | Dataset lineage, poisoning tests, quarantine, split and rollback evidence |
| LLM06:2026 | Unbounded Consumption | Requests consume unbounded tokens, compute, calls, storage, or money | Rate, budget, timeout, concurrency, loop, and denial-of-wallet tests |
| LLM07:2026 | Misinformation | Fluent output is false, unsupported, misleading, or acted on as fact | Groundedness, citation, abstention, calibration, and expert evidence |
| LLM08:2026 | Hidden Context Exposure | System prompts, hidden context, private instructions, or internal reasoning leak | Canary, context separation, output, logging, and side-channel tests |
| LLM09:2026 | Vector and Embedding Weaknesses | Retrieval indexes enable poisoning, leakage, access bypass, or semantic attacks | ACL, deletion, poisoning, cross-tenant, inversion, and quality tests |
| LLM10:2026 | Improper Output Handling | Model output reaches code, markup, queries, tools, or sinks unsafely | Typed validation, sink fuzzing, encoding, sandbox, and negative tests |

### LLM01–LLM05: input, information, agency, supply chain, and integrity

**LLM01 — Prompt Injection.** Injection can arrive through a user, webpage, email, PDF, image, audio, video, issue title, database row, MCP result, tool output, persistent memory, or RAG passage. Separate data and instruction channels; keep credentials and state changes in application code; use least privilege; validate output in trusted code; filter every modality; strip invisible characters; treat memory writes as privileged; pin tools; and test adaptive attackers. A prompt filter alone is not a security boundary.

**LLM02 — Sensitive Information Disclosure.** Disclosure includes user data, secrets, credentials, private documents, system prompts, hidden context, logs, tool outputs, embeddings, model artifacts, and metadata. Use minimization, tenant-bound identity, ACLs before retrieval, redaction, secret scanning, short retention, safe errors, and output/egress policy. Test synthetic canaries across users, tools, traces, logs, retries, and renders.

**LLM03 — Excessive Agency.** The application exposes too many functions, too much permission, or too much autonomy. Separate read/propose/write; use deterministic policy, schemas, allowlists, approval, idempotency, transaction limits, dry-run previews, and raw action views. An action matrix should list actor, tenant, tool, verb, fields, amount, approval, reversibility, and audit record.

**LLM04 — Supply Chain.** The chain includes base/adapted models, tokenizers, data, embeddings, indexes, prompts, plugins, MCP servers, packages, containers, runtimes, and evaluators. Pin versions and hashes, verify signatures, generate an AIBOM, record licenses/provenance, scan dependencies, isolate third-party code, and gate model/data/index/policy changes.

**LLM05 — Data and Model Poisoning.** Poisoning can target pretraining, fine-tuning, preferences, evaluation sets, RAG corpora, embeddings, memory, feedback, or artifacts. Use source allowlists, lineage, curation, anomalous-example checks, quarantine, independent holdouts, contamination checks, signed snapshots, and rollback. Measure attack success and false-positive cost.

### LLM06–LLM10: resources, truth, context, retrieval, and sinks

**LLM06 — Unbounded Consumption.** Budget tokens, context, calls, tools, storage, GPU time, queues, retries, and provider credits. Use per-user/tenant budgets, max steps, timeouts, concurrency caps, circuit breakers, caching where safe, spend alerts, routing, and a kill switch. Load-test bursts, loops, retries, and provider degradation.

**LLM07 — Misinformation.** A confident falsehood becomes a security risk when it changes a decision or drives a tool. Use authoritative retrieval, source/effective-date metadata, citation entailment, abstention, calibration, expert review, and uncertainty UX. Measure correctness, citation precision, abstention, and harm severity by slice.

**LLM08 — Hidden Context Exposure.** This broadens “system prompt leakage” to private developer instructions, memory, tool metadata, routing, internal context, logs, and reasoning-like content. Minimize context; separate tenants/channels; keep secrets out of prompts; redact traces; protect logs; and test rendered output, URLs, Unicode, errors, and side channels.

**LLM09 — Vector and Embedding Weaknesses.** Embeddings can be poisoned, queried for membership, used to bypass ACLs, or made to leak another tenant. Authorize before retrieval and again before generation; use namespaces, filters, encryption, deletion/re-index evidence, source provenance, query limits, index versioning, and adversarial retrieval tests.

**LLM10 — Improper Output Handling.** Model output is untrusted input. The sink may be SQL, shell, HTML, Markdown, browser code, email, a path, URL, interpreter, workflow parameter, or another model. Use typed schemas, semantic validation, parameterized APIs, encoding, allowlists, SSRF/path controls, safe renderers, sandboxes, and human review. Fuzz each sink.

## OWASP Top 10 for Agentic Applications 2026

Use this list when an AI system plans, acts, holds memory, delegates, communicates, or causes multi-step effects.

| ID | Risk | Core question | Minimum evidence |
|---|---|---|---|
| ASI01:2026 | Agent Goal Hijack | Can input, memory, a tool result, or another agent redirect the goal? | Goal contract, plan diff, indirect-injection tests, blocked-action trace |
| ASI02:2026 | Tool Misuse and Exploitation | Can a valid tool be used outside intended argument or task policy? | Capability matrix, argument validation, dry-run and abuse tests |
| ASI03:2026 | Identity and Privilege Abuse | Can delegation or tokens grant excess privilege? | Identity map, scope tests, rotation, revocation, audit |
| ASI04:2026 | Agentic Supply Chain Vulnerabilities | Can a model, MCP server, plugin, package, or registry compromise execution? | Pinning, signatures, AIBOM, sandbox, dependency review |
| ASI05:2026 | Unexpected Code Execution | Can natural language or generated artifacts reach an interpreter? | Isolation, network/secret policy, resource limits, escape tests |
| ASI06:2026 | Memory and Context Poisoning | Can persistent context corrupt future behavior? | Write policy, provenance, TTL/quarantine, cross-session tests |
| ASI07:2026 | Insecure Inter-Agent Communication | Can agents be spoofed, replayed, confused, or over-trusted? | Authenticated channels, nonces, schemas, replay tests |
| ASI08:2026 | Cascading Failures | Can one weak step amplify across agents, retries, or shared state? | Bounded depth, circuit breakers, recovery and fault injection |
| ASI09:2026 | Human-Agent Trust Exploitation | Can the agent manipulate approval or reviewer attention? | Raw action preview, provenance, dual control, fatigue tests |
| ASI10:2026 | Rogue Agents | Can an agent persist, evade oversight, or leave its contract? | Behavior baseline, quarantine, revocation, kill switch, forensics |

### Agentic control notes

- **ASI01 / ASI02:** Define a goal contract, plan-change rules, narrow tool schemas, semantic argument checks, dry-run, idempotency, and per-action budgets. Test semantic misuse, not only malformed syntax.
- **ASI03:** Use short-lived, down-scoped tokens; prove user and tenant context at the tool boundary; keep credentials out of model context; log principal, delegator, scope, tool, and approval.
- **ASI04 / ASI07:** Pin and sign tools and agents; bind tokens to issuer/audience; sign or integrity-protect task/artifact envelopes; use expiry, nonce, capability negotiation, and deny-by-default registries.
- **ASI05:** Run generated code in ephemeral isolation with no default secrets, restricted network, filesystem boundaries, CPU/memory/time limits, output limits, and cleanup.
- **ASI06:** Treat memory writes as privileged. Capture source, tenant, author, expiry, and content type; distinguish facts from instructions; quarantine, delete, roll back, and re-evaluate.
- **ASI08:** Bound fan-out, depth, retries, steps, and cost; use timeouts, typed handoffs, circuit breakers, health checks, compensation, and fail-closed paths.
- **ASI09:** Show the exact tool call, target, data, amount, destination, provenance, and policy decision—not only an agent summary. Use risk-tiered approval and dual control.
- **ASI10:** Baseline behavior, monitor tool and communication patterns, revoke identity, quarantine, preserve evidence, and exercise the kill switch before production.

## Data, MCP, supply chain, and governance

### Data-security lifecycle

| Stage | Threats | Controls |
|---|---|---|
| Acquire/transform | Over-collection, unlawful use, poisoning, hidden instructions | Purpose, rights, minimization, provenance, redaction, quarantine, lineage |
| Train/fine-tune | Backdoors, memorization, gradient leakage, license mismatch | Signed data, holdouts, privacy methods, poisoning eval, rollback |
| Index/embed | Cross-tenant leakage, stale ACL, inversion, poisoned chunks | Namespace, ACL-before-retrieval, encryption, deletion, index version |
| Context/memory | Instruction/data fusion, persistence, context overflow | Provenance labels, memory write gate, TTL, tenant isolation, budgets |
| Tool/output | Exfiltration, code/SQL/HTML injection, unsafe destinations | Egress policy, schemas, allowlists, sandbox, approval |
| Observe/delete | Sensitive traces, residual indexes, backups, replicas | Redaction, retention, access roles, deletion workflow, re-test |

### Secure MCP checklist

Use the official [OWASP secure MCP guide](https://genai.owasp.org/resource/a-practical-guide-for-secure-mcp-server-development/):

- Authenticate clients and servers; bind tokens to issuer, audience, user, tenant, and scope.
- Authorize every tool/resource call; separate read, propose, and write capabilities.
- Validate tool arguments and results with strict schemas and semantic policy.
- Isolate sessions and tenants; constrain URLs, paths, commands, time, output, and concurrency.
- Treat tool descriptions and resource content as untrusted instructions.
- Pin, sign, inventory, and review servers, packages, and registries.
- Log principal, tool, arguments, policy decision, trace ID, and outcome without leaking secrets.
- Test replay, confused deputy, SSRF, path traversal, exfiltration, malformed schemas, and tool failure.

### AIBOM fields

Capture model name/version/hash/license, adapter/base-model relationship, dataset source/rights/checksum, embedding model/index/ACL, tool or agent repository/version/signature/permissions, runtime/container/region, evaluation set/thresholds, and output provenance. The [OWASP AIBOM Generator](https://genai.owasp.org/resource/owasp-aibom-generator/) is a useful free starting point, not a complete system inventory.

### Prioritization record

For every finding, record **reachability, prerequisites, agency, impact, persistence, detectability, reversibility, affected population, uncertainty, owner, deadline, control, test, and residual risk**. OWASP identifiers name a risk; they do not replace a business decision.

## Control stack and tool path

| Layer | Controls | Evidence |
|---|---|---|
| Design | Data flow, threat model, trust boundaries, abuse cases | Architecture and decision record |
| Data | ACLs, provenance, minimization, poisoning, retention, deletion | Data card and tests |
| Model/context | Grounding, schemas, abstention, prompt/memory policy | Model/system card and eval |
| Identity/policy | Short-lived tokens, least privilege, deterministic gate, approval | Identity matrix and policy tests |
| Runtime | Sandbox, URL/path limits, rate/step/budget caps, isolation | Config and fault injection |
| Supply chain | Hashes, signatures, AIBOM, dependency/license review | Release manifest |
| Observe/evaluate | Traces, cost, drift, red team, alerts, judge calibration | Dashboard and regression set |
| Respond | Kill switch, rollback, revoke, quarantine, notify | Runbook and game-day record |

| Need | Free/open starting point | Managed/paid direction |
|---|---|---|
| Taxonomy | OWASP, MITRE ATLAS, NIST AI RMF, attack trees | GRC and AI-risk platforms |
| Red teaming | PyRIT, garak, promptfoo, Giskard, OWASP FinBot CTF | AI security platforms and managed testing |
| Web/API | OWASP ZAP, Burp Community, local test apps | Commercial AppSec suites |
| Supply chain | OWASP AIBOM Generator, CycloneDX/SPDX, signatures | Model registry and AI posture platforms |
| Runtime | JSON Schema, OpenTelemetry, local sandboxes | AI gateways, DLP, runtime guardrails |
| Response | Tabletop, trace export, OWASP incident guidance | AI SOC and managed detection |

Use only authorized, isolated targets. A scanner finding is a hypothesis until a human validates exploitability, impact, and conditions.

## Study path

1. **Beginner:** Learn the LLM/Agentic boundary; map a synthetic RAG app; identify trust boundaries and one control per risk.
2. **Intermediate:** Add MCP, delegated identity, a write tool, memory, sandboxed code, budgets, and fault-injection tests.
3. **Advanced:** Produce an AIBOM, crosswalk to NIST/ATLAS/CWE, run adaptive red/blue tests, exercise incident response, and defend residual risk.

## Interview preparation

- Explain the boundary between the OWASP LLM and Agentic Top 10.
- Why is prompt injection architectural rather than only a classifier problem?
- Describe a confused-deputy path and the identity controls that stop it.
- What belongs in an AIBOM, and how does it help during an incident?
- How would you evaluate a third-party MCP server?
- Why are system-prompt secrecy and output validation different controls?
- Design a cross-tenant retrieval test.
- What is a denial-of-wallet attack?
- How do you distinguish misinformation from retrieval and policy failure?
- What makes a generated-code sandbox a boundary?
- How can memory poisoning persist after the attacker disappears?
- What evidence proves a human approval control is not theater?
- How do cascading failures differ from one bad response?
- When should an agent identity be revoked?
- How would you prioritize low-frequency, irreversible impact?

## Knowledge check

1. Is OWASP a certification or a risk-and-control resource?
2. When should a system use both the LLM and Agentic Top 10?
3. Name three non-user surfaces where prompt injection can arrive.
4. Why is a prompt filter not a complete security boundary?
5. What is the difference between sensitive disclosure and hidden context exposure?
6. Why is excessive agency an application-design problem?
7. Name four AI supply-chain components besides a base model.
8. What is a denial-of-wallet attack?
9. Why must citation fidelity be measured separately from fluency?
10. Why is semantic similarity not authorization?
11. What must happen before output reaches SQL, shell, HTML, or a browser?
12. What makes ASI01 different from LLM01?
13. What is a confused deputy?
14. Why are MCP servers a supply-chain surface?
15. Name three generated-code sandbox controls.
16. Why should memory writes be privileged?
17. Name two controls for inter-agent replay or spoofing.
18. What limits a cascading failure?
19. How can a reviewer be exploited by an agent?
20. What is the response sequence for a rogue agent?

### Answer key

1. An open risk, threat, control, and testing resource; not a certification.
2. When the model is embedded in an application and also plans, uses tools, retains memory, delegates, or causes effects.
3. Retrieved documents, web pages, email, images, audio, video, tool results, issue titles, database rows, MCP servers, or memory.
4. Adaptive attackers can bypass filters; the model lacks an enforced instruction/data boundary and permissions can amplify impact.
5. Disclosure is the exposed information; hidden context exposure focuses on private instructions, memory, routing, or internal context.
6. The application chooses permissions, functionality, autonomy, and sinks; the model can be fooled.
7. Data, adapters, tokenizers, embeddings, indexes, prompts, tools, MCP servers, packages, containers, runtimes, or evaluators.
8. Resource exhaustion that creates unexpected paid usage or consumes service capacity.
9. Fluency does not entail support; citation fidelity tests whether the source supports the claim.
10. A similar document may be unauthorized; authorization must be enforced before retrieval and use.
11. Treat it as untrusted input; validate, encode/parameterize, restrict sinks, sandbox, and approve when needed.
12. LLM01 is input-side instruction manipulation; ASI01 is agentic goal/plan redirection across actions and time.
13. A privileged component is tricked into using its authority for an actor or task that should not receive it.
14. They connect agents to tools/data with code, credentials, schemas, and chained side effects.
15. Ephemeral isolation, restricted network, no default secrets, filesystem boundary, resource limits, output limits, and cleanup.
16. Poisoned memory can alter future sessions, users, plans, retrieval, and tools.
17. Authenticated channels, issuer/audience binding, signatures, nonce/expiry, replay detection, and schema validation.
18. Bounded depth/fan-out/retries/steps, circuit breakers, budgets, timeouts, typed handoffs, and compensation.
19. Through urgency, misleading summaries, selective evidence, approval fatigue, or display/execution mismatch.
20. Detect, quarantine, revoke/rotate identity, disable tools/routes, preserve evidence, notify, recover, and regression-test.

## Flashcards

What is the OWASP LLM Top 10 boundary?::Risks when a model is a component inside an application.
What is the OWASP Agentic Top 10 boundary?::Risks when a system plans, acts, retains memory, delegates, communicates, or causes effects.
What is LLM01:2026?::Prompt Injection.
What is LLM02:2026?::Sensitive Information Disclosure.
What is LLM03:2026?::Excessive Agency.
What is LLM04:2026?::Supply Chain.
What is LLM05:2026?::Data and Model Poisoning.
What is LLM06:2026?::Unbounded Consumption.
What is LLM07:2026?::Misinformation.
What is LLM08:2026?::Hidden Context Exposure.
What is LLM09:2026?::Vector and Embedding Weaknesses.
What is LLM10:2026?::Improper Output Handling.
What is ASI01:2026?::Agent Goal Hijack.
What is ASI02:2026?::Tool Misuse and Exploitation.
What is ASI03:2026?::Identity and Privilege Abuse.
What is ASI04:2026?::Agentic Supply Chain Vulnerabilities.
What is ASI05:2026?::Unexpected Code Execution.
What is ASI06:2026?::Memory and Context Poisoning.
What is ASI07:2026?::Insecure Inter-Agent Communication.
What is ASI08:2026?::Cascading Failures.
What is ASI09:2026?::Human-Agent Trust Exploitation.
What is ASI10:2026?::Rogue Agents.
What is an AIBOM?::An AI Bill of Materials inventorying models, data, adapters, tools, dependencies, runtimes, and provenance.
What is a denial-of-wallet attack?::An attack that exhausts tokens, calls, compute, storage, quotas, or paid credits.
What is excessive agency?::Granting a model too much functionality, permission, or autonomy.
What is hidden context exposure?::Leakage of private system/developer instructions, memory, routing, or internal context.
What is memory poisoning?::Persistent manipulation of agent memory or shared context that changes future behavior.
What is improper output handling?::Allowing untrusted model output to reach a downstream sink without safe validation or encoding.
What is indirect prompt injection?::Instructions embedded in external content processed by the model.
What is a confused deputy?::A privileged component tricked into using its authority for an unintended actor or task.
What is an AI kill switch?::A tested control that disables a model, route, tool, workflow, identity, or action class.
What is adaptive red teaming?::Testing after the attacker knows the deployed defense and can change payloads.
What is a residual-risk decision?::An explicit acceptance, mitigation, transfer, or rejection decision after evidence review.
What is OWASP FinBot?::A controlled OWASP agentic-security Capture-The-Flag environment.
What is COMPASS?::OWASP's threat-defense prioritization and governance dashboard/runbook methodology.
What is a least-privilege tool?::A tool whose identity, arguments, scope, destination, and side effects are narrowly limited.
What is an agent action matrix?::A table mapping actors and tools to verbs, fields, scopes, approvals, limits, reversibility, and evidence.

## Suggested projects

1. **OWASP risk register:** Map all ten LLM risks for a synthetic RAG chatbot, with one abuse case, control owner, and regression test per risk.
2. **Secure MCP server:** Build a read-only synthetic-document server with OAuth test identity, tenant ACLs, strict schemas, limits, traces, pinning, and replay/injection tests.
3. **Agentic Top 10 review:** Produce a goal contract, identity matrix, tool policy, memory policy, inter-agent envelope, fault-injection report, and residual-risk decision.
4. **AIBOM release gate:** Inventory model, adapter, data, embedding model, index, MCP tool, container, prompt, and evaluator; block releases with missing integrity or ownership evidence.
5. **AI incident tabletop:** Simulate indirect injection leading to memory poisoning, tool misuse, disclosure, and retry cascade; detect, contain, revoke, recover, and write regression cases.
6. **Purple-team program:** Map OWASP, NIST, MITRE ATLAS, and AIBOM controls; run authorized red-team tests, implement blue-team fixes, and present before/after evidence.

## Official sources checked 2026-08-24

- [OWASP GenAI Security Project](https://genai.owasp.org/)
- [OWASP GenAI LLM Top 10 2026](https://genai.owasp.org/resource/owasp-genai-llm-top-10-2026/)
- [OWASP Top 10 for Agentic Applications 2026](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/)
- [OWASP Agentic Security Initiative](https://genai.owasp.org/initiatives/agentic-security-initiative/)
- [OWASP GenAI Data Security Risks & Mitigations 2026](https://genai.owasp.org/resource/owasp-genai-data-security-risks-mitigations-2026/)
- [OWASP practical guide for secure MCP server development](https://genai.owasp.org/resource/a-practical-guide-for-secure-mcp-server-development/)
- [OWASP AI Security Solutions Landscape](https://genai.owasp.org/initiatives/ai-security-solutions/)
- [OWASP AIBOM Initiative](https://genai.owasp.org/owasp-aibom/)
- [OWASP AIBOM Generator](https://genai.owasp.org/resource/owasp-aibom-generator/)
- [OWASP Threat Defense COMPASS](https://genai.owasp.org/resource/owasp-genai-security-project-threat-defense-compass-1-0/)
- [OWASP AI Security Governance & Adoption](https://genai.owasp.org/initiatives/ai-security-governance-and-adoption/)
- [OWASP legacy page and 2026 canonical repository](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)
- [MITRE ATLAS](https://atlas.mitre.org/)

> [!note] Review trigger
> Re-check the OWASP LLM Top 10, Agentic Top 10, Data Security, MCP guidance, AIBOM tooling, AI-VSS/crosswalks, threat landscapes, incident-response guidance, and related NIST/ATLAS mappings by **2026-11-24**. Preserve dated copies and distinguish draft, release candidate, and final resources.
