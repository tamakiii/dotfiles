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