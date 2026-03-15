## ----------------------------------------------------------------------
## See the README.md file for usage.
## ----------------------------------------------------------------------

help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

check: ## Use ShellCheck to check for bugs on the update shell scripts.
	shellcheck -ax -P SCRIPTDIR scripts/update.sh

update: ## Run the update script to get the latests updates.
	./scripts/update.sh
