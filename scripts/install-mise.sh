#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly installer_url="https://mise.run"

if command -v mise >/dev/null 2>&1; then
  skip "mise は既にインストール済みのためスキップします"
  exit 0
fi

info "mise をインストールします"

tmpdir="$(mktemp -d)"
readonly tmpdir
trap 'rm -rf "${tmpdir}"' EXIT

readonly installer="${tmpdir}/install.sh"
step "installer を取得します"
if ! curl -fsSL "${installer_url}" --output "${installer}"; then
  echo "mise installer の取得に失敗しました: ${installer_url}" >&2
  exit 1
fi

if [[ ! -s "${installer}" ]]; then
  echo "mise installer が空です: ${installer_url}" >&2
  exit 1
fi

sh "${installer}"

mise_path="$(command -v mise 2>/dev/null || true)"
if [[ -z "${mise_path}" && -x "${HOME}/.local/bin/mise" ]]; then
  mise_path="${HOME}/.local/bin/mise"
fi
readonly mise_path

if [[ -z "${mise_path}" ]]; then
  echo "mise が見つかりません。mise のインストールに失敗しました" >&2
  exit 1
fi

if ! "${mise_path}" --version >/dev/null 2>&1; then
  echo "mise が実行できません: ${mise_path}" >&2
  exit 1
fi

success "mise のインストールが完了しました (${mise_path})"
