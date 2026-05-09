### Alias

# ---------------------------------------------------
# - If you want to ignore alias, enter below command.
#   In the case of vim ...
#     $ command vim
#     $ \vim
# ---------------------------------------------------

# CLI wrappers for fzf widgets that are otherwise registered with `zle -N`
# in 45_fzf_widgets.zsh. Calling those widgets directly from the command line
# would error because they manipulate LBUFFER / call `zle accept-line` etc.
fzf-tmux-attach-cli() {
  local session
  session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null \
    | fzf --prompt='tmux> ' --height=40% --layout=reverse)
  [[ -n "${session}" ]] && tmux attach-session -t "${session}"
}

fzf-git-add-cli() {
  local files
  files=$(git status --porcelain \
    | fzf --prompt='add> ' --height=40% --layout=reverse --multi \
    | awk '{print $2}')
  [[ -n "${files}" ]] && print -r -- "${files}" | xargs git add
}

## Common aliases
alias df='df -h'
alias du='du -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias history='history -i'
alias http-server='python3 -m http.server'
alias mkdir='mkdir -p'
alias pk='fzf-kill'
alias pssh='fzf-ssh'
alias reboot='sudo reboot'
alias scp='rsync -avhP'
alias sort='LC_ALL=C sort'
alias sudo='sudo '
alias ta='fzf-tmux-attach-cli'
alias tl='tmux ls'
alias uniq='LC_ALL=C uniq'
alias zmv='noglob zmv -W'

## Optional aliases
if (( ${+commands[bat]} )); then
  alias cat='bat -pp'
  alias lv='bat -p'
fi
(( ${+commands[moor]} )) && alias lvv='moor'
(( ${+commands[gojq]} ))   && alias jq='gojq'
(( ${+commands[gitui]} ))  && alias gui='gitui'
(( ${+commands[nvim]} ))   && alias vim='nvim'
(( ${+commands[xpanes]} )) && alias xp='xpanes'

## Git aliases
alias g='git'
alias ga='git add'
alias gaa='fzf-git-add-cli'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --oneline --graph --decorate'
alias gm='git merge'
alias gp='git push'
alias gr='git reset'
alias grb='git rebase'
alias gst='git status'
alias gss='git status -s'
alias gsh='git show'
alias gt='git tag'

## Docker aliases
# fzf-driven helpers (dce, dcl, dclf, dcrm, dcs, dirm) live in 65_docker.zsh.
alias dcla='docker container ls -a'
alias dcls='docker container ls'
alias dcp='docker container prune'
alias dib='DOCKER_BUILDKIT=1 docker image build'
alias dils='docker image ls'
alias dip='docker image prune'
alias dnls='docker network ls'
alias dnp='docker network prune'
alias dvls='docker volume ls'
alias dvp='docker volume prune'

## Kubernetes
alias k='kubectl'
alias krew='kubectl krew'
alias kns='kubectl ns'
alias kcx='kubectl ctx'
alias st='stern'

## Google Cloud
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'

## Global aliases
alias -g A='| awk'
alias -g G='| grep'
alias -g H='| head'
alias -g S='| sed'
alias -g T='| tail'
alias -g W='| wc'
alias -g X='| xargs'
if (( ${+commands[bat]} )); then
  alias -g L='| bat --paging=always'
else
  alias -g L='| ${PAGER:-less}'
fi
(( ${+commands[gojq]} )) && alias -g J='| gojq'
(( ${+commands[rg]} ))   && alias -g R='| rg'
(( ${+commands[yq]} ))   && alias -g Y='| yq'

## ls family
# Prefer lsd; otherwise fall back to BSD/GNU ls based on OS.
if (( ${+commands[lsd]} )); then
  alias ls='lsd'
  alias la='lsd -lah'
  alias ll='lsd -lh'
elif [[ "${OSTYPE}" == darwin* ]]; then
  alias ls='ls -hFG'
  alias la='ls -AFlhGp'
  alias ll='ls -AFlhGp'
elif [[ "${OSTYPE}" == linux* ]]; then
  alias ls='ls --color'
  alias la='ls -aFhl --color'
  alias ll='ls -Fhl --color'
fi

## OS-specific (non-ls) aliases
if [[ "${OSTYPE}" == darwin* ]]; then
  # coreutils
  if (( ${+commands[gcp]} )); then
    alias cp='gcp -i'
    alias mv='gmv -i'
    alias rm='grm -I'
    alias nproc='gnproc'
    alias shuf='gshuf'
  fi
  # findutils
  if (( ${+commands[gfind]} )); then
    alias find='gfind'
    alias xargs='gxargs'
  fi
elif [[ "${OSTYPE}" == linux* ]]; then
  alias cp='cp -i'
  alias mv='mv -i'
  alias rm='rm -I'

  (( ${+commands[xdg-open]} )) && alias open='xdg-open'
  if (( ${+commands[xsel]} )); then
    alias pbcopy='xsel -bi'
    alias pbpaste='xsel -bo'
  fi

  alias journalctl='sudo journalctl'
  alias jcl='journalctl'
  alias systemctl='sudo systemctl'
  alias scl='systemctl'
fi

## Suffix aliases
alias -s zip=zipinfo
if (( ${+commands[gzcat]} )); then
  alias -s {tgz,gz}=gzcat
elif (( ${+commands[zcat]} )); then
  alias -s {tgz,gz}=zcat
fi
alias -s {tbz,bz2}=bzcat
alias -s {md,txt}=vim
alias -s {json,xml,yaml,yml}=bat
