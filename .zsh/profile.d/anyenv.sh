export ANYENV_ROOT="/usr/local/anyenv"
if [ -d "${ANYENV_ROOT}" ]; then
  export PATH=${ANYENV_ROOT}/bin:$PATH
  eval "$(anyenv init - --no-rehash)"
fi
