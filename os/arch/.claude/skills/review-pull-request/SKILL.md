---
name: review-pull-request
description: Review a GitHub pull request as tamakiii-claude[bot] (the supervisor bot). Use this whenever the user wants to review a PR, check a PR, look at a diff, give feedback on a PR, or mentions a GitHub PR URL. Trigger on phrases like "review PR", "review this PR", "check the PR", "look at PR #N", "review https://github.com/...", "/review-pull-request", or "/review-pr". Also trigger when the user pastes a GitHub PR URL and wants feedback on it.
---

# Review PR

Review a pull request as the supervisor bot (`tamakiii-claude[bot]`) and post a structured review comment. This replaces the manual flow of fetching the diff, reading it, composing feedback, and posting — all in one step.

## Why this exists

The supervisor reviews agent PRs frequently. Each review involves the same steps: fetch PR metadata, read the diff, check against project conventions, and post structured feedback. This skill standardizes the review format and ensures nothing is missed.

## How to use

The user provides a PR reference — either a number, a URL, or "the open PR". The skill fetches everything, analyzes the changes, and posts a review.

### Step 1: Parse the request

Extract from the user's message:
- **PR number** — from a number, URL (`https://github.com/tamakiii/sandbox-bevy/pull/3`), or context ("the open PR")
- **Repo** — from the URL, or default to `tamakiii/sandbox-bevy` (the agent workspace). If the PR is on `tamakiii/openclaw-workspace`, use that instead.
- **Review type** — if the user says "approve", "request changes", or just wants a comment (default: comment)

### Step 2: Gather context

Run these in parallel — they're independent:

```bash
# PR metadata
.claude/bin/gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits

# Full diff
.claude/bin/gh pr diff <N> --repo <repo>

# Previous review comments (to avoid repeating feedback)
.claude/bin/gh api repos/<repo>/pulls/<N>/comments --jq '.[].body'

# Previous reviews
.claude/bin/gh api repos/<repo>/pulls/<N>/reviews --jq '.[] | {state: .state, body: .body}'
```

If the PR is on `tamakiii/sandbox-bevy`, also read project context:
```bash
# Current ROADMAP to check alignment
cat ~/Git/tamakiii/sandbox-bevy/main/memory/ROADMAP.md

# TOOLS.md for API convention reference
cat ~/Git/tamakiii/sandbox-bevy/main/TOOLS.md
```

### Step 3: Analyze the diff

Read the full diff carefully. Check for:

**Correctness:**
- Does the code compile? (Look for obvious syntax errors, missing imports)
- Are the right APIs used? (Cross-reference with TOOLS.md if available)
- Are there logic errors?

**Convention adherence:**
- Does it follow the patterns in TOOLS.md? (e.g., Bevy 0.18 APIs)
- Branch naming: `phaseN/short-description`
- Commit messages: descriptive, match the actual changes
- Are workspace files (ROADMAP.md, DEVLOG.md) updated?

**Scope:**
- Does the PR match its stated purpose? (title vs actual changes)
- Are there unrelated changes mixed in?
- Is the scope appropriate for one atomic task?

**Safety:**
- No secrets or credentials in the diff
- No force-pushes or history rewrites
- No changes to files outside the expected scope

### Step 4: Compose the review

Use this structure:

```markdown
## Review — tamakiii-claude[bot]

### Fix before merge
<numbered list of issues that should be addressed>

### Suggestions
<optional — nice-to-have improvements that aren't blocking>

### Looks good
<bullet list of things done well — acknowledge good work>
```

Guidelines for the review content:
- Be specific — reference file paths and line numbers when pointing out issues
- Distinguish between blocking issues ("Fix before merge") and optional improvements ("Suggestions")
- If everything looks clean, say so — don't invent problems
- If a previous review exists, check whether its feedback was addressed
- Keep it concise — the user reads these frequently

### Step 5: Post the review

Choose the appropriate review action based on the analysis:

**Comment** (default — when there are items to discuss):
```bash
.claude/bin/gh pr review <N> --repo <repo> --comment --body "<review body>"
```

**Approve** (when the PR is clean, or the user explicitly asks):
```bash
.claude/bin/gh pr review <N> --repo <repo> --approve --body "<review body>"
```

**Request changes** (when there are blocking issues):
```bash
.claude/bin/gh pr review <N> --repo <repo> --request-changes --body "<review body>"
```

Always pass the review body via a heredoc to preserve formatting:
```bash
.claude/bin/gh pr review <N> --repo <repo> --comment --body "$(cat <<'EOF'
## Review — tamakiii-claude[bot]
...
EOF
)"
```

After posting, show the user a summary of what was posted and the review action taken.

### Step 6: Write REVIEW_FEEDBACK.md (for sandbox-bevy PRs with requested changes)

If the review requested changes (not just approval) and the PR is on `tamakiii/sandbox-bevy`, write actionable fix items into the agent's `memory/REVIEW_FEEDBACK.md` so the agent can pick them up autonomously on its next session.

1. Ensure the agent workspace is on main:
   ```bash
   git -C ~/Git/tamakiii/sandbox-bevy/main checkout main
   git -C ~/Git/tamakiii/sandbox-bevy/main pull openclaw main
   ```

2. Write `memory/REVIEW_FEEDBACK.md` on main with this format:
   ```markdown
   # Pending Review Feedback

   ## PR #N: branch-name
   Branch: branch-name

   - [ ] File — specific fix instruction
   - [ ] File — specific fix instruction
   ```

   Important: include the `Branch:` line so the agent knows which branch to checkout.
   Each item must be atomic and actionable — the agent's 27b model needs explicit instructions, not vague requests. Reference file paths and what to change.

3. Commit and push to main:
   ```bash
   git -C ~/Git/tamakiii/sandbox-bevy/main add memory/REVIEW_FEEDBACK.md
   git -C ~/Git/tamakiii/sandbox-bevy/main commit -m "Add review feedback for agent"
   ```
   Push via the `openclaw` remote (credential helper handles auth):
   ```bash
   git -C ~/Git/tamakiii/sandbox-bevy/main push openclaw main
   ```

The agent's AGENTS.md instructs it to check REVIEW_FEEDBACK.md on main before ROADMAP.md. When it sees unchecked items, it checks out the specified branch, fixes them, commits, and pushes.

Skip this step if:
- The review is an approval (no changes needed)
- The PR is not on sandbox-bevy (other repos don't have this mechanism)

## Examples

### Review by PR number

User: "review PR #3 on sandbox-bevy"

→ Fetch PR #3 from `tamakiii/sandbox-bevy`, analyze diff, post review comment.

### Review by URL

User: "can you review https://github.com/tamakiii/openclaw-workspace/pull/4"

→ Extract repo `tamakiii/openclaw-workspace` and PR `4` from URL, analyze, post review.

### Review and approve

User: "review and approve the open PR"

→ Find the open PR, analyze, post approval review.

### Follow-up review

User: "review the PR again"

→ Fetch previous review comments, check if feedback was addressed, post follow-up review noting what's fixed and what's still pending.

## Important context

- Supervisor identity: `.claude/bin/gh` posts as `tamakiii-claude[bot]`
- Primary agent repo: `tamakiii/sandbox-bevy`
- Supervisor repo: `tamakiii/openclaw-workspace`
- Agent workspace files: ROADMAP.md, DEVLOG.md, TOOLS.md, AGENTS.md in `~/Git/tamakiii/sandbox-bevy/main`
- The agent uses Bevy 0.18 — check TOOLS.md for correct API patterns
- If reviewing a follow-up after feedback, explicitly note which items are addressed
