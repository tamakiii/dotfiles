# dotfiles

Personal dotfiles for Arch Linux and macOS.

## Structure

```
.
├── Makefile                    # Orchestrator: detects OS, clones myfiles, delegates
├── .zshrc                      # Shared shell config
├── .config/
│   ├── ghostty/themes/         # Shared terminal themes
│   ├── git/ignore              # Shared git ignore
│   ├── gitmux/gitmux.conf      # Shared gitmux config
│   ├── helix/config.toml       # Shared editor config
│   └── tmux/tmux.conf          # Shared tmux config (OS-detected PATH)
├── bin/                        # Shared scripts
│   ├── gh                      # gh wrapper (tamakiii-doppelganger bot)
│   ├── gh-app-token            # GitHub App token generator
│   └── tmux-*                  # Tmux helper scripts
└── os/
    ├── arch/
    │   ├── Makefile
    │   ├── .zprofile
    │   ├── .config/ghostty/config
    │   ├── .config/hypr/       # Hyprland WM config
    │   └── bin/                # pbcopy/pbpaste shims
    └── mac/
        ├── Makefile
        ├── .zprofile
        ├── .config/ghostty/config
        └── bin/                # github-mcp-headers, gw, etc.
```

Files are sourced from three locations:
- **Top level** — shared configs identical across both OSes
- **`os/<os>/`** — OS-specific configs (`.zprofile`, `ghostty/config`)
- **[`tamakiii/myfiles`](https://github.com/tamakiii/myfiles)** (private) — `.claude`, `.codex`, `.openclaw` configs, skills, and MCP settings

## Setup

```sh
make install
```

This will:
1. Clone `tamakiii/myfiles` to `.local/src/tamakiii/myfiles`
2. Run `make -C myfiles install` (AI tool configs)
3. Run `make -C os/<detected-os> install` (shell/editor/terminal configs)

All configs are symlinked to `$HOME`.

```sh
make uninstall
```

Removes all symlinks.
