#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
readonly REPO_ROOT

# `make install` で mise を入れた直後は PATH に載っていないことがあるため、
# run-mise-task.sh と同じ順で mise を解決する。
resolved_mise_cmd="$(command -v mise 2>/dev/null || true)"
if [[ -z "${resolved_mise_cmd}" && -x "${HOME}/.local/bin/mise" ]]; then
  resolved_mise_cmd="${HOME}/.local/bin/mise"
fi
readonly mise_cmd="${resolved_mise_cmd}"

if [[ -z "${mise_cmd}" ]]; then
  echo "mise が見つかりません" >&2
  exit 1
fi

# dotfiles の source を正しく解決するため、必ずリポジトリルートで実行する。
cd "${REPO_ROOT}"

"${mise_cmd}" trust
# shell activation は .zshrc/.zshenv 側で eval 済みのため skip する。
exec "${mise_cmd}" bootstrap --yes --skip mise-shell-activate "$@"
