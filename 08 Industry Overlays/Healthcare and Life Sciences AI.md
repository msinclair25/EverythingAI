---
title: Healthcare and Life Sciences AI
type: industry-overlay
scope: United States
level: [advanced]
status: current
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-09-12
tags: [ai-careers, industry, healthcare]
cssclasses: [everything-ai]
---

# Healthcare and Life Sciences AI

> [!warning] Not medical, legal, or regulatory advice
> This overlay teaches issue-spotting for AI work near US health contexts. A consequential decision needs qualified clinical, legal, privacy, and quality partners and current primary sources.

Add domain ownership, patient/user safety, privacy/security, validation that matches the *use*, human factors, incident handling, and a regulatory **question** — not a self-awarded label.

## Why this overlay exists

The same RAG assistant is three different products:

| Use | What changes |
|---|---|
| Admin scheduling | Inconvenience, maybe HIPAA if PHI is in scope |
| Clinician document summary | Wrong omission can change care; human remains responsible |
| Software that diagnoses or treats | May be a **device**; FDA pathway is a legal conclusion |

If you cannot name which row you are in, you do not have a contract.

## Contexts (do not mix)

Administrative workflow, clinical decision support, patient communication, medical devices, drug discovery, research, public health, and consumer wellness have different evidence and oversight. Ask whether FDA device authority, HIPAA/HITECH, human-subjects rules, state health privacy, nondiscrimination/accessibility, or professional licensure apply. **“Not a medical device” is a legal conclusion**, not a product slogan.

## Illegal shortcuts (teaching)

- Training or prompting on real PHI in a consumer tool.
- Claiming “FDA-approved” because a component model has a paper.
- Shipping a summarizer with only ROUGE; missing **omission of allergies / doses**.
- Using a general VLM on a diagnostic image without a slice eval (see [[Case - Vision Field Slice]]).
- Letting the model be the last word on emergency (“call 911”) without a designed escalation.

## Worked teaching decision

**Northline Health — teaching scenario.** Product wants an inbox summarizer for outpatient messages. Users: licensed nurses. Corpus: the patient’s chart the nurse can already open.

Contract you should force:

- Audience = licensed clinician, not the patient.
- Output = draft summary + source spans; **no** new diagnosis or order.
- Emergency language → hard escalate template, not a model guess.
- PHI stays in the covered entity’s approved environment.
- Eval: 150 synthetic + de-identified cases; **omission of meds/allergies** is a severity-1 fail; nurse time-to-trust is a secondary metric.
- Human signs the chart; the model never does.

**Ship this sprint:** retrieval over the *already-authorized* chart, span citations, omission rubric, escalation regex/classifier **in code**.  
**Do not ship:** patient-facing advice, fine-tune on raw clinic notes in a vendor that trains on prompts, or a “we’re not a device” banner as the only control.

Review trigger: any omission of a listed allergy in the eval slice, or a patient-facing leak.

## Evidence questions

Population and sites; retrospective vs prospective; comparator (current nurse workflow); clinical *and* operational outcomes; [[Calibration]] of any risk score; subgroup (age, language, disability); shift; alert burden; failure severity; comprehension; monitoring and update protocol; who is the clinician of record.

Reuse [[Case - Evaluation Harness]] for the split honesty. Reuse [[Retrieval Quality]] for chart citations.

## Suggested projects

- Beginner: audit a *public* patient-facing assistant for uncertainty, emergency escalation, accessibility, and sources. No real PHI.
- Intermediate: evaluation plan for clinical-document summarization using **synthetic** cases and an expert-review rubric (omission = fail).
- Advanced: change-control and monitoring plan for a multi-site model **without** making clinical claims.

## Quiz

1. Why is “not a medical device” a weak product sentence?
2. What severity-1 miss should a chart summarizer eval catch?
3. Who is the principal for chart access — the model or the clinician’s existing rights?
4. When would you refuse a patient-facing build?

> [!question]- Answer key
> 1. Device status is a legal conclusion about intended use and function, not a disclaimer. 2. Omission of allergies, doses, or other safety-critical facts present in the authorized chart. 3. The authenticated clinician’s authorized view; retrieval must not widen it. 4. When the product would advise diagnosis/treatment, or when escalation and licensed review are not designed.

## Flashcards

Intended use:: The clinical or admin job you claim; it drives regulation and eval.

Omission fail:: A summary that drops a safety-critical fact that was in the source.

Clinician of record:: The licensed person who remains responsible for the documented act.

Device question:: Whether software is a medical device — asked of counsel, not the model.

## Sources

[FDA Digital Health Center of Excellence](https://www.fda.gov/medical-devices/digital-health-center-excellence), [HHS HIPAA](https://www.hhs.gov/hipaa/index.html), [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework), verified 2026-08-12.

Next: [[Industry Overlay Hub]] · [[Case - Evaluation Harness]]
