# local loading
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

##------------------------------
# zsh plugins

# git prompt
zplug 'lib/git', from:oh-my-zsh

# Syntax highlighting.
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# History search.
zplug 'zsh-users/zsh-history-substring-search'

# Completions.
zplug 'zsh-users/zsh-completions', use:'src/_*', lazy:true

# Visual mode for vi-mode.
zplug 'b4b4r07/zsh-vimode-visual', defer:3

##------------------------------
# Useful commands

# anyframe
zplug 'mollifier/anyframe'

# checksec.sh
zplug 'slimm609/checksec.sh', \
  as:command, \
  use:'checksec'

# fzf
zplug 'junegunn/fzf-bin', \
  as:command, \
  from:gh-r, \
  rename-to:fzf

# ghq
zplug 'motemen/ghq', \
  as:command, \
  from:gh-r

# jq
zplug 'stedolan/jq', \
  as:command, \
  from:gh-r

# lstf
zplug 'yuuki/lstf', \
  as:command, \
  from:gh-r

# peco
zplug 'peco/peco', \
  as:command, \
  from:gh-r

# pget
zplug 'Code-Hex/pget', \
  as:command, \
  from:gh-r

# pt
zplug 'monochromegane/the_platinum_searcher', \
  as:command, \
  from:gh-r, \
  rename-to:pt

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

