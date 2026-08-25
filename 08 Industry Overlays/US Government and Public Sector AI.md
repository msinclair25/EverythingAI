---
title: US Government and Public Sector AI
aliases: [U.S. Government and Public Sector AI]
type: industry-overlay
scope: United States
level: [advanced]
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-09-12
tags: [ai-careers, industry, government, public-sector]
cssclasses: [everything-ai]
---

# U.S. Government and Public Sector AI

> [!warning] Not legal advice
> Policy instruments change. Distinguish **law**, **executive order**, **OMB memo**, **agency policy**, and **guidance**. None of the 2026 federal memos automatically bind a private company or a city unless some other authority says so.

Public-sector work adds legal authority, public records, procurement, accessibility (Section 508), civil rights/liberties, privacy, security, notice, due process/recourse, retention, vendor evidence, continuity, and oversight.

## Why this overlay exists

A public-information chatbot and a system that recommends **who gets a benefit or who is audited** are different constitutional and administrative problems. The overlay exists so you ask **authority and recourse** before you ask **which model**.

## Federal policy at cutoff (August 12, 2026)

Covered federal agencies should consult OMB M-25-21 (use/governance), M-25-22 (acquisition), and M-26-04 (federal “Unbiased AI Principles” for LLM use/procurement), plus agency policy. [EO 14409](https://www.whitehouse.gov/presidential-actions/2026/06/promoting-advanced-artificial-intelligence-innovation-and-security/) adds June 2026 federal AI/cyber directions. National-security systems have distinct authorities and [NSPM-11](https://www.whitehouse.gov/presidential-actions/2026/06/national-security-presidential-memorandum-nspm-11/). [EO 14365](https://www.whitehouse.gov/presidential-actions/2025/12/eliminating-state-law-obstruction-of-national-artificial-intelligence-policy/) addresses state AI laws and a federal legislative recommendation.

M-25-21 directs covered CFO Act agencies to designate a Chief AI Officer. [[Chief AI Officer and Head of AI]] is a senior accountability role — not an entry title.

State and local governments are **not** automatically under those memos. Check that jurisdiction.

## Illegal shortcuts (teaching)

- Scraping a benefits FAQ and answering eligibility as if it were an adjudication.
- Ignoring Section 508 because “it’s just a pilot.”
- A vendor that trains on citizen prompts containing case facts.
- No appeal path on an automated enforcement recommendation.
- Treating an EO as if it repealed a statute.

## Worked teaching decision

**Teaching agency:** a state labor department wants a chatbot on unemployment *rules*.

Contract:

- Answers only from the **effective** published rule pages (authority + date). See [[Retrieval Quality]].
- No determination of *this claimant’s* award. Every eligibility-shaped question ends with “this is not a decision; file or talk to a specialist” plus the official channel.
- Logs are public-records-aware: do not keep full claimant stories by default.
- 508: keyboard, captions, plain language, language access as the agency already must.
- Eval: 80 public FAQ items + 20 adversarial “am I approved?” prompts that must **abstain** from personal determination.
- Procurement: data-use, exit, and eval rights in the contract, not in a slide.

**Ship:** cited RAG over current rules + hard abstain on personal adjudication.  
**Do not ship:** an agent that “checks your wage file and files the claim.”

## Public-value questions

What statute and public purpose support this use? Does an automated output affect benefit, liberty, employment, service, or enforcement? What accessible notice, explanation, human review, appeal, and remedy exist? Can the record be reconstructed? What happens if the vendor dies at 5 p.m. Friday?

## Suggested projects

- Beginner: source map — law vs EO vs OMB memo vs standard vs blog.
- Intermediate: procurement evidence matrix for a fictional public-information assistant.
- Advanced: impact / eval / recourse plan for a high-impact use using **synthetic** scenarios only.

## Quiz

1. Why can’t a rules chatbot decide a claim?
2. Name two instruments that are not statutes.
3. What must “am I approved?” do?
4. Why do logs need a public-records design?

> [!question]- Answer key
> 1. Adjudication needs authority, a record, and usually due process; a FAQ bot has none of that. 2. Executive orders and OMB memoranda (also guidance, blog posts). 3. Abstain from personal determination and point to the official process. 4. Retention, disclosure, and minimization duties differ from a private SaaS debug log.

## Flashcards

Authority:: The statute or delegation that allows the agency to act.

Recourse:: Notice, explanation, human review, and appeal on a decision that affects a person.

Public records:: Logs and prompts may be disclosable; design minimization first.

Pilot is production:: Accessibility and privacy duties usually attach before the press release.

## Sources

[OMB memoranda](https://www.whitehouse.gov/omb/information-resources/guidance/memoranda/), [EO 14365](https://www.whitehouse.gov/presidential-actions/2025/12/eliminating-state-law-obstruction-of-national-artificial-intelligence-policy/), [EO 14409](https://www.whitehouse.gov/presidential-actions/2026/06/promoting-advanced-artificial-intelligence-innovation-and-security/), [NSPM-11](https://www.whitehouse.gov/presidential-actions/2026/06/national-security-presidential-memorandum-nspm-11/), [GAO AI Accountability Framework](https://www.gao.gov/products/gao-21-519sp), [Section 508](https://www.section508.gov/), verified 2026-08-12.

Next: [[AI Policy Analyst]] · [[US AI Law and Policy Orientation]]
