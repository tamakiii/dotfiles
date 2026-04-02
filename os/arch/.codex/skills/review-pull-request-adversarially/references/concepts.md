# Concepts

## Purpose

An adversarial PR review is not a harsher version of a normal code review. It is a different review mode focused on invalidating the approach, assumptions, and framing before invalidating the code details.

## Terminology

- `Adversarial review`: a review that actively looks for why the proposal may be wrong.
- `Devil's advocate review`: similar posture, usually conversational and skeptical.
- `Red-team review`: pressure-tests a proposal against failure, abuse, or mistaken assumptions.
- `Cross-model review`: a second reviewer intentionally pushes against the first model's framing.

These are close cousins. For this skill, treat them as compatible triggers unless the user asks for a narrower meaning.

## Review Depth

Use a depth proportional to the PR:

- `Light`: challenge the core framing and one or two likely failure modes.
- `Standard`: cover framing, coherence, and pre-mortem.
- `Deep`: add multiple perspectives and compare rejected alternatives.

Deep adversarial review is appropriate when the PR changes architecture, workflow, product direction, or policy. It is usually noise for tiny, mechanical changes.

## When This Adds Value

Adversarial review is useful when:

- the PR proposes a non-obvious design decision
- the author may be solving the wrong problem
- the change introduces policy, workflow, or architectural assumptions
- the team wants to avoid local optimization around a bad premise

## When This Adds Noise

Avoid or downshift the mode when:

- the PR is tiny and mechanical
- the objections would be preference-only
- no realistic alternative exists within the PR's scope
- the review would repeat earlier discussion without new evidence

## Constructive Standard

The goal is to strengthen the PR, not perform skepticism theatrically. A good adversarial finding:

- identifies the assumption being challenged
- explains the concrete risk
- proposes a feasible alternative
- makes clear whether the concern is blocking or merely worth discussion
