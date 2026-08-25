# Everything AI

Everything AI is a United States-focused, evidence-aware study vault for learning, practicing, and interviewing for AI work. It is designed for Obsidian and includes a parallel Notion import layer.

The material is organized around a simple loop:

> Learn the field → choose the role → build evidence → prepare for the interview.

## What is inside

- Foundations: math, statistics, machine learning, deep learning, transformers, generative AI, RAG, agents, deployment, economics, safety, and policy.
- Core skills: product discovery, data quality, UX, automation, evaluation, threat modeling, accessibility, governance, and AI economics.
- Career map and role tracks: technical, nontechnical, and hybrid roles with responsibilities, workflows, skills, tools, evidence, projects, flashcards, quizzes, and interview prompts.
- Technical studio: inference, tokens and cost, context engineering, retrieval quality, adaptation, quantization, evaluation harnesses, agent permissions, OWASP-oriented security, and design cases.
- Tool atlas: Azure DevOps and Foundry, Cloudflare, Vercel, MCP, model providers, local runtimes, vector search, MLOps, security, observability, and creative tools.
- Assessment center: diagnostic, cumulative checks, quizzes, flashcards, role readiness, and interview preparation.
- Visual maps and builder paths for navigating the material.

## Start here

Open [Everything AI - Home](00%20Start%20Here/Everything%20AI%20-%20Home.md), then choose a path:

1. **New to AI:** [Builder 4-Week Syllabus](00%20Start%20Here/Builder%204-Week%20Syllabus.md)
2. **Choosing a role:** [Choose Your AI Career](00%20Start%20Here/Choose%20Your%20AI%20Career.md)
3. **Technical depth:** [Technical Skills Hub](12%20Technical%20Studio/Technical%20Skills%20Hub.md)
4. **Practice:** [Assessment Center](06%20Assessment%20Center/Assessment%20Center.md)
5. **Notion:** [Notion Import Guide](Notion%20Import%20Guide.md)

## Notion import

The repository includes a generated full pack and three smaller packs:

- [Notion Import Pack.zip](Notion%20Import%20Pack.zip)
- [Part 1 — Core Learning](Notion%20Import%20Pack%20-%20Part%201%20Core%20Learning.zip)
- [Part 2 — Roles and Practice](Notion%20Import%20Pack%20-%20Part%202%20Roles%20and%20Practice.zip)
- [Part 3 — Tools, Research, and Studio](Notion%20Import%20Pack%20-%20Part%203%20Tools%2C%20Research%2C%20and%20Studio.zip)

Import a ZIP through Notion's **Settings → Import → ZIP** flow. The CSV catalog can be imported separately as a Notion database. Rebuild the packs after vault edits with:

```bash
ruby scripts/export_notion.rb
```

Obsidian Markdown is the canonical source; the Notion layer is a one-way derivative. See [Notion Import Guide](Notion%20Import%20Guide.md) for conversion rules and known differences.

## Evidence and freshness

Research notes use an official-first source policy and record verification and review dates. The current research cutoff for this release is **August 25, 2026**. Software, pricing, laws, job postings, and vendor capabilities change; verify linked primary sources before making a production, legal, or career decision.

## Working with the vault

The source files are Obsidian Flavored Markdown. Wikilinks, callouts, frontmatter, Mermaid, Bases, Canvas, flashcards, and quizzes are intentional parts of the authoring experience. The `everything-ai` CSS snippet is included for the visual layout used in Obsidian; machine-specific workspace state is ignored.

## License and reuse

No open-source or Creative Commons license has been selected for this repository yet. Unless a license is added, the contents remain protected by applicable copyright law; viewing the public repository does not grant permission to redistribute or commercially reuse the material.
