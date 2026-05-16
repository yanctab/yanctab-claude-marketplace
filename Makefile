# Makefile

.PHONY: submodules help install

## help - show available targets
help:
	@grep -E '^## [a-zA-Z_-]+ - ' Makefile | awk 'BEGIN {FS=" - "} {printf "  %-15s %s\n", substr($$1, 4), $$2}'

## submodules - init and update all plugin submodules to their pinned commits
submodules:
	git submodule update --init plugins/*
