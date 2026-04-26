#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=scripts/common.sh
source "${SCRIPT_DIR}/common.sh"

readonly xdg_cache_home="${XDG_CACHE_HOME:-${HOME}/.cache}"
readonly zsh_completions_dir="${xdg_cache_home}/zsh/completions"
readonly zsh_compdump="${xdg_cache_home}/zsh/.zcompdump"

generate_completions() {
  info "zsh 補完スクリプトを再生成します"
  rm -rf "${zsh_completions_dir}"
  mkdir -p "${zsh_completions_dir}"
  zsh -ic "
    setopt clobber
    ZSH_LOCAL_COMPLETIONS='${zsh_completions_dir}'
    [[ -x \"\$(command -v docker)\" ]] && docker completion zsh >! \"\$ZSH_LOCAL_COMPLETIONS/_docker\"
    [[ -x \"\$(command -v kubectl)\" ]] && kubectl completion zsh >! \"\$ZSH_LOCAL_COMPLETIONS/_kubectl\"
    [[ -n \"\$(command -v mise)\" ]] && mise completion zsh >! \"\$ZSH_LOCAL_COMPLETIONS/_mise\"
    [[ -x \"\$(command -v uv)\" ]] && uv generate-shell-completion zsh >! \"\$ZSH_LOCAL_COMPLETIONS/_uv\"
  "
  success "completions の再生成が完了しました"
}

update_compdump() {
  info "zsh 補完ダンプを更新します"
  rm -f "${zsh_compdump}" "${zsh_compdump}.zwc"
  zsh -ic "autoload -Uz compinit; compinit -u -C -d '${zsh_compdump}'; [[ -f '${zsh_compdump}' ]] && zcompile '${zsh_compdump}'"
  success "compdump の更新が完了しました"
}

generate_completions
update_compdump
success "zsh 補完の再生成とダンプ更新が完了しました"
