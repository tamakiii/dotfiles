# Sourced by every zsh invocation (login, interactive, scripts, `zsh -c`).
# Keep cheap and side-effect-free — anything that writes to stdout here
# breaks tools that spawn `zsh -c "..."`. Heavy/interactive setup belongs
# in .zshrc; once-per-login setup belongs in .zprofile.

# Default GitHub Projects v2 board (Kanban #5) for the gh-project CLI and
# the skills that wrap it (pull-request-create, kanban-sweep). See
# tamakiii/meta#300.
export GH_PROJECT_DEFAULT=5

# Where the kikigaki skill keeps captured ChatGPT conversations: `c/` for
# ones saved from the signed-in browser, `share/` for the older share-link
# route. Both import-conversation.py and build-turns.py read this, so the
# archive is named here rather than in either script. Machine-specific
# because the retriever mount is.
export KIKIGAKI_ARCHIVE="/mnt/retriever/ARAKI/Documents/ChatGPT/chatgpt.com"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US"
export EDITOR="$(which hx || which helix)"
