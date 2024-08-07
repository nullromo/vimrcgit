# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set terminal variable to use color. Hopefully this does not cause problems
# later on.
export TERM='xterm-256color'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

GREEN='\[\033[01;32m\]'
GRAY='\[\033[00m\]'
BLUE='\[\033[01;34m\]'
YELLOW='\[\033[33m\]'
WHITE='\[\033[37m\]'

# prints a label for the PS1
get_git_branch() {
    # if there is a .git directory, then use the name of that directory
    if [ -d .git ]; then
        echo $(__git_ps1 "($(basename `git rev-parse --show-toplevel`): %s)")
    else
        # find the root git directory
        GIT_DIR=$(git rev-parse --git-dir 2> /dev/null || echo 'aaa')
        # if it doesn't exist, then print nothing
        if [ "$GIT_DIR" == "aaa" ]; then
            echo ''
        else
            echo $(__git_ps1 "($(basename `git rev-parse --show-toplevel`): %s)")
        fi;
    fi;
}

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u${GRAY}:${BLUE}\w${YELLOW} \$(get_git_branch)${GRAY}\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# restart mysql if it isn't running
MYSQL_RUNNING=$(sudo service mysql status)
if [ "$MYSQL_RUNNING" == " * MySQL is stopped." ]; then
    sudo service mysql restart
fi

# allow X11 to work
# old way was to use resolv.conf
#export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0.0"
# newer way was to use ip route list
export DISPLAY=$(ip route list default | awk '{print $3}'):0
# newest way is to just let WSLg take over and you don't need to do anything. No X server required. However, there are major performance issues

export LIBGL_ALWAYS_INDIRECT=1

export XDG_RUNTIME_DIR='/tmp/runtime-kkovacs/'

# global location for node.js
export NODE_PATH=/usr/local/lib/node_modules/

# add docker to path
export PATH="$PATH:$HOME/.local/bin"

# define docker host
export DOCKER_HOST=tcp://localhost:2375

# add sqlcmd to path
export PATH="$PATH:/opt/mssql-tools/bin"

## add /usr/lib to library search path to find mysql c++ library
export LD_LIBRARY_PATH=/usr/lib

# add confd to path
source /opt/confd/confdrc

# set docker host
export DOCKER_HOST=tcp://localhost:2375

# make the cursor a blinking underscore
printf '\033[3 q'

# go home immediately
#home

# hide the PS1 for demo videos
#PS1="$ "

# set up z (https://github.com/rupa/z)
. /home/kkovacs/z/z.sh

export EDITOR=vim

# source rust thingy
. "$HOME/.cargo/env"
