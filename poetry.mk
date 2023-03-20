.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.venv

uninstall:
	rm -rf .venv

pyproject.toml:
	python3 -m poetry init

poetry.lock:
	python3 -m poetry self lock --no-update

.venv:
	python3 -m poetry install --no-cache --no-root
