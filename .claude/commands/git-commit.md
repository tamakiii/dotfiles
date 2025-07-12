---
allowed-tools: Bash(git add:*), Bash(git commit:*), Bash(git status:*), Bash(git diff:*)
description: Commit staged changes
---

## Context
- `git status`: !`git status`
- Staged diffs: !`git diff --staged`

## Task
Craft a commit message for the staged diffs, ask for user approval, then run:
!`git commit -m "<your message>"`
