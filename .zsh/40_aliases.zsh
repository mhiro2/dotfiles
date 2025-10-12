### Alias

# ---------------------------------------------------
# - If you want to ignore alias, enter below command.
#   In the case of vim ...
#     $ command vim
#     $ \vim
# ---------------------------------------------------

function fzf-ssh-alias {
  local host=$(grep '^Host' ~/.ssh/config | awk '{ print $2 }' | fzf --prompt 'ssh> ' --height=40% --layout=reverse)
  if [ -n "${host}" ]; then
    echo "ssh ${host}"
    \ssh ${host}
  fi
}

## Common aliases
alias df='df -h'
alias du='du -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias history='history -i'
alias hist='history'
alias http-server='python -m http.server'
alias mkdir='mkdir -p'
alias pk='fzf-kill'
alias pssh='fzf-ssh-alias'
alias reboot='sudo reboot'
alias scp='scp -p'
alias sort='LC_ALL=C sort'
alias sudo='sudo '
alias ta='fzf-tmux-attach'
alias tl='tmux ls'
alias uniq='LC_ALL=C uniq'
autoload -Uz zmv
alias zmv='noglob zmv -W'

## Optional aliases
type bat >& /dev/null && alias cat='bat -pp' && \
                         alias lv='bat -p' && \
                         alias lvv='bat --paging=always' && \
                         alias less='bat --paging=always'
type gojq >& /dev/null && alias jq='gojq'
type http >& /dev/null && alias https='http --default-scheme=https'
type nvim >& /dev/null && alias vim='nvim'
type viddy >& /dev/null && alias watch='viddy'
type xpanes >& /dev/null && alias xp='xpanes'

## Git aliases
alias g='git'
alias ga='git add'
alias gaa='fzf-git-add'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --pretty=oneline'
alias gm='git merge'
alias gp='git push'
alias gr='git reset'
alias grb='git rebase'
alias gst='git status'
alias gss='git status -s'
alias gsh='git show'
alias gt='git tag'

## Docker aliases
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

_docker_fzf_select_container() {
  local prompt="$1"; shift
  local selection
  selection=$(docker container "$@" | awk 'NR==1 {next} {print}' | fzf --prompt "${prompt}> " --height=40% --layout=reverse)
  [[ -n "${selection}" ]] || return 1
  printf '%s\n' "${selection}" | awk '{print $1}'
}

_docker_fzf_select_containers_multi() {
  local prompt="$1"; shift
  local selection
  selection=$(docker container "$@" | awk 'NR==1 {next} {print}' | fzf --prompt "${prompt}> " --height=40% --layout=reverse --multi)
  [[ -n "${selection}" ]] || return 1
  printf '%s\n' "${selection}" | awk '{print $1}'
}

_docker_fzf_select_images_multi() {
  local prompt="$1"; shift
  local selection
  selection=$(docker image "$@" | awk 'NR==1 {next} {print}' | fzf --prompt "${prompt}> " --height=40% --layout=reverse --multi)
  [[ -n "${selection}" ]] || return 1
  printf '%s\n' "${selection}" | awk '{print $3}'
}

dce() {
  local container
  container=$(_docker_fzf_select_container "exec" ls) || return 1
  docker container exec -it "${container}" /bin/bash
}

dcl() {
  local container
  container=$(_docker_fzf_select_container "logs" ls -a) || return 1
  docker container logs "${container}"
}

dclf() {
  local container
  container=$(_docker_fzf_select_container "logs" ls) || return 1
  docker container logs -f "${container}"
}

dcrm() {
  local selection
  local -a containers
  selection=$(_docker_fzf_select_containers_multi "rm" ls -a --filter status=exited) || return 1
  containers=(${(f)selection})
  (( ${#containers[@]} )) || return 1
  docker container rm "${containers[@]}"
}

dcs() {
  local selection
  local -a containers
  selection=$(_docker_fzf_select_containers_multi "stop" ls) || return 1
  containers=(${(f)selection})
  (( ${#containers[@]} )) || return 1
  docker container stop "${containers[@]}"
}

dirm() {
  local selection
  local -a images
  selection=$(_docker_fzf_select_images_multi "rm" ls) || return 1
  images=(${(f)selection})
  (( ${#images[@]} )) || return 1
  docker image rm "${images[@]}"
}

alias k='kubectl'
alias krew='kubectl krew'
alias kns='kubectl ns'
alias kcx='kubectl ctx'
alias st='stern'

## Google Cloud
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'

## Global aliases.
alias -g A='| awk'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| lv'
alias -g S='| sed'
alias -g T='| tail'
alias -g W='| wc'
alias -g X='| xargs'
type gojq >& /dev/null && alias -g J='| gojq'
type pv >& /dev/null && alias -g P='| pv'
type rg >& /dev/null && alias -g R='| rg'
#type xsel >& /dev/null && alias -g X='| xsel -bi'
type yq >& /dev/null && alias -g Y='| yq'

## Architecture depends
if [[ "${OSTYPE}" == darwin* ]]; then
  alias la='ls -AFlhGp'
  alias ll='la'
  alias ls='ls -hFG'
  # coreutils
  if [ -d /usr/local/Cellar/coreutils ] || [ -d /opt/homebrew/Cellar/coreutils ]; then
    alias cp='gcp -i'
    alias mv='gmv -i'
    alias rm='grm -i'
    alias nproc='gnproc'
    alias shuf='gshuf'
  fi
  # findutils
  if [ -d /usr/local/Cellar/findutils ] || [ -d /opt/homebrew/Cellar/findutils ]; then
    alias find='gfind'
    alias xargs='gxargs'
  fi
elif [[ "${OSTYPE}" == linux* ]]; then
  alias cp='cp -i'
  alias mv='mv -i'
  alias rm='rm -i'
  alias la='ls -aFhl --color'
  alias ll='ls -Fhl --color'
  alias ls='ls --color'

  type xdg-open >& /dev/null && alias open='xdg-open'
  type xsel >& /dev/null && alias pbcopy='xsel -bi' \
                         && alias pbpaste='xsel -bo'

  alias firewall-cmd='sudo firewall-cmd'
  alias fw='firewall-cmd'
  alias fwl='fw --list-all'
  alias fwr='fw --reload'

  alias journalctl='sudo journalctl'
  alias jcl='journalctl'
  alias systemctl='sudo systemctl'
  alias scl='systemctl'

  alias zfs='sudo zfs'
  alias zpool='sudo zpool'
fi

## Overwrite ls aliases with lsd
type lsd >& /dev/null && alias la='lsd -lah' \
                      && alias ll='lsd -lh' \
                      && alias ls='lsd'

## Suffix aliases
alias -s zip=zipinfo
alias -s {tgz,gz}=gzcat
alias -s {tbz,bz2}=bzcat
alias -s {md,txt}=vim
alias -s csv=csview
alias -s {json,xml,yaml,yml}=bat
