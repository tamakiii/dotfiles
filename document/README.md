# Documentation Index

This directory contains documentation and reference materials for the dotfiles repository.

## Available Documentation

### Reference Materials

#### [snippets.md](snippets.md)
Quick reference guide for commonly used shell commands and workflows, organized by category:

- **File & Directory Navigation**: Interactive selection with fzf, repository navigation
- **Git Operations**: Branch management, worktree operations, commit helpers
- **Development Tools**: Terminal recording, AI-assisted workflows
- **Clipboard Operations**: URL parsing, configuration diffing

**Usage Example:**
```bash
# Interactive file selection
ls | fzf --select-1 --exit-0

# AI-assisted git commit
claude --model sonnet -p '/git-commit'
```

### Tool Documentation

#### [bin/scriptty/README.md](bin/scriptty/README.md)
Comprehensive guide for the `scriptty` terminal session recorder:

- **BSD Script Enhancement**: Modern UX wrapper around macOS's built-in script command
- **Advanced Recording Modes**: Keylogging, live streaming, raw recording
- **Session Management**: Resume, status checking, duration tracking
- **Log Organization**: Smart file naming, viewing, and cleanup

**Key Features:**
- npx-style command execution: `scriptty claude` instead of `script output.txt claude`
- BSD script superpowers: Access to keylogging (`-k`), live streaming (`-f`), raw mode (`-r`)
- Security features: Private mode with sensitive data scanning

## Documentation Categories

### Quick Reference
- **snippets.md**: Shell command quick reference for daily workflows

### Tool Guides
- **bin/scriptty/README.md**: Terminal recording and session management
- **../workbench/README.md**: Development tools and Go utilities
- **../workbench/git-url/README.md**: Git URL parser utility

### Configuration Guides
- **../README.md**: Main repository documentation and setup
- **../CLAUDE.md**: Claude Code specific configuration and workflows
- **../.claude/commands/README.md**: Custom slash commands documentation

## Documentation Standards

### File Organization
- **Tool-specific documentation**: Located in the tool's directory
- **General documentation**: Located in this `document/` directory
- **Configuration documentation**: Located at repository root

### Cross-References
Documentation files include cross-references to related materials:
- Links to tool documentation from main README
- References to configuration files from tool docs
- Integration examples showing tools working together

### Format Conventions
- **Headings**: Use descriptive hierarchical headings
- **Code blocks**: Include language specification for syntax highlighting
- **Examples**: Provide practical, runnable examples
- **File paths**: Use relative paths from the current document location

## Integration with Main Documentation

This documentation integrates with the main repository documentation:

### Main README.md
- **Tool overview table**: Lists all tools with their documentation links
- **Quick start sections**: Reference detailed documentation in this directory
- **Configuration sections**: Link to specific configuration documentation

### CLAUDE.md
- **Tool workflow integration**: Shows how tools work with Claude Code
- **Command references**: Links to detailed command documentation
- **Build instructions**: References workbench and tool-specific build guides

## Contributing to Documentation

When adding new tools or features:

1. **Create tool-specific documentation** in the appropriate directory
2. **Update this index** to reference new documentation
3. **Add cross-references** from related documentation
4. **Include practical examples** showing real-world usage
5. **Follow established formatting** and organization patterns

### Documentation Checklist

- [ ] Tool has its own README.md
- [ ] Tool is listed in main repository README.md
- [ ] Tool is referenced in this documentation index
- [ ] Examples show integration with existing tools
- [ ] Cross-references are updated in related documentation

## Finding Documentation

### By Tool
- **scriptty**: [bin/scriptty/README.md](bin/scriptty/README.md)
- **git-url**: [../workbench/git-url/README.md](../workbench/git-url/README.md)
- **Claude commands**: [../.claude/commands/README.md](../.claude/commands/README.md)

### By Category
- **Setup and Installation**: [../README.md](../README.md)
- **Claude Code Integration**: [../CLAUDE.md](../CLAUDE.md)
- **Development Tools**: [../workbench/README.md](../workbench/README.md)
- **Shell Workflows**: [snippets.md](snippets.md)

### By Use Case
- **Terminal recording**: [bin/scriptty/README.md](bin/scriptty/README.md)
- **Git URL parsing**: [../workbench/git-url/README.md](../workbench/git-url/README.md)
- **AI-assisted development**: [../CLAUDE.md](../CLAUDE.md)
- **Quick commands**: [snippets.md](snippets.md)

## Documentation Maintenance

This documentation is maintained alongside the codebase:
- Updates accompany feature additions
- Examples are tested for accuracy
- Cross-references are verified during updates
- Organization follows the repository structure