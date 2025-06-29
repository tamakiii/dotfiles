---
allowed-tools: [mcp__human-in-the-loop__ask_human]
---
# Interactive Prompt Detected

I've encountered an interactive prompt or dialog that requires user input.

Use the ask_human tool to handle: $ARGUMENTS

The user has instructed that I should ALWAYS use ask_human when encountering ANY interactive prompt or dialog with options to proceed, including:
- Confirmation dialogs
- Menu selections
- Any prompt waiting for user input
- Commands ready to run but waiting for confirmation

CRITICAL: When seeing a command ready to run but waiting for confirmation, I must ALWAYS use ask_human instead of proceeding automatically.

I will now ask the human how to proceed with this interactive prompt.