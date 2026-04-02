# Concepts

## Purpose

An adversarial PR review is not a harsher version of a standard code review. It is a separate review mode focused on invalidating the approach, assumptions, and framing before invalidating code details.

The goal is constructive skepticism: strengthen the proposal by finding what may be wrong in the logic, framing, or design.

## Terminology

- `Adversarial review`: a review that actively looks for why the proposal may be wrong.
- `Devil's advocate review`: similar posture, usually more conversational and skeptical.
- `Red-team review`: pressure-tests a proposal against failure, abuse, or mistaken assumptions.
- `Cross-model review`: a second reviewer intentionally pushes against the first model's framing.
- `Adversarial debate`: a related term used in research and evaluation contexts for structured argument against an initial proposal.

These terms are close cousins. For this skill, treat them as compatible triggers unless the user asks for a narrower meaning.

## Why This Matters

A single model reviewing its own output often carries forward the same biases that produced the output. Standard review finds bugs, style issues, and missing tests. Adversarial review is valuable because it challenges whether the proposal itself is well-posed.

This is where cross-model review often helps. One model may implement or draft the proposal while another model reviews the proposal from a skeptical perspective. The value is not that one model is universally better; it is that different models often have different blind spots, priors, and reasoning habits.

## Two Distinct Review Phases

Treat these as separate review modes:

1. Standard code review:
   bugs, correctness, tests, style, regressions
2. Adversarial or intellectual review:
   problem framing, assumptions, alternatives, design coherence, future failure modes

Do not collapse them into one pass. The questions and success criteria are different.

## Review Depth

Use a depth proportional to the PR:

- `Light`: challenge the core framing and one or two likely failure modes.
- `Standard`: cover framing, coherence, and pre-mortem.
- `Deep`: add multiple perspectives, compare rejected alternatives, and pressure-test long-term maintenance implications.

Deep adversarial review is appropriate when the PR changes architecture, workflow, product direction, operational policy, or team process. It is usually noise for tiny, mechanical changes.

## Useful Adversarial Patterns

### Structured Devil's Advocate

Do not ask the reviewer to merely "review this". Ask it to assume the approach may be wrong and look for evidence. This changes the optimization target from defending a proposal to dismantling a weak one.

Useful categories to probe:

- hidden assumptions
- unstated constraints
- rejected alternatives
- failure modes
- scope creep risks
- over-engineering signals

### Multi-Perspective Decomposition

For deeper review, decompose the skepticism into distinct roles:

- `The Skeptic`: why the feature may be unnecessary
- `The Architect`: whether rejected alternatives were actually worse
- `The User`: whether the PR solves the stated problem or a different one
- `The Maintainer`: what will become confusing or costly later

This often yields better coverage than a single monolithic skeptical pass.

### Future Failure Pre-mortem

One of the most effective techniques is to ask for a short incident report from the future where the PR caused trouble. Reasoning backward from failure often exposes risks that are easy to miss when reasoning forward from the author's intent.

Useful pre-mortem questions:

- what is the most likely incident three months after shipping?
- what is the most likely path to technical debt?
- what will future contributors misunderstand first?

## When This Adds Value

Adversarial review is useful when:

- the PR proposes a non-obvious design decision
- the author may be solving the wrong problem
- the change introduces policy, workflow, or architectural assumptions
- alternatives appear to have been rejected without discussion
- the team wants to avoid local optimization around a bad premise

## When This Adds Noise

Avoid or downshift the mode when:

- the PR is tiny and mechanical
- the objections would be preference-only
- no realistic alternative exists within the PR's scope
- the review would repeat earlier discussion without new evidence

## Key Pitfall: Performative Skepticism

The main failure mode is generating objections that sound rigorous but are shallow. The reviewer is then "being adversarial" only in tone, not in substance.

A good countermeasure is to require every critique to include:

- the assumption being challenged
- the concrete risk if the assumption is wrong
- a feasible alternative

If the reviewer cannot propose what better looks like, the critique is often too shallow to be useful.

## Constructive Standard

The goal is to strengthen the PR, not perform skepticism theatrically. A good adversarial finding:

- identifies the assumption being challenged
- explains the concrete risk
- proposes a feasible alternative
- makes clear whether the concern is blocking or merely worth discussion

## General Workflow Guidance

For a general-purpose setup, a strong pattern is:

1. run a normal code review pass
2. run an adversarial review pass
3. compare where the two agree and where they diverge

The value of adversarial review is highest when it is treated as a distinct lens, not just a more aggressive tone applied to ordinary review.
