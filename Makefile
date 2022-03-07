XDG_CONFIG_FILES := bat git nvim peco pip yamllint
EXCLUDE_FILES    := .DS_Store .git .github .gitignore .gitmodules
DOT_FILES        := $(filter-out $(EXCLUDE_FILES), $(wildcard .??*))
DOT_FILES_ALL    := $(DOT_FILES) $(XDG_CONFIG_FILES)

BREW_CMD  := $(shell command -v brew 2> /dev/null)
ZINIT_CMD := $(shell command -v zinit 2> /dev/null)

.PHONY: all
all: init brew zinit

.PHONY: brew
brew:
ifndef $(BREW_CMD)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
endif

.PHONY: clean
clean:
	@-$(foreach f, $(DOT_FILES), unlink $(HOME)/$(f);)
	@-$(foreach f, $(XDG_CONFIG_FILES), unlink $(HOME)/.config/$(f);)

.PHONY: install
install:
	make -j all

.PHONY: init
init:
	git submodule init
	git submodule update
	mkdir -p $(HOME)/.config
	@-$(foreach f, $(DOT_FILES), ln -sf $(PWD)/$(f) $(HOME);)
	@-$(foreach f, $(XDG_CONFIG_FILES), ln -sf $(PWD)/$(f) $(HOME)/.config;)

.PHONY: list
list:
	@$(foreach f, $(DOT_FILES_ALL), ls -dF $(f);)

.PHONY: update
update:
	git pull origin main

.PHONY: zinit
zinit:
ifndef $(ZINIT_CMD)
	/bin/bash -c "$$(curl -fsSL https://git.io/zinit-install)"
endif
