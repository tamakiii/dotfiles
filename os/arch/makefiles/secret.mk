.PHONY: @help

@help:
	@echo "Arch Linux secret makefile - uses gh CLI for GitHub token"

# GitHub token from gh CLI
GITHUB_PERSONAL_ACCESS_TOKEN := $(shell gh auth token 2>/dev/null || echo "")

# Discord tokens - empty on Arch for now
DISCORD_CHANNEL_ID_CLAUDE =
DISCORD_USER_ID =
DISCORD_TOKEN =