# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this dotfiles repository.

**Note**: This `CLAUDE.md` is repository-specific. The `.claude/CLAUDE.md` file in this repository gets symlinked to `~/.claude/CLAUDE.md` and applies globally to all Claude sessions.

## Repository Overview

This is a personal dotfiles repository that manages configuration files for various development tools including zsh, tmux, helix editor, and more. The repository uses symbolic links to install configurations into the user's home directory.

## Key Commands

### Installation and Setup
```bash
make check-dependency  # Check if required tools are installed
make install          # Install all dotfiles and create symbolic links
make check            # Verify that all symbolic links are properly created
make uninstall        # Remove all symbolic links
```

### Required Dependencies
The following tools must be installed before running `make install`:
- zsh
- tmux
- uv
- fzf
- hx (helix editor)

### Ubuntu-specific Installation
```bash
make -C make -f ubuntu.mk install
```

## Repository Structure

The repository follows a pattern where configuration files are stored in the repository and then symlinked to their expected locations:

- `.zshrc`: `~/.zshrc` - Zsh configuration with antigen plugin manager
- `.config/tmux/`: `~/.config/tmux/` - Tmux configuration
- `.config/helix/`: `~/.config/helix/` - Helix editor configuration
- `.config/claude/`: `~/.config/claude/` - Claude configuration including MCP settings

## Important Implementation Details

1. **Makefile Pattern**: The Makefile uses a consistent pattern for creating symbolic links:
   - First creates the directory if needed
   - Then creates a symbolic link using `ln -sfnv`
   - Uses `$(abspath)` to ensure absolute paths

2. **Error Handling**: The Makefile includes error handling for missing dependencies through the `check-dependency` function

3. **Shell Configuration**: The `.zshrc` includes:
   - Antigen plugin manager setup
   - History configuration with fzf integration
   - Custom prompt with emoji
   - PATH modifications for dotfiles-specific binaries

4. **MCP Configuration**: The repository includes MCP (Model Context Protocol) configuration for GitHub integration at `.config/claude/mcp.json`

## MCP (Model Context Protocol) Setup

This dotfiles repository includes MCP server configuration to enable enhanced Claude Code capabilities.

### Configuration Files
- `.config/claude/mcp.json` - MCP server configuration template with GitHub integration
- The Makefile automatically populates GitHub tokens from macOS keychain using `security find-generic-password`

### Usage
To use MCP servers in any workspace:

```bash
# Launch Claude with MCP configuration
claude --mcp-config ~/.config/claude/mcp.json

# Verify MCP servers are loaded
claude --mcp-config ~/.config/claude/mcp.json /mcp
```

### Security Notes
- GitHub tokens are retrieved from macOS keychain, not stored in files
- MCP configuration uses environment variable substitution to keep secrets secure
- The configuration is version controlled while keeping credentials separate
