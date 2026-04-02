---
name: review-pull-request
description: Review a GitHub pull request as tamakiii-claude[bot]. Use this whenever the user wants to review a PR, check a PR, look at a diff, give feedback on a PR, or mentions a GitHub PR URL. Trigger on phrases like "review PR", "review this PR", "check the PR", "look at PR #N", "review https://github.com/...", "/review-pull-request", or "/review-pr". Also trigger when the user pastes a GitHub PR URL and wants feedback on it.
---

# Review PR

Review a pull request as `tamakiii-claude[bot]` and post a structured review comment. This replaces the manual flow of fetching the diff, reading it, composing feedback, and posting — all in one step.

## How to use

The user provides a PR reference — either a number, a URL, or "the open PR". The skill fetches everything, analyzes the changes, and posts a review.

### Step 1: Parse the request

Extract from the user's message:
- **PR number** — from a number, URL (e.g. `https://github.com/tamakiii/dotfiles/pull/186`), or context ("the open PR")
- **Repo** — from the URL, or derive from the current directory's origin remote:
  ```bash
  git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
  ```
- **Review type** — if the user says "approve", "request changes", or just wants a comment (default: comment)

### Step 2: Gather context

Run these in parallel — they're independent:

```bash
# PR metadata
~/.claude/bin/gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits

# Full diff
~/.claude/bin/gh pr diff <N> --repo <repo>

# Previous review comments (to avoid repeating feedback)
~/.claude/bin/gh api repos/<repo>/pulls/<N>/comments --jq '.[].body'

# Previous reviews
~/.claude/bin/gh api repos/<repo>/pulls/<N>/reviews --jq '.[] | {state: .state, body: .body}'
```

### Step 3: Analyze the diff

Read the full diff carefully. Check for:

**Correctness:**
- Does the code work? (Look for obvious syntax errors, missing dependencies, broken references)
- Are shell scripts correct? (quoting, variable expansion, exit codes)
- Are config files valid? (YAML/TOML/JSON syntax, correct option names)

**Convention adherence:**
- Does it follow existing patterns in the repo?
- Commit messages: descriptive, match the actual changes
- Are there CLAUDE.md or project convention violations?

**Scope:**
- Does the PR match its stated purpose? (title vs actual changes)
- Are there unrelated changes mixed in?
- Is the scope appropriate for one atomic task?

**Safety:**
- No secrets or credentials in the diff
- No force-pushes or history rewrites
- No changes to files outside the expected scope
- Shell scripts don't introduce injection risks

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
- Omit sections that have no items (e.g., skip "Fix before merge" if there are none)

### Step 5: Post the review

Select the review action based on the review content — not a default:

- **`--request-changes`** — when the review includes a "Fix before merge" section with items. Blocking issues must show up as "changes requested" on the PR.
- **`--approve`** — when there are no blocking issues (no "Fix before merge" section, or the user explicitly asks to approve).
- **`--comment`** — only when the user explicitly asks for a comment-only review.

```bash
# Request changes (has "Fix before merge" items)
~/.claude/bin/gh pr review <N> --repo <repo> --request-changes --body "$(cat <<'EOF'
## Review — tamakiii-claude[bot]
...
EOF
)"

# Approve (no blocking issues)
~/.claude/bin/gh pr review <N> --repo <repo> --approve --body "$(cat <<'EOF'
## Review — tamakiii-claude[bot]
...
EOF
)"
```

After posting, show the user a summary of what was posted and the review action taken.

## Examples

### Review by PR number

User: "review PR #186"

→ Derive repo from `origin`, fetch PR #186, analyze diff, post review comment.

### Review by URL

User: "can you review https://github.com/tamakiii/dotfiles/pull/186"

→ Extract repo `tamakiii/dotfiles` and PR `186` from URL, analyze, post review.

### Review and approve

User: "review and approve the open PR"

→ Find the open PR, analyze, post approval review.

### Follow-up review

User: "review the PR again"

→ Fetch previous review comments, check if feedback was addressed, post follow-up review noting what's fixed and what's still pending.

## Important context

- Identity: `~/.claude/bin/gh` posts as `tamakiii-claude[bot]`
- Always use `~/.claude/bin/gh`, never bare `gh`
- Always specify `--repo <owner/repo>` explicitly
- Derive repo from `git remote get-url origin` when not provided in the user's message
- If reviewing a follow-up after feedback, explicitly note which items are addressed
