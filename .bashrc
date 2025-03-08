#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza'
alias lsa='eza -lasnew'
alias grep='grep --color=auto'
alias code='uwsm app -- code'
alias mpvhdr='uwsm app -- mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk'

# Define color escape sequences
RESET="\[\e[0m\]"    # Reset color
BOLD="\[\e[1m\]"     # Bold text
BLACK="\[\e[30m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"

parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}

PS1="[\u@\h \w]\$(parse_git_branch | sed 's/^/  /') \$ "
