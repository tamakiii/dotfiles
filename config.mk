.PHONY: help install uninstall

CONFIGFILES := $(wildcard ./.config/*)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: 
	$(foreach f, $(CONFIGFILES), ln -sfnv $(abspath $f) $(HOME)/$f;)

uninstall:
	-$(foreach f, $(CONFIGFILES), rm -vrf $(HOME)/$f;)


