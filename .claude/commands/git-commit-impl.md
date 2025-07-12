---
allowed-tools: Bash(git commit:*)
description: Execute git commit with a validated message provided as argument
---

# Git Commit Implementation

This command takes a commit message as an argument and validates it before executing the commit.

## Instructions

1. **Validate the commit message in $ARGUMENTS**:
   - If $ARGUMENTS is empty or contains only whitespace, respond with: "Error: Commit message cannot be empty"
   - If $ARGUMENTS contains placeholder text like `<YOUR_COMMIT_MESSAGE>`, `[YOUR_COMMIT_MESSAGE]`, `<your message>`, `[your message]`, `placeholder`, `<message>`, `[message]`, or starts with `TODO:`, respond with: "Error: Commit message contains placeholder text. Please provide a real commit message."
   - If $ARGUMENTS contains angle brackets `<>` or square brackets `[]` around generic terms, respond with the placeholder error

2. **If validation passes, execute the git commit**:
   !`git commit -m "$ARGUMENTS"`

3. **Provide feedback**:
   - On success: Show the commit was created successfully
   - On failure: Show the git error message

## Usage Examples

Valid:
- `/git-commit-impl fix: resolve authentication type errors`
- `/git-commit-impl feat: add user profile management`
- `/git-commit-impl docs: update API documentation`

Invalid:
- `/git-commit-impl` (empty)
- `/git-commit-impl <YOUR_COMMIT_MESSAGE>`
- `/git-commit-impl [placeholder]`
- `/git-commit-impl TODO: fix this later`