# tamakiii/dotfiles

Personal dotfiles repository that manages configuration files for development tools including zsh, tmux, helix editor, and Claude Code with MCP server integration.

## Quick Start

```sh
make check-dependency  # Verify required tools are installed
make install           # Install dotfiles and create symlinks
make check             # Verify installation
```

### Ubuntu Installation
```sh
make -C make -f ubuntu.mk install
```

## Claude Code Setup

This repository includes configuration for Claude Code with MCP (Model Context Protocol) server integration.

### MCP Configuration

The repository automatically sets up MCP configuration with GitHub and human-in-the-loop integration:
- Creates `~/.config/claude/mcp.json` for general use across workspaces
- Creates `~/.claude/mcp.json` for dotfiles workspace
- Retrieves secrets securely from macOS keychain during installation
- Uses environment variable substitution to populate configuration template

### Claude CLI Wrapper

The repository includes a `bin/claude-cli` wrapper script that automatically loads the MCP configuration:

```sh
# The wrapper automatically includes --mcp-config ~/.config/claude/mcp.json
claude-cli

# Verify MCP servers are loaded
claude-cli /mcp

# Example: Analyze a specific commit
claude-cli -p "Describe this commit: https://github.com/mojombo/grit/commit/634396b2f541a9f2d58b00be1a07f0c358b999b3"

# Example: Review a file from a repository
claude-cli -p "Please review the copilot-instruction: https://github.com/tamakiii/meta/blob/main/.github/copilot-instructions.md"
```

The wrapper script:
- Automatically adds `--mcp-config ~/.config/claude/mcp.json` to all commands
- Allows manual override if you provide your own `--mcp-config` parameter
- Uses XDG_CONFIG_HOME if set, otherwise defaults to `~/.config`

## MCP Servers

### Available MCP Servers

#### GitHub MCP Server
Enables Claude to interact with GitHub repositories, issues, and pull requests.
- **Type**: HTTP-based server
- **Capabilities**: Repository browsing, issue management, PR operations
- **Authentication**: Uses GITHUB_PERSONAL_ACCESS_TOKEN from keychain

#### Human-in-the-Loop Server
Enables Claude to ask for user input via Discord integration.
- **Type**: Command-line based server
- **Capabilities**: Interactive prompts, confirmation dialogs
- **Authentication**: Uses Discord channel and user ID from keychain

### MCP Resource References

The GitHub MCP server supports referencing resources using the `@` syntax:
- `@github:issue://114` - References issue #114 in the current repository context

## Configuration Files

### Global Configuration
- `~/.claude/CLAUDE.md` - Global preferences and best practices (symlinked from `.claude/CLAUDE.md`)
- `~/.claude/settings.json` - Claude Code settings with permissions (symlinked from `.claude/settings.json`)
- `~/.claude/commands/` - Custom slash commands (symlinked from `.claude/commands/`)
- `~/.config/claude/mcp.json` - MCP server configuration (generated from template)

### Project-Specific Configuration
- `CLAUDE.md` - Repository-specific instructions for Claude Code

**Note on Cross-Repository References**: Currently, the standard MCP resource syntax doesn't support direct cross-repository issue references. For issues in other repositories, use the full GitHub URL instead of the resource syntax.

## Security

All secrets are stored securely in macOS keychain:
- `GITHUB_TOKEN` - GitHub personal access token
- `DISCORD_CHANNEL_ID_CLAUDE` - Discord channel ID for human-in-the-loop
- `DISCORD_USER_ID` - Discord user ID

Use the commands in `makefiles/include/secret.macos.mk` to manage keychain entries.

## References

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp)
