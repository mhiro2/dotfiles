# ---------------------------------
# zsh configuration file
# ---------------------------------

limit coredumpsize 0

autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz is-at-latest

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Load plugins with zinit.
if [[ -d "${ZINIT_HOME}" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

  source "${HOME}/.zsh/zinit.zsh"
fi

# Activate mise
eval "$(mise activate zsh)"

# Load config files.
for f in ${HOME}/.zsh/[0-9]*.(sh|zsh)
do
  source "${f}"
done
