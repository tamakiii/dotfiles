.PHONY: help build

help:
	@cat $(firstword $(MAKEFILE_LIST))

build: \
	os/arch/packages.txt

os/arch/packages.txt:
	pacman -Qe > $@
