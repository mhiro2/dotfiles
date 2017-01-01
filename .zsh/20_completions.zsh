### Completion

# Insert space and slash used by the _expand completer.
zstyle ':completion:*' add-space true
# Completion modifiers.
zstyle ':completion:*' completer \
         _expand _complete _match _ignored _approximate _oldlist _list _history _prefix
# Ignore case.
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
# Verbose output for completion listing.
zstyle ':completion:*' verbose yes
# All different types of matches displayed separately.
zstyle ':completion:*' group-name ''
# Make the completion menu selectable.
zstyle ':completion:*:default' menu select=2
# Try to keep a preﬁx containing a tilde or parameter expansion.
zstyle ':completion:*' keep-prefix
# Use a completion cache.
zstyle ':completion:*' use-cache true
# Sudo completion.
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# Set the list separator.
zstyle ':completion:*' list-separator '-->'
# Use 'cdpath' when the word don't match.
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# Fuzzy matching of completions for when you mistype them
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:(approximate|correct):*' max-errors 2 numeric
# Ignore parent directory.
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# Ignore what's already in the line.
zstyle ':completion:*:(mv|rm|kill|diff):*' ignore-line yes
# If you end up using a directory as argument, this will remove the trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true
