.PHONY: help setup install teardown uninstall

DIR_VIRTUALENV := $(shell python3 -m poetry env info -p)

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup:
	python3 -m poetry config --local virtualenvs.prompt null

install: \
	$(DIR_VIRTUALENV)

teardown:
	python3 -m poetry config --local virtualenvs.prompt --unset

uninstall:
	rm -rf $(DIR_VIRTUALENV)

pyproject.toml:
	python3 -m poetry init

poetry.lock:
	python3 -m poetry self lock --no-update

$(DIR_VIRTUALENV):
	python3 -m poetry install --no-root
