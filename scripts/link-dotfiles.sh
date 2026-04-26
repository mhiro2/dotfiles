#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
readonly REPO_ROOT
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly action="${1:-init}"
readonly xdg_config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"

readonly -a xdg_config_files=(bat cmux ghostty git mise nvim tmux)
readonly -a exclude_files=(.DS_Store .git .github .gitignore .gitmodules .claude .tmux)
readonly -a claude_files=(.claude/settings.json .claude/statusline.py)

contains() {
  local -r needle="$1"
  shift
  local item
  for item in "$@"; do
    [[ "${item}" == "${needle}" ]] && return 0
  done
  return 1
}

dot_files=()
for path in "${REPO_ROOT}"/.??*; do
  [[ -e "${path}" ]] || continue
  name="${path##*/}"
  contains "${name}" "${exclude_files[@]}" && continue
  dot_files+=("${name}")
done
readonly -a dot_files

link_file() {
  local -r src="$1"
  local -r dest="$2"
  mkdir -p "$(dirname -- "${dest}")"
  ln -sfn "${src}" "${dest}"
}

unlink_if_symlink() {
  local -r dest="$1"
  if [[ -L "${dest}" ]]; then
    unlink "${dest}"
  fi
}

case "${action}" in
  init)
    info "シンボリックリンクを初期化します"
    mkdir -p "${xdg_config_home}"
    for file in "${dot_files[@]}"; do
      link_file "${REPO_ROOT}/${file}" "${HOME}/${file}"
    done
    for file in "${xdg_config_files[@]}"; do
      link_file "${REPO_ROOT}/${file}" "${xdg_config_home}/${file}"
    done
    for file in "${claude_files[@]}"; do
      link_file "${REPO_ROOT}/${file}" "${HOME}/${file}"
    done
    success "init が完了しました"
    ;;
  clean)
    info "シンボリックリンクを削除します"
    for file in "${dot_files[@]}"; do
      unlink_if_symlink "${HOME}/${file}"
    done
    for file in "${xdg_config_files[@]}"; do
      unlink_if_symlink "${xdg_config_home}/${file}"
    done
    for file in "${claude_files[@]}"; do
      unlink_if_symlink "${HOME}/${file}"
    done
    success "clean が完了しました"
    ;;
  *)
    printf 'usage: %s {init|clean|list}\n' "$0" >&2
    exit 2
    ;;
esac
