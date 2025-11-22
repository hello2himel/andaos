#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Fastfetch on terminal launch
fastfetch

# Prompt
PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep--color=auto'
