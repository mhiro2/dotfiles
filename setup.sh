#!/bin/sh -eu

cd $(dirname $0)

git submodule init
git submodule update

# install zplug
if [ ! -d ~/.zplug ]; then
    curl -sL zplug.sh/installer | zsh
fi

# dotfiles
for dotfiles in .?*
do
  case ${dotfiles} in
    ..)          continue ;;
    .git*)       continue ;;
    .circle.yml) continue ;;
    *)           ln -sf "${PWD}/${dotfiles}" ${HOME} ;;
  esac
done

# neovim
ln -sf nvim ${HOME}/.config
