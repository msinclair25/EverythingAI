---
title: 03 Python SQL Git and Software Foundations
aliases:
  - Python SQL Git and Software Foundations
type: foundation
module: 3
scope: United States
level:
  - beginner
  - intermediate
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2027-02-12
estimated_hours: 15-40
prerequisites:
  - "[[01 AI Systems and Vocabulary]]"
tags:
  - ai-careers
  - foundations
  - software-engineering
cssclasses:
  - everything-ai
---

# 03 · Python, SQL, Git, and Software Foundations

## Outcome

You understand the technical substrate used by AI teams and can identify the depth your role requires. This note is a competency map, not a syntax manual.

## Python

Python dominates AI prototyping and much production glue because of its scientific and ML ecosystem. Learn:

- values, types, collections, control flow, functions, modules, exceptions, and context managers;
- virtual environments and dependency locking;
- arrays/dataframes and vectorized operations;
- files, JSON, HTTP requests, environment variables, and command-line arguments;
- type hints, logging, testing, profiling, and packaging;
- asynchronous I/O when coordinating model calls or tools;
- reading library documentation and tracing errors.

Production competency is not “the script ran once.” It means deterministic configuration where possible, validated inputs, explicit errors, tests, observability, safe secret handling, and a reproducible environment.

## SQL and data access

Learn to express:

- selection, filtering, sorting, aggregation, joins, subqueries, common table expressions, and window functions;
- keys, constraints, normalization, indexes, and transactions;
- query plans and the difference between correctness and performance;
- timestamps, nulls, duplicates, slowly changing data, and data contracts;
- access control, parameterized queries, and data minimization.

AI systems often join operational events, feedback, model versions, and evaluation records. A flawed join can create leakage or false conclusions without raising an exception.

## Git and collaboration

Git provides version history and reviewable change:

- repository, commit, branch, merge/rebase, remote, tag, diff, and ignore rules;
- small coherent commits and meaningful messages;
- pull-request review, protected branches, release tags, and rollback thinking;
- never committing credentials, private data, large model artifacts, or unlicensed material;
- versioning prompts, evaluation sets, schemas, configuration, and deployment manifests alongside code where appropriate.

## APIs and integration

Understand HTTP methods, URLs, headers, status codes, JSON schemas, authentication, pagination, timeouts, retries, rate limits, idempotency, streaming, and webhooks. A robust AI integration must distinguish:

- retryable from permanent failure;
- provider error from invalid user input;
- network timeout from completed-but-unacknowledged action;
- model output from trusted structured data.

Validate structured output against a schema. Treat model-generated arguments as untrusted input before a tool call.

## Testing stack

| Layer | Question |
|---|---|
| Unit | Does this function behave for controlled inputs? |
| Integration | Do components and APIs work together? |
| Contract/schema | Does each boundary preserve the agreed shape and meaning? |
| End-to-end | Does the user workflow succeed? |
| Model/system evaluation | Is probabilistic behavior acceptable across cases? |
| Security | Can unauthorized input cross a trust boundary? |
| Load/reliability | Does it work under concurrency, delay, failure, and recovery? |

Traditional tests remain necessary; model evaluations add rather than replace them.

## Runtime and operations vocabulary

- **Process/container:** isolated execution; containers package software and dependencies but are not a complete security boundary.
- **CI/CD:** automated checks and delivery workflows.
- **Environment:** development, test/staging, production; data and permissions must be controlled separately.
- **Telemetry:** logs, metrics, and traces used to understand behavior.
- **Secret:** credential or key stored in a secret manager or protected environment—not source control or prompts.

## Depth by role

| Role family | Target |
|---|---|
| Engineering, research engineering, data, platform | author, test, review, profile, deploy, and debug production-quality code |
| Technical product, solutions, evaluation, security | read code, query data, prototype, inspect APIs, and reason about architecture |
| Product, governance, UX, business | understand data/API/system boundaries and ask precise risk questions; optional scripting increases leverage |
| Automation and operations | build controlled workflows, validate inputs/outputs, manage credentials, and diagnose failure paths |

## Quiz

1. Why should model-produced JSON still be schema-validated?
2. What makes a retry dangerous for a tool that changes state?
3. Why version prompts and evaluation sets?
4. Distinguish a unit test from a model/system evaluation.
5. Name four things that must not be committed to Git.
6. Why can a syntactically correct SQL join still invalidate an evaluation?

> [!success]- Answer key
> 1. A model's output is probabilistic and untrusted; valid-looking text can omit, mis-type, or inject fields. 2. The first request may have succeeded without acknowledgement, so retrying can duplicate the action; use idempotency and state checks. 3. To reproduce behavior, review changes, associate results with a configuration, and roll back. 4. A unit test checks deterministic component behavior; a model/system evaluation measures probabilistic behavior over representative cases and metrics. 5. Credentials, private data, large artifacts, generated secrets, proprietary/unlicensed material, and environment files containing secrets are valid examples. 6. Wrong cardinality, duplicate keys, temporal leakage, null handling, or population filtering can silently change the sample and outcome.

## Flashcards

Virtual environment:: An isolated Python dependency environment for a project.

Parameterized query:: A query that binds values separately from SQL text to improve correctness and reduce injection risk.

Transaction:: A unit of database work with defined atomicity and consistency behavior.

Git commit:: A versioned snapshot with authorship and history; best kept small and coherent.

API contract:: The agreed request, response, behavior, and error semantics across a component boundary.

Idempotency:: The property that repeating an operation has the same intended effect as performing it once.

Schema validation:: Checking structure, types, required fields, and constraints before trusting data.

CI/CD:: Automated integration checks and delivery/deployment processes.

Telemetry:: Logs, metrics, and traces that provide evidence about runtime behavior.

Secret management:: Protecting and rotating credentials outside source code and ordinary content.

## Free-first references

- [Python tutorial](https://docs.python.org/3/tutorial/) and [Python packaging guide](https://packaging.python.org/).
- [PostgreSQL tutorial](https://www.postgresql.org/docs/current/tutorial.html).
- [Pro Git](https://git-scm.com/book/en/v2), free official book.
- [MDN HTTP overview](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview).

Next: [[04 Data Foundations]].
