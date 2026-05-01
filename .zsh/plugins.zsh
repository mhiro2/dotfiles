##------------------------------
# Plugin bootstrap via antidote
# https://getantidote.github.io/

# Force the experimental async git prompt for a snappier prompt.
# ref: https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#async-git-prompt
zstyle ':omz:alpha:lib:git' async-prompt force

# Ensure completion cache dir exists and add it to $fpath
# (the OMZ git library writes its async cache here).
typeset -g ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${XDG_CACHE_HOME}/omz}"
mkdir -p "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# Use `jj` as the insert-mode escape sequence (consumed by jeffreytse/zsh-vi-mode).
ZVM_VI_INSERT_ESCAPE_BINDKEY='jj'
# Always start each new prompt in insert mode (default would inherit the last mode).
ZVM_LINE_INIT_MODE='i'

ANTIDOTE_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/antidote"

if [[ -e "${ANTIDOTE_HOME}/antidote.zsh" ]]; then
  source "${ANTIDOTE_HOME}/antidote.zsh"
  antidote load "${HOME}/.zsh/.zsh_plugins.txt"
fi
