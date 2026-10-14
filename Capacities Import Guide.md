---
title: Capacities Import Guide
aliases:
  - Capacities Bridge
type: bridge-guide
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: current
as_of: 2026-10-14
last_verified: 2026-10-14
review_by: 2026-11-14
tags:
  - bridge/capacities
  - export
  - interoperability
cssclasses:
  - everything-ai
source_policy: official-first
---

# Capacities Import Guide

> [!abstract] Purpose
> This guide explains the four Capacities import packs generated from Everything AI. The Obsidian Markdown vault remains the source of edits. The Capacities packs are dated snapshots.

## Files and import order

| Order | Pack | Vault content | Importable files |
|---:|---|---|---:|
| 1 | [Learning and Career Map](<Capacities Import Pack - 1 Learning and Career Map.zip>) | Start, foundations, core skills, career map, this guide | 57 |
| 2 | [Role Tracks](<Capacities Import Pack - 2 Role Tracks.zip>) | 63 technical and nontechnical role profiles, role directory | 64 |
| 3 | [Tools and Technical Studio](<Capacities Import Pack - 3 Tools and Technical Studio.zip>) | Tool atlas, 16 technical concepts, and worked cases | 64 |
| 4 | [Practice Research and Visuals](<Capacities Import Pack - 4 Practice Research and Visuals.zip>) | Assessments, interviews, industry overlays, templates, research, and three infographic images | 57 |

Capacities' [bulk importer](https://docs.capacities.io/reference/bulk-import) currently limits each job to **100 importable files**. The generator enforces that limit for every ZIP. Four packs are necessary for this vault. Import the packs in the order shown, one ZIP at a time. Keep the desktop app open until each import finishes.

The ZIP names are also available in the [GitHub repository](https://github.com/msinclair25/EverythingAI). Download the ZIP files directly; do not import the entire GitHub repository ZIP, which includes Obsidian settings, scripts, and other exports.

## Prepare one Capacities space

In the Capacities desktop app, create or select the space for Everything AI. The export marks notes with these `type` values:

| Object type | What it holds | Setup |
|---|---|---|
| `Role` | 63 role profiles | Create a custom Role type |
| `Concept` | Foundations, core skills, and technical concepts | Create a custom Concept type |
| `Tool` | AI tool and platform guides | Create a custom Tool type |
| `Case` | Worked technical cases | Create a custom Case type |
| `Research` | Source notes and dated updates | Create a custom Research type |
| `Page` | Hubs, directories, assessments, guides, and other notes | Use Capacities' Page type |

The importer can infer an object type from a Markdown file's YAML `type` property when the matching type exists in the space. If you prefer a simple first pass, choose `Page` as the fallback type and let unmatched notes become Pages. For the richer layout above, create the five custom types first.

The pack also supplies `title`, comma-separated `tags`, source path, source type, scope, level, last verified date, and review date in frontmatter. In the mapping preview, map only properties you have set up and want to retain. Verification dates also appear in each note's visible source record, so they remain readable when a custom property is not mapped.

## Import in the desktop app

1. Open **Settings → Import Content → Start importing** in Capacities desktop. Bulk import is not available in the web app.
2. Upload Pack 1's ZIP. Select `Page` as the fallback type. Leave type detection from frontmatter enabled; do not force the fallback type. Do not enable folder-based type extraction, because the pack uses the `type` property as its primary mapping method.
3. Choose how to keep folder context. The **Block** option adds the source folder path as text; it is useful for this numbered learning structure. You may also add a common import tag or marker.
4. Click **Analyze** and inspect the type and property preview. Confirm a foundation note maps to Concept and the import guide maps to Page. Fix any wrong mapping before importing.
5. Import Pack 1, then Packs 2–4 the same way. In Pack 2, confirm `Capacities Role Explorer` maps to Page and role profiles map to Role. Capacities asks for additional confirmation on imports with more than 50 objects.
6. Open `Everything AI` (the imported Home page), `Capacities Role Explorer`, and three image notes. Spot-check roles, flashcards, external citations, properties, and links.

Capacities' [Obsidian migration guide](https://docs.capacities.io/migration/import-from-obsidian) specifically recommends a consistent type mapping, importing connected notes together where possible, and checking links, properties, and media after import. The file limit means this vault must be split; links across packs may need manual repair after all four imports. Capacities resolves imported links by title against notes in the current job or content already in the space. The generator normalizes Obsidian note links to canonical titles to aid that resolution; it cannot guarantee cross-pack links are repaired automatically.

## What converts

- Standard Markdown headings, lists, tables, code blocks, citations, quizzes, and the existing question-and-answer flashcards remain in the notes.
- Obsidian note wikilinks become canonical-title wikilinks. Embedded note links become references to their note objects.
- Obsidian callouts become plain labeled blockquotes. Highlight marks become bold text.
- The Obsidian Role Explorer Base, Source Review Base, and Canvas have readable Markdown replacements. These are static snapshots, not live Capacities views.
- The three visual-map PNGs are included alongside their notes with relative image paths.
- Mermaid diagrams remain fenced source blocks. Capacities may display them as code rather than diagrams; the three PNG infographics remain visual study aids.
- Each imported note links back to its current GitHub source and retains its own verification/review dates where present.

## Rebuild and verify

```bash
ruby scripts/validate_vault.rb
CAPACITIES_AS_OF=2026-10-14 ruby scripts/export_capacities.rb
```

The exporter uses Ruby's standard library and the system `zip` command. Its date defaults to today; setting `CAPACITIES_AS_OF` creates a reproducible dated Source Review snapshot. Running the exporter replaces the four generated ZIPs. It does not write to your Capacities account.

Capacities imports create objects in your space. Reimporting a later snapshot may create duplicates, so review the next import against what is already there. The source links in the imported notes make it easier to compare a copied page with the latest vault version. Edits in Capacities do not flow back into the Obsidian vault.

## Official documentation

- [Bulk Import Reference](https://docs.capacities.io/reference/bulk-import) — desktop workflow, mapping, supported formats, and current limits.
- [Import from Obsidian](https://docs.capacities.io/migration/import-from-obsidian) — type mapping, linked notes, and verification.
