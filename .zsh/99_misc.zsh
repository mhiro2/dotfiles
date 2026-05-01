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

# git-wt
eval "$(git wt --init zsh)"
