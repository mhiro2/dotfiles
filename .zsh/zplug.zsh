# local loading
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

##------------------------------
# zsh plugins

# git prompt
zplug 'lib/git', from:oh-my-zsh

# Syntax highlighting.
#zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zdharma/fast-syntax-highlighting', defer:2

# History search.
zplug 'zsh-users/zsh-history-substring-search'

# Fish-like fast/unobtrusive autosuggestions.
zplug 'zsh-users/zsh-autosuggestions', defer:2

# Completions.
zplug 'zsh-users/zsh-completions', use:'src/_*', lazy:true
zplug 'plugins/terraform', from:oh-my-zsh, lazy:true

# for osx completions. (install only cask's "docker")
zplug 'plugins/docker', from:oh-my-zsh, lazy:true, if:"[[ $OSTYPE == darwin* ]]"
zplug 'plugins/docker-compose', from:oh-my-zsh, lazy:true,  if:"[[ $OSTYPE == darwin* ]]"

# Visual mode for vi-mode.
zplug 'b4b4r07/zsh-vimode-visual', defer:3

# Display current k8s context and namespace.
zplug "superbrothers/zsh-kubectl-prompt", defer:2

##------------------------------
# Useful commands

# anyframe
zplug 'mollifier/anyframe'

# checksec.sh
zplug 'slimm609/checksec.sh', \
  as:command, \
  use:'checksec'

# delta
zplug 'dandavison/delta', \
  as:command, \
  from:gh-r, \
  rename-to:delta

# dive
zplug 'wagoodman/dive', \
  as:command, \
  from:gh-r

# fd
zplug 'sharkdp/fd', \
  as:command, \
  from:gh-r, \
  rename-to:fd

# fzf
zplug 'junegunn/fzf-bin', \
  as:command, \
  from:gh-r, \
  rename-to:fzf

# ghq
zplug 'x-motemen/ghq', \
  as:command, \
  from:gh-r

# jq
zplug 'stedolan/jq', \
  as:command, \
  from:gh-r

# lstf
zplug 'yuuki/lstf', \
  as:command, \
  from:gh-r, \
  if:"[[ $OSTYPE == linux* ]]"

# peco
zplug 'peco/peco', \
  as:command, \
  from:gh-r

# pget
zplug 'Code-Hex/pget', \
  as:command, \
  from:gh-r

# progress
zplug 'Xfennec/progress', \
  as:command, \
  hook-build:'make', \
  rename-to:pg

# pt
zplug 'monochromegane/the_platinum_searcher', \
  as:command, \
  from:gh-r, \
  rename-to:pt

# rb
zplug 'thisredone/rb', \
  as:command, \
  use:'rb'

# ripgrep
zplug 'BurntSushi/ripgrep', \
  as:command, \
  from:gh-r, \
  rename-to:rg

# tmux-xpanes
zplug 'greymd/tmux-xpanes'

##------------------------------
# other

# gdb-peda
zplug 'longld/peda'
