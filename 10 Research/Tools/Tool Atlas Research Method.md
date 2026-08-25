---
title: Tool Atlas Research Method
tags:
  - research/tools
  - methodology
status: published
type: research-method
scope: United States
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
cssclasses:
  - everything-ai
---

# Tool Atlas Research Method

## Scope

The [[AI Tool Atlas]] is a U.S.-focused, representative decision guide. It is not a ranking, marketplace, exhaustive product directory, procurement approval, security assessment, or legal opinion.

## Source standard

Only first-party sources were used for product availability and access posture:

- official product and pricing pages;
- official documentation/help centers;
- official source-code repositories and license files;
- U.S. government standards/guidance;
- official standards-body pages.

Search results, review sites, social posts, news reports, affiliate comparisons, and unsourced pricing tables were not used as evidence in the notes.

## Pricing method

The atlas records **posture**, not amounts:

- open source or source-available;
- downloadable/open weights;
- free/no-fee;
- free tier, allowance, credits, or trial;
- paid subscription or consumption;
- enterprise/sales-assisted.

Exact prices were intentionally omitted because plan names, quotas, models, regions, currencies, promotional credits, feature entitlements, and billing units change. The linked official pricing page is authoritative at purchase time.

## Verification protocol

For each category:

1. Confirm the product/service is represented on an official page.
2. Check the current official pricing/plan page where public.
3. For open software, link the official repository/docs and avoid assuming model/data licenses match the code license.
4. Describe only stable category-level capabilities; avoid volatile model-version claims.
5. Mark every note with **as_of** and **last_verified: 2026-08-12**.
6. Record sources in [[Tool Source Registry]].

## Known limitations

- “Available in the U.S.” can still depend on state, account type, age, waitlist, cloud region, quota, enterprise contract, or preview eligibility.
- A free plan can have distinct data-use, retention, support, and IP terms.
- Enterprise features may not be publicly priced.
- Open-source code, open weights, datasets, plugins, and generated outputs can carry different licenses.
- Official vendor pages are primary for their own offerings but are not independent evidence of quality, security, or compliance.
- Live pages often lack stable publication dates; the registry records the **verification/access date**.
- Model catalogs and AI coding/productivity plan entitlements change fastest and should be rechecked monthly.

## Review cadence

| Category | Cadence | Trigger an immediate review when… |
|---|---|---|
| APIs, coding, creative, productivity, cloud | Monthly | plan/model/credit policy changes or deprecation |
| Frameworks, RAG, training, MLOps, eval, automation | Quarterly | major release/license/managed-service change |
| Security and governance | Monthly–quarterly | new NIST guidance, major threat class, or legal/control change |
| Entire registry | Quarterly | broken link, acquisition, shutdown, rename, or new category |
