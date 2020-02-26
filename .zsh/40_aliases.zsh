### Alias

# ---------------------------------------------------
# - If you want to ignore alias, enter below command.
#   In the case of vim ...
#     $ command vim
#     $ \vim
# ---------------------------------------------------

function peco-ssh {
  local host=$(grep '^Host' ~/.ssh/config | awk '{ print $2 }' | peco --prompt '[ssh]')
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
alias http-server='python -m SimpleHTTPServer'
alias lv='LC_ALL=ja_JP.UTF-8 lv -c'
alias mkdir='mkdir -p'
alias pk='anyframe-widget-kill'
alias pssh='peco-ssh'
alias reboot='sudo reboot'
alias scp='scp -p'
alias sort='LC_ALL=C sort'
alias sudo='sudo '
alias ta='anyframe-widget-tmux-attach'
alias tl='tmux ls'
alias uniq='LC_ALL=C uniq'
autoload -Uz zmv
alias zmv='noglob zmv -W'

## Optional aliases
type http >& /dev/null && alias https='http --default-scheme=https'
type htop >& /dev/null && alias top='htop'
type nvim >& /dev/null && alias vim='nvim'
type pget >& /dev/null && alias pget='pget -p6'
type xpanes >& /dev/null && alias xp='xpanes'

## Git aliases
alias g='git'
alias ga='git add'
alias gaa='anyframe-widget-git-add'
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
alias dce='docker container exec -it $(dcls | peco --prompt "[exec /bin/bash]" | cut -d'"'"' '"'"' -f 1) /bin/bash'
alias dcea='docker container exec -it $(dcls | peco --prompt "[exec /bin/ash]" | cut -d'"'"' '"'"' -f 1) /bin/ash'
alias dcl='docker container logs $(dcla | peco --prompt "[logs]" | cut -d'"'"' '"'"' -f 1)'
alias dclf='docker container logs -f $(dcls | peco --prompt "[logs]" | cut -d'"'"' '"'"' -f 1)'
alias dcla='docker container ls -a'
alias dcls='docker container ls'
alias dcp='docker container prune'
alias dcrm='docker container rm $(dcla | grep "Exited" | peco --prompt "[rm]" | cut -d'"'"' '"'"' -f 1)'
alias dcs='docker container stop $(dcls | peco --prompt "[stop]" | cut -d'"'"' '"'"' -f 1)'
alias dib='DOCKER_BUILDKIT=1 docker image build'
alias dils='docker image ls'
alias dip='docker image prune'
alias dirm='docker image rm $(dils | peco --prompt "[rm]" | awk '"'"'{ print $3 }'"'"')'
alias dnls='docker network ls'
alias dnp='docker network prune'
alias dvls='docker volume ls'
alias dvp='docker volume prune'

## kubernetes aliases
function kon {
  save_aliases=$(alias -L)
  source ~/.zsh/lib/.kubectl_aliases
  #source <(kubectl completion zsh)
}

function koff {
  unalias -m '*'
  eval ${save_aliases}
  unset save_aliases
}

alias kns='kubens'
alias kcx='kubectx'

## Global aliases.
alias -g A='| awk'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| lv'
alias -g S='| sed'
alias -g T='| tail'
alias -g W='| wc'
alias -g X='| xargs'
type jq >& /dev/null && alias -g J='| jq'
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
  if [ -d /usr/local/Cellar/coreutils ]; then
    alias cp='gcp -i'
    alias mv='gmv -i'
    alias rm='grm -i'

    alias make="make -j$(gnproc)"
    alias nproc='gnproc'
    alias shuf='gshuf'
  fi
  # findutils
  if [ -d /usr/local/Cellar/findutils ]; then
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
  alias make="make -j$(nproc)"

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

  type sway >& /dev/null && alias sway='XKB_DEFAULT_OPTIONS=ctrl:nocaps sway'
fi

## Development
alias bi="bundle install --jobs=$(nproc) --path=vendor/bundle"
alias be='bundle exec'

## Suffix aliases
alias -s zip=zipinfo
alias -s {tgz,gz}=gzcat
alias -s {tbz,bz2}=bzcat
alias -s {md,txt}=vim
alias -s {csv,json,xml,yaml,yml}=vim
