# tamakiii/dotfiles/snippets

```
ls | fzf --select-1 --exit-0
cd "$(basename $(git remote get-url origin) .git)"
cd "$(git worktree list | fzf --select-1 --exit-0 | awk '{ print $1 }')"
scriptty claude-cli
git log -1
git pull origin "$(git rev-parse --abbrev-ref @)"
git push origin "$(git rev-parse --abbrev-ref @)"
git worktree add /tmp/"$(git remote get-url origin | git-url | jq -r '.path' | sed 's/\.git$//')" -b "$(date -u +%Y%m%dT%H%M%SZ)"
claude --model sonnet -p '/git-commit'
```
