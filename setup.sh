#!/usr/bin/env bash

set -eu

cd $(dirname $0)

git submodule init
git submodule update

readonly ARCH_XDG_CONFIGS=(compton i3 sway terminator)
readonly COMMON_XDG_CONFIGS=(fish git nvim peco pip yapf)

zplug_install () {
  local installer='https://raw.githubusercontent.com/zplug/installer/master/installer.zsh'
  curl -sL --proto-redir -all,https $installer | zsh
}

mklink_xdg_config () {
  if [ ! -L "${XDG_CONFIG_HOME}/${1}" ]; then
    ln -sf "${PWD}/${1}" "${XDG_CONFIG_HOME}/${1}"
  fi
}

# install zplug
if [ ! -d ~/.zplug ]; then
  zplug_install
fi

# dotfiles
for dotfiles in .?*
do
  case ${dotfiles} in
    ..)            continue ;;
    .git*)         continue ;;
    .travis.yml)   continue ;;
    *)             ln -sf "${PWD}/${dotfiles}" ${HOME} ;;
  esac
done

mkdir -p ${XDG_CONFIG_HOME}

# for ArchLinux
if [ -f /etc/arch-release ]; then
  for item in ${ARCH_XDG_CONFIGS[@]}
  do
    mklink_xdg_config ${item}
  done
fi

# common
for item in ${COMMON_XDG_CONFIGS[@]}
do
  mklink_xdg_config ${item}
done

