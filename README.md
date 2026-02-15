# dotfiles

Personal dotfiles managed with Make and symlinks.

## Requirements

- macOS with [Homebrew](https://brew.sh)
- zsh (default on macOS)
- git

### Optional tools

- [fzf](https://github.com/junegunn/fzf) - fuzzy finder (`brew install fzf`)
- [bat](https://github.com/sharkdp/bat) - cat with syntax highlighting (`brew install bat`)
- [Starship](https://starship.rs) - cross-shell prompt (`brew install starship`)
- [gitmux](https://github.com/arl/gitmux) - git status in tmux (`brew install gitmux`)
- [Helix](https://helix-editor.com) - text editor (`brew install helix`)
- [Ghostty](https://ghostty.org) - terminal emulator

## Install

```sh
git clone --recursive git@github.com:tamakiii/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/os/mac
make install
```

If you already cloned without `--recursive`:

```sh
git submodule update --init --recursive
```

## Uninstall

```sh
cd ~/.dotfiles/os/mac
make uninstall
```

## Structure

```
os/mac/
├── .zshrc                  # Shell configuration
├── .zprofile               # Login shell (PATH, locale)
├── .zsh/plugins/           # Zsh plugins (git submodules)
├── .config/
│   ├── git/                # Git config and global ignore
│   ├── tmux/               # Tmux configuration
│   ├── helix/              # Helix editor
│   ├── ghostty/            # Ghostty terminal
│   ├── gitmux/             # Git status in tmux
│   └── claude/             # Claude Code MCP config
├── .claude/                # Claude Code settings
├── bin/                    # Custom scripts
└── Makefile                # Install/uninstall targets
```
