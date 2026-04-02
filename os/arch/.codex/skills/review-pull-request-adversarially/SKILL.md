---
name: review-pull-request-adversarially
description: Perform a constructive adversarial review of a GitHub pull request by challenging the PR's assumptions, framing, and design choices rather than doing a standard correctness/style review. Use when the user asks for an adversarial review, devil's advocate review, red-team review, skeptical review, challenge review, or asks whether a PR's approach is actually sound instead of merely whether the code is correct.
---

# Adversarial PR Review

Perform a constructive adversarial review of a pull request. Focus on whether the approach itself is sound: the problem framing, hidden assumptions, discarded alternatives, and likely future failure modes.

For deeper terminology, review depth guidance, and when this style adds value instead of noise, read `references/concepts.md`.

## Workflow

### 1. Identify the PR

Extract the PR reference from the user's message: a number, URL, or "the open PR".

If the repository is not explicit, derive it from `origin`:

```bash
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
```

### 2. Gather context

Run these in parallel:

```bash
~/.codex/bin/gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits
~/.codex/bin/gh pr diff <N> --repo <repo>
~/.codex/bin/gh api repos/<repo>/pulls/<N>/comments
~/.codex/bin/gh api repos/<repo>/pulls/<N>/reviews
~/.codex/bin/gh pr view <N> --repo <repo> --json commits --jq '.commits[].messageHeadline'
```

Read the PR body, commit messages, existing discussion, and prior reviews before forming objections. If the PR description is missing or weak, say explicitly that parts of the review are inferred from the diff.

### 3. Review adversarially in three phases

Adopt the adversarial posture deliberately: start from the assumption that the approach may be wrong, then look for evidence. Do not defend the PR by default.

Probe these categories throughout:

- hidden assumptions
- unstated constraints
- rejected alternatives that may have been better
- failure modes
- scope creep and maintenance risk
- signs of over-engineering

#### Phase 1: Problem framing

Challenge what the PR claims to solve:

- What problem is the PR solving?
- Is that the real problem, or a proxy for a different root cause?
- Which assumptions about users, runtime environment, or workflow are left unstated?
- Which alternatives appear to have been discarded without discussion?

#### Phase 2: Logical coherence

Check whether the implementation actually matches the stated goal:

- Does the implementation solve the problem it claims to solve?
- Where are the gaps between the goal and the chosen approach?
- Which edge cases are silently ignored?
- Is there circular reasoning in the design?

#### Phase 3: Future failure pre-mortem

Reason backward from a future incident caused by this PR:

- Write a three-sentence incident report as if this PR caused an issue three months later.
- Identify the most likely path to technical debt.
- Identify what future contributors are most likely to misunderstand.

### 4. Filter performative skepticism

Do not post shallow objections just to sound rigorous.

Every critique must include:

- why the current approach is weak
- a concrete alternative
- why that alternative is actually feasible for this PR

Drop findings that are merely stylistic, preference-driven, or not actionable.

### 5. Decide whether this review style is appropriate

If the PR is trivial, say so and suggest a standard review instead. Good candidates for opting out include:

- typo-only changes
- mechanical dependency bumps
- obvious low-risk config churn

If an adversarial review already exists in either prior review comments or reviews, read it first and only post again when you have materially new findings.

### 6. Post the review

Always post adversarial reviews as a comment via `~/.codex/bin/gh`. Do not approve and do not request changes from this skill; its purpose is skeptical analysis, not merge gating.

Use this structure:

```bash
~/.codex/bin/gh pr review <N> --repo <repo> --comment --body "$(cat <<'EOF'
## Adversarial Review

> This review challenges assumptions, design decisions, and problem framing rather than doing a standard code-quality pass.

### Problem Framing
<findings>

### Logical Coherence
<findings>

### Future Failure Pre-mortem
<three-sentence incident report>

### Findings Summary
| # | Finding | Severity | Confidence | Alternative |
|---|---------|----------|------------|-------------|
| 1 | ... | Fatal flaw / Significant concern / Worth discussing | High / Medium / Low | ... |
EOF
)"
```

Severity meanings:

- `Fatal flaw`: likely to cause a significant problem if merged as-is
- `Significant concern`: likely future risk, but not obviously immediate
- `Worth discussing`: non-blocking design concern

Confidence meanings:

- `High`: directly supported by the diff or discussion
- `Medium`: strong inference from available context
- `Low`: plausible concern that needs validation

## Multi-Perspective Mode

When the user asks for a deeper or more thorough adversarial review, decompose the analysis into these perspectives:

- `The Skeptic`: why the feature may be unnecessary
- `The Architect`: whether rejected alternatives were actually worse
- `The User`: whether the PR solves the claimed problem
- `The Maintainer (6 months later)`: what will become confusing or costly

## What This Skill Does Not Do

- standard bug/style/test review as the primary goal
- approval or request-changes decisions
- nitpicking trivial preferences
