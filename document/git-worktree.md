# git worktree

## Setup

```sh
git clone git@github.com:USER/REPO.git master
cd master
```

## Add worktree (new branch)

```sh
git worktree add ~/Git/USER/REPO/BRANCH-NAME
```

## Add worktree (existing remote branch)

```sh
git branch -r | sed 's/origin\///' | xargs -n1 | fzf --select-1 --exit-0 | xargs -I @ git worktree add ~/Git/USER/REPO/@ @
```

## List

```sh
git worktree list
```

## Navigate (fzf)

```sh
pushd "$(git worktree list | fzf --select-1 --exit-0 | awk '{ print $1 }')"
```

## Remove

```sh
git worktree remove "$(git worktree list | fzf --select-1 --exit-0 | awk '{ print $1 }')"
```
