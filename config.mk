.PHONY: help install uninstall

CONFIGFILES := $(wildcard ./.config/*)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: $(HOME)/.config
	$(foreach f, $(CONFIGFILES), ln -sf $(abspath $f) $(HOME)/$f;)

uninstall:
	-$(foreach f, $(CONFIGFILES), unlink $(HOME)/$f;)

$(HOME)/.config:
	mkdir -p $@
