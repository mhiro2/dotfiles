# local loading
zplug "zplug/zplug"

##------------------------------
# zsh plugins

# git prompt
zplug "lib/git", from:oh-my-zsh

# Syntax highlighting.
zplug "zsh-users/zsh-syntax-highlighting"

# History search.
zplug "zsh-users/zsh-history-substring-search"

# Completions.
zplug "zsh-users/zsh-completions"


##------------------------------
# Useful commands

# anyframe
zplug "mollifier/anyframe", \
    at:4c23cb60

# # enhancd
# zplug "b4b4r07/enhancd", \
#     use:init.sh

# ctop
zplug "bcicen/ctop", \
    as:command, \
    from:gh-r, \
    rename-to:"ctop"

# fzf
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

# ghq
zplug "motemen/ghq", \
    as:command, \
    from:gh-r

# jq
zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    frozen:1

# peco
zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

# pget
zplug "Code-Hex/pget", \
    as:command, \
    from:gh-r, \
    frozen:1

# pt
zplug "monochromegane/the_platinum_searcher", \
    as:command, \
    from:gh-r, \
    rename-to:"pt", \
    frozen:1

zplug "knq/usql", \
    as:command, \
    from:gh-r
