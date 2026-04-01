---
name: review-pull-request-adversarially
description: |
  Perform a constructive adversarial review of a pull request. Goes beyond standard code review (bugs, style, tests) to critically examine assumptions, design decisions, and problem framing.
  Use this when the user says "adversarial review", "devil's advocate review", "red team this PR", "challenge this PR", "poke holes in this", "is this PR actually sound?", or asks for a critical/skeptical review of a PR's approach rather than its code quality.
metadata:
  short-description: Adversarial PR review — challenge assumptions, not just code
---

# Adversarial PR Review

This skill is distinct from standard code review. It critically examines whether the PR's approach itself is sound — the problem framing, unstated assumptions, and design decisions — not just whether the code is correct.

The goal is **constructive** adversarial: strengthen the PR by finding what's wrong in logic, framing, and assumptions.

## Background

For deeper context on the adversarial review philosophy, terminology (devil's advocate review, red team review, cross-model review, adversarial debate), review depth levels, and when this approach adds value vs. noise, read `references/concepts.md`.

## Why this matters

A single model reviewing its own output suffers from the same biases that produced it. Deliberately challenging assumptions from a different perspective surfaces blind spots that standard review misses.

## How to use

### Step 1: Identify the PR

Extract the PR reference from the user's message — a number, URL, or "the open PR":

```bash
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
```

### Step 2: Gather context

Run in parallel:

```bash
# PR metadata
gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits

# Full diff
gh pr diff <N> --repo <repo>

# Existing discussion
gh api repos/<owner>/<repo>/pulls/<N>/comments

# Commit history to understand intent
gh pr view <N> --repo <repo> --json commits --jq '.commits[].messageHeadline'
```

### Step 3: Adversarial review — three phases

After reading the diff and description, adopt the adversarial posture: **start from the assumption that the approach is wrong**, then look for evidence. This is the key shift — instead of building a case for the PR, you are dismantling one. The goal is not to confirm the PR is good, but to find where it is weak.

Probe these categories across all phases: hidden assumptions, unstated constraints, unconsidered alternatives, failure modes, scope creep risks, over-engineering signals.

#### Phase 1: Problem framing review

Challenge the problem the PR claims to solve:

- What problem does this PR claim to solve?
- Is the problem statement accurate, or does it mask a different root cause?
- Are there unstated assumptions about users, environment, or constraints?
- Were alternatives implicitly rejected without discussion?

#### Phase 2: Logical coherence

Verify alignment between the implementation and the goal:

- Does the implementation actually solve the stated problem?
- Are there logical gaps between the goal and the approach?
- Are edge cases acknowledged or silently ignored?
- Is there circular reasoning ("we need X because we built Y which needs X")?

#### Phase 3: Future failure pre-mortem

Reason backward from a future where this PR caused problems:

- Write a 3-sentence incident report as if this PR caused an issue 3 months after shipping
- What is the most likely path to technical debt?
- What will future contributors most likely misunderstand?

### Step 4: Filter performative skepticism

Self-check each finding. The risk is generating objections that sound substantive but are shallow — playing devil's advocate just to seem thorough.

**Every critique must include a concrete alternative.** If you cannot propose what "better" looks like, the critique is probably superficial. Remove it.

Filter findings against these questions:
- "Is this a real problem, or just a preference?"
- "Is the proposed alternative actually feasible?"
- "Is this finding actionable for the PR author?"

### Step 5: Format and post

Use `gh` to post the review comment. Always specify `--repo` explicitly.

```bash
gh pr review <N> --repo <repo> --comment --body "$(cat <<'EOF'
## Adversarial Review 🔍

> This review goes beyond standard code review to critically examine assumptions, design decisions, and problem framing.

### Problem Framing
<findings>

### Logical Coherence
<findings>

### Future Failure Pre-mortem
<3-sentence incident report from the future>

---

### Findings Summary

| # | Finding | Severity | Confidence | Alternative |
|---|---------|----------|------------|-------------|
| 1 | ... | Fatal flaw / Significant / Worth discussing | High / Medium / Low | ... |

---
🤖 Adversarial review by Codex
EOF
)"
```

#### Severity levels

- **Fatal flaw**: Merging as-is is likely to cause a significant problem
- **Significant concern**: Creates future risk if not addressed
- **Worth discussing**: Room for improvement, but not a blocker

#### Confidence levels

- **High**: Specific issue directly verifiable from the diff
- **Medium**: Reasonable inference based on context
- **Low**: Possible concern, needs further investigation

### What this skill does NOT do

- Standard code review (bugs, style, test coverage) — use a regular review for that
- Approve or request changes — always posts as a comment
- Nitpick style preferences or trivial concerns

## Edge cases

**PR has no description:**
Infer intent from commit messages and the diff. State clearly that the review is based on inference.

**Trivial changes (typo fixes, dependency updates, etc.):**
Tell the user this PR is not a good candidate for adversarial review, and suggest a standard review instead.

**Adversarial review already posted:**
Read the previous review. Only post again if there are new findings.

## Multi-perspective mode

When the user asks for a deeper or more thorough review, decompose into four perspectives:

- **The Skeptic**: Why might this entire feature be unnecessary?
- **The Architect**: Were implicitly rejected design alternatives actually worse?
- **The User**: Does this solve the stated problem, or a different one?
- **The Maintainer (6 months later)**: What will be confusing or regrettable?
