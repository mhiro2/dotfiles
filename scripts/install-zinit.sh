#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly action="${1:-install}"
readonly zinit_dir="${HOME}/.local/share/zinit"
readonly zinit_script="${zinit_dir}/zinit.git/zinit.zsh"

case "${action}" in
  install)
    if [[ -d "${zinit_dir}/zinit.git" ]]; then
      skip "zinit は既にインストール済みのためスキップします"
      exit 0
    fi
    info "zinit をインストールします"
    NO_INPUT=1 NO_ANNEXES=1 NO_EDIT=1 NO_TUTORIAL=1 \
      bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    success "zinit のインストールが完了しました"
    ;;
  update)
    if [[ ! -f "${zinit_script}" ]]; then
      skip "zinit は未インストールのためスキップします"
      exit 0
    fi
    step "zinit を更新します"
    zsh -ic "source \"${zinit_script}\"; typeset -i exit_code=0; zinit self-update || exit_code=\$?; zinit update --parallel || exit_code=\$?; wait || exit_code=\$?; exit \$exit_code"
    success "zinit のアップグレードが完了しました"
    ;;
  *)
    printf 'usage: %s {install|update}\n' "$0" >&2
    exit 2
    ;;
esac
