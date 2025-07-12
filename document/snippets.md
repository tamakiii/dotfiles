# Shell Snippets

## File & Directory Navigation

### Interactive file selection
```bash
ls | fzf --select-1 --exit-0
```
Select a file from current directory using fzf. Auto-selects if only one match.

### Change to repository root
```bash
cd "$(basename $(git remote get-url origin) .git)"
```
Navigate to a directory named after the git repository.

### Interactive worktree selection
```bash
cd "$(git worktree list | fzf --select-1 --exit-0 | awk '{ print $1 }')"
```
Select and navigate to a git worktree directory using fzf.

## Git Operations

### Show last commit
```bash
git log -1
```
Display the most recent commit with full details.

### Pull current branch
```bash
git pull origin "$(git rev-parse --abbrev-ref @)"
```
Pull latest changes for the current branch from origin.

### Push current branch
```bash
git push origin "$(git rev-parse --abbrev-ref @)"
```
Push current branch to origin remote.

### Create temporary worktree
```bash
git worktree add /tmp/"$(git remote get-url origin | git-url | jq -r '.path' | sed 's/\.git$//')" -b "$(date -u +%Y%m%dT%H%M%SZ)"
```
Create a new worktree in /tmp with a timestamped branch name.

## Development Tools

### Terminal recording
```bash
scriptty claude-cli
```
Start terminal recording session with claude-cli.

### AI-assisted git commit
```bash
claude --model sonnet -p '/git-commit'
```
Use Claude to help create git commit messages.

## Clipboard Operations

### Navigate to repository from clipboard URL
```bash
cd "$(basename "$(pbpaste)" .git)"
```
Extract repository name from a git URL in clipboard and navigate to that directory.

### Compare MCP config with clipboard
```bash
diff -u --color <(cat ~/.config/claude/mcp.json) <(pbpaste)
```
Show colored diff between your MCP configuration and clipboard contents.

## Claude Worktree Sessions

### Start parallel Claude session
```bash
claude-worktree start
```
Create a new isolated worktree and launch Claude Code for parallel development.

### Start session with recording
```bash
claude-worktree start --record
```
Start a Claude session in worktree with scriptty recording enabled.

### Quick session workflow
```bash
# Start session
claude-worktree start

# After Claude work, commit changes
claude-worktree commit "Add authentication feature"

# Merge back to main
claude-worktree merge

# Cleanup session
claude-worktree cleanup
```
Complete workflow for isolated Claude development sessions.

### Resume previous session
```bash
claude-worktree resume $(claude-worktree list | grep -o '[0-9]*T[0-9]*Z' | head -1)
```
Resume the most recent Claude worktree session.

### List and cleanup old sessions
```bash
# List all sessions
claude-worktree list

# Cleanup specific session
claude-worktree cleanup 20250712T143022Z

# Cleanup current session
claude-worktree cleanup
```
Session management and cleanup commands.

### Worktree status check
```bash
claude-worktree status
```
Check if you're in a worktree and show git status for current session.
