.PHONY: help deps install chsh clean

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deps:
	@type brew > /dev/null

install: ## Show dot files in this repo
	$(brew --prefix)/opt/fzf/install

chsh: /etc/shells ## Change shell
	grep $(TARGET) $^ || (echo "Shell $(TARGET) not found in /etc/shells"; exit 1)
	chsh --shell $(TARGET) tecmint
	# Open `Preferences > Users & Groups > Right click icon -> Advanced Options` Set `Login shell``
	# and restart OS

clean:
	$(brew --prefix)/opt/fzf/uninstall

