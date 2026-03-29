---
name: create-pull-request
description: "Automate the full PR creation workflow: detect changes, create a branch from main, stage, commit, push, and open a PR via .claude/bin/gh as tamakiii-claude[bot]. Trigger whenever the user says 'create a PR', 'create new PR', '/create-pull-request', '/create-pr', 'push and create a PR', 'open a PR', 'make a PR', 'PR this', or any variation that implies they want their current changes turned into a pull request. Also trigger when the user finishes a task and says something like 'ship it' or 'send it' in the context of creating a PR."
---

# Create PR

Create a pull request from the current working state — branching, staging, committing, pushing, and opening the PR in one flow.

## How to use

The user asks to create a PR, optionally with a description of what the changes are for. The skill detects the current state and takes the right path.

### Step 1: Assess the current state

Run these in parallel to understand what you're working with:

```bash
# What branch are we on?
git branch --show-current

# Are there uncommitted changes?
git status --short

# What's the diff? (staged + unstaged)
git diff HEAD

# Recent commits for message style reference
git log --oneline -5

# Does the current branch have an upstream?
git rev-parse --abbrev-ref @{upstream} 2>/dev/null || echo "no upstream"

# What repo are we in? (for --repo flag)
git remote get-url origin | sed 's|.*github.com[:/]||;s|\.git$||'
```

This tells you which of three paths to take:

1. **On main with uncommitted changes** — need to branch, stage, commit, push, create PR
2. **On a feature branch with uncommitted changes** — stage, commit, push, create PR
3. **On a feature branch, everything committed** — push (if needed), create PR

### Step 2: Create a branch (if on main)

If you're on main with changes, create a descriptive branch:

```bash
git checkout main && git pull
git checkout -b <branch-name>
```

Branch naming conventions (match the repo style):
- Bug fixes: `fix/short-description`
- New features: `add/short-description`
- Improvements: `improve/short-description`
- Documentation: `docs/short-description`

Derive the branch name from the actual changes — read the diff to understand what was done.

### Step 3: Stage and commit (if there are uncommitted changes)

Stage relevant files. Be selective — never stage:
- `.env` or credentials files
- Large binary files that shouldn't be tracked
- Unrelated changes the user didn't intend to include

```bash
git add <specific-files>
```

Write a commit message based on the diff content. Follow the repo's commit message style (short, imperative, describes the "what"):

```bash
git commit -m "$(cat <<'EOF'
<descriptive message>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

If the changes span multiple logical units, ask the user whether to bundle them or split into separate commits.

### Step 4: Push

Push to origin with upstream tracking:

```bash
git push -u origin <branch-name>
```

Skip this step if the branch is already pushed and up-to-date with the remote.

### Step 5: Create the PR

Use `.claude/bin/gh` (not plain `gh`) to create the PR as `tamakiii-claude[bot]`. Always specify `--repo` explicitly using the value derived in Step 1.

```bash
.claude/bin/gh pr create --repo <owner/repo> --title "<title>" --body "$(cat <<'EOF'
## Summary
- <bullet points describing what changed and why>

## Test plan
- [ ] <verification steps>

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

PR title guidelines:
- Keep under 70 characters
- Use imperative mood ("Add feature" not "Added feature")
- Match the nature of changes: "Add ...", "Fix ...", "Update ...", "Document ..."

PR body guidelines:
- Summary should explain both *what* changed and *why*
- Test plan should list concrete verification steps
- Include the Claude Code attribution line

### Step 6: Report the result

Show the user the PR URL so they can review it. Include a brief summary of what was done:
- Branch name
- Files changed
- Commit message
- PR URL

## Edge cases

**Already on a non-main branch with commits and no uncommitted changes:**
Skip branching and committing. Just push (if needed) and create the PR.

**Branch already pushed but no PR exists:**
Skip the push. Just create the PR from the existing remote branch.

**Branch already has a PR:**
Tell the user a PR already exists and show the URL. Don't create a duplicate.

**No changes at all (clean working tree on main):**
Tell the user there's nothing to create a PR for.

**User specifies a branch name or PR title:**
Use what they provide instead of auto-generating.

## Important context

- Always use `.claude/bin/gh` for PR creation — this posts as `tamakiii-claude[bot]`. Never use bare `gh`.
- Always specify `--repo <owner/repo>` explicitly — derive from `git remote get-url origin` when not provided.
- Use heredocs for multi-line PR bodies to preserve formatting.
