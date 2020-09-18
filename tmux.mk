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
	[[ ! -d "$@" ]] && git clone https://github.com/tmux-plugins/tpm $@ || true

.tmux/plugins: .tmux
.tmux:
	mkdir -p $@

clean:
	rm -rf .tmux
