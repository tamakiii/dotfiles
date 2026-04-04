UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
  OS := mac
else
  OS := arch
endif

.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: .local/src/tamakiii/myfiles
	$(MAKE) -C .local/src/tamakiii/myfiles install
	$(MAKE) -C os/$(OS) install

uninstall:
	$(MAKE) -C os/$(OS) uninstall
	$(MAKE) -C .local/src/tamakiii/myfiles uninstall

.local/src/tamakiii/myfiles:
	git clone git@github.com:tamakiii/myfiles.git $@
