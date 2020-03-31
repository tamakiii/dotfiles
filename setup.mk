.PHONY: help install chsh clean

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

chsh: /etc/shells
	grep $(TARGET) $^ || (echo "Shell $(TARGET) not found in /etc/shells"; exit 1)
	chsh --shell $(TARGET) tecmint
	# Open `Preferences > Users & Groups > Right click icon -> Advanced Options` Set `Login shell``
	dscl . change /users/$(whoami) UserShell /bin/bash $(TARGET)

install: ## Show dot files in this repo

clean:

