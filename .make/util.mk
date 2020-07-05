.PHONY: help

help:
	@cat $(firstword $(MAKEFILE_LIST))

git-delete-branches:
	git for-each-ref --format='%(refname:short)' 'refs/heads/*' | fzf --multi | xargs -I@ git branch -D @
