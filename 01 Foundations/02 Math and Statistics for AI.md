---
title: 02 Math and Statistics for AI
aliases:
  - Math and Statistics for AI
type: foundation
module: 2
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2027-02-12
estimated_hours: 10-30
prerequisites:
  - "[[01 AI Systems and Vocabulary]]"
tags:
  - ai-careers
  - foundations
  - mathematics
  - statistics
cssclasses:
  - everything-ai
---

# 02 · Math and Statistics for AI

## Outcome

You can interpret the mathematical ideas behind representation, learning, uncertainty, and evaluation, then choose the depth required by your role.

## Depth map

| Role work | Needed depth |
|---|---|
| Research, applied science, advanced modeling | derive and implement linear algebra, probability, calculus, optimization, and statistical inference |
| ML/data/evaluation engineering | calculate, implement, diagnose, and explain metrics and optimization behavior |
| Product, UX, governance, business | interpret distributions, uncertainty, experiments, base rates, tradeoffs, and misleading summaries |
| Creative, customer, operations | reason about variation, sampling, evaluation rates, and confidence; collaborate on deeper analysis |

## Linear algebra — representing relationships

- A **scalar** is one number; a **vector** is an ordered list; a **matrix** is a rectangular array; a **tensor** generalizes arrays to more dimensions.
- An **embedding** is a learned vector representation. Geometric closeness can encode useful similarity but does not guarantee truth or fairness.
- The **dot product** measures aligned magnitude and underlies attention and similarity calculations.
- Matrix multiplication composes transformations. Dimensions must align.

If $x$ is an input vector, a simple learned layer can be written:

$$z = Wx + b$$

The model learns weights $W$ and bias $b$.

## Probability — expressing uncertainty

- A **random variable** maps outcomes to values.
- A **distribution** describes possible values and their probabilities.
- **Expected value** is the probability-weighted average; **variance** describes spread.
- **Conditional probability** $P(A\mid B)$ means the probability of $A$ given $B$.
- **Bayes' rule** updates beliefs when evidence arrives:

$$P(A\mid B)=\frac{P(B\mid A)P(A)}{P(B)}$$

Base rates matter. Even a strong detector can produce many false positives when the target event is rare.

## Statistics — learning from samples

- A **population** is the target set; a **sample** is what you observe.
- A point estimate without an uncertainty interval hides sampling variation.
- A **confidence interval** is produced by a procedure with a long-run coverage property; it is not automatically the probability that this particular fixed parameter lies in the realized interval.
- A **p-value** is not the probability that a hypothesis is true and does not measure practical importance.
- **Effect size** and uncertainty are usually more decision-relevant than significance alone.
- **Correlation** does not establish causation. Confounding, selection, reverse causality, and measurement choices can create associations.

## Learning and optimization

A model learns by reducing a **loss function**. Gradient-based optimization uses derivatives to estimate how parameters should change:

$$\theta_{t+1}=\theta_t-\eta\nabla_\theta L(\theta_t)$$

where $\eta$ is the learning rate. Too large may diverge; too small may be inefficient. Real training uses minibatches, adaptive optimizers, schedules, regularization, and extensive diagnostics.

Common losses include mean squared error for some regression tasks and cross-entropy for classification or token prediction. A lower training loss does not guarantee real-world usefulness.

## Measurement essentials

For binary classification:

- **Precision** $= TP/(TP+FP)$: of predicted positives, how many were positive?
- **Recall** $= TP/(TP+FN)$: of actual positives, how many were found?
- **Specificity** $= TN/(TN+FP)$.
- **F1** is the harmonic mean of precision and recall; it hides the actual costs and threshold.
- **Calibration** asks whether predicted probabilities correspond to observed frequencies.

Choose metrics from consequences. Screening may emphasize recall; scarce investigative capacity may emphasize precision. High-stakes use normally needs more than one aggregate metric.

## Experimental reasoning

1. Define the decision and outcome before examining favorable results.
2. Specify the unit of analysis and assignment.
3. Separate offline model metrics from user/business outcomes.
4. Protect against leakage and repeated peeking.
5. Report uncertainty, exclusions, and negative results.
6. Check heterogeneous effects and practical significance.

## Quiz

1. Why can a high-accuracy detector be poor for a rare event?
2. What does an embedding's geometric proximity establish—and not establish?
3. Distinguish precision from recall.
4. Why is training loss insufficient evidence for deployment?
5. What is wrong with “the p-value is the chance the null hypothesis is true”?
6. A probability model predicts 0.8 for 1,000 comparable cases. What would good calibration imply?

> [!success]- Answer key
> 1. Base-rate effects can make false positives dominate even with apparently strong accuracy. 2. It establishes proximity under that representation and similarity function; it does not establish factual equivalence, causality, fairness, or suitability. 3. Precision conditions on predicted positives; recall conditions on actual positives. 4. It does not establish generalization, representative evaluation, calibrated confidence, acceptable errors, robustness, safety, latency, cost, or user value. 5. A p-value is the probability of data at least as extreme under a specified null and assumptions, not a posterior probability of the hypothesis. 6. Roughly 80% of those comparable cases should realize the event, subject to sampling uncertainty and a clearly defined comparison group.

## Flashcards

Embedding:: A learned vector representation whose geometry can encode useful relationships.

Expected value:: The probability-weighted average of possible values.

Variance:: A measure of dispersion around the mean.

Conditional probability:: The probability of an event given that another condition holds.

Base-rate problem:: When event prevalence strongly changes the practical meaning of detector performance.

Precision:: True positives divided by all predicted positives.

Recall:: True positives divided by all actual positives.

Calibration:: Agreement between predicted probabilities and observed outcome frequencies for comparable predictions.

Loss function:: The quantity optimized during training; it is a proxy, not the whole product objective.

Gradient:: The vector of partial derivatives indicating local directions of increase; optimization commonly moves in the negative direction.

Effect size:: The magnitude of a difference or relationship, interpreted with context and uncertainty.

Correlation vs causation:: Association alone does not prove that changing one variable will change another.

## Sources and further study

- [NIST AI 800-3, statistical models for AI evaluation](https://www.nist.gov/news-events/news/2026/02/new-report-expanding-ai-evaluation-toolbox-statistical-models), released 2026-02-19; verified 2026-08-12.
- [OpenIntro Statistics](https://www.openintro.org/book/os/), free textbook.
- [Mathematics for Machine Learning](https://mml-book.github.io/), free author-hosted text.

Next: [[03 Python SQL Git and Software Foundations]] and [[05 Machine Learning]].
