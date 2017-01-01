ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ☂" # Ⓓ
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ♪" # Ⓞ
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✚ " # ⓐ ⑃
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✎"  # ⓜ ⑁
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖" # ⓧ ⑂
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭" # ⓣ
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➜" # ⓡ ⑄
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ♥" # ⓤ ⑊

PROMPT='%{$fg[red]%}❖ %{$fg[yellow]%}%n@%{$fg[yellow]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)
%# '

RPROMPT='%* $(git_prompt_status)%{$reset_color%}'
