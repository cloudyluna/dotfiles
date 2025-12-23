# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias gc='git clone'
alias gd='git diff'
alias gs='git status'

export EDITOR="emacs -Q --no-window-system --load $HOME/.quick-emacs.el"
export GSK_RENDERER="gl"

eval "$(direnv hook bash)"

export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

