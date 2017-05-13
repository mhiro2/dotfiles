#!/bin/sh -eu

cd $(dirname $0)

git submodule init
git submodule update

zplug_install () {
  #local installer='https://zplug.sh/installer'
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
    .editorconfig) continue ;;
    .git*)         continue ;;
    .travis.yml)   continue ;;
    *)             ln -sf "${PWD}/${dotfiles}" ${HOME} ;;
  esac
done

mkdir -p ${HOME}/.config

# fish
if [ ! -L "${HOME}/.config/fish" ]; then
  ln -sf "${PWD}/fish" "${HOME}/.config/fish"
fi

# neovim
if [ ! -L "${HOME}/.config/nvim" ]; then
  ln -sf "${PWD}/nvim" "${HOME}/.config/nvim"
fi
