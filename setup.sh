#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

git submodule init
git submodule update

readonly XDG_CONFIG_HOME=${HOME}/.config
readonly ARCH_XDG_CONFIGS=(compton dunst i3 sway terminator)
readonly COMMON_XDG_CONFIGS=(bat fish git nvim peco pip xonsh yamllint yapf)

zinit_install()  {
  mkdir "${HOME}/.zinit"
  git clone https://github.com/zdharma/zinit.git "${HOME}/.zinit/bin"
}

mklink_xdg_config()  {
  if [ ! -L "${XDG_CONFIG_HOME}/${1}" ]; then
    ln -sf "${PWD}/${1}" "${XDG_CONFIG_HOME}/${1}"
  fi
}

# install zinit
if [ ! -d "${HOME}/.zinit" ]; then
  zinit_install
fi

# dotfiles
for dotfiles in .?*; do
  case ${dotfiles} in
    ..)            continue ;;
    .git*)         continue ;;
    .travis.yml)   continue ;;
    *)             ln -sf "${PWD}/${dotfiles}" "${HOME}" ;;
  esac
done

mkdir -p "${XDG_CONFIG_HOME}"

# for ArchLinux
if [ -f /etc/arch-release ]; then
  for item in "${ARCH_XDG_CONFIGS[@]}"; do
    mklink_xdg_config "${item}"
  done
fi

# common
for item in "${COMMON_XDG_CONFIGS[@]}"; do
  mklink_xdg_config "${item}"
done
