# local loading
zplug "zplug/zplug"

##------------------------------
# zsh plugins

# git prompt
zplug "lib/git", from:oh-my-zsh

# Syntax highlighting.
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# History search.
zplug "zsh-users/zsh-history-substring-search"

# Completions.
zplug "zsh-users/zsh-completions"
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh

# Visual mode for vi-mode.
zplug "b4b4r07/zsh-vimode-visual", defer:3

##------------------------------
# Useful commands

# anyframe
zplug "mollifier/anyframe", \
    at:4c23cb60

# # ctop
# zplug "bcicen/ctop", \
#     as:command, \
#     from:gh-r, \
#     rename-to:"ctop"

# # enhancd
# zplug "b4b4r07/enhancd", \
#     use:init.sh

# # exa
# zplug "ogham/exa", \
#     as:command, \
#     rename-to:"exa", \
#     from:gh-r

# # fzf
#zplug "junegunn/fzf-bin", \
#    as:command, \
#    from:gh-r, \
#    rename-to:"fzf", \
#    frozen:1

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

# # rush
# zplug "shenwei356/rush", \
#     as:command, \
#     from:gh-r

# tmux-xpanes
zplug "greymd/tmux-xpanes"

# # usql
#zplug "knq/usql", \
#    as:command, \
#    from:gh-r

