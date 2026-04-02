---
name: review-pull-request
description: Review a GitHub pull request by fetching its metadata, diff, and prior review context, then posting a structured review through the bundled GitHub wrapper in this plugin. Use when the user asks to review a PR, check a PR, inspect a diff, look at a PR by number or URL, approve a PR, request changes, or provide GitHub review feedback.
---

# Review Pull Request

Review a pull request end to end: resolve the PR reference, inspect the changes carefully, decide whether to approve or request changes, and post the review as `tamakiii-codex[bot]`.

## Workflow

### 1. Parse the request

Extract:

- PR number from the user's message or URL
- repository from the URL, or derive it from `origin`
- requested review mode, if the user explicitly wants `approve`, `request changes`, or comment-only feedback

When the user refers to "the open PR", identify it from the current repository context before continuing.

### 2. Gather context

Run these in parallel:

```bash
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
CODEX_GH_PROFILE=codex <plugin-root>/scripts/gh pr view <N> --repo <repo> --json title,body,headRefName,baseRefName,state,additions,deletions,files,commits
CODEX_GH_PROFILE=codex <plugin-root>/scripts/gh pr diff <N> --repo <repo>
CODEX_GH_PROFILE=codex <plugin-root>/scripts/gh api repos/<repo>/pulls/<N>/comments --jq '.[].body'
CODEX_GH_PROFILE=codex <plugin-root>/scripts/gh api repos/<repo>/pulls/<N>/reviews --jq '.[] | {state: .state, body: .body}'
```

Use the review comments and prior reviews to avoid repeating already-addressed feedback.

### 3. Analyze the change set

Prioritize actual review findings:

- correctness bugs
- behavioral regressions
- missing or weak tests
- unsafe shell, config, or automation changes
- scope mismatches between title/body and the diff
- secrets, credentials, or other sensitive content

Reference concrete files and lines whenever possible.

If the repository contains local guidance such as `CLAUDE.md`, `AGENTS.md`, or other project instructions, read the relevant parts before finalizing the review.

### 4. Write the review

Use a compact structure like:

```markdown
## Review

### Fix before merge
1. <blocking issue>

### Suggestions
1. <non-blocking suggestion>

### Looks good
- <brief positive note>
```

Guidelines:

- Omit empty sections.
- Keep blocking issues in `Fix before merge`.
- Keep optional improvements in `Suggestions`.
- If no findings exist, say so explicitly instead of inventing nits.
- For follow-up reviews, note which earlier issues were resolved and which remain.

### 5. Post the review

Always use the bundled wrapper at `<plugin-root>/scripts/gh` with `CODEX_GH_PROFILE=codex` so the review is posted as `tamakiii-codex[bot]`.

Choose the action from the findings:

- `--request-changes` when there are blocking issues
- `--approve` when there are no blocking issues, unless the user explicitly asked for comment-only
- `--comment` only when the user explicitly wants comment-only feedback

Example:

```bash
CODEX_GH_PROFILE=codex <plugin-root>/scripts/gh pr review <N> --repo <repo> --request-changes --body "$(cat <<'EOF'
## Review

### Fix before merge
1. <issue>
EOF
)"
```

### 6. Report back to the user

After posting, summarize:

- review action taken
- primary findings
- whether the PR was approved or changes were requested

## Important Details

- Use the bundled `<plugin-root>/scripts/gh`, not bare `gh`.
- Always pass `--repo <owner/repo>` explicitly.
- Derive the repo from `origin` when it is not present in the request.
- Default to a code-review mindset: findings first, summary second.
