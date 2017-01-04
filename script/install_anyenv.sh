#!/usr/bin/env bash
set -eu

readonly USERNAME=$(whoami)
readonly ANYENV_GROUP="anyenv"
readonly ANYENV_HOME="/usr/local"

echo "Add ${USERNAME} to ${ANYENV_GROUP} group"
if [ ! "$(getent group ${ANYENV_GROUP})" ]; then
  sudo groupadd ${ANYENV_GROUP}
  sudo gpasswd -a ${USERNAME} ${ANYENV_GROUP}
fi
echo

echo "Install anyenv"
if [ ! -e "${ANYENV_HOME}"/anyenv ]; then
  sudo git clone https://github.com/riywo/anyenv.git ${ANYENV_HOME}/anyenv
  sudo git clone https://github.com/znz/anyenv-update.git ${ANYENV_HOME}/anyenv/plugins/anyenv-update
  sudo git clone https://github.com/znz/anyenv-git.git ${ANYENV_HOME}/anyenv/plugins/anyenv-git

  sudo chgrp -R ${ANYENV_GROUP} ${ANYENV_HOME}/anyenv
  sudo chmod -R g+rwxX ${ANYENV_HOME}/anyenv
fi
echo

echo "Add anyenv initialization profile: /etc/profile.d/anyenv.sh"
if [ ! -e /etc/profile.d/anyenv.sh ]; then
sudo tee /etc/profile.d/anyenv.sh << "EOF" > /dev/null
export ANYENV_ROOT="/usr/local/anyenv"
if [ -d "${ANYENV_ROOT}" ]; then
  export PATH=${ANYENV_ROOT}/bin:$PATH
  eval "$(anyenv init - --no-rehash)"
fi
EOF
fi
echo

echo "Complete!"
