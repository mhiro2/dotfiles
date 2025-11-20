XDG_CONFIG_FILES := bat git mise nvim yamllint
EXCLUDE_FILES    := .DS_Store .git .github .gitignore .gitmodules
DOT_FILES        := $(filter-out $(EXCLUDE_FILES), $(wildcard .??*))
DOT_FILES_ALL    := $(DOT_FILES) $(XDG_CONFIG_FILES)

BREW_CMD := $(shell command -v brew 2> /dev/null)
MISE_CMD := $(shell command -v mise 2> /dev/null)
ZINIT_DIR := $(HOME)/.local/share/zinit
ZINIT_INSTALLED := $(shell test -d "$(ZINIT_DIR)/zinit.git" && echo installed)
ZINIT_SCRIPT := $(ZINIT_DIR)/zinit.git/zinit.zsh

ZSH_COMPLETIONS_DIR := $(XDG_CACHE_HOME)/zsh/completions
ZSH_COMPDUMP := $(XDG_CACHE_HOME)/zsh/.zcompdump

COLOR_INFO := \033[1;34m
COLOR_SUCCESS := \033[1;32m
COLOR_SKIP := \033[1;33m
COLOR_RESET := \033[0m

.PHONY: all
all: init brew zinit mise refresh-completion

.PHONY: brew
brew:
ifeq ($(shell uname), Darwin)
ifeq ($(BREW_CMD),)
	@printf "$(COLOR_INFO)==> Homebrew をインストールします$(COLOR_RESET)\n"
ifeq ($(shell uname -m), arm64)
	NONINTERACTIVE=1 arch -arm64e /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
endif
	NONINTERACTIVE=1 arch -x86_64 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@printf "$(COLOR_SUCCESS)✔ Homebrew のインストールが完了しました$(COLOR_RESET)\n"
else
	@printf "$(COLOR_SKIP)✔ Homebrew は既にインストール済みのためスキップします$(COLOR_RESET)\n"
endif
else
	@printf "$(COLOR_SKIP)✔ macOS 以外のため Homebrew インストールをスキップします$(COLOR_RESET)\n"
endif

.PHONY: clean
clean:
	@printf "$(COLOR_INFO)==> シンボリックリンクを削除します$(COLOR_RESET)\n"
	@-$(foreach f, $(DOT_FILES), unlink $(HOME)/$(f);)
	@-$(foreach f, $(XDG_CONFIG_FILES), unlink $(HOME)/.config/$(f);)
	@printf "$(COLOR_SUCCESS)✔ clean が完了しました$(COLOR_RESET)\n"

.PHONY: install
install:
	@printf "$(COLOR_INFO)==> すべてのセットアップタスクを実行します$(COLOR_RESET)\n"
	$(MAKE) all
	@printf "$(COLOR_SUCCESS)✔ install が完了しました$(COLOR_RESET)\n"

.PHONY: init
init:
	@printf "$(COLOR_INFO)==> サブモジュールとシンボリックリンクを初期化します$(COLOR_RESET)\n"
	git submodule init
	git submodule update
	mkdir -p $(HOME)/.config
	@-$(foreach f, $(DOT_FILES), ln -sf "$(PWD)/$(f)" "$(HOME)";)
	@-$(foreach f, $(XDG_CONFIG_FILES), ln -sf "$(PWD)/$(f)" "$(HOME)/.config";)
	@printf "$(COLOR_SUCCESS)✔ init が完了しました$(COLOR_RESET)\n"

.PHONY: list
list:
	@printf "$(COLOR_INFO)==> 管理対象ファイルを一覧表示します$(COLOR_RESET)\n"
	@$(foreach f, $(DOT_FILES_ALL), ls -dF $(f);)
	@printf "$(COLOR_SUCCESS)✔ list が完了しました$(COLOR_RESET)\n"

.PHONY: upgrade
upgrade:
	@printf "$(COLOR_INFO)==> 各種ツールのアップグレードを実行します$(COLOR_RESET)\n"
ifeq ($(shell uname), Darwin)
ifeq ($(BREW_CMD),)
	@printf "$(COLOR_SKIP)✔ Homebrew は未インストールのためスキップします$(COLOR_RESET)\n"
else
	@printf "$(COLOR_INFO)   -> Homebrew を更新します$(COLOR_RESET)\n"
	@brew update
	@HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade
	@printf "$(COLOR_SUCCESS)✔ Homebrew のアップグレードが完了しました$(COLOR_RESET)\n"
endif
else
	@printf "$(COLOR_SKIP)✔ macOS 以外のため Homebrew アップグレードをスキップします$(COLOR_RESET)\n"
endif
ifeq ($(ZINIT_INSTALLED),)
	@printf "$(COLOR_SKIP)✔ zinit は未インストールのためスキップします$(COLOR_RESET)\n"
else
	@printf "$(COLOR_INFO)   -> zinit を更新します$(COLOR_RESET)\n"
	@zsh -ic "source \"$(ZINIT_SCRIPT)\"; typeset -i exit_code=0; zinit self-update || exit_code=$$?; zinit update --parallel || exit_code=$$?; wait || exit_code=$$?; exit $$exit_code"
	@printf "$(COLOR_SUCCESS)✔ zinit のアップグレードが完了しました$(COLOR_RESET)\n"
endif
	@printf "$(COLOR_SUCCESS)✔ upgrade が完了しました$(COLOR_RESET)\n"

.PHONY: mise
mise:
ifeq ($(MISE_CMD),)
	@printf "$(COLOR_INFO)==> mise をインストールします$(COLOR_RESET)\n"
ifeq ($(shell uname), Darwin)
	HOMEBREW_NO_AUTO_UPDATE=1 brew install mise
else
	curl -s https://mise.run | sh
endif
	@printf "$(COLOR_SUCCESS)✔ mise のインストールが完了しました$(COLOR_RESET)\n"
else
	@printf "$(COLOR_SKIP)✔ mise は既にインストール済みのためスキップします$(COLOR_RESET)\n"
endif
	mise install

.PHONY: completions
completions:
	@printf "$(COLOR_INFO)==> zsh 補完スクリプトを再生成します$(COLOR_RESET)\n"
	@rm -rf "$(ZSH_COMPLETIONS_DIR)"
	@mkdir -p "$(ZSH_COMPLETIONS_DIR)"
	@zsh -ic '\
	  setopt clobber; \
	  ZSH_LOCAL_COMPLETIONS="$(ZSH_COMPLETIONS_DIR)"; \
	  [[ -x "$$(command -v docker)" ]] && docker completion zsh >! "$$ZSH_LOCAL_COMPLETIONS/_docker"; \
	  [[ -x "$$(command -v kubectl)" ]] && kubectl completion zsh >! "$$ZSH_LOCAL_COMPLETIONS/_kubectl"; \
	  [[ -n "$$(command -v mise)" ]] && mise completion zsh >! "$$ZSH_LOCAL_COMPLETIONS/_mise"; \
	  [[ -x "$$(command -v uv)" ]] && uv generate-shell-completion zsh >! "$$ZSH_LOCAL_COMPLETIONS/_uv"; \
	'
	@printf "$(COLOR_SUCCESS)✔ completions の再生成が完了しました$(COLOR_RESET)\n"

.PHONY: compdump
compdump:
	@printf "$(COLOR_INFO)==> zsh 補完ダンプを更新します$(COLOR_RESET)\n"
	@rm -f "$(ZSH_COMPDUMP)" "$(ZSH_COMPDUMP).zwc"
	@zsh -ic 'autoload -Uz compinit; compinit -u -C -d "$(ZSH_COMPDUMP)"; [ -f "$(ZSH_COMPDUMP)" ] && zcompile "$(ZSH_COMPDUMP)"'
	@printf "$(COLOR_SUCCESS)✔ compdump の更新が完了しました$(COLOR_RESET)\n"

.PHONY: refresh-completion
refresh-completion: completions compdump
	@printf "$(COLOR_SUCCESS)✔ zsh 補完の再生成とダンプ更新が完了しました$(COLOR_RESET)\n"

.PHONY: zinit
zinit:
ifeq ($(ZINIT_INSTALLED),)
	@printf "$(COLOR_INFO)==> zinit をインストールします$(COLOR_RESET)\n"
	NO_INPUT=1 NO_ANNEXES=1 NO_EDIT=1 NO_TUTORIAL=1 bash -c "$$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	@printf "$(COLOR_SUCCESS)✔ zinit のインストールが完了しました$(COLOR_RESET)\n"
else
	@printf "$(COLOR_SKIP)✔ zinit は既にインストール済みのためスキップします$(COLOR_RESET)\n"
endif
