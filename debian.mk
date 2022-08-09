.PHONY: help install clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	echo "hello linux"

clean:
	echo "nothing to clean"
