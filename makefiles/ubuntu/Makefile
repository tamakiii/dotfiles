.PHONY: help install check update upgrade uninstall

SHELL := bash --noprofile --norc -eo pipefail
exit = echo "[error] $(2) '$(3)'"; exit $(1);
current-shell = $(shell grep "$$(whoami)" /etc/passwd | awk -F : '{ print $$7 }')

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: update
	apt install --no-install-recommends \
		fzf \
		zsh \
		language-pack-en

check:
	@test "$$(which zsh)" = "$(call current-shell)" || { $(call exit,1,default shell should be zsh,$$_) }

update:
	apt update

upgrade:
	apt upgrade

uninstall:
	echo "not implemented yet"
	exit 255
