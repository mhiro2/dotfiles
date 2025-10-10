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
    zsh-set-terminal-title() {
      printf "\e]0;%s@%s:%s\x7" "${USER}" "${HOST%%.*}" "${PWD}"
    }
    add-zsh-hook precmd zsh-set-terminal-title
    ;;
esac

# cursor for vi-mode
function zle-keymap-select zle-line-init zle-line-finish {
  case ${KEYMAP} in
    vicmd)
      printf "\e[2 q"  # block cursor
      ;;
    viins|main)
      printf "\e[6 q"  # bar cursor
      ;;
    vivis|vivli)
      printf "\e[2 q"  # block cursor
      ;;
  esac
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
