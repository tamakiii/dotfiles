---
name: tmux-launch-claude
description: Launch or message Claude Code instances in tmux panes across workspaces. Use this skill whenever the user wants to delegate work to another Claude session, send a task to a specific workspace/worktree, start Claude in another pane, coordinate multiple Claude instances, or says things like "send this to", "launch claude in", "run this in the other workspace", "delegate", or "have another claude work on this". Also trigger when decomposing work across git worktrees.
---

# tmux-launch-claude

Send tasks to Claude Code instances running in other tmux panes. If Claude is already running in the target workspace, send a message directly. If not, find an idle shell pane, launch Claude, and send the message.

## Scripts

This skill bundles two scripts in its `scripts/` directory. Reference them via the skill path:

```
<skill-path>/scripts/tmux-claude-launch
<skill-path>/scripts/tmux-claude-send
```

Both output tab-separated fields: `target  session  window_name  path  branch`

## Workflow

### Step 1: Determine the target workspace

When the user refers to a worktree by name (e.g., "in imai"), resolve it against the **current repo's** worktrees first:

```bash
git worktree list
```

This outputs lines like:
```
/home/tamakiii/.dotfiles                    0dad494 [update-arch-20230321a]
/home/tamakiii/Git/tamakiii/dotfiles/imai   0dad494 [imai]
```

Match the user's name against the branch names in brackets. Use the corresponding path as the target workspace. Do not assume the worktree belongs to a different project.

Resolve `~` to the full home path before passing to scripts.

### Step 2: Check if Claude is already running there

```bash
<skill-path>/scripts/tmux-claude-send --list
```

Look for a pane whose path matches the target workspace. If found, skip to Step 4.

### Step 3: Find an idle pane and launch Claude

```bash
<skill-path>/scripts/tmux-claude-launch --list --dir <workspace-path>
```

- **One idle pane** — use it directly.
- **Multiple idle panes** — present the options to the user and ask them to choose:
  ```
  Found multiple idle panes in <workspace>:
  1. example:1.0 — zsh — ~/Git/.../acrux (add/feature)
  2. example:1.2 — zsh — ~/Git/.../acrux (add/feature)
  Which pane should I use?
  ```
- **No idle panes** — tell the user: "No idle shell pane found in <workspace>. Open a new pane there first."

### Step 4: Send the task

If Claude is **already running** in the target pane (found in Step 2):

```bash
<skill-path>/scripts/tmux-claude-send <target> "$(cat <<'EOF'
<task message>
EOF
)"
```

If Claude **needs to be launched** (from Step 3):

```bash
<skill-path>/scripts/tmux-claude-launch --target <target> --message "$(cat <<'EOF'
<task message>
EOF
)"
```

The `--message` flag waits for Claude to start (up to 30s) before sending.

## Writing the task message

Send the task directly as a message — don't write intermediate files like TASK.md. The message should be self-contained and include everything the target Claude needs:

- What to do (the task)
- Relevant file paths
- Branch to work on (if applicable)
- Any constraints or patterns to follow

Keep messages concise but complete. The target Claude has access to the workspace and can read files itself.

## Example

User: "Have another Claude add input validation to the API endpoints in the acrux worktree"

```bash
# Step 2: Check for existing Claude
<skill-path>/scripts/tmux-claude-send --list
# Output shows no Claude pane in ~/Git/tamakiii/example/acrux

# Step 3: Find idle pane
<skill-path>/scripts/tmux-claude-launch --list --dir ~/Git/tamakiii/example/acrux
# Output: example:1.2  example  zsh  ~/Git/.../acrux  add/feature

# Step 4: Launch and send
<skill-path>/scripts/tmux-claude-launch --target example:1.2 --message "$(cat <<'EOF'
Add input validation to all API endpoints in src/api/. Each endpoint should validate:
- Required fields are present
- Field types match the schema
- String lengths are within bounds

Use the existing validation helpers in src/utils/validate.ts as patterns.
EOF
)"
```
