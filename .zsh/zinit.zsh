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

# Additional completion definitions.
zinit ice lucid nocd atload"zicompinit; zicdreplay" blockf
zinit light zsh-users/zsh-completions

# Ensure completion cache dir exists and add it to $fpath.
typeset -g ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.cache/omz}"
mkdir -p "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

zinit wait lucid for \
   OMZP::docker \
   OMZP::kubectl \
   OMZP::terraform/_terraform

#------------------------------
# CLI utilities

zinit ice lucid from"gh-r" as"program" pick"*/bat"
zinit load sharkdp/bat

zinit ice wait lucid from"gh-r" as"program" pick"*/fd"
zinit load sharkdp/fd

zinit ice wait lucid from"gh-r" as"program"
zinit load junegunn/fzf

zinit ice wait lucid from"gh-r" as"program" pick"*/ghq"
zinit load x-motemen/ghq

zinit ice lucid from"gh-r" as"program" pick"*/lsd"
zinit load lsd-rs/lsd

zinit ice lucid from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit load BurntSushi/ripgrep

zinit ice lucid as"program" pick"bin/xpanes"
zinit light greymd/tmux-xpanes

zinit wait lucid from"gh-r" as"program" for \
  pick"*/csview" wfxr/csview \
  pick"*/delta" dandavison/delta \
  wagoodman/dive \
  pick"*/gojq" itchyny/gojq \
  pick"*/grex" pemistahl/grex \
  pick"*/jnv" ynqa/jnv \
  pick"*/killport" jkfran/killport \
  pick"*/tailspin" bensadeh/tailspin \
  pick"*/viddy" sachaos/viddy \
  pick"*/xxh" xxh/xxh

zinit ice wait lucid as"program" make
zinit load Xfennec/progress
