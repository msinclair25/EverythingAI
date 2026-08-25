---
title: MCP Deep Dive — 2026-08-24
aliases:
  - MCP Deep Dive
  - Model Context Protocol Deep Dive
  - MCP Study Guide
type: technical-study
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
  - ai/mcp
  - ai/agents
  - ai/platform
  - ai/security
  - ai/interoperability
  - ai/study
cssclasses:
  - everything-ai
source_policy: official-first
---

# MCP Deep Dive — 2026-08-24

> [!abstract] The point of this note
> Model Context Protocol (MCP) is an open protocol for connecting AI hosts and clients to tools, resources, prompts, and other agent capabilities. It is not an authorization system, a sandbox, an agent framework, or a guarantee that a server is safe. This note teaches the protocol as a production engineering surface: wire behavior, capability negotiation, transports, identity, OAuth, tool contracts, security, testing, operations, economics, and career evidence.

This is a U.S.-focused study note with primary sources checked on **August 24, 2026**. The current release line is **2026-07-28**; the ecosystem is still migrating from the stateful **2025-11-25** era. Pair this note with [[Agent and Orchestration Frameworks]], [[AI Threat Modeling]], [[OWASP and AI Security — 2026]], [[AI Expansion Atlas — 2026-08-24]], and [[Case - OWASP Agentic Security Review]].

> [!warning] Protocol version matters
> Do not copy a 2025-era `initialize`/`Mcp-Session-Id` example into a 2026 stateless server without checking the SDK and wire version. The 2026-07-28 release removes protocol-level sessions, adds `server/discover`, moves server-initiated interactions into Multi Round-Trip Requests (MRTR), moves Tasks into an extension, hardens OAuth, and deprecates roots, sampling, logging, and legacy HTTP+SSE. Keep a compatibility matrix in every real project.

## What MCP is — and is not

| MCP is | MCP is not |
|---|---|
| A JSON-RPC protocol and schema for hosts, clients, and servers | A model, prompt library, agent planner, or workflow engine |
| A common way to expose tools, resources, prompts, and structured results | An identity provider or policy engine |
| A boundary where a host can inspect, authorize, trace, and revoke capabilities | Proof that a tool description is truthful or that a server is trustworthy |
| A transport-neutral protocol with standard `stdio` and Streamable HTTP transports | A replacement for API contracts, OAuth, network controls, sandboxing, or human approval |
| An interoperability layer for local and remote model applications | A reason to give an agent broad credentials or unrestricted filesystem access |

The useful mental model is **capability plumbing**:

1. A **host** owns the user experience, model context, consent, policy, and multiple client connections.
2. A **client** is the host-owned connection to one MCP server.
3. A **server** exposes focused capabilities and enforces its own application authorization.
4. A **model** may propose a tool call, but deterministic policy decides whether the call is allowed.
5. A **trace and evidence layer** makes every discovery, authorization, call, result, approval, error, and recovery observable.

## The protocol architecture

~~~mermaid
flowchart LR
    U["User / event"] --> H["Host<br/>model + UX + policy"]
    H --> C1["Client A"]
    H --> C2["Client B"]
    C1 --> S1["Local MCP server<br/>stdio"]
    C2 --> S2["Remote MCP server<br/>Streamable HTTP"]
    S1 --> D1["Files / repo / local tools"]
    S2 --> D2["SaaS / database / APIs"]
    S2 --> ID["OAuth resource server"]
    H --> P["Approval + policy gate"]
    P --> C1
    P --> C2
    H --> T["Trace + audit + cost"]
    S1 --> T
    S2 --> T
    R["Registry / server metadata"] -.-> C2
    O["OWASP + NIST + ATLAS"] -.controls.-> P
~~~

### Host, client, and server responsibilities

| Component | Owns | Must not assume |
|---|---|---|
| Host | User consent, model context, server allowlist, tool visibility, approval UX, data-sharing policy, connection lifecycle | A tool annotation or description is a security control |
| Client | One server connection, protocol version, capability handling, request/response validation, token storage, retries | Another server can be trusted because the client trusts a different server |
| Server | Tool/resource/prompt behavior, input/output validation, authorization, upstream credentials, rate limits, domain policy | The model will follow the tool description or that the client has done all authorization |
| Gateway / WAF | TLS, Origin/Host validation, routing, authentication enforcement, rate/spend limits, request IDs | Parsing untrusted JSON is equivalent to enforcing policy |
| Identity provider | User/workload authentication, consent, scopes, issuer metadata, token issuance and rotation | An MCP server may forward a client token to a different upstream API |
| Operator | Version pinning, registry provenance, conformance evidence, incident response, deprecation migration | “It worked in Inspector” is production evidence by itself |

## The 2026 release line and migration map

### Protocol-era comparison

| Era | Lifecycle | HTTP behavior | Server-initiated interaction | Study/implementation posture |
|---|---|---|---|---|
| 2024-11-05 | Legacy initialization and session model | HTTP+SSE | Bidirectional stream | Support only when a required client still depends on it |
| 2025-11-25 | Stateful `initialize` / `initialized`, `Mcp-Session-Id` for Streamable HTTP | Streamable HTTP, optional SSE | Elicitation, sampling, roots, logging, experimental Tasks | Keep as a compatibility target; test explicitly |
| 2026-07-28 | Request/response stateless core; optional `server/discover` | One MCP endpoint, header-routable, horizontally scalable | MRTR returns `input_required`; Tasks is an extension; `subscriptions/listen` for change streams | Preferred target for new remote systems |

The official 2026 release adds:

- **Stateless core:** the `initialize`/`initialized` exchange and `Mcp-Session-Id` are retired for the 2026 wire. Each request carries its protocol version and client metadata; an explicit handle is the right way to carry application state across calls.
- **Discovery:** `server/discover` lets a client learn supported versions, capabilities, instructions, and server metadata before invoking tools. It is useful but not a substitute for authorization.
- **Multi Round-Trip Requests (MRTR):** a server can return `resultType: "input_required"` and the client retries the original request with `inputResponses`; this replaces the need for an always-open server-to-client channel.
- **Header-based routing:** Streamable HTTP requests carry `Mcp-Method` and, for tools, `Mcp-Name`, so a gateway can route, meter, and authorize without parsing the JSON body.
- **Cacheable lists:** `tools/list`, `prompts/list`, `resources/list`, and `resources/read` can carry `ttlMs` and `cacheScope`; clients can cache catalogs while respecting server hints.
- **Extensions:** extensions are negotiated through capability metadata, identified independently, and versioned outside the core specification. Tasks, MCP Apps, and Enterprise-Managed Authorization are important examples.
- **Authorization hardening:** validate the OAuth `iss` parameter, bind credentials to their issuer, use resource indicators and audience checks, and prefer Client ID Metadata Documents (CIMD) over new Dynamic Client Registration (DCR).
- **Deprecations:** roots, sampling, logging, and legacy HTTP+SSE remain available during a minimum twelve-month window, but new designs should not build on them.

> [!tip] Compatibility rule
> A production client should be able to state: “I speak `2026-07-28` and `2025-11-25`; here is the behavior difference for sessions, server-to-client requests, Tasks, subscriptions, logging, and auth.” A production server should record the negotiated era in its trace and have a removal date for legacy support.

### A safe compatibility matrix

| Test dimension | Legacy expectation | 2026 expectation | Evidence |
|---|---|---|---|
| Version | `initialize` selects protocol | `server/discover` or per-request metadata selects protocol | Captured request/response |
| State | Session ID and server-side connection state may exist | Explicit handle in tool arguments; no hidden protocol session | Two requests routed to different replicas |
| User input mid-call | Server-initiated request over a live channel | `input_required` followed by a retry with `inputResponses` | Approval/decline/cancel tests |
| Long-running work | Experimental Tasks in the core | `io.modelcontextprotocol/tasks` extension | Create, poll, update, cancel, expire |
| Change notifications | Individual subscriptions and SSE behavior | `subscriptions/listen` stream with requested notification kinds | Reconnect and multi-replica test |
| Auth registration | DCR commonly used | CIMD preferred; DCR compatibility only | Metadata and issuer/audience test |
| Deprecations | Roots/sampling/logging normal | Deprecated; replacement path documented | Migration note and warning budget |

## MCP primitives: what each surface is for

### Tools — model-controlled actions

Tools are callable functions with a name, description, `inputSchema`, optional `outputSchema`, optional execution/task support, and behavioral annotations.

| Tool design field | Engineering meaning | Safe practice |
|---|---|---|
| `name` / `title` | Stable programmatic name and human-facing label | Use names that state the action and object; avoid vague `run` or `do_it` |
| `description` | Hint used by a model and displayed to a user | Document preconditions, side effects, authorization, cost, and failure states; treat the text as untrusted metadata |
| `inputSchema` | JSON Schema for arguments | Reject unknown or malformed fields, enforce bounds, enums, tenant IDs, and resource ownership |
| `outputSchema` | Expected structured result shape | Validate on the server and, where supported, on the client; retain a readable text representation for compatibility |
| `readOnlyHint` | Advisory statement that the tool does not modify state | Use as a hint only; enforce read-only behavior in code and credentials |
| `destructiveHint` | Advisory statement about destructive behavior | Default to destructive until deterministic policy proves otherwise |
| `idempotentHint` | Advisory statement that repeat calls have no additional effect | Implement idempotency keys or compare-and-set semantics when the action matters |
| `openWorldHint` | Advisory statement that the tool interacts with external entities | Apply egress, domain, and data-loss controls to open-world tools |
| `execution.taskSupport` | Whether a tool may or must use the Tasks extension | Set timeouts, poll limits, expiry, cancellation, and replay rules |

> [!danger] An annotation is not authorization
> The current schema describes annotations as hints. A malicious or compromised server can lie about read-only, destructive, idempotent, or open-world behavior. The host must derive approval and risk from trusted server identity, tool inventory, policy, and observed behavior.

### Resources — application-controlled context

Resources expose readable data such as files, documents, API responses, schemas, or generated artifacts. They can be static (`resource://catalog`) or templated (`resource://customers/{customer_id}`).

Study the difference between:

- **Resource discovery:** `resources/list` and resource templates tell a client what can be read.
- **Resource retrieval:** `resources/read` returns text, images, audio, or embedded resource links.
- **Resource freshness:** subscriptions and cache hints decide when a client should re-read.
- **Resource authorization:** the URI is not an access-control decision; the server still checks the caller, tenant, object, and purpose.
- **Resource trust:** retrieved text can contain prompt injection, false instructions, secrets, or malicious links; pass it to a model as untrusted context.

### Prompts — user-controlled reusable workflows

Prompts are named templates with arguments and content blocks. They help a user select a workflow without forcing a model to invent the entire instruction. Treat prompt templates as code-like configuration:

- version and review them;
- avoid hidden instructions that expand data access;
- disclose which resources and tools the workflow may use;
- validate arguments and tenant scope;
- keep a human approval step for consequential actions.

### Client features

| Feature | Original purpose | 2026 posture |
|---|---|---|
| Sampling | Ask the host’s model to generate a completion | Deprecated for new designs; call a provider directly or use an explicit application boundary |
| Roots | Tell a server which workspace directories are relevant | Deprecated and informational; pass explicit resource URIs or safe path parameters instead |
| Elicitation | Ask a user for missing information or confirmation | Use MRTR on modern connections; never request passwords/API keys through form mode |
| Logging | Server-to-client protocol log messages | Deprecated; use application logging and OpenTelemetry with redaction |
| Completion | Help complete prompt/resource-template arguments | Useful for UX, but still validate the final value server-side |

### Utilities and extensions

| Surface | Why it matters |
|---|---|
| Pagination | Bounds list size, token use, and memory; cursors must be opaque and scoped |
| Progress | Shows work advancing; never use progress as proof that a side effect succeeded |
| Cancellation | Stops expensive or dangerous work; handlers need cooperative cancellation and cleanup |
| Tasks extension | Represents long-running work with `tasks/get`, `tasks/update`, `tasks/result`, and `tasks/cancel`; treat task handles as capabilities |
| `subscriptions/listen` | One modern stream for requested change notifications; design for reconnects and multi-replica delivery |
| MCP Apps | Server-provided UI rendered in a host sandbox; review HTML, postMessage, origins, data flow, and tool consent |
| Enterprise-Managed Authorization | Enterprise policy can manage authorization relationships; verify the extension and deployment contract before depending on it |

## Wire protocol and transports

### JSON-RPC envelope

MCP messages use JSON-RPC 2.0 requests, notifications, and responses. A request ID must correlate the response; errors must be machine-readable and safe to return to a model. Do not put secrets in IDs, URIs, query strings, tool descriptions, or error messages.

### `stdio`

Use `stdio` when a trusted host launches a local server process:

- the client starts the subprocess;
- JSON-RPC messages are newline-delimited on `stdin`/`stdout`;
- `stdout` must contain only valid MCP messages;
- diagnostics belong on `stderr`;
- the host controls the executable, arguments, working directory, environment, and filesystem boundary;
- installation must be explicit and reviewable; never silently execute a command copied from an untrusted server card or web page.

Local does not mean safe. A local server can read files, exfiltrate secrets, execute code, or modify a repository with the host’s permissions.

### Streamable HTTP

Use Streamable HTTP when the server is a separately deployed service:

- one MCP endpoint supports HTTP `POST` and `GET`;
- clients advertise `application/json` and `text/event-stream` in `Accept`;
- modern POST requests include `Mcp-Method` and, when relevant, `Mcp-Name`;
- the server validates `Origin` to prevent DNS rebinding and binds local development to `127.0.0.1`;
- the gateway terminates TLS, applies host/origin policy, enforces authentication, and preserves request IDs;
- modern requests can be load-balanced without protocol session stickiness;
- application state still needs explicit handles, durable storage, idempotency, and tenant binding;
- legacy clients may require the deprecated HTTP+SSE compatibility path during migration.

~~~http
POST /mcp HTTP/1.1
Host: mcp.example.com
MCP-Protocol-Version: 2026-07-28
Mcp-Method: tools/call
Mcp-Name: search
Accept: application/json, text/event-stream
Authorization: Bearer <token>
Content-Type: application/json

{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"search","arguments":{"query":"MCP"},"_meta":{"io.modelcontextprotocol/clientInfo":{"name":"study-host","version":"1.0.0"}}}}
~~~

### HTTP gateway checklist

1. Validate `Host` and `Origin`; reject invalid browser origins with `403`.
2. Enforce TLS and prevent access tokens in URLs or logs.
3. Route and meter using trusted headers only after normalizing and validating them.
4. Limit body size, header size, tool argument size, list page size, and task duration.
5. Apply per-tenant and per-user rate/spend quotas.
6. Preserve W3C trace context in `_meta` without accepting caller-supplied identity as authoritative.
7. Use request cancellation, upstream timeouts, circuit breakers, and retry budgets.
8. Disable or tightly restrict public CORS and browser exposure.
9. Treat `Mcp-Param-*` values as untrusted and verify them against the JSON body.
10. Test the same policy through direct origin, gateway, retries, and a second replica.

## Authorization, identity, and OAuth

### The roles

| Role | Meaning |
|---|---|
| Resource owner | The person or workload whose data/action is being accessed |
| MCP client | OAuth client requesting an access token to call the MCP server |
| MCP server | OAuth resource server protecting its own endpoint |
| Authorization server | Issues tokens, publishes metadata, and obtains consent |
| Upstream resource server | A downstream API the MCP server may call with a separate token |

### Remote authorization flow

~~~mermaid
sequenceDiagram
    participant C as MCP client
    participant M as MCP server
    participant AS as Authorization server
    participant API as Upstream API
    C->>M: Request without valid token
    M-->>C: 401 + WWW-Authenticate resource_metadata
    C->>M: Fetch Protected Resource Metadata
    M-->>C: authorization_servers + scopes
    C->>AS: Discover metadata; authorize with PKCE + resource
    AS-->>C: Code + iss
    C->>AS: Exchange code; validate iss and redirect
    AS-->>C: Access token bound to MCP resource/audience
    C->>M: Authorization: Bearer token
    M->>M: Validate signature, issuer, audience, scope, tenant, expiry
    M->>API: Use a separate upstream token or server credential
    API-->>M: Result
    M-->>C: Authorized MCP result
~~~

### Required controls for HTTP MCP authorization

- **Protected Resource Metadata:** the MCP server identifies its authorization server(s); clients use `WWW-Authenticate` or the well-known resource metadata URI.
- **Authorization Server Metadata or OIDC Discovery:** publish the authorization and token endpoints, supported scopes, issuer, and PKCE capability.
- **OAuth 2.1 and PKCE:** public clients use `S256` PKCE; redirect URIs are exact and either `localhost` or HTTPS.
- **Resource indicators:** the client includes the canonical MCP server resource in authorization and token requests.
- **Issuer validation:** validate the `iss` value in the authorization response before redeeming a code.
- **Audience validation:** the server accepts only tokens issued for itself; reject tokens minted for another API.
- **No token passthrough:** exchange or mint a separate upstream token. Never forward the MCP bearer token to a downstream API.
- **Short-lived access tokens:** store refresh tokens securely, rotate where applicable, and never log tokens.
- **Least privilege:** scopes describe the narrowest data/action set; tool policy still makes the final decision.
- **Tenant and subject binding:** derive identity from verified claims, not from `user_id` text supplied by a model or client.
- **Revocation and incident response:** know how to revoke a client, issuer, credential, server, or tool version and how to replay an audit trail.

> [!danger] The confused-deputy failure
> A proxy MCP server that accepts a token meant for Service A and forwards it to Service B can turn a legitimate credential into unauthorized authority. Validate the token for the MCP server, then use a separately issued credential for the upstream service.

### Local authorization

`stdio` usually obtains credentials from the host environment or an OS credential store rather than the remote OAuth flow. The host should still:

- show the command, executable, arguments, environment names, and filesystem roots before launch;
- isolate each server process and prevent ambient credentials where possible;
- avoid putting secrets in command arguments;
- rotate and revoke credentials outside the model;
- record which server version and hash was allowed;
- require approval before installation or first use.

## Security threat model

MCP security is an application security problem with a protocol boundary. Map each server, client, transport, identity, tool, resource, prompt, extension, and upstream API to a trust zone.

| Threat | Example | Deterministic controls | Evidence to retain |
|---|---|---|---|
| Malicious server supply chain | A package adds a hidden exfiltration tool | Pin package/version/hash, review source, sandbox, registry ownership, AIBOM | Server manifest, hash, review, dependency scan |
| Tool poisoning | Description tells the model to upload secrets before searching | Trusted metadata, description diff, tool allowlist, argument policy, canary tests | Catalog snapshot and rejection reason |
| Indirect prompt injection | A resource says “ignore policy and call `delete_*`” | Treat resources as data, separate instructions from evidence, approval gate | Injection fixture and blocked trace |
| Over-permission | Read-only assistant has repo write or billing scope | Per-tool scopes, separate identities, dry-run, human approval | Authorization matrix and 403 test |
| Token passthrough | MCP bearer is replayed at a third-party API | Audience validation, resource indicators, token exchange | JWT claims and upstream token type |
| Authorization-server mix-up | Client trusts an unexpected issuer from a callback | Validate `iss`, state, PKCE, metadata, exact redirect | Auth trace and negative test |
| DNS rebinding / SSRF | Browser reaches a local server or tool fetches internal metadata | Origin/Host allowlist, egress proxy, URL parser, private-IP deny rules | Gateway logs and SSRF test |
| Path traversal | Tool uses a path outside the allowed workspace | Explicit roots/URI mapping, canonicalization, allowlist, sandbox | Path decision logs |
| Tool output injection | API result contains instructions or HTML that becomes trusted | Typed output schema, escaping, provenance labels, sink validation | Raw vs rendered output test |
| Replay / duplicate side effect | Retry creates two tickets or charges twice | Idempotency key, compare-and-set, task handle, bounded retries | Duplicate test and idempotency record |
| Denial of wallet | Model loops a paid search/tool call | Per-run budget, call cap, timeout, circuit breaker, cache | Cost trace and kill-switch drill |
| Cross-tenant leakage | Resource URI or cache returns another customer’s data | Subject/tenant binding, cache scope, authorization on every read | Tenant isolation test |
| MCP Apps compromise | Server UI uses unsafe iframe messaging or external scripts | Sandboxed origin, CSP, message validation, UI/tool consent | Widget review and CSP report |
| Logging leakage | Trace captures tokens, PII, prompt documents, or secrets | Redaction, sampling, retention, access control, secret scanners | Redaction test and retention policy |
| Rogue long-running task | Task handle is guessed, reused, or never expires | Unpredictable scoped handle, owner binding, TTL, cancellation, state machine | Task transition and expiry tests |

### The trust hierarchy

1. **Deterministic policy** — highest authority: identity, tenant, scope, action class, budget, network, and approval.
2. **Verified server identity and version** — package provenance, registry ownership, signature/hash, review status.
3. **Schema and runtime validation** — input/output contracts, path and domain checks, timeouts, rate limits.
4. **Human consent** — clear action, data, destination, cost, reversibility, and expiry.
5. **Tool annotations and descriptions** — useful hints, never proof.
6. **Model reasoning** — a proposal that can be wrong, manipulated, or incomplete.

## Tool contract and server design

### A good tool contract

Before writing handler code, create a tool card:

| Field | Required question |
|---|---|
| Purpose | What single job does the tool perform? |
| Actor | Which verified subject/tenant is allowed? |
| Inputs | Which fields are required, bounded, enumerated, or mutually exclusive? |
| Outputs | What schema, provenance, freshness, and error states are returned? |
| Side effects | What changes, sends, deletes, spends, or exposes data? |
| Authorization | Which scope and resource ownership checks are needed? |
| Idempotency | What happens if the same call is retried? |
| Budget | What is the maximum time, tokens, API calls, rows, bytes, and dollars? |
| Approval | Which risk classes need a person or deterministic workflow approval? |
| Recovery | How can the action be rolled back, compensated, or quarantined? |
| Observability | Which request, trace, task, policy, and upstream IDs are recorded? |
| Versioning | Which tool/schema version is this, and what breaks on change? |

### Server implementation checklist

- Register only the tools, resources, prompts, and extensions required for the job.
- Keep handlers small; put business authorization in a policy/service layer, not in a prompt.
- Validate input against JSON Schema and repeat important checks after parsing.
- Return typed, bounded results; do not leak stack traces, tokens, SQL, or internal paths.
- Use `outputSchema` for machine-consumed results and include human-readable provenance.
- Use pagination and explicit filters rather than “return everything.”
- Make writes idempotent and expose a dry-run or preview where practical.
- Use separate read and write tools so approval and scopes are legible.
- Apply timeouts and cancellation to every network, subprocess, model, and database call.
- Never allow a model-provided URL, path, tenant, or identity to bypass policy.
- Keep third-party credentials in the server’s credential boundary; do not expose them to model context.
- Emit trace IDs, policy decisions, upstream IDs, latency, bytes, and cost with redaction.
- Maintain a versioned tool manifest and test catalog changes as API changes.

## Client and host design

The host is the last line between a model proposal and a real-world effect.

### Connection policy

| Decision | Safer default |
|---|---|
| Server discovery | Explicit allowlist or curated registry; show publisher, version, permissions, and update history |
| Local launch | User-confirmed command, pinned package, isolated environment, no ambient secrets |
| Remote connection | HTTPS, Origin/Host validation, OAuth metadata, audience-bound tokens |
| Tool exposure | Expose only tools needed for this task; hide write tools until approved |
| Resource context | Label source and trust; keep instructions, evidence, and untrusted content separate |
| Approval | Show exact action, arguments, destination, data, scopes, cost, reversibility, and expiry |
| Failure | Fail closed for authorization, schema, policy, and tenant errors; fail safe for model uncertainty |
| Logging | Redact secrets and sensitive content; retain enough metadata to reconstruct decisions |

### User approval should answer

1. Which server and publisher is asking?
2. Which tool will run, with which arguments?
3. Which data will leave this trust boundary?
4. Which account, tenant, or resource will be affected?
5. Is the action read-only, additive, destructive, or externally visible?
6. What is the estimated cost, duration, and retry behavior?
7. Can the action be undone, previewed, or cancelled?

## Operations, observability, and AI SRE

### Minimum production telemetry

| Signal | Example dimensions | Why it matters |
|---|---|---|
| Availability | server, transport, region, protocol era | Distinguish an app outage from a client/transport incompatibility |
| Tool success | tool, schema version, tenant, error class | Find bad contracts and upstream failures |
| Authorization | 401/403, issuer, audience, scope, subject hash | Detect token misuse, drift, or policy regressions |
| Policy | allow/deny/approval/timeout, risk class | Explain why an action was blocked or permitted |
| Latency | queue, model, tool, upstream, p50/p95/p99 | Prevent slow chains and hidden retries |
| Reliability | retries, cancellations, duplicate suppression, circuit state | Control cascading failures |
| Cost | tokens, calls, bytes, task duration, dollars | Stop denial-of-wallet and budget surprises |
| Data | tenant, source URI, row/byte count, redaction result | Detect leakage and stale/overscoped retrieval |
| Catalog drift | tool/resource/prompt hash and version | Catch supply-chain and description changes |
| Trace completeness | traceparent, spans, sampled fields | Reconstruct model → tool → result → approval |

### Rollout sequence

1. Inventory servers, clients, tools, resources, prompts, extensions, identities, and upstream APIs.
2. Pin versions and capture the tool/resource/prompt catalog as a reviewable artifact.
3. Run local `stdio` tests with synthetic data and a denied write path.
4. Run modern and legacy protocol tests; record deprecations and migration dates.
5. Deploy a read-only remote server behind a gateway with OAuth, Origin/Host checks, and redaction.
6. Add deterministic policy, approval, budgets, cancellation, idempotency, and rollback.
7. Run Inspector, conformance, contract, abuse, load, and failure-injection tests.
8. Shadow or pilot with a small tenant cohort; compare quality, latency, cost, and blocked actions.
9. Promote a versioned server/tool manifest; do not silently change the catalog behind a stable endpoint.
10. Operate a kill switch, credential rotation, server quarantine, and incident replay drill.

### Incident runbook

When an MCP server or tool is suspected of abuse:

- stop new calls with an allowlist or circuit breaker;
- revoke client/server/upstream credentials and rotate tokens;
- preserve the catalog, package hash, config, traces, approvals, and network logs;
- identify affected tenants, resources, tools, and time range;
- search for prompt injection, token exposure, unusual destinations, and repeated tasks;
- quarantine the server version and publish a status/registry change;
- notify affected owners and document legal/privacy escalation;
- add a regression fixture and conformance/security test before re-enabling;
- record residual risk and a dated follow-up review.

## Testing strategy

### Test pyramid

| Layer | Examples | Fast tool path |
|---|---|---|
| Unit | Schema validation, authorization predicate, idempotency, URL/path parser | pytest / Vitest / SDK in-memory client |
| Contract | `tools/list`, `resources/list`, `prompts/list`, `tools/call`, errors, output schemas | MCP SDK test client |
| Protocol | Modern/legacy negotiation, headers, MRTR, cache hints, Tasks, subscriptions | Official conformance suite |
| Security | Injection, tool poisoning, token audience, issuer mix-up, DNS rebinding, SSRF, path escape | Synthetic fixtures + gateway tests |
| Reliability | Timeout, retry, cancellation, duplicate call, replica loss, expired task | Fault injection and load harness |
| UX | Consent, decline/cancel, clear risk and cost, inaccessible or misleading descriptions | Inspector + user tests |
| Production | Drift, spend, trace completeness, tenant isolation, rollback | Staging telemetry and game days |

### Official developer tools

The reference **MCP Inspector** offers Web, CLI, and TUI clients over the same core; use it to inspect tools, resources, prompts, notifications, OAuth, and both legacy and modern protocol eras. The official **conformance** project runs version-scoped client/server scenarios, wire-schema checks, extension visibility, and expected-failure baselines.

~~~bash
# Web Inspector against a local stdio server
npx @modelcontextprotocol/inspector node dist/server.js

# Scriptable Inspector call
npx @modelcontextprotocol/inspector --cli \
  https://mcp.example.com/mcp --transport http \
  --method tools/call --tool-name search \
  --tool-arg query=MCP --format json

# Run server conformance for the modern release line
npx @modelcontextprotocol/conformance server \
  --url http://localhost:3000/mcp \
  --requirements 2026-07-28
~~~

### Test cases every serious server should have

- malformed JSON-RPC and unknown method;
- missing, extra, wrong-type, oversized, and boundary arguments;
- tool annotation that lies about read-only or idempotency;
- output that violates `outputSchema`;
- resource URI for another tenant or path outside the allowlist;
- prompt injection in a resource, tool result, or server description;
- 401 discovery, expired token, wrong audience, wrong issuer, insufficient scope;
- token in query string or downstream token passthrough attempt;
- invalid `Origin`, `Host`, CORS, SSRF, private-IP, and redirect behavior;
- retry after timeout and duplicate write with the same idempotency key;
- task handle guessing, stale task, cancel after completion, expiry, and replay;
- MRTR accept, decline, cancel, malformed response, and maximum-round failure;
- cached list with stale `ttlMs`, reordered tools, changed catalog hash, and multi-replica read;
- client disconnect, server restart, upstream outage, and circuit recovery;
- redaction of prompt, resource, token, PII, and error fields in traces.

## Registry, provenance, and supply chain

The official MCP Registry is a discovery/catalog layer, not a security verdict. Treat a registry entry as metadata that needs verification:

1. Resolve the namespace and publisher ownership.
2. Pin the server name, version, package source, transport, and expected capabilities.
3. Review the repository, license, dependencies, release history, and security policy.
4. Record a package hash, image digest, SBOM/AIBOM, and tool catalog snapshot.
5. Verify the server in a sandbox with Inspector and conformance.
6. Promote only the reviewed artifact; monitor catalog and dependency drift.

> [!warning] Registry preview
> Registry APIs and metadata are evolving. Do not rely on “latest” in production. Use a curated internal catalog for business-critical servers and require a re-review when the server version, package, description, scopes, or tool list changes.

## Free-first and paid production paths

| Need | Free/open learning path | Paid/managed path | Evidence to compare |
|---|---|---|---|
| Server/client SDK | Official TypeScript, Python, Go, C# SDKs; local `stdio` | Managed agent/runtime or enterprise SDK support | Spec-era support, release cadence, test coverage |
| Inspection | MCP Inspector Web/CLI/TUI via `npx` | Hosted developer portal or enterprise integration testing | Catalog inspection, OAuth, CI usability |
| Conformance | Official conformance CLI and GitHub Action | Vendor support or managed compliance pipeline | Scored requirements, wire-schema checks, baseline discipline |
| Auth | Local OIDC/OAuth test provider, signed test JWTs | Microsoft Entra, Auth0, Okta, AWS, or enterprise IdP | Metadata, issuer/audience, rotation, admin policy |
| Gateway | Caddy, NGINX, Envoy, Traefik, or a local reverse proxy | Cloud API gateway, WAF, private networking, SIEM | Origin/Host, rate/spend, egress, audit, latency |
| Storage/tasks | SQLite/Postgres, local queue, deterministic handles | Managed Postgres, Redis, queues, workflow engine | Durability, tenant isolation, TTL, recovery |
| Telemetry | OpenTelemetry Collector, Jaeger, Prometheus, Grafana | Datadog, New Relic, Honeycomb, Azure Monitor, CloudWatch | Trace joins, redaction, retention, alerting |
| Registry | Read-only official registry API plus a checked-in catalog | Private registry, approval workflow, vendor scanning | Ownership, signatures, drift, status/revocation |
| Security testing | pytest/Vitest, Semgrep, ZAP, fuzzing, synthetic injection corpus | DAST/SAST, SIEM, red-team platform, managed assessment | Coverage, false positives, evidence, remediation |

Free tools still have labor, hosting, patching, and incident costs. Paid tools still need a threat model and exit plan.

## MCP role map

| Role | MCP evidence to build |
|---|---|
| [[Agentic AI Engineer]] | A multi-tool server with explicit state handles, MRTR approval, typed results, retries, and trace correlation |
| [[AI Platform Engineer]] | Stateless HTTP deployment behind a gateway, multi-replica routing, identity, budgets, catalog promotion, and rollback |
| [[AI Security Engineer]] | Threat model, token audience/issuer tests, tool-poisoning corpus, SSRF/DNS-rebinding controls, and incident runbook |
| [[MLOps Engineer]] | Versioned catalog, conformance CI, OpenTelemetry traces, SLOs, drift alerts, and cost/latency dashboards |
| [[AI Evaluation Engineer]] | Golden tool-call dataset, schema/error evaluators, trajectory assertions, approval metrics, and regression gates |
| [[AI Red Teamer]] | Malicious server/resource/tool fixtures, prompt-injection chains, exfiltration tests, and report with residual risk |
| [[AI Product Manager]] | Tool inventory, user consent design, approval taxonomy, unit economics, accessibility, and launch/rollback criteria |
| [[AI Governance Specialist]] | AIBOM, data flow, vendor/registry review, retention, subprocessors, policy mapping, and evidence ownership |

## Study path

### Beginner: understand the boundary

1. Read the architecture and primitives sections.
2. Run a local read-only `stdio` server with synthetic data.
3. Inspect `tools/list`, call one tool, read one resource, and render one prompt.
4. Write a one-page tool card and explain why annotations are hints.
5. Complete the beginner questions and flashcards below.

### Intermediate: build a safe remote integration

1. Deploy a Streamable HTTP server behind a local gateway.
2. Add `inputSchema`, `outputSchema`, pagination, timeouts, idempotency, and redacted traces.
3. Implement OAuth metadata, PKCE, resource indicators, issuer/audience validation, and separate upstream credentials.
4. Add an approval gate for a dry-run write.
5. Run Inspector, conformance, malformed-input, injection, and tenant-isolation tests.

### Advanced: operate and migrate

1. Serve modern and legacy protocol eras with explicit compatibility tests.
2. Use explicit state handles, Tasks, MRTR, cache hints, `subscriptions/listen`, and multi-replica routing.
3. Build a private catalog with provenance, AIBOM/SBOM, hash pinning, and review status.
4. Measure p95 latency, tool success, policy decisions, spend, trace completeness, and recovery.
5. Run an incident game day and produce an audit-ready release dossier.

### Expert: contribute to the ecosystem

- Read the current roadmap and SEP process.
- Implement or review an SDK feature against the conformance suite.
- Contribute a secure reference server, test fixture, or extension.
- Compare protocol interoperability across at least two SDKs and two protocol eras.
- Publish a migration note that names behavior differences, test evidence, and deprecation deadlines.

## Interview preparation

Be ready to answer these without hiding behind “the SDK handles it”:

1. What problem does MCP solve, and what security problems does it not solve?
2. Explain host, client, and server boundaries. Why is one client connection per server useful?
3. Compare `stdio` and Streamable HTTP. When is each appropriate?
4. What changed in the 2026-07-28 protocol?
5. Why did MCP remove protocol-level sessions, and how should application state work now?
6. What does `server/discover` provide, and why is discovery not authorization?
7. How does MRTR replace a server-initiated elicitation over a stateless connection?
8. How would you migrate a 2025 Tasks implementation to the Tasks extension?
9. How do you prevent a model from invoking a destructive tool based on a poisoned description?
10. What is the difference between a tool annotation and an authorization decision?
11. Walk through MCP OAuth discovery from a `401` response.
12. Why are resource indicators and audience validation important?
13. What is token passthrough, and why is it a confused-deputy risk?
14. How would you authenticate a local `stdio` server?
15. How do you design a tool so a retry cannot duplicate a payment or ticket?
16. Which fields belong in `outputSchema`, and what should still be validated outside the model?
17. How would you prevent SSRF and DNS rebinding in a remote MCP deployment?
18. Which metrics tell you that a server is expensive, unreliable, or leaking data?
19. What should a registry review contain before a server is allowed into production?
20. How would you prove that a server works behind two replicas and a real gateway?

## Knowledge check

### Quiz

1. What are the three core MCP actors?
2. Which primitive is model-controlled: tools, resources, or prompts?
3. Why are tool annotations not sufficient for approval?
4. What transport is normally used when a host launches a local server?
5. What transport is designed for separately deployed remote servers?
6. What protocol-era feature does `server/discover` complement?
7. How does a 2026 server carry application state across calls?
8. What does MRTR return when a tool needs user input?
9. Which extension contains modern Tasks?
10. Name two MCP features deprecated in 2026-07-28.
11. What metadata does a protected MCP server expose after a 401?
12. Which OAuth parameter binds a token request to the target resource?
13. What must a server validate before accepting an access token?
14. Why must an MCP server not pass its inbound bearer to an upstream API?
15. Which HTTP header must a Streamable HTTP server validate to reduce DNS rebinding risk?
16. What is the difference between a resource URI and an access-control decision?
17. Give one control for duplicate side effects.
18. Which official tool provides interactive Web/CLI/TUI server inspection?
19. What does the conformance suite validate besides a happy-path call?
20. Why should “latest” not be used as a production registry pin?

### Answer key

1. Host, client, and server.
2. Tools.
3. They are untrusted hints; a server can lie, so policy must enforce behavior.
4. `stdio`.
5. Streamable HTTP.
6. The 2026 stateless per-request lifecycle and capability discovery.
7. With an explicit, scoped handle passed as an ordinary argument and backed by durable state when needed.
8. An `input_required` result with requests that the client answers in `inputResponses`.
9. `io.modelcontextprotocol/tasks`.
10. Any two of roots, sampling, logging, or legacy HTTP+SSE.
11. OAuth Protected Resource Metadata, via `WWW-Authenticate` or a well-known endpoint.
12. The OAuth `resource` parameter (RFC 8707).
13. Signature, issuer, audience, expiry, scope, subject/tenant, and policy.
14. It creates token passthrough and confused-deputy risk; use a separate upstream credential.
15. `Origin` (and validate `Host` as part of gateway policy).
16. A URI identifies a resource; authorization must still check identity, tenant, purpose, and scope.
17. Idempotency keys, compare-and-set, a dry-run, or a deduplicated task handle.
18. MCP Inspector.
19. Wire schema, versioned scenarios, errors, auth, backcompat, extensions, and expected-failure discipline.
20. “Latest” can change capabilities, code, dependencies, permissions, or behavior without a reviewed release.

## Flashcards

What is MCP?::An open JSON-RPC protocol for connecting AI hosts/clients to servers that expose tools, resources, prompts, and related capabilities.
What is MCP not?::It is not an identity provider, sandbox, agent planner, policy engine, or proof that a server is safe.
What does the host own?::User experience, model context, consent, connection policy, approval, and multiple client lifecycles.
What does an MCP client represent?::A host-owned connection to one MCP server.
What does an MCP server expose?::Focused tools, resources, prompts, and optional extensions while enforcing its own application authorization.
Which MCP primitive is model-controlled?::Tools.
Which MCP primitive is application-controlled context?::Resources.
Which MCP primitive is user-controlled workflow text?::Prompts.
What is a tool inputSchema?::A JSON Schema contract for the arguments a tool accepts.
What is a tool outputSchema?::A JSON Schema contract for structured tool results.
Are tool annotations authorization?::No; annotations are hints and may be untrusted.
What does readOnlyHint mean?::An advisory claim that a tool does not modify its environment.
What does destructiveHint mean?::An advisory claim that a non-read-only tool may perform destructive updates.
What does idempotentHint mean?::An advisory claim that repeating the same call has no additional effect.
What does openWorldHint mean?::An advisory claim that a tool interacts with external entities.
What is stdio transport?::A local subprocess transport where JSON-RPC uses stdin/stdout and diagnostics use stderr.
What must never appear on a stdio server stdout?::Anything that is not a valid MCP JSON-RPC message.
What is Streamable HTTP?::The remote MCP transport using a single HTTP endpoint with POST and GET, optionally streaming SSE.
What replaced HTTP+SSE?::Streamable HTTP replaced it for the 2025-11-25 transport era; legacy HTTP+SSE is deprecated.
What changed in MCP 2026-07-28?::Stateless core, server/discover, MRTR, header routing, cache hints, extension formalization, auth hardening, and deprecations.
What was retired in the 2026 stateless core?::The initialize/initialized exchange and Mcp-Session-Id protocol session.
How does a modern MCP server discover capabilities?::A client may call server/discover; requests also carry modern metadata.
How should application state cross modern requests?::Use an explicit scoped handle passed as a normal argument and persist state safely.
What is MRTR?::Multi Round-Trip Requests, where a server returns input_required and the client retries with inputResponses.
Where did Tasks move?::Into the io.modelcontextprotocol/tasks extension.
What is subscriptions/listen?::A modern stream that lets clients opt into notification kinds.
Which features are deprecated in 2026-07-28?::Roots, sampling, logging, and legacy HTTP+SSE.
What does Protected Resource Metadata do?::It tells a client which authorization server(s) protect the MCP resource.
What is the OAuth resource parameter?::A resource indicator that binds authorization and token requests to the target MCP server.
What is audience validation?::Checking that a token was issued for this MCP server, not another service.
What is token passthrough?::Forwarding the inbound MCP bearer to a downstream API; it is forbidden because of confused-deputy risk.
Why validate iss?::To prevent authorization-server mix-up and redeeming a code under an unexpected issuer.
What is CIMD?::OAuth Client ID Metadata Documents, the preferred registration direction over new DCR.
Why use PKCE?::To prevent authorization-code interception and injection, especially for public clients.
What is a resource URI?::An identifier for data; it is not by itself an authorization decision.
Why use idempotency keys?::To prevent retries from duplicating a consequential side effect.
What is a task handle?::A scoped capability for tracking long-running work through the Tasks extension.
What does Origin validation protect?::It reduces DNS rebinding attacks against local or remote Streamable HTTP servers.
What is tool poisoning?::Malicious or misleading tool metadata that steers a model toward unsafe behavior.
What is indirect prompt injection in MCP?::Instructions hidden in a resource or tool result that try to alter model or tool behavior.
What is the official MCP Inspector?::A Web, CLI, and TUI developer tool for testing and debugging MCP servers.
What does MCP conformance test?::Versioned client/server behavior, wire schemas, auth, backcompat, and required scenarios.
Why pin a registry server version?::Because latest can change code, dependencies, capabilities, permissions, and tool descriptions.
What is the safest first production tool posture?::A narrowly scoped, read-only tool with typed schemas, full traces, budgets, and no ambient secrets.

## Suggested projects

### Beginner — local read-only knowledge server

Build a Python or TypeScript `stdio` server with two read-only tools and one resource over a synthetic U.S. public-data corpus. Use explicit schemas, bounded pagination, source IDs, and redacted errors.

**Deliver:** README, server manifest, tool cards, Inspector screenshot, five unit tests, five malformed-input tests, and a short “what the model cannot do” note.

### Intermediate — safe write preview

Add a dry-run tool that proposes a change but cannot commit it. Require an approval token generated outside the model, validate tenant/resource ownership, and make repeated calls idempotent.

**Deliver:** authorization matrix, policy tests, preview/commit traces, duplicate-call test, cancellation test, and user approval copy.

### Intermediate — authenticated remote server

Deploy Streamable HTTP behind a local gateway. Implement protected resource metadata, OAuth 2.1/PKCE, resource indicators, issuer/audience checks, separate upstream credentials, Origin/Host validation, and redaction.

**Deliver:** auth sequence diagram, negative JWT tests, SSRF/DNS-rebinding tests, gateway config, runbook, and a cost/latency baseline.

### Advanced — modern/legacy compatibility lab

Serve both `2025-11-25` and `2026-07-28`. Exercise `server/discover`, explicit state handles, MRTR, Tasks, cache hints, `subscriptions/listen`, and the legacy fallback. Pin the client mode in tests.

**Deliver:** behavior matrix, captured wire samples, migration guide, deprecation dates, two-replica load test, and conformance report.

### Advanced — MCP security lab

Create intentionally malicious fixtures: a poisoned tool description, an injected resource, a wrong-audience token, a token passthrough proxy, an SSRF URL, a path traversal, a duplicate write, and a runaway paid tool loop.

**Deliver:** threat model mapped to [[OWASP and AI Security — 2026]], exploit reproduction, control, regression test, residual risk, and incident report.

### Capstone — curated MCP platform

Build an internal catalog that records publisher/namespace, version, package hash, transport, capabilities, scopes, AIBOM/SBOM, review status, conformance result, telemetry owner, and retirement date. Promote a server through dev, staging, and production with approval and rollback.

**Deliver:** platform architecture, catalog schema, promotion pipeline, cost/SLO dashboard, tenant-isolation evidence, incident game day, and an interview-ready release dossier.

## Source notes checked 2026-08-24

- [The 2026-07-28 MCP specification release](https://blog.modelcontextprotocol.io/posts/2026-07-28/) — stateless core, MRTR, header routing, cache hints, Tasks, authorization hardening, and deprecations.
- [The new MCP roadmap](https://blog.modelcontextprotocol.io/posts/mcp-roadmap/) — August 22, 2026 priorities for messaging, HTTP hardening, identity/security, primitives, and SDK experience.
- [MCP 2025-11-25 authorization](https://modelcontextprotocol.io/specification/2025-11-25/basic/authorization) — OAuth 2.1, Protected Resource Metadata, CIMD/DCR, PKCE, resource indicators, issuer/audience validation, and token passthrough rules.
- [MCP 2025-11-25 transports](https://modelcontextprotocol.io/specification/2025-11-25/basic/transports) — `stdio`, Streamable HTTP, Origin validation, localhost binding, and legacy compatibility.
- [MCP 2025-11-25 schema](https://modelcontextprotocol.io/specification/2025-11-25/schema) — tool schemas, output schemas, annotations, content blocks, and metadata.
- [MCP draft changelog](https://modelcontextprotocol.io/specification/draft/changelog) — stateless/session changes, header requirements, cache ordering, OpenTelemetry trace context, and extension metadata.
- [MCP Inspector 2026 documentation](https://github.com/modelcontextprotocol/modelcontextprotocol/blob/main/docs/docs/2026-07-28/tools/inspector.mdx) — Web, CLI, TUI, OAuth, and protocol-era inspection.
- [MCP conformance tests](https://github.com/modelcontextprotocol/conformance) — version-scoped scenarios, wire-schema checks, extension handling, and CI.
- [MCP TypeScript SDK v2](https://ts.sdk.modelcontextprotocol.io/v2/api/%40modelcontextprotocol/server/) and [MCP Python SDK](https://py.sdk.modelcontextprotocol.io/get-started/) — current implementation paths.
- [Official MCP Registry API](https://github.com/modelcontextprotocol/registry/blob/main/docs/reference/api/official-registry-api.md) — catalog, versions, status, authentication, and metadata.
- [OWASP secure MCP guide](https://genai.owasp.org/resource/a-practical-guide-for-secure-mcp-server-development/) — complementary security checklist and threat framing.

> [!info] Review trigger
> Recheck this note when a dated MCP specification, SDK major version, authorization extension, registry API, Inspector release, or conformance requirement changes. Treat 2026-07-28 deprecation windows and the 2026 roadmap as moving targets.

See [[AI Tools and Practices Update — 2026-08-24]] for cross-platform practice and [[Security and Red Teaming]] for the broader security lab.
