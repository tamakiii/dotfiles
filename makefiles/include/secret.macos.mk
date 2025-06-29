# macOS-specific secret configuration
#
# macOS Keychain Management Commands
# ==================================
#
# Export API Key to Environment Variable:
#   export OPENAI_API_KEY="$(security find-generic-password -s OPENAI_API_KEY -a $(whoami) -w)"
#
# Copy Secret to Clipboard:
#   security find-generic-password -s OPENAI_API_KEY -a "$(whoami)" -w | pbcopy
#
# Register New Secret:
#   security add-generic-password -s OPENAI_API_KEY -a "$(whoami)" -w "$(pbpaste)"
#
# Update Existing Secret:
#   security add-generic-password -s OPENAI_API_KEY -a "$(whoami)" -w "$(pbpaste)" -U
#
# Delete Secret:
#   security delete-generic-password -s OPENAI_API_KEY -a "$(whoami)" -w
#
# Open Keychain Access:
#   open /System/Applications/Passwords.app
#
# Notes:
# - Uses macOS `security` command for keychain interactions
# - Supports service-specific password storage
# - Allows secure retrieval and management of secrets
# - Integrates with system keychain for credential management

# Current user for keychain lookups
KEYCHAIN_USER := $(shell whoami)

# GitHub variables from macOS Keychain
GITHUB_PERSONAL_ACCESS_TOKEN ?= $(shell security find-generic-password -s GITHUB_TOKEN -a $(KEYCHAIN_USER) -w)

# Discord variables from macOS Keychain
DISCORD_CHANNEL_ID_CLAUDE ?= $(shell security find-generic-password -s DISCORD_CHANNEL_ID_CLAUDE -a $(KEYCHAIN_USER) -w)
DISCORD_USER_ID ?= $(shell security find-generic-password -s DISCORD_USER_ID -a $(KEYCHAIN_USER) -w)
DISCORD_TOKEN ?= $(shell security find-generic-password -s DISCORD_TOKEN -a $(KEYCHAIN_USER) -w)