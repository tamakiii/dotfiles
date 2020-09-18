.PHONY: help install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.tmux/plugins/tpm

dependencies:
	@type tmux > /dev/null
	@type git > /dev/null

.tmux/plugins/tpm: .tmux/plugins
	[[ -d $@ ]] || git clone -b $(BRANCH) git@github.com:tmux-plugins/tpm.git $@

.tmux/plugins: .tmux
	mkdir -p $@

.tmux:
	mkdir -p $@

clean:
	rm -rf .tmux
