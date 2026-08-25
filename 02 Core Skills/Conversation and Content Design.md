---
title: Conversation and Content Design
type: skill
family: human-experience
scope: United States
level:
  - beginner
  - intermediate
  - advanced
status: release-1
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
tags: [ai-careers, core-skills, conversation-design, content-design]
cssclasses: [everything-ai]
---

# Conversation and Content Design

Conversation design creates cooperative interaction under uncertain language and system capability. Content design ensures every word helps a person understand, decide, and recover.

## Conversation anatomy

Define intents/goals, entities/slots, context/state, turn strategy, confirmations, repair, escalation, persona boundaries, channels/modalities, and completion criteria. For generative systems, add grounding rules, tool/action boundaries, memory policy, refusal behavior, and evaluation rubrics.

## Repair patterns

- ask one high-value clarification;
- offer bounded interpretations;
- restate the intended action before commitment;
- expose missing evidence or permission;
- preserve completed work during failure;
- hand off context and source records to a human;
- say what the system cannot do and the next viable path.

Persona should guide tone, not imply consciousness, credentials, or authority the system lacks. Use plain language, inclusive examples, and channel-appropriate brevity.

## Evaluation

Measure task completion, turns/effort, repair success, groundedness, action correctness, escalation quality, accessibility, user comprehension, and harmful failure—not “engagement” alone.

## Quiz

1. What makes a clarification high value? 2. Why preserve work during repair? 3. What is a persona boundary? 4. Why is engagement an incomplete metric?

> [!success]- Answers
> 1. It resolves uncertainty that materially changes the response/action with minimal burden. 2. Repetition increases effort, abandonment, and mistakes. 3. A constraint preventing tone/design from implying false identity, authority, emotion, or capability. 4. Long or repeated interaction can reflect confusion or failure.

## Flashcards

Conversation repair:: A strategy for detecting and recovering from misunderstanding or failure.

Turn strategy:: Rules for what the system asks, says, or does next given state.

Persona boundary:: A limit that prevents character/tone from overstating identity or capability.

Next: [[Conversation Designer]] and [[AI Content Designer]].
