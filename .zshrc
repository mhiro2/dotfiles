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

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        else
            echo
        fi
    fi
    #zplug load --verbose
    zplug load
fi

# Load config files.
for f in ${HOME}/.zsh/[0-9]*.(sh|zsh)
do
    source "${f}"
done
