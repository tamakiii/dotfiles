---
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*)
description: Commit staged changes automatically
---

## Context
- `git status`: !`git status`
- Staged diffs: !`git diff --staged`

## Task
1. Review the staged changes and craft an appropriate commit message
2. Validate that the message is descriptive and not a placeholder
3. Commit automatically using a simple command format

Replace `[YOUR_COMMIT_MESSAGE]` with the actual commit message and run:
!`git commit -m "[YOUR_COMMIT_MESSAGE]

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"`

## Guidelines
- Create concise, descriptive commit messages
- Focus on what changed and why
- Never use placeholder text like "<your message>", "placeholder", etc.
- Ensure message accurately reflects the staged changes
