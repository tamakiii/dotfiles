.PHONY: help install check check-dependency check-winget uninstall

SHELL := bash --noprofile --norc -eo pipefail
error-install := echo "[error] install '$$_'"; exit 1;
check-dependency =  winget list -q $(1) > /dev/null || { $(call error-install) }

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: ~/.wslconfig
	winget install Helix.Helix
	winget install 9NT1R1C2HH7J # https://apps.microsoft.com/detail/9nt1r1c2hh7j

check:
	test -L ~/AppData/Roaming/helix/config.toml
	test -L ~/AppData/Roaming/helix/themes

check-dependency:
	@$(call check-dependency,Helix.Helix)

check-winget:
	@$(call cehck-dependency,9NT1R1C2HH7J) # ChatGPT

uninstall:
	rm -vrf ~/.wslconfig

~/.wslconfig: .wslconfig
	ln -sfnv $(abspath $<) $@
