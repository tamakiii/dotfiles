# Environment-specific profile configuration template
# This file contains machine/environment-specific settings that are generated
# during dotfiles installation. The actual values come from environment variables
# or keychain entries to keep sensitive information out of version control.

# PATH configuration
# Prioritized paths for development tools and utilities
# Order matters: earlier entries take precedence
paths=(
    # Local project binaries
    "bin"
    ".venv/bin"

    # Dotfiles-specific tools
    "$HOME/.dotfiles/bin"
    "$HOME/.dotfiles/node_modules/.bin"

    # Dotcommands-specific tools
    "$HOME/.dotcommands/bin"
    "$HOME/.dotcommands/command/bin"

    # Python virtual environment
    "$HOME/.venv/bin"

    # User-specific binaries
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/bin"

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

# Optional: Environment-specific customizations
# Uncomment and modify as needed for specific environments
# export CUSTOM_ENV_VAR="${CUSTOM_ENV_VAR:-default_value}"
# export DEVELOPMENT_MODE="${DEVELOPMENT_MODE:-false}"
