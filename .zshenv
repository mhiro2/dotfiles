# ---------------------------------
# zsh environment file
# ---------------------------------
umask 0022

## LANG
export LANGUAGE='en_US.UTF-8'
export LANG=${LANGUAGE}
export LC_ALL=${LANGUAGE}

## EDITOR
export EDITOR=nvim

## PATH
typeset -U PATH path cdpath fpath manpath
setopt no_global_rcs

path=(
  ${HOME}/.local/bin(N-/)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

cdpath=(${HOME})

manpath=(
  /opt/homebrew/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
  {,/opt/homebrew,/usr/local,/usr}/sbin(N-/)
)

typeset -T LD_LIBRARY_PATH ld_library_path; typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path; typeset -U library_path
typeset -T CPATH cpath; typeset -U cpath

## XDG base directory
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

## Enable coloring
export CLICOLOR=1

# Settings for golang
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export PATH=${GOBIN}:${PATH}

# Settings for rust
export CARGO_HOME=${HOME}/.cargo
export PATH=${CARGO_HOME}/bin:${PATH}

## fzf
export FZF_DEFAULT_OPTS='--extended --ansi --multi'

## command history
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=${HISTSIZE}
if [[ $UID == 0 ]]; then
  unset HISTFILE
  export SAVEHIST=0
fi
