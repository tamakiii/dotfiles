.PHONY: help install clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f brew.mk $@


clean:
	$(MAKE) -f brew.mk $@
