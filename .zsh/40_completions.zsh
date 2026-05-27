### Completion

# Insert space and slash used by the _expand completer.
zstyle ':completion:*' add-space yes
# Completion modifiers.
zstyle ':completion:*' completer _expand _complete _match _approximate
# Approximate (typo-tolerant) matching: allow 1 error per 3 chars of the word,
# so short words (e.g. command names) stay strict and huge candidate sets don't blow up.
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
# Staged matching: exact -> case-insensitive -> partial-after-separator -> substring.
# Tries each rule in order, only loosening when the previous yields no matches.
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
# Verbose output for completion listing.
zstyle ':completion:*' verbose yes
# Colorize the completion list using LS_COLORS (set in 30_colors.zsh via vivid).
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Colored, labelled group headings / messages in the completion listing.
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages'     format '%F{cyan}-- %d --%f'
zstyle ':completion:*:warnings'     format '%F{red}-- no matches --%f'
# All different types of matches displayed separately.
zstyle ':completion:*' group-name ''
# Make the completion menu selectable.
zstyle ':completion:*:default' menu select=long-list
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
# Ignore parent directory.
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# Ignore what's already in the line.
zstyle ':completion:*:(mv|rm|kill|diff):*' ignore-line yes
# If you end up using a directory as argument, this will remove the trailing slash (useful in ln)
zstyle ':completion:*' squeeze-slashes true

typeset -g ZSH_LOCAL_COMPLETIONS="${ZSH_LOCAL_COMPLETIONS:-${XDG_CACHE_HOME}/zsh/completions}"
typeset -g ZSH_ZCOMPDUMP="${ZSH_ZCOMPDUMP:-${XDG_CACHE_HOME}/zsh/.zcompdump}"
fpath=("${ZSH_LOCAL_COMPLETIONS}" $fpath)

autoload -Uz compinit
if [[ -n ${ZSH_ZCOMPDUMP}(#qN.mh+24) ]]; then
  compinit -d "${ZSH_ZCOMPDUMP}"
else
  compinit -C -d "${ZSH_ZCOMPDUMP}"
fi
