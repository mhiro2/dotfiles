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
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

cdpath=(${HOME})

manpath=(
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
  {,/usr/local,/usr}/sbin(N-/)
)

typeset -T LD_LIBRARY_PATH ld_library_path; typeset -U ld_library_path
typeset -T LIBRARY_PATH library_path; typeset -U library_path
typeset -T CPATH cpath; typeset -U cpath

## Enable coloring
export CLICOLOR=1

## ls command colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Settings for golang
export GOPATH=${HOME}/.go
export GOBIN=${GOPATH}/bin
export PATH=${GOBIN}:${PATH}

## XDG base directory
export XDG_CONFIG_HOME=${HOME}/.config

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

# anyenv
[[ -s ${HOME}/.zsh/profile.d/anyenv.sh ]] && source ${HOME}/.zsh/profile.d/anyenv.sh

# linuxbrew
export LINUXBREW_ROOT=${HOME}/.linuxbrew
if [ -d "${LINUXBREW_ROOT}" ]; then
  export PATH=${LINUXBREW_ROOT}/bin:$PATH
  export MANPATH=${LINUXBREW_ROOT}/share/man:$MANPATH
  export INFOPATH=${LINUXBREW_ROOT}/share/info:$INFOPATH
fi
