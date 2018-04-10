### Alias

# ---------------------------------------------------
# - If you want to ignore alias, enter below command.
#   In the case of vim ...
#     $ command vim
#     $ \vim
# ---------------------------------------------------

## Common aliases
alias df='df -h'
alias du='du -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias http-server='python -m SimpleHTTPServer'
alias lv='LC_ALL=ja_JP.UTF-8 lv -c'
alias mkdir='mkdir -p'
alias reboot='sudo reboot'
alias scp='scp -p'
alias sort='LC_ALL=C sort'
alias sudo='sudo '
alias uniq='LC_ALL=C uniq'
autoload -Uz zmv
alias zmv='noglob zmv -W'

## Optional aliases
type http >& /dev/null && alias https='http --default-scheme=https'
type htop >& /dev/null && alias top='htop'
type nvim >& /dev/null && alias vim='nvim'
type pget >& /dev/null && alias pget='pget -p6'

## Git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --oneline'
alias gp='git push'
alias gr='git reset'
alias gst='git status'

## Docker aliases
alias dce='docker container exec -it $(dps | peco | cut -d'"'"' '"'"' -f 1) /bin/bash'
alias dcea='docker container exec -it $(dps | peco | cut -d'"'"' '"'"' -f 1) /bin/ash'
alias dcl='docker container logs $(dps | peco | cut -d'"'"' '"'"' -f 1)'
alias dcrm='docker container rm $(dps | grep "Exited" | peco | cut -d'"'"' '"'"' -f 1)'
alias dcp='docker container prune'
alias dcs='docker container stop $(dps | grep -v "Exited" | peco | cut -d'"'"' '"'"' -f 1)'
alias dil='docker image ls'
alias dip='docker image prune'
alias dirm='docker image rm $(dil | peco | awk '"'"'{ print $3 }'"'"')'
alias dnl='docker network ls'
alias dnp='docker network prune'
alias dps='docker container ps -a'
alias dvl='docker volume ls'
alias dvp='docker volume prune'

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
type xsel >& /dev/null && alias -g X='| xsel -bi'
type yq >& /dev/null && alias -g J='| yq'

## Development
alias bi="bundle install --jobs=$(nproc) --path=vendor/bundle"
alias be='bundle exec'
alias pir='pip install -r requirements.txt'
alias tl='tmux ls'

## Architecture depends
if [[ "${OSTYPE}" == darwin* ]]; then
  alias la='ls -AFlhGp'
  alias ll='la'
  alias ls='ls -hFG'
  # coreutils
  if [ -d /usr/local/Cellar/coreutils ]; then
    alias cp='nocorrect gcp -i'
    alias mv='nocorrect gmv -i'
    alias rm='nocorrect grm -i'

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
  alias cp='nocorrect cp -i'
  alias mv='nocorrect mv -i'
  alias rm='nocorrect rm -i'
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

## Suffix aliases
alias -s zip=zipinfo
alias -s {tgz,gz}=gzcat
alias -s {tbz,bz2}=bzcat
alias -s {md,txt}=vim
alias -s {csv,json,xml,yaml,yml}=vim

