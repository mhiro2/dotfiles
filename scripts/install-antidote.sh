#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly action="${1:-install}"
readonly antidote_dir="${XDG_DATA_HOME:-${HOME}/.local/share}/antidote"
readonly antidote_repo="https://github.com/mattmc3/antidote.git"

case "${action}" in
  install)
    if [[ -d "${antidote_dir}" ]]; then
      skip "antidote は既にインストール済みのためスキップします"
      exit 0
    fi
    info "antidote をインストールします"
    git clone --depth=1 "${antidote_repo}" "${antidote_dir}"
    success "antidote のインストールが完了しました"
    ;;
  update)
    if [[ ! -d "${antidote_dir}" ]]; then
      skip "antidote は未インストールのためスキップします"
      exit 0
    fi
    step "antidote を更新します"
    git -C "${antidote_dir}" pull --ff-only
    if [[ -f "${antidote_dir}/antidote.zsh" ]]; then
      zsh -ic "source \"${antidote_dir}/antidote.zsh\"; antidote update"
    fi
    success "antidote のアップグレードが完了しました"
    ;;
  *)
    printf 'usage: %s {install|update}\n' "$0" >&2
    exit 2
    ;;
esac
