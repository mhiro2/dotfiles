export KREW_ROOT="${HOME}/.krew"
if [ -d "${KREW_ROOT}" ]; then
  export PATH=${KREW_ROOT}/bin:$PATH
fi
