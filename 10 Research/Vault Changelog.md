---
title: Vault Changelog
type: changelog
scope: United States
status: active
as_of: 2026-08-24
last_verified: 2026-08-24
review_by: 2026-11-24
tags: [ai-careers, changelog]
cssclasses: [everything-ai]
---

# Vault Changelog

## 2026-08-25 — Notion bridge and import packs

- Added [[Notion Import Guide]] with the source-of-truth/sync model, import workflow, conversion rules, and official Notion limitations.
- Added scripts/export_notion.rb, which generates a full ZIP, three smaller import-safe ZIPs, static Role Explorer/Source Review pages, a Canvas replacement, copied image assets, and a Notion Note Catalog CSV.
- Preserved Obsidian as canonical; the bridge is a one-way derivative and does not overwrite vault notes.

## 2026-08-25 — Visual, language, sizing, spacing, and flow pass

- Tuned the everything-ai CSS snippet for a readable content width, editor/reader parity, heading rhythm, paragraph/list measure, calmer table headers, sticky table context, callout accents, responsive table sizing, and more consistent embed spacing.
- Added a quick-route table and recommended sequence to [[AI DevOps and Cloud Engineering — 2026-08-24]].
- Added a visible infrastructure/DevOps learning route to [[Everything AI - Home]] and updated the assessment entry points.
- Static QA remains clean: 225 Markdown notes, frontmatter parses, and wikilinks resolve. Live Obsidian/desktop rendering could not be captured because the local Obsidian/Orca runtime was not reachable.

## 2026-08-24 — Current tools, practices, and technical-role evidence

- Added [[AI Tools and Practices Update — 2026-08-24]] with current primary-source signals, eight cross-role practices, a role technique map, a knowledge check, flashcards, study drills, and four project briefs.
- Added [[Tool Atlas — 2026-08-24 Update]] with free/open and managed paths, current tool decisions, a reusable tool card, a 90-minute proof-of-concept protocol, and a scored selection rubric.
- Added a dated practice overlay to all 23 notes in the technical role folder, so each role profile now points from its work anatomy to current evidence expectations.
- Updated [[Everything AI - Home]] to release 2 with an August 24, 2026 research cutoff while retaining the August 12 baseline as a dated release snapshot.
- Sources checked: MCP roadmap/authorization, OpenAI Agents SDK tracing/testing, Gemini Interactions/caching, Microsoft Foundry evaluation/observability, vLLM, OpenTelemetry GenAI semantic conventions, and NIST TEVV.
- Added [[Microsoft Azure DevOps and Foundry]] with current Azure DevOps MCP, WIF service connections, environments, Foundry hosted agents, Toolboxes, networking, evaluation gates, azd command-surface caveat, traces, free-first paths, and role study sequence.
- Added [[Case - Azure DevOps Foundry Release Gate]] and indexed it in [[Technical Studio]] as a worked release decision with constructed thresholds, failure injects, interview drill, quiz, flashcards, and a capstone extension.
- Added [[Azure DevOps Foundry Release Dossier Template]] so learners can turn the case into a reusable release, approval, and rollback evidence record.
- Added [[Cloudflare and Vercel AI]] with current edge/web AI platform research: Workers AI, AI Gateway, Agents, AI Search, Workflows, AI SDK 7, WorkflowAgent, Sandbox, Connect, Fluid Compute, free/paid paths, role mapping, interview prep, quiz, flashcards, and projects.
- Added [[Case - Edge AI Platform Choice]] and indexed it in [[Technical Studio]] as a worked multi-tenant platform decision with constructed budgets, recovery tests, sandbox controls, fallback evaluation, and cross-vendor trace requirements.
- Added [[AI Expansion Atlas — 2026-08-24]] covering twelve next-wave AI domains: agent interoperability/identity, AI SRE, on-device/private AI, provenance/AIBOM, reasoning compute, document intelligence, privacy, infrastructure sustainability, coding agents, physical AI, AI for science, and realtime interaction.
- Added [[OWASP and AI Security — 2026]] with the current LLM and Agentic Top 10 boundaries, GenAI Data Security, secure MCP, AIBOM, COMPASS, governance, control stack, quizzes, flashcards, interview prompts, and safe portfolio projects.
- Added [[Case - OWASP Agentic Security Review]] and indexed it in [[Technical Studio]] as a ship/stop assessment for injection, identity, tools, memory, MCP, output handling, denial-of-wallet, cascading failure, recovery, and release gates.
- Added [[MCP Deep Dive — 2026-08-24]] as a dedicated protocol-to-production study layer covering the 2026 release line, legacy migration, primitives, transports, OAuth, security threats, conformance, registry provenance, operations, interviews, flashcards, and projects.
- Added [[AI DevOps and Cloud Engineering — 2026-08-24]] as the AI × DevOps/cloud engineering study layer: AI for DevOps, DevOps for AI, cloud comparison, IaC, CI/CD, OIDC/WIF, evaluation, Kubernetes, OTel/MCP observability, supply chain, FinOps, role practice, projects, interview prep, quiz, and flashcards.
- Updated [[Security and Red Teaming]], [[AI Tool Atlas]], four technical role overlays, dated research updates, and source registries with the expansion and OWASP layers.

## 2026-08-12 — Use layer: syllabus, exam, overlays, visuals

- Frozen the concept spine at 16 ([[Concept Spine Freeze]]).
- Added [[Builder 4-Week Syllabus]], [[Technical Cumulative Check]] (20 items, pass 16/20), [[Case - Vision Field Slice]].
- Thickened [[Healthcare and Life Sciences AI]], [[Financial Services and Insurance AI]], [[US Government and Public Sector AI]] to teaching length.
- Polish: [[How an AI Assistant Should Use This Vault]]; renumbered [[Flashcard Index]].
- Visuals: [[Visual Maps Hub]] plus three Grok Imagine 2K PNGs (builder path, spine, RAG autopsy) and HTML/SVG fallbacks.

## 2026-08-12 — Sampling, calibration, quantization, vision

- Added [[Sampling and Decoding]], [[Calibration]], [[Quantization]], [[Vision and Multimodal Systems]].
- Linked [[Computer Vision Engineer]], [[Inference and Performance Engineer]], [[LLM Engineer]]; interview drill 10; glossary terms (temperature, top-p, IoU, mAP, VLM, ECE, PTQ).

## 2026-08-12 — Concept spine 9–12 + split case

- Added [[Embeddings and Similarity]], [[The Training Loop]], [[The Agent Loop]], [[Untrusted Context and Injection]].
- Added [[Case - Split Integrity]] (honest customer/time split vs a dirty 0.94).
- Added interview drill 9; linked [[ML Engineer]]; expanded [[AI Glossary]].

## 2026-08-12 — Technical concept spine

- Added [[Technical Skills Hub]] and eight concept notes that teach the idea, why it exists, the jargon, and a worked teaching example: tokens/cost, leakage, metrics, attention/KV, context engineering, contracts, retrieval quality, adaptation methods.
- Expanded [[AI Glossary]] with the same terms, linked back to the concept notes.
- Builder path is now: foundations → concept spine → two studio cases → role.

## 2026-08-12 — Technical Studio (practice layer)

- Added `12 Technical Studio`: study method, five worked decision cases, eight interview drills, and a case template.
- Cases cover adaptation choice, evaluation gates, agent permissions, serving capacity, and retrieval failure analysis. All numbers are labeled teaching envelopes.
- Wired the studio into Home, How to Use, Learning Path Builder (Layer 2b for builders), Technical AI Careers, Core Skills Hub, Assessment Center, interview hub, and flashcard/quiz indexes.
- Did not add prescriptive labs. Code appears only as inspectable artifacts.

## 2026-08-12 — Release 1

- Created native Obsidian navigation, visual career map, Bases explorers, templates, and CSS.
- Established an August 12, 2026 research cutoff, U.S. scope, source policy, registry, and review queue.
- Added universal beginner-to-advanced AI foundations with quizzes and flashcards.
- Added role bridge skills, career taxonomy/title crosswalk, role profiles, tool atlas, interviews, project suggestions, and industry overlays.
- Added current federal landmarks EO 14365, EO 14409, and NSPM-11 with actor/scope caveats; distinguished policy instruments, recommendations, and enacted law.
- Expanded to 63 full role tracks, including trust and safety operations, enterprise sales, product marketing, strategic partnerships, technical support/user operations, and CAIO/Head of AI feeder paths.
- Release inventory: 176 Markdown notes, 620 flashcards, 98 quiz/knowledge-check notes, 117 Mermaid diagrams, one Canvas, and two Bases.
- Normalized career-role metadata for Bases, replaced a low-information Canvas embed with an interactive link, and cleaned Mermaid labels for native Obsidian rendering.
- Labeled volatile policy, tools, prices, agents, and evaluation material for recurring review.

## Update entry template

### YYYY-MM-DD — topic

- Changed:
- Reason/source:
- Notes affected:
- Next review:
