.PHONY: help setup install update teardown uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup:
	python3 -m poetry config --local virtualenvs.prompt null

install: \
	//

update: \
	requirements.txt

teardown:
	python3 -m poetry config --local virtualenvs.prompt --unset

uninstall:
	//

pyproject.toml:
	python3 -m poetry init
