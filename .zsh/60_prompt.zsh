HOST_PROMPT="%K{160}%F{255}  %F{160}%k%F{214} %n@%m%f%k%f:"
DIR_PROMPT="%F{87}%~ %k%f"
PROMPT_HEAD="%F{1}%F{3}%F{2}%f"

ZSH_THEME_GIT_PROMPT_PREFIX="%K{2}%F{0}  "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %K{0}%F{2}%k%f"

PROMPT='${HOST_PROMPT}${DIR_PROMPT}$(git_prompt_info)
$PROMPT_HEAD '

RPROMPT='%* '

