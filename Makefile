# Makefile

.PHONY: submodules help install

## help - show available targets
help:
	@grep -E '^## [a-zA-Z_-]+ - ' Makefile | awk 'BEGIN {FS=" - "} {printf "  %-15s %s\n", substr($$1, 4), $$2}'

## submodules - init and update all plugin submodules to their pinned commits
submodules:
	git submodule update --init plugins/*

## install - run install in every local -dev plugin directory
install: submodules
	@jq -r '.plugins[] | select(.name | endswith("-dev")) | select(.source | type == "string") | .source' .claude-plugin/marketplace.json \
	  | while IFS= read -r dir; do \
	      $(MAKE) -C "$$dir" install; \
	    done
