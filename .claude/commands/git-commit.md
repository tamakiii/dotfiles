---
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*), mcp__human-in-the-loop__ask_human
description: Commit staged changes with proper message validation
---

## Context
- `git status`: !`git status`
- Staged diffs: !`git diff --staged`

## Task
1. Review the staged changes and craft an appropriate commit message
2. Use the ask_human tool to get user approval for the commit message
3. Validate that the message is not a placeholder (reject messages like "<your message>", "placeholder", etc.)
4. If approved and valid, commit with the format:

```bash
git commit -m "$(cat <<'EOF'
[USER_APPROVED_MESSAGE]

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

## Validation Rules
- Reject placeholder text like "<your message>", "placeholder", "TODO", etc.
- Ensure message is not empty or whitespace only
- Confirm message accurately describes the staged changes
- Get explicit user approval before committing
