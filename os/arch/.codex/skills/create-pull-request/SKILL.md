---
name: create-pull-request
description: Create a GitHub pull request from the current working tree by assessing changes, creating a branch from main when needed, staging, committing, pushing, and opening the PR through the local Codex GitHub wrapper. Use when the user asks to create a PR, open a PR, push and create a PR, make a PR, ship the current changes, or otherwise wants the current work turned into a pull request.
---

# Create Pull Request

Turn the current repository state into a pull request in one flow: inspect the tree, branch if needed, commit if needed, push, and open the PR.

## Workflow

### 1. Assess the repository state

Run these in parallel:

```bash
git branch --show-current
git status --short
git diff HEAD
git log --oneline -5
git rev-parse --abbrev-ref @{upstream} 2>/dev/null || echo "no upstream"
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
```

Use the results to choose the path:

1. On `main` with local changes: create a branch, stage, commit, push, create PR.
2. On a feature branch with local changes: stage, commit, push, create PR.
3. On a feature branch with everything committed: push if needed, then create PR.

If the working tree is clean on `main`, stop and tell the user there is nothing to turn into a PR.

### 2. Create a branch when starting from `main`

Update `main` first, then branch from it:

```bash
git switch main
git pull
git switch -c <branch-name>
```

Derive the branch name from the actual diff and match the repository's style. Prefer concise prefixes such as:

- `fix/...`
- `add/...`
- `improve/...`
- `docs/...`

If the user already gave a branch name, use it.

### 3. Stage and commit only the intended changes

Stage explicit paths rather than blindly staging everything. Exclude secrets, credentials, generated noise, and unrelated edits.

```bash
git add <paths>
git commit -m "<commit message>"
```

Write the commit message from the diff. Keep it short, imperative, and consistent with the repository's recent history.

If the diff contains more than one unrelated logical change, stop and ask the user whether to split it before opening a PR.

### 4. Push the branch

Push with upstream tracking when the branch is new:

```bash
git push -u origin <branch-name>
```

If the branch already has an upstream, push normally only when the local branch is ahead.

### 5. Create the pull request

Always use the local wrapper at `~/.local/bin/gh` so the PR is created as `tamakiii-doppelganger[bot]`. Always pass `--repo` explicitly.

Before creating a new PR, check whether one already exists for the current branch:

```bash
~/.local/bin/gh pr list --repo <owner/repo> --head <branch-name> --json number,url
```

If a PR already exists, report the URL instead of creating a duplicate.

When creating a PR:

```bash
~/.local/bin/gh pr create --repo <owner/repo> --title "<title>" --body "$(cat <<'EOF'
## Summary
- <what changed>
- <why it changed>

## Test plan
- [ ] <verification step>
EOF
)"
```

PR title guidance:

- Keep it short.
- Use imperative mood.
- Match the actual scope of the diff.

PR body guidance:

- Explain what changed and why.
- Provide concrete verification steps.
- Do not include Claude-specific attribution.

### 6. Report the result

After creating the PR, tell the user:

- branch name
- commit message
- files changed
- PR URL

## Edge Cases

- Existing feature branch with clean history: push if needed and create the PR.
- Existing remote branch with no PR: skip branching and just open the PR.
- Existing PR for the branch: report the existing URL.
- User-provided title or branch name: prefer the user's value.

## Important Details

- Use `~/.local/bin/gh`, not bare `gh`.
- Always pass `--repo <owner/repo>` explicitly.
- Derive `<owner/repo>` from `origin` when the user did not specify it.
- Keep staging selective; never sweep unrelated local edits into the PR.
