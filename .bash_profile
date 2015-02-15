####################################
# ~/.bash_profile -bash  profile
#
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bash_profile
#
# ########################################
# umask 022

# .bashrc calls .bash_aliases and .bash_functions

[[ -r ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# my prefered bin
if [ -d "$HOME/.local/bin" ]; then
   PATH="$HOME/.local/bin:$PATH"
fi

# system variables
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANT_HOME=/media/data/Tools/ant-1.9.1
export NODE_WEBKIT=/media/data/Tools/node-webkit
export MAVEN_OPTS="-Xms128m -Xmx1024m"
export M2_HOME=/media/data/Tools/apache-maven-3.2.3
export ROO_HOME=/media/data/Tools/spring-roo-1.2.5
export PHANTOM_HOME=/media/data/Tools/phantomjs-1.9.7-linux-x86_64
export PYTHON=python2

PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ROO_HOME/bin:$ANT_HOME/bin:$PATH
PATH=$PHANTOM_HOME/bin:$NODE_WEBKIT/bin:$PATH


echo 'bash_profile'
