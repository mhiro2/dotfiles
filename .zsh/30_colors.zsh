## ls command colors
() {
  local vivid_cache_dir vivid_theme_cache

  command -v vivid >/dev/null 2>&1 || return

  vivid_cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/vivid"
  vivid_theme_cache="${vivid_cache_dir}/molokai.lscolors"

  if [[ -f "${vivid_theme_cache}" ]]; then
    export LS_COLORS="$(<"${vivid_theme_cache}")"
  elif mkdir -p "${vivid_cache_dir}" 2>/dev/null \
       && vivid generate molokai >| "${vivid_theme_cache}" 2>/dev/null; then
    export LS_COLORS="$(<"${vivid_theme_cache}")"
  else
    export LS_COLORS="$(vivid generate molokai)"
  fi
}
