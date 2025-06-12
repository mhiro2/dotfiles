##------------------------------
# zsh plugins

# Disable async git prompt in oh-my-zsh to avoid the error.
# ref: https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#disable-async-git-prompt
zstyle ':omz:alpha:lib:git' async-prompt no

# Git prompt.
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

zinit ice from"gh-r" as"program" pick"*/bat"
zinit load sharkdp/bat

zinit ice from"gh-r" as"program" pick"*/fd"
zinit load sharkdp/fd

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice from"gh-r" as"program" pick"*/ghq"
zinit load x-motemen/ghq

zinit ice from"gh-r" as"program" pick"*/lsd"
zinit load lsd-rs/lsd

zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

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

zinit wait lucid for \
  as"program" make Xfennec/progress \
