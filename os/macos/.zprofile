# Environment-specific profile configuration template
# This file contains machine/environment-specific settings that are generated
# during dotfiles installation. The actual values come from environment variables
# or keychain entries to keep sensitive information out of version control.

# Homebrew environment setup
# Required for Homebrew-installed packages to work correctly
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH configuration
# Prioritized paths for development tools and utilities
# Order matters: earlier entries take precedence
paths=(
    # Local project binaries
    "bin"
    ".venv/bin"

    # GNU utilities (preferred over BSD versions on macOS)
    "/opt/homebrew/opt/make/libexec/gnubin"
    "/opt/homebrew/opt/coreutils/libexec/gnubin"
    "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
    "/opt/homebrew/opt/grep/libexec/gnubin"
    "/opt/homebrew/opt/findutils/libexec/gnubin"

    # System utilities
    "/opt/homebrew/opt/util-linux/bin"
    "/opt/homebrew/opt/util-linux/sbin"

    # Development toolchains
    "/opt/homebrew/opt/llvm/bin"
    "/opt/homebrew/opt/binutils/bin"
    "/opt/homebrew/opt/node@22/bin"
    "/opt/homebrew/opt/go/bin"

    # Homebrew itself
    "/opt/homebrew/bin"

    # Dotfiles-specific tools
    "$HOME/.dotfiles/bin"
    "$HOME/.dotfiles/node_modules/.bin"

    # Dotcommands-specific tools
    "$HOME/.dotcommands/bin"
    "$HOME/.dotcommands/command/bin"

    # .local/bin
    "$HOME/.local/bin"

    # Python virtual environment
    "$HOME/.venv/bin"

    # Additional development tools
    "$HOME/Library/Application Support/Coursier/bin"
    "$HOME/go/bin"

    # Application-specific binaries
    "/Applications/Xcode.app/Contents/Developer/usr/bin"
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
