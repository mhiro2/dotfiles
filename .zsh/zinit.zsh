##------------------------------
# Prompt and completion helpers

# Force the experimental async git prompt for a snappier prompt.
# ref: https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#async-git-prompt
zstyle ':omz:alpha:lib:git' async-prompt force

# Preload async helper so the git library finds _omz_register_handler.
zinit snippet OMZL::async_prompt.zsh

# Oh My Zsh git prompt integration.
zinit snippet OMZL::git.zsh

# Defer helper plugins; load them after initial prompt setup.
zinit ice wait lucid
zinit light-mode for \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  b4b4r07/zsh-vimode-visual

# Load history substring search eagerly because key bindings use it straight away.
zinit light 'zsh-users/zsh-history-substring-search'

# Additional completion definitions
zinit ice lucid nocd blockf
zinit light zsh-users/zsh-completions

# Ensure completion cache dir exists and add it to $fpath.
typeset -g ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.cache/omz}"
mkdir -p "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

zinit wait lucid for \
   OMZP::terraform/_terraform

#------------------------------
# CLI utilities

zinit ice lucid as"program" pick"bin/xpanes"
zinit light greymd/tmux-xpanes

zinit wait lucid from"gh-r" as"program" for \
  pick"*/csview" wfxr/csview \
  pick"*/tailspin" bensadeh/tailspin

zinit ice wait lucid as"program" make
zinit load Xfennec/progress
