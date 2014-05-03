####################################
# ~/.bashrc - ever a work in progress
#
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bashrc
#
# sudo groupadd robuntu -g 1111; sudo groupadd dev -g 1112; # add new groups
# sudo usermod -aG robuntu,dev,fuse $USER;   # add $USER to these groups
# sudo usermod -g dev $USER;                 # change $USER's primary group to dev 
# ########################################
# umask 022

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#shopt -s globstar # **  in a pathname expansion matches all files and zero or more dirs, subdirs
#shopt -s cdspell
shopt -s checkwinsize      #update the values of LINES and COLUMNS.
# shopt -s cmdhist
# shopt -s dotglob
# shopt -s expand_aliases
# shopt -s extglob
shopt -s histappend
# shopt -s hostcomplete
# shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth   # don't put duplicate lines or lines starting with space history.
export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome


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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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



# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h  \w\[\033[0;32m\]\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '

PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] $ '


function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1="\[\e[32m\]\$(parse_git_branch)\[\e[34m\]\h:\W \$ \[\e[m\]"
export PS1

export SASSPATH=.

# https://github.com/huyng/bashmarks
. ~/.local/bin/bashmarks.sh

## RUBY & GEMS
# \curl -L https://get.rvm.io | bash -s stable --ignore-dotfiles
# source ~/.rvm/scripts/rvm
# rvm list known; rvm install 2.0.0 --autolibs=2; <install missing packages>; rvm install 2.0.0  --autolibs=2;
# echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
# echo '. "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
#
. "$HOME/.rvm/scripts/rvm"


## NVM, NPM & NODEJS
# git clone https://github.com/creationix/nvm.git ~/.nvm
# . ~/.nvm/nvm.sh;
# nvm ls-remote; nvm install v0.10.26; nvm use 0.10.26; nvm alias default 0.10.26
#
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
[[ -r "$HOME/.nvm/bash_completion" ]] && . "$HOME/.nvm/bash_completion"
#export node_path="$HOME/.nvm/v0.11.6/bin/node"


## ALIAS & FUNCTION DEFINITIONS
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions


echo '.bashrc'

