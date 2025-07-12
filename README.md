# tamakiii/dotfiles

Personal dotfiles repository that manages configuration files for development tools including zsh, tmux, helix editor, and Claude Code with MCP server integration.

## What's Included

This repository sets up a complete development environment with:

| Tool | Purpose | Config Location |
|------|---------|----------------|
| **zsh** | Interactive shell with antigen plugin manager | `.zshrc`, `.zsh/` |
| **tmux** | Terminal multiplexer for session management | `.config/tmux/` |
| **helix** | Modern modal text editor | `.config/helix/` |
| **Claude Code** | AI coding assistant with MCP integration | `.claude/`, `.config/claude/` |
| **ghostty** | GPU-accelerated terminal emulator | `.config/ghostty/` |
| **git** | Version control configuration | `.config/git/` |
| **GitHub Copilot** | AI code completion with custom prompts | `.llm/prompt/github-copilot/` |

### Ubuntu Installation
```sh
make -C make -f ubuntu.mk install
```

## System Requirements

### macOS
- macOS 15.5+ (Sequoia or newer)
- Homebrew package manager
- Xcode Command Line Tools

### Ubuntu
- Ubuntu 24.04+ or compatible distribution
- Package manager (apt)
- Build essentials

### Required Dependencies
The following tools must be installed before running `make install`:
- `zsh` - Z shell
- `tmux` - Terminal multiplexer
- `uv` - Fast Python package installer
- `fzf` - Command-line fuzzy finder
- `hx` - Helix editor

## 🛠️ Installation

### Standard Installation
```sh
git clone https://github.com/tamakiii/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make check-dependency  # Verify all required tools
make install           # Install configurations
make check             # Verify installation success
```

## Claude Code & AI Integration

This repository includes comprehensive AI tooling setup for modern development workflows.

### Claude Code Setup

Claude Code is configured with Model Context Protocol (MCP) server integration for enhanced AI assistance:

```sh
# The wrapper automatically includes MCP configuration
claude-cli

# Verify MCP servers are loaded
claude-cli /mcp

# Example: Analyze a commit
claude-cli -p "Describe this commit: https://github.com/mojombo/grit/commit/634396b2f541a9f2d58b00be1a07f0c358b999b3"

# Example: Review a file
claude-cli -p "Please review: https://github.com/tamakiii/meta/blob/main/.github/copilot-instructions.md"
```

### Available MCP Servers

#### GitHub Integration
- **Capabilities**: Repository browsing, issue management, PR operations
- **Authentication**: Uses `GITHUB_PERSONAL_ACCESS_TOKEN` from keychain
- **Resource syntax**: `@github:issue://114` for issue references

#### Human-in-the-Loop Server
- **Capabilities**: Interactive prompts via Discord integration
- **Authentication**: Uses Discord credentials from keychain
- **Use cases**: Confirmation dialogs, user input requests

### AI Code Assistance
- **GitHub Copilot**: Custom instruction prompts for code generation, review, testing
- **Claude Code**: Contextual AI assistance with project-specific knowledge
- **LLM Prompts**: Pre-configured templates in `.llm/prompt/`

For detailed MCP configuration, see [MCP.md](MCP.md).

## Configuration Details

### Global Claude Configuration
- `~/.claude/CLAUDE.md` - Global AI assistant preferences
- `~/.claude/settings.json` - Claude Code permissions and settings
- `~/.claude/commands/` - Custom slash commands
- `~/.config/claude/mcp.json` - MCP server configuration

### Shell Configuration
- `.zshrc` - Main zsh configuration with plugins and aliases
- `.zsh/` - Additional zsh modules and customizations

### Terminal Configuration
- `.config/tmux/` - Tmux configuration with custom key bindings
- `.config/ghostty/` - Modern terminal emulator settings

### Editor Configuration
- `.config/helix/` - Helix editor configuration and themes

## Troubleshooting

### Common Issues

#### Installation Fails
```sh
# Check if all dependencies are installed
make check-dependency

# Verify file permissions
ls -la ~/.dotfiles

# Re-run installation
make uninstall && make install
```

#### Symlinks Not Working
```sh
# Check existing symlinks
ls -la ~/ | grep -E "\->"

# Remove broken symlinks
find ~/ -type l -exec test ! -e {} \; -delete

# Reinstall
make install
```

#### MCP Servers Not Loading
```sh
# Check MCP configuration
cat ~/.config/claude/mcp.json

# Verify secrets in keychain
security find-generic-password -s "GITHUB_TOKEN"

# Test Claude CLI
claude-cli /mcp
```

#### Shell Not Loading Properly
```sh
# Check zsh installation
which zsh

# Verify antigen installation
ls -la ~/.dotfiles/.zsh/antigen.zsh

# Reload configuration
source ~/.zshrc
```

## Backup & Updates

### Updating Dotfiles
```sh
cd ~/.dotfiles
git pull origin main
make uninstall
make install
make check
```

### Safe Configuration Testing
```sh
# Create a test branch for experiments
git switch -c test-config

# Make changes and test
# ...

# If satisfied, merge back
git checkout main
git merge test-config
```

## Security

All secrets are stored securely in macOS keychain and accessed via environment variables:

| Secret | Purpose | Keychain Service |
|--------|---------|-----------------|
| `GITHUB_TOKEN` | GitHub API access | `GITHUB_TOKEN` |
| `DISCORD_CHANNEL_ID_CLAUDE` | Human-in-the-loop integration | `DISCORD_CHANNEL_ID_CLAUDE` |
| `DISCORD_USER_ID` | Discord user identification | `DISCORD_USER_ID` |

### Managing Secrets

The `security` command is macOS's CLI tool for managing keychains, certificates, and system security.

#### Basic Operations
```sh
# Add a new secret to keychain
security add-generic-password -s "SECRET_NAME" -a "$USER" -w "secret_value"

# Retrieve a secret
security find-generic-password -s "SECRET_NAME" -w

# Update existing password (use -U flag)
security add-generic-password -s "SECRET_NAME" -a "$USER" -w "new_secret_value" -U

# Delete a password
security delete-generic-password -s "SECRET_NAME" -a "$USER"
```

#### Working with Environment Variables
```sh
# Export secret to environment variable
export GITHUB_TOKEN="$(security find-generic-password -s GITHUB_TOKEN -a $(whoami) -w)"

# Copy password to clipboard
security find-generic-password -s GITHUB_TOKEN -a "$(whoami)" -w | pbcopy
```

#### Interactive Password Management
```sh
# Register password from clipboard
security add-generic-password -s "API_KEY" -a "$(whoami)" -w "$(pbpaste)"

# Update password from clipboard
security add-generic-password -s "API_KEY" -a "$(whoami)" -w "$(pbpaste)" -U
```

#### Visual Keychain Management
```sh
# Launch Keychain Access app
open /System/Applications/Passwords.app
```

Use the commands in `makefiles/include/secret.macos.mk` for advanced keychain management.

## References

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [Helix Editor Documentation](https://docs.helix-editor.com/)
- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)

---

**Note**: This dotfiles setup is optimized for macOS and Ubuntu. Windows support may require additional configuration via WSL.
