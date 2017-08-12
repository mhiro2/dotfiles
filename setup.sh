#!/bin/sh -eu

cd $(dirname $0)

git submodule init
git submodule update

zplug_install () {
  local installer='https://raw.githubusercontent.com/zplug/installer/master/installer.zsh'
  curl -sL --proto-redir -all,https $installer | zsh
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

# fish
if [ ! -L "${XDG_CONFIG_HOME}/fish" ]; then
  ln -sf "${PWD}/fish" "${XDG_CONFIG_HOME}/fish"
fi

# neovim
if [ ! -L "${XDG_CONFIG_HOME}/nvim" ]; then
  ln -sf "${PWD}/nvim" "${XDG_CONFIG_HOME}/nvim"
fi

# sway
if [ ! -L "${XDG_CONFIG_HOME}/sway" ]; then
  ln -sf "${PWD}/sway" "${XDG_CONFIG_HOME}/sway"
fi

# terminator
if [ ! -L "${XDG_CONFIG_HOME}/terminator" ]; then
  ln -sf "${PWD}/terminator" "${XDG_CONFIG_HOME}/terminator"
fi

# yapf
if [ ! -L "${XDG_CONFIG_HOME}/yapf" ]; then
  ln -sf "${PWD}/yapf" "${XDG_CONFIG_HOME}/yapf"
fi

