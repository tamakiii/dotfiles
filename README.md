# dotfiles

Personal dotfiles for Arch Linux and macOS.

## Structure

```
.
├── Makefile                    # Orchestrator: detects OS, clones myfiles, delegates
├── .zshrc                      # Shared shell config
├── .config/
│   ├── helix/config.toml       # Shared editor config
│   └── ghostty/themes/         # Shared terminal themes
├── bin/                        # Shared scripts (tmux-*, gh-app-token)
└── os/
    ├── arch/                   # Arch-specific configs
    │   ├── Makefile            # install/uninstall targets
    │   ├── .zprofile
    │   ├── .config/            # tmux, ghostty, gitmux, git, hypr
    │   └── bin/                # pbcopy/pbpaste shims
    └── mac/                    # macOS-specific configs
        ├── Makefile
        ├── .zprofile
        ├── .config/            # tmux, ghostty, gitmux, git
        └── bin/                # github-mcp-headers, gw, etc.
```

Files are sourced from three locations:
- **Top level** — shared configs identical across both OSes
- **`os/<os>/`** — OS-specific configs that differ
- **`tamakiii/myfiles`** (private) — `.claude`, `.codex`, `.openclaw` configs, skills, and MCP settings

## Setup

```sh
make install
```

This will:
1. Clone `tamakiii/myfiles` to `.local/src/tamakiii/myfiles`
2. Run `make -C os/<detected-os> install`

All configs are symlinked to `$HOME`.

```sh
make uninstall
```

Removes all symlinks.
