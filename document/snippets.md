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

### Delete all local branches except current
```bash
git branch | grep -v ^\* | xargs -I @ git branch -D @
```
Delete all local git branches except the currently checked out branch.

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
