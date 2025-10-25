source_if_exists() {
  [ -f $1 ] && . $1
}

# Source global definitions.
source_if_exists /etc/bashrc

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
source_if_exists $HOME/.bash_aliases
source_if_exists $HOME/.bash_functions
case `uname -s` in
  Linux*)
  source_if_exists $HOME/.bash_aliases.linux
  source_if_exists $HOME/.bash_functions.linux
  ;;
  Darwin*)
  source_if_exists $HOME/.bash_aliases.macos
  source_if_exists $HOME/.bash_functions.macos
  ;;
esac
if [ -d ~/.bash_autocompletions ]; then
  for f in ~/.bash_autocompletions/*; do
    [ -f "$f" ] && . "$f"
  done
fi

# Source z, fzf, and combine them.
source_if_exists $HOME/.z.sh
source_if_exists $HOME/.fzf.bash
if [ type "z" &> /dev/null ] && [ type "fzf" &> /dev/null ]; then
  unalias z 2> /dev/null
  function z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
  }
fi

# Source and setup asdf.
source_if_exists $HOME/.asdf/asdf.sh
source_if_exists $HOME/.asdf/completions/asdf.bash
source_if_exists $HOME/.asdf/plugins/java/set-java-home.bash

# Comand prompt.
PS1='\[\033[01;34m\]\w \$\[\033[00m\] '
if [ $(type -t __git_ps1) ]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWCOLORHINTS=1
  PS1='\[\033[01;34m\]\w\[\033[0;37m\]$(__git_ps1 "(%s)") \[\033[01;34m\]\$\[\033[00m\] '
fi
if [ -f /run/.containerenv ] && [ -f /run/.toolboxenv ]; then
  PS1="\[\033[35m\]⬢\[\033[0m\] $PS1"
fi

# Bash history.
shopt -s histappend
shopt -s cmdhist
shopt -s lithist
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE='history:ls:l:pwd:exit:bg:fg'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Tab completion for sudo and killall.
complete -cf sudo
complete -cf killall

# Editor.
EDITOR='vi -e'
VISUAL='vi'
