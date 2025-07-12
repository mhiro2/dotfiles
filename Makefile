XDG_CONFIG_FILES := bat git nvim yamllint
EXCLUDE_FILES    := .DS_Store .git .github .gitignore .gitmodules
DOT_FILES        := $(filter-out $(EXCLUDE_FILES), $(wildcard .??*))
DOT_FILES_ALL    := $(DOT_FILES) $(XDG_CONFIG_FILES)

ZINIT_CMD := $(shell command -v zinit 2> /dev/null)
MISE_CMD := $(shell command -v mise 2> /dev/null)

.PHONY: all
all: init brew zinit mise

.PHONY: brew
brew:
ifeq ($(shell uname), Darwin)
  ifeq ($(shell uname -m), arm64)
		arch -arm64e /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  endif
	arch -x86_64 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

.PHONY: mise
mise:
ifndef $(MISE_CMD)
ifeq ($(shell uname), Darwin)
	brew install mise
else
	curl -s https://mise.run | sh
endif
endif

.PHONY: zinit
zinit:
ifndef $(ZINIT_CMD)
	/bin/bash -c "$$(curl -fsSL https://git.io/zinit-install)"
endif
