---
allowed-tools: Bash(git commit:*)
description: Execute git commit with a validated message provided as argument
---

# Git Commit Implementation

This command takes a commit message as an argument and validates it before executing the commit.

## Validation

First, validate the commit message provided in: $ARGUMENTS

### Reject if:
1. Message is empty or only whitespace
2. Message contains placeholder text patterns:
   - `<YOUR_COMMIT_MESSAGE>`
   - `[YOUR_COMMIT_MESSAGE]`
   - `<your message>`
   - `[your message]`
   - `placeholder`
   - `<message>`
   - `[message]`
   - `TODO:` at the start
   - Any variation with angle brackets or square brackets around generic terms

### Error Messages:
- For empty message: "Error: Commit message cannot be empty"
- For placeholder text: "Error: Commit message contains placeholder text. Please provide a real commit message."

## Execution

If validation passes, execute:
!`git commit -m "$ARGUMENTS"`

## Usage Examples

Valid:
- `/git-commit-impl: fix: resolve authentication type errors`
- `/git-commit-impl: feat: add user profile management`
- `/git-commit-impl: docs: update API documentation`

Invalid:
- `/git-commit-impl:` (empty)
- `/git-commit-impl: <YOUR_COMMIT_MESSAGE>`
- `/git-commit-impl: [placeholder]`