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

## ls command colors
if command -v vivid >/dev/null 2>&1; then
  vivid_cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/vivid"
  vivid_theme_cache="${vivid_cache_dir}/molokai.lscolors"
  if [[ -f "${vivid_theme_cache}" ]]; then
    export LS_COLORS="$(<"${vivid_theme_cache}")"
  elif mkdir -p "${vivid_cache_dir}" 2>/dev/null \
       && vivid generate molokai >| "${vivid_theme_cache}" 2>/dev/null; then
    export LS_COLORS="$(<"${vivid_theme_cache}")"
  else
    export LS_COLORS="$(vivid generate molokai)"
  fi
fi

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
