### Keybind
## -v (-M vicmd) : command mode
## -a (-M viins) : insert mode

# Bindings.
bindkey -v

# Move to begining and end of line.
bindkey -M vicmd '^A' vi-beginning-of-line
bindkey -M vicmd '^E' vi-end-of-line
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line

# Search forward and backward in the history for a specified string.
bindkey -M vicmd '^N' history-beginning-search-forward
bindkey -M vicmd '^P' history-beginning-search-backward
bindkey -M viins '^N' history-beginning-search-forward
bindkey -M viins '^P' history-beginning-search-backward

# Search forward and backward in the history for any part of string.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Kill from the cursor to the end of the line.
bindkey -M vicmd '^K' kill-line
bindkey -M viins '^K' kill-line

# Kill from the beginning of the line to the cursor position.
bindkey -M vicmd '^U' backward-kill-line
bindkey -M viins '^U' backward-kill-line

# Delete the current word.
bindkey -M vicmd '^D' delete-word
bindkey -M viins '^D' delete-word

# Enable UNDO and REDO.
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

# Don't store register.
bindkey -M vicmd 'x' delete-char

# Enable Fn-Delete key.
bindkey -M viins '^[[3~' delete-char

# Enable Delete key at all times.
bindkey -M viins "^?" backward-delete-char

# Easy escape.
bindkey -M viins 'jj' vi-cmd-mode

# Select menu list by vi-like keybind.
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Use commandline stack.
show_buffer_stack() {
  zle vi-end-of-line
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
bindkey -M vicmd '^Q' show_buffer_stack
bindkey -M viins '^Q' show_buffer_stack

# Use anyframe.
autoload -Uz anyframe-init anyframe-init
zstyle ":anyframe:selector:" use peco

# Smart change directory using cdr.
bindkey -M viins '^S' anyframe-widget-cdr

# Smart history search and execute.
bindkey -M viins '^R' anyframe-widget-execute-history

# Smart history search and put command line.
bindkey -M viins '^F' anyframe-widget-put-history

# Search ghq projects.
bindkey -M viins '^G' anyframe-widget-cd-ghq-repository

# Attach tmux session.
bindkey -M viins '^T' anyframe-widget-tmux-attach

# Checkout git branch
bindkey -M viins '^B' anyframe-widget-checkout-git-branch
