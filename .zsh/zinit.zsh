##------------------------------
# zsh plugins

# git prompt
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/git.zsh
zinit snippet OMZL::git.zsh

# Syntax highlighting.
zinit light 'zdharma/fast-syntax-highlighting'

# History search.
zinit light 'zsh-users/zsh-history-substring-search'

# Fish-like fast/unobtrusive autosuggestions.
zinit light 'zsh-users/zsh-autosuggestions'

# Visual mode for vi-mode.
zinit light 'b4b4r07/zsh-vimode-visual'

# Display current k8s context and namespace.
zinit light "superbrothers/zsh-kubectl-prompt"

# Completions.
zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice as"completion"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker-compose/_docker-compose

zinit ice as"completion"
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/terraform/_terraform

zinit ice blockf if'[[ "$OSTYPE" = *darwin* ]]'
zinit snippet $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

#------------------------------
# Useful commands

# anyframe
zinit light mollifier/anyframe

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

# ko
zinit ice from"gh-r" as"program" pick"*/ko"
zinit load google/ko

# kubecolor
zinit ice from"gh-r" as"program" pick"*/kubecolor"
zinit load dty1er/kubecolor

# logo-ls
zinit ice from"gh-r" as"program" pick"*/logo-ls"
zinit load Yash-Handa/logo-ls

# lstf
zinit ice if'[[ "$OSTYPE" = linux* ]]' from"gh-r" as"program" pick"*/lstf"
zinit load yuuki/lstf

# peco
zinit ice from"gh-r" as"program" pick"*/peco"
zinit load peco/peco

# # pget
zinit ice from"gh-r" as"program" pick"*/pget"
zinit load Code-Hex/pget

# progress
zinit ice as"program" make
zinit light Xfennec/progress

# pt
zinit ice from"gh-r" as"program" pick"*/pt"
zinit load monochromegane/the_platinum_searcher

# ripgrep
zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

# tmux-xpanes
zinit light greymd/tmux-xpanes
