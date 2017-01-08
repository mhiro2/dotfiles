### misc

autoload -Uz chpwd_recent_dirs cdr
autoload -Uz zmv
autoload -Uz zcalc

# for cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ":completion:*" recent-dirs-insert always
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default true
zstyle ":chpwd:*" recent-dirs-pushd true

# Terminal title.
case "${TERM}" in
  rxvt*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

## Change cursor shape to indicate vi-mode.
#function zle-keymap-select zle-line-init {
#  # change cursor shape in iTerm2
#  case ${KEYMAP} in
#    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
#    viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
#  esac
#
#  zle reset-prompt
#  zle -R
#}
#
#function zle-line-finish {
#  print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
#}
#zle -N zle-line-init
#zle -N zle-line-finish
#zle -N zle-keymap-select
