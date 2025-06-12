# FZF-based widgets to replace anyframe functionality

# Smart change directory using cdr
fzf-cdr() {
  local selected_dir
  selected_dir=$(cdr -l | sed 's/^[0-9][0-9]*[[:space:]]*//' | fzf --prompt="cd> " --height=40% --layout=reverse)
  if [[ -n "$selected_dir" ]]; then
    LBUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cdr

# Smart history search and execute
fzf-execute-history() {
  local selected_command
  selected_command=$(fc -l -1000 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' | tac | fzf --prompt="exec> " --height=40% --layout=reverse)
  if [[ -n "$selected_command" ]]; then
    LBUFFER="$selected_command"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-execute-history

# Smart history search and put command line
fzf-put-history() {
  local selected_command
  selected_command=$(fc -l -1000 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//' | tac | fzf --prompt="hist> " --height=40% --layout=reverse)
  if [[ -n "$selected_command" ]]; then
    LBUFFER="$selected_command"
  fi
  zle reset-prompt
}
zle -N fzf-put-history

# Search ghq projects
fzf-cd-ghq-repository() {
  local selected_dir
  selected_dir=$(ghq list | fzf --prompt="ghq> " --height=40% --layout=reverse)
  if [[ -n "$selected_dir" ]]; then
    LBUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-cd-ghq-repository

# Attach tmux session
fzf-tmux-attach() {
  local selected_session
  selected_session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --prompt="tmux> " --height=40% --layout=reverse)
  if [[ -n "$selected_session" ]]; then
    LBUFFER="tmux attach-session -t ${selected_session}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-tmux-attach

# Checkout git branch
fzf-checkout-git-branch() {
  local selected_branch
  selected_branch=$(git branch -a | sed 's/^..//' | sed 's/^remotes\///' | sort -u | fzf --prompt="branch> " --height=40% --layout=reverse)
  if [[ -n "$selected_branch" ]]; then
    LBUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-checkout-git-branch

# Process killer
fzf-kill() {
  local selected_process
  selected_process=$(ps aux | sed 1d | fzf --prompt="kill> " --height=40% --layout=reverse --multi | awk '{print $2}')
  if [[ -n "$selected_process" ]]; then
    echo "$selected_process" | xargs kill
    if [[ $ZLE_STATE == *insert* || $ZLE_STATE == *command* ]]; then
      zle reset-prompt
    fi
  fi
}
zle -N fzf-kill

# Interactive git add
fzf-git-add() {
  local selected_files
  selected_files=$(git status --porcelain | fzf --prompt="add> " --height=40% --layout=reverse --multi | awk '{print $2}')
  if [[ -n "$selected_files" ]]; then
    echo "$selected_files" | xargs git add
    zle reset-prompt
  fi
}
zle -N fzf-git-add

# SSH host selector
fzf-ssh() {
  local selected_host
  selected_host=$(grep '^Host' ~/.ssh/config 2>/dev/null | awk '{print $2}' | fzf --prompt="ssh> " --height=40% --layout=reverse)
  if [[ -n "$selected_host" ]]; then
    echo "ssh ${selected_host}"
    ssh "${selected_host}"
  fi
}