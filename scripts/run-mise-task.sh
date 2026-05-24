#!/usr/bin/env bash
set -euo pipefail

readonly task="${1:-}"
if [[ -z "${task}" ]]; then
  printf 'usage: %s <task>\n' "$0" >&2
  exit 2
fi

resolved_mise_cmd="$(command -v mise 2>/dev/null || true)"
if [[ -z "${resolved_mise_cmd}" && -x "${HOME}/.local/bin/mise" ]]; then
  resolved_mise_cmd="${HOME}/.local/bin/mise"
fi

readonly mise_cmd="${resolved_mise_cmd}"
unset resolved_mise_cmd

if [[ -z "${mise_cmd}" ]]; then
  echo "mise が見つかりません" >&2
  exit 1
fi

exec "${mise_cmd}" run "${task}"
