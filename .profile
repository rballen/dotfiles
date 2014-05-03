####################################
# ~/.profile - profile for debian based distros
#
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.profile
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
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export ANT_HOME=/media/data/Tools/ant-1.9.1
export NODE_WEBKIT=/media/data/Tools/node-webkit/bin
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m"
export M2_HOME=/media/data/Tools/maven-3.0.4
export ROO_HOME=/media/data/Tools/spring-roo-1.2.4.
export CATALINA_OPTS="-Xms128m -Xmx1024m -XX:MaxPermSize=256m"
export CATALINA_HOME=/media/data/Tools/tomcat-8.0.3
#export ATLAS_HOME=/media/data/Tools/atlassian-plugin-sdk
# export VAGRANT_HOME=/opt/vagrant/bin
#ANDROID_HOME=/media/data/Tools/android-sdk-linux/tools
#ANDROID_PTOOLS=/media/data/Tools/android-sdk-linux/platform-tools
export PHANTOM_HOME=/media/data/Tools/phantomjs-1.9.2-linux-x86_64
#export GOROOT=$HOME/Projects/go
export GOPATH=/usr/bin/go
JSHINT=/home/ra/.nvm/v0.10.28/bin/jshint

# export PATH
PATH=$NVM_BIN:$PHANTOM_HOME/bin:$NODE_WEBKIT:$JAVA_HOME/bin:$M2_HOME/bin:$ROO_HOME/bin:$ANT_HOME/bin:$JSHINT:$PATH
#PATH=$ANDROID_HOME/bin:$ANDROID_PTOOLS/bin:$PATH
#PATH=$VAGRANT_HOME/bin:$PATH
#PATH="$DROID_HOME/bin:$DROID_HOME/sdk/tools:$DROID_HOME/sdk/platform-tools:$PATH"



echo '.profile'
