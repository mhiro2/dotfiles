.DEFAULT_GOAL := help

MISE_TASK := ./scripts/run-mise-task.sh

.PHONY: help
help: ## タスク一覧を表示する
	@awk 'BEGIN { FS = ":.*##" } \
		/^## .* ##$$/ { \
			title = $$0; \
			gsub(/^## /, "", title); \
			gsub(/ ##$$/, "", title); \
			printf "\n\033[1m%s\033[0m\n", title; \
			next; \
		} \
		/^[a-zA-Z0-9][a-zA-Z0-9_-]+:.*##/ { \
			desc = $$2; \
			gsub(/^[ \t]+/, "", desc); \
			printf "  \033[36m%-24s\033[0m %s\n", $$1, desc; \
		}' $(MAKEFILE_LIST)

## セットアップ ##

.PHONY: install
install: bootstrap init ## すべての dotfiles セットアップタスクを実行する
	@$(MISE_TASK) dotfiles:install

.PHONY: bootstrap
bootstrap: brew mise ## make install に必要な最小ツールを用意する

.PHONY: brew
brew: ## Homebrew をインストールする
	@./scripts/install-homebrew.sh

.PHONY: mise
mise: ## mise をインストールする
	@./scripts/install-mise.sh

## dotfiles ##

.PHONY: init
init: ## dotfiles のシンボリックリンクを作成する
	@./scripts/link-dotfiles.sh init

.PHONY: clean
clean: ## dotfiles のシンボリックリンクを削除する
	@./scripts/link-dotfiles.sh clean

.PHONY: upgrade
upgrade: ## 管理対象ツールを更新する
	@$(MISE_TASK) dotfiles:upgrade
