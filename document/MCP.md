# Model Context Protocol (MCP) Configuration

This document provides detailed information about the MCP server configuration in this dotfiles repository.

## Overview

This repository includes comprehensive MCP (Model Context Protocol) server integration that enhances Claude Code with additional capabilities for GitHub interaction and human-in-the-loop workflows.

## MCP Configuration

The repository automatically sets up MCP configuration with GitHub and human-in-the-loop integration:

- Creates `~/.config/claude/mcp.json` for general use across workspaces
- Creates `~/.claude/mcp.json` for dotfiles workspace
- Retrieves secrets securely from macOS keychain during installation
- Uses environment variable substitution to populate configuration template

## Claude CLI Wrapper

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

## Available MCP Servers

### GitHub MCP Server
Enables Claude to interact with GitHub repositories, issues, and pull requests.
- **Type**: HTTP-based server
- **Capabilities**: Repository browsing, issue management, PR operations
- **Authentication**: Uses GITHUB_PERSONAL_ACCESS_TOKEN from `gh auth token`

### Human-in-the-Loop Server
Enables Claude to ask for user input via Discord integration.
- **Type**: Command-line based server
- **Capabilities**: Interactive prompts, confirmation dialogs
- **Authentication**: Uses Discord channel and user ID from keychain

## MCP Resource References

The GitHub MCP server supports referencing resources using the `@` syntax:
- `@github:issue://114` - References issue #114 in the current repository context

**Note on Cross-Repository References**: Currently, the standard MCP resource syntax doesn't support direct cross-repository issue references. For issues in other repositories, use the full GitHub URL instead of the resource syntax.

## Configuration Files

### Global Configuration
- `~/.claude/CLAUDE.md` - Global preferences and best practices (symlinked from `.claude/CLAUDE.md`)
- `~/.claude/settings.json` - Claude Code settings with permissions (symlinked from `.claude/settings.json`)
- `~/.claude/commands/` - Custom slash commands (symlinked from `.claude/commands/`)
- `~/.config/claude/mcp.json` - MCP server configuration (generated from template)

### Project-Specific Configuration
- `CLAUDE.md` - Repository-specific instructions for Claude Code

## Troubleshooting MCP Issues

### MCP Servers Not Loading
```sh
# Check MCP configuration
cat ~/.config/claude/mcp.json

# Verify GitHub authentication
gh auth status

# Test Claude CLI with MCP
claude-cli /mcp
```

### Authentication Issues
```sh
# Verify GitHub token
gh auth token

# Test GitHub API access
curl -H "Authorization: token $(gh auth token)" \
     https://api.github.com/user
```

### Discord Integration Issues
```sh
# Check Discord credentials
security find-generic-password -s "DISCORD_CHANNEL_ID_CLAUDE" -w
security find-generic-password -s "DISCORD_USER_ID" -w
```

## Security Considerations

All MCP server configurations use environment variables:
- GitHub token obtained via `gh auth token` (cross-platform)
- Discord credentials from macOS keychain
- No secrets are stored in plain text
- Environment variable substitution happens during installation

## Advanced Configuration

### Custom MCP Servers
To add additional MCP servers, modify the `.config/claude/mcp.json` template and add the corresponding environment variables to your secret configuration.

### Development Mode
For testing MCP configurations:
```sh
# Test configuration syntax
cat ~/.config/claude/mcp.json | jq .

# Manually test a server
claude-cli --mcp-config ~/.config/claude/mcp.json /mcp
```

## References

- [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [Model Context Protocol Specification](https://spec.modelcontextprotocol.io/)
- [GitHub MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/github)
