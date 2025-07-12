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

Generate a descriptive commit message based on the staged changes and commit using:
/git-commit-impl <your generated commit message here>

## Guidelines
- Create concise, descriptive commit messages
- Focus on what changed and why
- The /git-commit-impl command will automatically validate against placeholder text
- Ensure message accurately reflects the staged changes
