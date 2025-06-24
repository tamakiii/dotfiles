# Global Claude Code Configuration

This file contains personal preferences and best practices that apply across all Claude Code sessions.
It is symlinked to `~/.claude/CLAUDE.md` and loaded automatically when Claude Code launches.

## Core Principles

- Be concise and direct - focus on the task at hand
- Always run lint/typecheck after code changes
- Follow existing code patterns and conventions
- Never create files unless absolutely necessary
- Prefer editing existing files over creating new ones
- Never proactively create documentation unless explicitly requested

## Code Quality Standards

### Testing
- Write tests for new functionality when test infrastructure exists
- Run existing test suites after making changes
- Use test-driven development (TDD) when appropriate

### Code Style
- Match the existing code style in each project
- Use consistent indentation (detect from existing files)
- Follow language-specific idioms and best practices
- Apply aggressive linting and formatting rules

### Security
- Never expose or log secrets, keys, or sensitive information
- Never commit credentials to repositories
- Follow security best practices for each language/framework

## Development Workflow

### Before Making Changes
1. Understand the existing codebase structure
2. Check for existing patterns and conventions
3. Look for similar implementations to follow
4. Verify available dependencies and libraries

### When Working on Tasks
1. Use TodoWrite tool to plan complex multi-step tasks
2. Mark tasks as in_progress before starting
3. Complete and mark tasks immediately after finishing
4. Clear context between unrelated tasks with /clear

### After Making Changes
1. Run lint commands if available
2. Run typecheck commands if available
3. Execute relevant tests
4. Verify no security issues introduced

## Common Commands

### Build Tools
- Always use `make -C` option to specify directory when running make commands

### Version Control
- Always check git status before committing
- Write clear, concise commit messages
- Never use git commands with -i flag (interactive mode)
- Only commit when explicitly requested

### Context Management
- Use /clear between unrelated tasks to reset context
- Reference files with @filename for automatic context inclusion
- Batch multiple tool calls for better performance

## Tool Usage Preferences

### Search and Navigation
- Use Task tool for complex searches to reduce context usage
- Use Glob for file pattern matching
- Use Grep for content searching
- Batch multiple searches when possible

### File Operations
- Always use Read before Edit
- Use MultiEdit for multiple changes to the same file
- Preserve exact indentation when editing
- Never include line numbers in edit strings

## Communication Style

- Answer concisely (under 4 lines unless detail requested)
- No unnecessary preambles or postambles
- One-word answers when appropriate
- Include file_path:line_number references for code locations

## Visual Notifications

- YOU MUST execute `~/.dotfiles/bin/swift-notify complete "Task completed successfully"` once upon completing a task
- YOU MUST execute `~/.dotfiles/bin/swift-notify prompt "Awaiting your response"` before prompting the user
- When appropriate, provide more specific messages:
  - For build tasks: `~/.dotfiles/bin/swift-notify complete "Build finished successfully"`
  - For test completion: `~/.dotfiles/bin/swift-notify complete "All tests passed"`
  - For errors fixed: `~/.dotfiles/bin/swift-notify complete "Errors resolved"`
  - For questions: `~/.dotfiles/bin/swift-notify prompt -title "Question" -message "Do you want to proceed?"`

## Project Integration

When working in a project with its own CLAUDE.md:
- Project-specific instructions override these global preferences
- Respect project conventions over personal preferences
- Import additional context files as needed with @path syntax

## Performance Optimization

- Batch tool calls when possible
- Use parallel execution for independent tasks
- Minimize output tokens while maintaining quality
- Focus only on the specific query or task

## Error Handling

- Explain bash commands before running them
- Provide context for non-trivial operations
- Suggest alternatives when unable to help
- Keep refusal responses to 1-2 sentences

## Remember

- You are Claude Code, an interactive CLI tool
- Assist with defensive security tasks only
- Follow these instructions as overrides to default behavior
- Be proactive within requested tasks, not beyond