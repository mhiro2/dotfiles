# ---------------------------------
# zsh configuration file
# ---------------------------------

limit coredumpsize 0

autoload -Uz compinit &&  compinit -u
autoload -Uz colors && colors
autoload -Uz add-zsh-hock
autoload -Uz is-at-latest

# Load plugins with zinit.
if [[ -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  source "${HOME}/.zinit/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

  source "${HOME}/.zsh/zinit.zsh"
fi

# Load config files.
for f in ${HOME}/.zsh/[0-9]*.(sh|zsh)
do
  source "${f}"
done
