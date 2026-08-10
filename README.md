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

`make setup` also applies a small compatibility patch to `tmux-resurrect`.
The plugin otherwise passes session names such as `@` through tmux's ambiguous
target parser; tmux 3.7b can crash while saving or restoring such a session. The
patch finds sessions and windows from unfiltered listings and compares their
names as data instead. `make check` verifies that the installed plugin remains
patched. Setup fails instead of changing the checkout if the upstream source no
longer matches the reviewed patch.

Run the isolated save/restore regression test with:

```sh
make test
```

```sh
make uninstall
```

Removes all symlinks.
