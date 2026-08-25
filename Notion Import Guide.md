---
title: Notion Import Guide
aliases:
  - Notion Bridge
  - Notion Export
type: bridge-guide
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: current
as_of: 2026-08-25
last_verified: 2026-08-25
review_by: 2026-11-25
tags:
  - bridge/notion
  - export
  - interoperability
cssclasses:
  - everything-ai
source_policy: official-first
---

# Notion Import Guide

> [!abstract] Purpose
> This is a parallel Notion delivery layer for Everything AI. Obsidian remains the authoring source of truth; the exporter creates a clean derivative for Notion import without changing the Obsidian notes.

## Files

| File | Use |
|---|---|
| [Notion Import Pack.zip](<Notion Import Pack.zip>) | Complete vault export; preserves the folder structure and standardizes links, callouts, and metadata |
| [Notion Import Pack - Part 1 Core Learning.zip](<Notion Import Pack - Part 1 Core Learning.zip>) | Start Here, foundations, core skills, and career map |
| [Notion Import Pack - Part 2 Roles and Practice.zip](<Notion Import Pack - Part 2 Roles and Practice.zip>) | Role tracks, assessment, interviews, and industry overlays |
| [Notion Import Pack - Part 3 Tools, Research, and Studio.zip](<Notion Import Pack - Part 3 Tools, Research, and Studio.zip>) | Tool atlas, templates, research, visuals, and technical studio |
| [scripts/export_notion.rb](<scripts/export_notion.rb>) | Rebuilds the full and split packs after vault changes |

The split packs keep each import below the current Notion bulk-import rate guidance. Import all three parts if the full pack is rate-limited or partially imported.

## Import workflow

1. In Notion desktop or web, choose **Settings → Import → ZIP**, or use **/zip**.
2. Upload the full pack, or import Parts 1–3.
3. Open the imported README page, then Everything AI Home.
4. Import Notion Note Catalog.csv separately if you want a searchable Notion database of notes.
5. Recreate a table of contents or database views in Notion after import; Notion does not preserve Obsidian heading anchors.

Notion's official importer accepts Markdown, ZIP, and CSV. Standard headings, lists, links, code blocks, and simple tables are the safest interchange layer. See the [Notion import documentation](https://www.notion.com/help/import-data-into-notion).

## What is converted

- YAML frontmatter becomes readable metadata and tags below each page title.
- Obsidian wikilinks become ordinary Markdown links when a target exists.
- Same-page heading links become readable text because Notion does not import anchor links.
- Obsidian callouts become bold-labeled Markdown blockquotes.
- Obsidian image embeds become standard Markdown images with copied assets.
- Mermaid remains a code block so the diagram source is preserved.
- Bases become static Role Explorer and Source Review pages.
- Canvas becomes 11 Visual Maps/Notion Visual Map.md.
- Comments, block IDs, CSS classes, and unsupported embeds are removed or reduced to readable text.

## Rebuild after editing the vault

~~~bash
ruby scripts/export_notion.rb
~~~

The script creates the ZIP files in the vault root. It uses only Ruby's standard library plus the system zip command; no cloud service or Notion credential is required.

## Sync model

Treat Obsidian Markdown as canonical. Edit there, rebuild the packs, and import new or changed pages into Notion deliberately. Notion imports generally add content rather than updating existing pages, so do not treat repeated imports as automatic synchronization.

> [!warning] Not a two-way sync
> Edits made in Notion will not flow back into the vault. Keep decisions, source notes, flashcards, and role-track changes in Obsidian, then regenerate the Notion derivative.
