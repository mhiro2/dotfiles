#!/usr/bin/env bash
set -eu

if [ -x "/usr/lcoal/bin/tmux" ]; then
  echo "tmux already installed"
  exit 0
fi

readonly TMUX_BUILD_DIR=$(mktemp -d)
readonly TMUX_VERSION="2.4"

# Ubuntu16
if [ -x "/usr/bin/apt-get" ]; then
  sudo apt-get install libevent-dev libncurses5-dev
fi
# CentOS7
if [ -x "/usr/bin/yum" ]; then
  sudo yum -y install libevent-devel ncurses-devel
fi

echo
echo "Install tmux"
curl -sL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz | tar zxC ${TMUX_BUILD_DIR}
cd "${TMUX_BUILD_DIR}/tmux-${TMUX_VERSION}"
./configure --silent --prefix=/usr/local && make -j$(nproc) --silent
sudo make --silent install

trap "
rm -rf ${TMUX_BUILD_DIR}
" 0
