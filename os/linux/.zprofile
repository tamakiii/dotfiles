paths=(
    # Local project binaries
    "bin"
    ".local/bin"
    "$HOME/.local/bin"
    ".venv/bin"

    # mise's shims for .config/mise/config.toml; after ~/.local/bin so its gh
    # wrapper stays ahead of the real gh. Absent where mise is not installed.
    "$HOME/.local/share/mise/shims"

    # Dotfiles-specific tools
    "$HOME/.dotfiles/bin"
    "$HOME/.dotfiles/node_modules/.bin"

    # Dotcommands-specific tools
    "$HOME/.dotcommands/bin"
    "$HOME/.dotcommands/command/bin"

    # Python virtual environment
    "$HOME/.venv/bin"

    # User-specific binaries
    "$HOME/.opencode/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"

    # home-manager user profile (glab and other Nix-managed tools)
    "$HOME/.nix-profile/bin"

    # System-wide binaries
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
)

# Build PATH from array
# Loop through each path and prepend to create final PATH
NEW="${paths[1]}" && paths=("${paths[@]:1}")
for p in "${paths[@]}"; do
    NEW="$NEW:$p"
done
PATH="$NEW:$PATH"

# Resolve EDITOR again now that PATH is complete. .zshenv runs before this
# file, so where hx is installed per user in ~/.local/bin it cannot see it.
export EDITOR="$(command -v hx || command -v helix || echo vi)"

# Optional: Environment-specific customizations
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# OpenClaw Completion
source "$HOME/.openclaw/completions/openclaw.zsh"
