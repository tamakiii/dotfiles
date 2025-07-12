# Claude Custom Commands

This directory contains custom slash commands for Claude Code to enforce the use of the `ask_human` tool in specific situations.

## Background

Despite clear instructions in `~/.claude/CLAUDE.md`, Claude Code sometimes doesn't call `ask_human` when encountering interactive prompts or confirmation dialogs. These custom commands provide an explicit way to ensure Claude uses the `ask_human` tool when needed.

## Available Commands

### `/confirm`
Use when Claude encounters any confirmation prompt or dialog.

**Example usage:**
```
/confirm: proceed with installation
/confirm: delete these files
```

### `/rerun`
Use when Claude should ask if you want to run something again.

**Example usage:**
```
/rerun: the build process
/rerun: the failed tests
```

### `/automation-ready`
Use when an automation tool has started and is waiting for manual action.

**Example usage:**
```
/automation-ready: export automation is ready
/automation-ready: backup process started
```

### `/interactive`
Use for any interactive prompt or menu that requires user input.

**Example usage:**
```
/interactive: command confirmation dialog
/interactive: menu selection required
```

### `/git-commit-impl`
Execute git commit with a validated message provided as argument.

**Example usage:**
```
/git-commit-impl: fix: resolve authentication type errors
/git-commit-impl: feat: add user profile management
```

**Validation:**
- Rejects empty messages
- Rejects placeholder text like `<YOUR_COMMIT_MESSAGE>`, `[placeholder]`, etc.

### `/git-commit`
AI-assisted commit message generation with automatic validation.

**Example usage:**
```
/git-commit
```

**Features:**
- Analyzes staged changes automatically
- Generates appropriate commit messages
- Uses `/git-commit-impl` for validation
- Follows conventional commit format

## How It Works

Each command file:
1. Specifies `allowed-tools: [mcp__human-in-the-loop__ask_human]` to ensure only the ask_human tool is used
2. Contains instructions that reference the specific scenarios from CLAUDE.md
3. Accepts arguments via `$ARGUMENTS` to provide context

## When to Use

Use these commands when Claude:
- Shows you a confirmation dialog but doesn't ask for your input
- Completes a task and should ask "Would you like me to run it again?"
- Indicates an automation tool is ready but doesn't ask what to do next
- Encounters any interactive prompt but proceeds automatically

## Installation

These commands are automatically installed when you run `make install` from the dotfiles root directory. They are symlinked from `.claude/commands/` to `~/.claude/commands/` making them available globally in all Claude Code sessions.

## Adding New Commands

To add a new command:

1. Create a new `.md` file in this directory
2. Add YAML frontmatter with `allowed-tools`
3. Write clear instructions for Claude
4. Use `$ARGUMENTS` to accept parameters
5. Run `make install` to update the symlink

Example template:
```markdown
---
allowed-tools: [mcp__human-in-the-loop__ask_human]
---
# Command Title

Description of when to use ask_human for: $ARGUMENTS

Specific instructions referencing CLAUDE.md requirements.
```