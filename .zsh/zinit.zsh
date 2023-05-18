##------------------------------
# zsh plugins

# git prompt
zinit snippet OMZL::git.zsh

# Syntax highlighting.
zinit light 'zdharma-continuum/fast-syntax-highlighting'

# History search.
zinit light 'zsh-users/zsh-history-substring-search'

# Fish-like fast/unobtrusive autosuggestions.
zinit light 'zsh-users/zsh-autosuggestions'

# Visual mode for vi-mode.
zinit light 'b4b4r07/zsh-vimode-visual'

# Display current k8s context and namespace.
zinit light "superbrothers/zsh-kubectl-prompt"

# Lazy load packages.
zinit wait lucid for \
  OMZP::docker-compose/_docker-compose \
  OMZP::gcloud \
  OMZP::helm \
  OMZP::kubectl \
  OMZP::terraform/_terraform

# Completions.
zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions

#------------------------------
# Useful commands

# anyframe
zinit light mollifier/anyframe

# bat
zinit ice from"gh-r" as"program" pick"*/bat"
zinit load sharkdp/bat

# csview
zinit ice from"gh-r" as"program" pick"*/csview"
zinit load wfxr/csview

# delta
zinit ice from"gh-r" as"program" pick"*/delta"
zinit load dandavison/delta

# dive
zinit ice from"gh-r" as"program"
zinit load wagoodman/dive

# fd
zinit ice from"gh-r" as"program" pick"*/fd"
zinit load sharkdp/fd

# fzf
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# ghq
zinit ice from"gh-r" as"program" pick"*/ghq"
zinit load x-motemen/ghq

# gojq
zinit ice from"gh-r" as"program" pick"*/gojq"
zinit load itchyny/gojq

# grex
zinit ice from"gh-r" as"program" pick"*/grex"
zinit load pemistahl/grex

# killport
zinit ice from"gh-r" as"program" pick"*/killport"
zinit load jkfran/killport

# lsd
zinit ice from"gh-r" as"program" pick"*/lsd"
zinit load lsd-rs/lsd

# peco
zinit ice from"gh-r" as"program" pick"*/peco"
zinit load peco/peco

# progress
zinit ice as"program" make
zinit light Xfennec/progress

# ripgrep
zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

# tmux-xpanes
zinit light greymd/tmux-xpanes

# tv
zinit ice from"gh-r" as"program" pick"*/tv"
zinit load uzimaru0000/tv

# xxh
zinit ice from"gh-r" as"program" pick"*/xxh"
zinit load xxh/xxh
