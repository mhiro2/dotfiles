### Alias

# Common aliases
alias lv='LC_ALL=ja_JP.UTF-8 lv -c'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mkdir='mkdir -p'
alias reboot='sudo reboot'
alias scp='scp -p'
alias sort='LC_ALL=C sort'
alias uniq='LC_ALL=C uniq'
autoload -Uz zmv
alias zmv='noglob zmv -W'
which pget >& /dev/null && alias pget='pget -p6'

# Global aliases.
alias -g A='| awk'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| lv'
alias -g S='| sed'
alias -g T='| tail'
alias -g W='| wc'
alias -g X='| xargs'
which pv >& /dev/null && alias -g P='| pv'

# Parallel compression and decompression.
# which pigz >& /dev/null && alias gzip='pigz -v'
# which unpigz >& /dev/null && alias gunzip='unpigz'
# which lbzip2 >& /dev/null && alias bzip2='lbzip2 -v' && alias bunzip2='lbzip2 -d'
# which pixz >& /dev/null && alias xz='pixz' && alias unxz='pixz -d'

# Git aliases.
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gp='git push'
alias gr='git remote'
alias grv='git revert'
alias gst='git status'

if [[ "${OSTYPE}" == darwin* ]]; then
  alias la='ls -AFlhGp'
  alias ls='ls -hFG'
  which nvim >& /dev/null && alias vi='nvim' && alias vim='nvim'
  # coreutils
  if [ -d /usr/local/Cellar/coreutils ]; then
    alias mv='nocorrect gmv -i'
    alias cp='nocorrect gcp -i'
    alias nproc='gnproc'
    alias make="make -j$(nproc)"
    alias shuf='gshuf'
  fi
  # findutils
  if [ -d /usr/local/Cellar/findutils ]; then
    alias find='gfind'
    alias xargs='gxargs'
  fi
elif [[ "${OSTYPE}" == linux* ]]; then
  which nvim >& /dev/null && alias vim='nvim'
  alias la='ls -aFhl --color'
  alias tl='tmux ls'
  alias make="make -j$(nproc)"
  alias mv='nocorrect mv -i'
  alias cp='nocorrect cp -i'
  alias firewall-cmd='sudo firewall-cmd'
  alias systemctl='sudo systemctl'
  alias virsh='sudo virsh'
  alias zfs='sudo zfs'
  alias zpool='sudo zpool'
fi

# Suffix aliases
alias -s zip=zipinfo
alias -s {tgz,gz}=gzcat
alias -s {tbz,bz2}=bzcat
alias -s txt=vim
alias -s {csv,json,xml,yaml,yml}=vim

### }}}
