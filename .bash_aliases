export CLICOLOR=1
alias lsa='ls -la'

# Colorize grep.
export GREP_COLOR="1;33"
alias grep='grep -G'

# Dotfiles.
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
