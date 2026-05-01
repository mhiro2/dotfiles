# ---------------------------------
# zsh environment file
# ---------------------------------
umask 0022

## LANG
export LANGUAGE='en_US.UTF-8'
export LANG=${LANGUAGE}

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
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

## Enable coloring
export CLICOLOR=1

## User-installed binaries land in ~/.local/bin (already on PATH)
export GOBIN=${HOME}/.local/bin
export CARGO_INSTALL_ROOT=${HOME}/.local

## fzf
export FZF_DEFAULT_OPTS='--extended --ansi --multi --height=80% --layout=reverse --border'
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=numbers --line-range=:200 {} 2>/dev/null || cat {}"'
export FZF_CTRL_R_OPTS='--bind="ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort"'

## command history
[[ -d ${XDG_STATE_HOME}/zsh ]] || mkdir -p ${XDG_STATE_HOME}/zsh
HISTFILE=${XDG_STATE_HOME}/zsh/history
HISTSIZE=100000
SAVEHIST=${HISTSIZE}
if [[ $UID == 0 ]]; then
  unset HISTFILE
  export SAVEHIST=0
fi
