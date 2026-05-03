### Docker fzf-driven helpers

# Select Docker objects via fzf and emit the requested column.
# Usage: _docker_fzf_select <prompt> <object> <column> <multi> [docker subcmd args...]
#   <object> = "container" | "image"
#   <multi>  = 0 | 1
_docker_fzf_select() {
  local prompt="$1" object="$2" column="$3" multi="$4"
  shift 4
  local -a fzf_opts
  fzf_opts=(--prompt "${prompt}> " --height=40% --layout=reverse)
  (( multi )) && fzf_opts+=(--multi)
  local selection
  selection=$(docker "${object}" "$@" \
    | awk 'NR==1 {next} {print}' \
    | fzf "${fzf_opts[@]}") || return 1
  [[ -n "${selection}" ]] || return 1
  printf '%s\n' "${selection}" | awk -v col="${column}" '{print $col}'
}

dce() {
  local container
  container=$(_docker_fzf_select 'exec' container 1 0 ls) || return 1
  docker container exec -it "${container}" /bin/bash
}

dcl() {
  local container
  container=$(_docker_fzf_select 'logs' container 1 0 ls -a) || return 1
  docker container logs "${container}"
}

dclf() {
  local container
  container=$(_docker_fzf_select 'logs' container 1 0 ls) || return 1
  docker container logs -f "${container}"
}

dcrm() {
  local selection
  local -a containers
  selection=$(_docker_fzf_select 'rm' container 1 1 ls -a --filter status=exited) || return 1
  containers=(${(f)selection})
  (( ${#containers[@]} )) || return 1
  docker container rm "${containers[@]}"
}

dcs() {
  local selection
  local -a containers
  selection=$(_docker_fzf_select 'stop' container 1 1 ls) || return 1
  containers=(${(f)selection})
  (( ${#containers[@]} )) || return 1
  docker container stop "${containers[@]}"
}

dirm() {
  local selection
  local -a images
  selection=$(_docker_fzf_select 'rm' image 3 1 ls) || return 1
  images=(${(f)selection})
  (( ${#images[@]} )) || return 1
  docker image rm "${images[@]}"
}
