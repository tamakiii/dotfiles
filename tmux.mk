.PHONY: help install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.tmux/plugins/tpm

dependencies:
	type git > /dev/null

.tmux/plugins/tpm: .tmux/plugins
		git clone https://github.com/tmux-plugins/tpm $@

.tmux/plugins: .tmux
.tmux:
	mkdir -p $@

clean:
	rm -rf .tmux
