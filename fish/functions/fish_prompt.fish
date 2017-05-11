function fish_prompt
  set -l prompt_git

  if command git rev-parse --is-inside-work-tree > /dev/null 2>&1
    set -l branch_symbol \uE0A0
    set -l branch (git symbolic-ref HEAD | sed "s#refs/heads/#$branch_symbol #")

    set prompt_git (set_color normal)' on' (set_color green)$branch
  end

  printf '%s%s@%s:%s%s %s' (set_color red)'❖ ' \
                           (set_color yellow)(whoami) \
                           (prompt_hostname) \
                           (set_color blue)(prompt_pwd) \
                           $prompt_git
  printf '\n%s' (set_color normal)'% '
end
