set -x fish_greeting ""

## LANG
set -x LC_ALL en_US.UTF-8

## PATH
set -U fish_user_paths /usr/local/bin

fish_vi_key_bindings

function fish_mode_prompt
end

set -x EDITOR nvim
set -x PAGER lv

set fish_color_command green bold

## golang
set -x GOPATH $HOME/.go
set -x GOBIN $GOPATH/bin
set -x fish_user_paths $GOBIN $fish_user_paths

## anyenv
#set -gx ANYENV_ROOT /usr/local/anyenv
#if test -d $ANYENV_ROOT
#  set -x fish_user_paths /usr/local/anyenv/bin $fish_user_paths
#  eval (anyenv init - --no-rehash fish)
#end

## fundle
# https://github.com/tuvistavie/fundle
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'tuvistavie/fundle' --path 'completions'
fundle plugin 'oh-my-fish/plugin-peco'
fundle init
