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
- go (for workbench tools)

### OS-Specific Installation

#### Ubuntu
```bash
make -C make -f ubuntu.mk install
```

#### Arch Linux
See `os/arch/CLAUDE.md` for detailed Arch Linux installation instructions and package management.

## Repository Structure

The repository follows a pattern where configuration files are stored in the repository and then symlinked to their expected locations:

- `.zshrc`: `~/.zshrc` - Zsh configuration with antigen plugin manager
- `.config/tmux/`: `~/.config/tmux/` - Tmux configuration
- `.config/helix/`: `~/.config/helix/` - Helix editor configuration
- `.config/claude/`: `~/.config/claude/` - Claude configuration including MCP settings
- `bin/`: Custom utility scripts including scriptty
- `workbench/`: Development tools and Go utilities
- `document/`: Documentation and reference materials

## Build and Development

### Workbench Tools
Build development utilities:
```bash
make -C workbench build    # Build all tools
make -C workbench clean    # Clean artifacts
```

### Environment Profile Management

The repository includes a template-based approach for managing environment-specific configurations:

```bash
make install  # Generates ~/.zprofile from os/macos/.zprofile
```

**Key Files:**
- `os/macos/.zprofile` - macOS-specific profile template with documented environment setup
- `os/arch/CLAUDE.md` - Arch Linux-specific configuration and installation guide
- `~/.zprofile` - Generated file containing actual environment configuration
- The template is processed during installation using `envsubst` for environment variable substitution

**OS-Specific Documentation:**
- For Arch Linux users, see `os/arch/CLAUDE.md` for distribution-specific setup instructions
- For macOS users, the default configuration in `os/macos/` is used

**Security Notes:**
- Environment-specific values can be sourced from environment variables or keychain
- The template provides context and documentation without exposing sensitive information
- Generated `.zprofile` is not version controlled but the template structure is documented

### Custom Scripts
Utility scripts are located in `bin/` and added to PATH via `.zshrc`:
- `scriptty` - Terminal recording with BSD script enhancement
- Additional utilities as development needs arise

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

4. **MCP Configuration**: The repository includes MCP (Model Context Protocol) configuration for GitHub integration

5. **Custom Slash Commands**: Enhanced Claude Code workflow with custom commands:
   - `/confirm`, `/rerun`, `/automation-ready`, `/interactive` - Human-in-the-loop helpers

6. **Development Tools**: 
   - `scriptty` - Enhanced terminal session recorder with BSD script features
   - `git-url` - Git URL parser utility for extracting endpoint information
   - Workbench environment for building and testing Go utilities

## MCP (Model Context Protocol) Setup

This dotfiles repository includes MCP server configuration to enable enhanced Claude Code capabilities.

### Configuration Files
- `.config/claude/mcp.json` - MCP server configuration template with GitHub and human-in-the-loop integration
- Installation creates:
  - `~/.claude/mcp.json` - For dotfiles workspace (not currently implemented)
  - `~/.config/claude/mcp.json` - For general workspace usage
- The Makefile automatically populates secrets from macOS keychain using environment variable substitution

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
- The configuration template is version controlled while keeping credentials separate

## Custom Slash Commands

The repository includes enhanced Claude Code slash commands in `.claude/commands/`:

### Human-in-the-Loop Commands
- `/confirm: <context>` - Ensures ask_human tool usage for confirmation prompts
- `/rerun: <context>` - Handles "run again" scenarios with ask_human
- `/automation-ready: <context>` - Manages automation waiting states
- `/interactive: <context>` - Handles interactive prompt scenarios

## Development Tools

### Workbench Environment

The `workbench/` directory contains Go-based development utilities:

```bash
# Build all workbench tools
make -C workbench build

# Build specific tool
make -C workbench/git-url build

# Clean build artifacts
make -C workbench clean
```

#### git-url Utility
Parses Git URLs and outputs endpoint information as JSON:

```bash
# Parse from git remote
git remote get-url origin | git-url

# Parse any Git URL
echo "git@github.com:user/repo.git" | git-url
```

### scriptty - Terminal Session Recorder

Enhanced BSD script wrapper for macOS with modern UX:

```bash
# Record interactive session
scriptty

# Record with keystroke timing
scriptty -k claude-session

# Live streaming output
scriptty -f npm test

# Session management
scriptty -s              # Check status
scriptty -l              # List sessions
scriptty --resume        # Resume last session
```

Key BSD script features:
- Keylog mode (`-k`) for timing data
- Live streaming (`-f`) for real-time output
- Raw mode (`-r`) for unprocessed recording
- Session management and organization

### Shell Snippets

Quick reference commands in `document/snippets.md`:
- File and directory navigation with fzf
- Git operations and worktree management
- Development tool shortcuts
- Clipboard operations

## Bluetooth Troubleshooting on Arch Linux

### Key Learnings

**Working Solutions:**
- **Blueman** is superior to GNOME Settings for Bluetooth pairing on Arch Linux
- Sony WF-C710N earphones successfully paired after fixing PipeWire audio endpoint issues
- Audio endpoint registration errors require PipeWire/WirePlumber restart

**Specific Device Issues:**
- **HHKB-Studio2 Keyboard**: Multiple pairing slots (1-4) with different MAC addresses per slot
  - Slot switching: Fn + Control + [1-4]
  - Clear all pairings: Fn + Z + Backspace
  - Known authentication failures with Linux - common issue
  - Different slots show as different devices (HHKB-Studio1, HHKB-Studio2, etc.)

**Critical Fixes:**
1. **Audio Endpoint Error**: "No audio endpoints registered"
   - Solution: `systemctl --user restart wireplumber pipewire pipewire-pulse`
   - Root cause: WirePlumber Bluetooth codec ABI version mismatches

2. **Authentication Failures**: 
   - Use Blueman instead of GNOME Settings or bluetoothctl
   - Trust device before pairing: `bluetoothctl trust <MAC>`
   - Use appropriate agent: KeyboardOnly for keyboards, default for audio

**Working Bluetooth Stack:**
- bluez 5.83-1 with blueman 2.4.6-1
- PipeWire 1.2.5 with WirePlumber
- Kernel 6.10.10-arch1-1 (past problematic 5.9.x versions)
