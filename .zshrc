# ---------------------------------
# zsh configuration file
# ---------------------------------

limit coredumpsize 0

autoload -Uz colors && colors
autoload -Uz add-zsh-hook
autoload -Uz is-at-latest

# Load plugins via antidote.
source "${HOME}/.zsh/plugins.zsh"

# Activate mise
eval "$(mise activate zsh)"

# Load config files.
for f in ${HOME}/.zsh/[0-9]*.(sh|zsh)
do
  source "${f}"
done
