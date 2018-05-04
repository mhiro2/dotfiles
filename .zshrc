# ---------------------------------
# zsh configuration file
# ---------------------------------

limit coredumpsize 0

autoload -Uz compinit &&  compinit -u
autoload -Uz colors && colors
autoload -Uz add-zsh-hock
autoload -Uz is-at-latest

# Load plugins.
if [[ -f ${HOME}/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=${HOME}/.zsh/zplug.zsh
    source ${HOME}/.zplug/init.zsh

    zplug load
fi

# Load config files.
for f in ${HOME}/.zsh/[0-9]*.(sh|zsh)
do
    source "${f}"
done
