.PHONY: help apply diff update edit status cd init test

# Default target
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

apply: ## Apply dotfiles changes
	chezmoi apply

diff: ## Show pending changes
	chezmoi diff

update: ## Pull latest from git and apply
	chezmoi update

edit: ## Edit chezmoi config
	chezmoi edit-config

status: ## Show managed file status
	chezmoi status

cd: ## Open shell in source directory
	@echo "Run: chezmoi cd"

init: ## Re-initialize chezmoi (prompts for data)
	chezmoi init

verify: ## Verify templates without applying
	chezmoi verify

doctor: ## Run chezmoi diagnostics
	chezmoi doctor

managed: ## List all managed files
	chezmoi managed

unmanaged: ## List unmanaged files in home
	chezmoi unmanaged

data: ## Show template data
	chezmoi data

execute-template: ## Test a template (usage: make execute-template FILE=path)
	chezmoi execute-template < $(FILE)

re-add: ## Re-add modified files to source
	chezmoi re-add

forget: ## Forget a file (usage: make forget FILE=path)
	chezmoi forget $(FILE)
