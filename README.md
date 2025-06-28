# tamakiii/dotfiles

## How to use
```sh
make check-dependency
make install
```

### Ubuntu
```sh
make -C make -f ubuntu.mk install
```

## Claude Code Setup

This repository includes configuration for Claude Code with MCP (Model Context Protocol) server integration.

### MCP Configuration

The repository automatically sets up MCP configuration for GitHub integration:
- Creates `~/.config/claude/mcp.json` for general use across workspaces
- Retrieves GitHub tokens securely from macOS keychain using `envsubst`

### Usage Examples

```sh
# Launch Claude with MCP configuration
claude --mcp-config ~/.config/claude/mcp.json

# Verify MCP servers are loaded
claude --mcp-config ~/.config/claude/mcp.json /mcp

# Example: Analyze a specific commit
claude -p "Describe this commit: https://github.com/mojombo/grit/commit/634396b2f541a9f2d58b00be1a07f0c358b999b3"

# Example: Review a file from a repository
claude -p "Please review the copilot-instruction: https://github.com/tamakiii/meta/blob/main/.github/copilot-instructions.md"
```

## MCP Servers

### GitHub MCP Server

The GitHub MCP server enables Claude to interact with GitHub repositories, issues, and pull requests.

- **Repository**: https://github.com/github/github-mcp-server
- **Configuration**: Automatically set up in `~/.config/claude/mcp.json`

### MCP Resource References

The GitHub MCP server supports referencing resources using the `@` syntax:
- `@github:issue://114` - References issue #114 in the current repository context

**Note on Cross-Repository References**: Currently, the standard MCP resource syntax doesn't support direct cross-repository issue references. For issues in other repositories, use the full GitHub URL instead of the resource syntax.

See also: [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp#reference-mcp-resources)
