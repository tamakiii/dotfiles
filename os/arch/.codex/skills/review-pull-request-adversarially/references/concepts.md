# Adversarial-Critical AI Code Review: Concepts and Context

Read this reference when you need deeper understanding of the review philosophy behind this skill.

## Terminology

The term "adversarial review" here is used in the **intellectual** sense — deliberately challenging assumptions — not the security/attack sense.

Related terms that describe the same family of techniques:
- **Devil's advocate review** — arguing the opposing position to test robustness
- **Red team review** — borrowed from security, meaning systematic stress-testing of decisions
- **Cross-model review** — exploiting different models' blind spots by having them check each other
- **Adversarial debate** — the academic term for structured disagreement to improve reasoning quality

The key nuance: **constructive** adversarial. The goal is to strengthen, not to destroy.

## Core insight: Model diversity as intellectual friction

A single model reviewing its own output suffers from the same biases that produced the output. The cross-model review pattern (e.g., one model implements, a different model reviews) exploits the fact that different models have different blind spots, training biases, and reasoning patterns.

Even within a single model, switching the optimization target — from "build a case for this approach" to "find evidence this approach is wrong" — produces meaningfully different analysis.

## Two distinct review phases

Standard code review and adversarial review serve fundamentally different purposes:

1. **Standard code review**: bugs, style, correctness, test coverage — "is the code right?"
2. **Adversarial/intellectual review**: problem framing, assumptions, missing alternatives, logical gaps — "is this the right code?"

Phase 2 is harder because it requires reasoning about what's **absent** (unconsidered alternatives, unstated assumptions) rather than what's present.

## Review depth levels

### Level 1: Structured devil's advocate

The simplest approach. Assume the approach is wrong and find evidence for why. This works because it changes what the reviewer optimizes for — instead of building a case, it dismantles one.

Categories to probe: hidden assumptions, unstated constraints, unconsidered alternatives, failure modes, scope creep risks, over-engineering signals.

### Level 2: Multi-perspective decomposition

Decompose the review into distinct perspectives, inspired by Six Thinking Hats and courtroom debate models:

- **The Skeptic**: "Why might this entire feature be unnecessary?"
- **The Architect**: "What design alternatives were implicitly rejected, and were they actually worse?"
- **The User**: "Does this actually solve the stated problem, or a different one?"
- **The Maintainer (6 months later)**: "What will be confusing or regrettable?"

Each perspective surfaces different kinds of issues.

### Level 3: Pre-mortem / failure scenario

The most powerful technique: write a **post-mortem from the future** where the PR caused a problem. "Imagine this shipped and something went wrong 3 months later. Write the incident report."

This forces backward reasoning from failure rather than forward reasoning from intent. Backward reasoning bypasses the confirmation bias inherent in reviewing code you understand the purpose of.

## The performative skepticism trap

The biggest risk in adversarial review is generating objections that sound substantive but are shallow — playing devil's advocate just to appear thorough. Signs of performative skepticism:

- Objections that are really just style preferences reframed as concerns
- "This could be a problem" without specifics about when or how
- Critiques that apply equally to any PR (too generic to be useful)
- Findings with no actionable alternative

The countermeasure: **require a concrete alternative for every critique**. If the reviewer cannot articulate what "better" looks like, the critique is probably not substantive. This single rule filters out most performative findings.

## Cross-model ecosystem and tooling

The "implement with one model, review with another" pattern has become an established workflow. The rationale: different models have different blind spots, so cross-model review catches things self-review cannot.

This skill fits into that pattern — Codex reviewing work produced by Claude Code (or vice versa). Concrete implementations:

- **codex-plugin-cc** (OpenAI official): Provides `/codex:review` (standard) and `/codex:adversarial-review` (steerable, challenges design decisions). Supports standard review, adversarial review, and task delegation.
- **claude-review-loop** (community, by hamelsmu): Two-phase lifecycle where Claude implements and Codex reviews before exit is allowed.
- **codex-pr-review** (community, by johnpsasser): Reviews PRs with findings filtered by a configurable confidence threshold.

The division of labor — one model implements, a different model reviews — is grounded in benchmark differences between models. Each model has areas where it excels and areas where it's weaker, making cross-checking genuinely complementary rather than redundant.

### Integration as a dedicated agent identity

For multi-agent setups (e.g., with AGENTS.md/SOUL.md), the adversarial reviewer works best as a **separate agent identity** with its own personality emphasizing skepticism and intellectual rigor. The recommended flow: route PRs through standard review first, then adversarial review, and require both to pass before merge.

## When adversarial review adds value vs. noise

**Good candidates:**
- PRs that introduce new abstractions or architectural patterns
- Changes to core domain logic or business rules
- PRs where the "why" is more complex than the "what"
- Large PRs that touch multiple concerns
- PRs generated by AI (cross-checking the AI's reasoning)

**Poor candidates:**
- Typo fixes, dependency bumps, formatting changes
- Mechanical refactors with obvious correctness
- One-line bug fixes with clear root cause
- PRs that have already been extensively discussed in issues/design docs
