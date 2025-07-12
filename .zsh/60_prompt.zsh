HOST_PROMPT="%K{124}%F{255}  %F{88}%k%F{214} %n@%m%f%k%f:"
DIR_PROMPT="%F{81}%~ %k%f"
PROMPT_HEAD="%F{1}%F{3}%F{2}%f"

ZSH_THEME_GIT_SHOW_UPSTREAM=1
ZSH_THEME_GIT_PROMPT_PREFIX="%K{34}%F{0}  "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %K{0}%F{34}%k%f"

# Remove unnecessary quotation marks based on the following:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh
function git_prompt_info() {
  # If we are on a folder not tracked by git, get out.
  # Otherwise, check for hide-info at global and local repository level
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
     || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
  fi

  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
  || ref=$(__git_prompt_git describe --tags --exact-match HEAD 2> /dev/null) \
  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
  || return 0

  # Use global ZSH_THEME_GIT_SHOW_UPSTREAM=1 for including upstream remote info
  local upstream
  if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} )); then
    upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null) \
    && upstream=" -> ${upstream}"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref}${upstream}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

PROMPT='${HOST_PROMPT}${DIR_PROMPT}$(git_prompt_info)
$PROMPT_HEAD '

RPROMPT='($ZSH_KUBECTL_PROMPT)'
