####################################
# ~/.bashrc - ever a work in progress
#
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.githubusercontent.com/rballen/dotfiles/master/.bashrc
#
# sudo groupadd robuntu -g 1111; sudo groupadd dev -g 1112; # add new groups
# sudo usermod -aG robuntu,dev,fuse $USER;                  # add $USER to these groups
# sudo usermod -g dev $USER;                                # change $USER's primary group to dev
# ########################################
# umask 022

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
HISTCONTROL=ignoreboth   # don't put duplicate lines or lines starting with space history.

export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    # alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


## ALIAS & FUNCTION DEFINITIONS
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1="\[\e[32m\]\$(parse_git_branch)\[\e[34m\]\h:\W \$ \[\e[m\]"
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] $ '
export PS1
export SASSPATH=.    # sublime

export CHEATCOLORS=true

# helps with accessibility bus console errors
export NO_AT_BRIDGE=1

# https://github.com/huyng/bashmarks
# git clone git://github.com/huyng/bashmarks.git; cd bashmarks; make install
# cd ~/ ; wget https://raw.githubusercontent.com/rballen/dotfiles/master/.sdirs
. ~/.local/bin/bashmarks.sh

## RUBY & GEMS
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"


# NVM NODEJS - added to path on xubuntu 14.04 and v0.10.28
export NVM_DIR="$HOME/.nvm"
source $HOME/.nvm/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
PATH=$NVM_BIN:$PATH
export NVM_IOJS_ORG_MIRROR=https://iojs.org/dist
export PYTHON=python2

# docker
. ~/.docker-compose


echo "bashrc"

export SASS_SPEC_PATH=/home/ra/bin/sass-spec
export SASS_SASSC_PATH=/home/ra/bin/sassc
export SASS_LIBSASS_PATH=/home/ra/bin/libsass

export SASSC_HOME=/home/ra/bin/sassc


PATH=$SASSC_HOME/bin:$PATH
