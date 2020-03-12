# Source global definitions.
[ -f /etc/bashrc ] && . /etc/bashrc

# Source platform definitions.
case `uname -s` in
  Linux*)
  [ -f ~/.bashrc.linux ] && . ~/.bashrc.linux
  ;;
  Darwin*)
  [ -f ~/.bashrc.macos ] && . ~/.bashrc.macos
  ;;
esac

# Source aliases, functions and autocompletions.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions
case `uname -s` in
  Linux*)
  [ -f ~/.bash_aliases.linux ] && . ~/.bash_aliases.linux
  [ -f ~/.bash_functions.linux ] && . ~/.bash_functions.linux
  ;;
  Darwin*)
  [ -f ~/.bash_aliases.macos ] && . ~/.bash_aliases.macos
  [ -f ~/.bash_functions.macos ] && . ~/.bash_functions.macos
  ;;
esac
for f in ~/.bash_autocompletions/*; do . $f; done

# Source z, fzf, and combine them.
[ -f ~/.z.sh ] && . ~/.z.sh
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
if [ type "z" &> /dev/null ] && [ type "fzf" &> /dev/null ]; then
  unalias z 2> /dev/null
  function z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
  }
fi

# Comand prompt.
PS1='\[\033[01;34m\]\w \$\[\033[00m\] '
if [ $(type -t __git_ps1) ]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWCOLORHINTS=1
  PS1='\[\033[01;34m\]\w\[\033[0;37m\]$(__git_ps1 "(%s)") \[\033[01;34m\]\$\[\033[00m\] '
fi
if [ -f /run/.containerenv ] && [ -f /run/.toolboxenv ]; then
  PS1=$(printf "\033[35m⬢\033[0m%s" " $PS1")
fi

# Bash history.
shopt -s histappend
shopt -s cmdhist
HISTSIZE=100000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Tab completion for sudo and killall.
complete -cf sudo
complete -cf killall

# Editor.
EDITOR='vi'

# Environment variables.
export GOPATH=$HOME/.go
