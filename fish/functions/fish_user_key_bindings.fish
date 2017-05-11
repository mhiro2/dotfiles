# Move to begining and end of line.
bind \ca beginning-of-line
bind \ce end-of-line backward-char
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line

# Search forward and backward in the history for a specified string.
bind \cp history-search-backward
bind \cn history-search-forward
bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward

# Kill from the cursor to the end of the line.
bind \k kill-line
bind -M insert \k kill-line

# Easy escape.
bind -M insert -m default jj backward-char force-repaint

bind -M insert \cr 'peco_select_history (commandline -b)'
