####################################
# ~/.bash_profile
#
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
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
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export ANT_HOME=/media/data/Tools/ant-1.9.1
export NODE_WEBKIT=/media/data/Tools/nwjs-v0.12.1-linux-x64
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m"
export M2_HOME=/media/data/Tools/maven-3.2.3
export ROO_HOME=/media/data/Tools/spring-roo-1.3.1
export CATALINA_OPTS="-Xms128m -Xmx1024m -XX:MaxPermSize=256m"
export CATALINA_HOME=/media/data/Tools//apache-tomcat-8.0.15
#export ATLAS_HOME=/media/data/Tools/atlassian-plugin-sdk
# export VAGRANT_HOME=/opt/vagrant/bin
#ANDROID_HOME=/media/data/Tools/android-sdk-linux/tools
#ANDROID_PTOOLS=/media/data/Tools/android-sdk-linux/platform-tools
export PHANTOM_HOME=/media/data/Tools/phantomjs-1.9.8-linux-x86_64
export GOROOT=$HOME/bin/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$GOROOT/bin
#JSHINT=/home/ra/.nvm/v0.10.28/bin/jshint

# export PATH
PATH=$PHANTOM_HOME/bin:$NODE_WEBKIT:$JAVA_HOME/bin:$M2_HOME/bin:$ROO_HOME/bin:$ANT_HOME/bin:$PATH
#PATH=$JSHINT:$PATH
#PATH=$ANDROID_HOME/bin:$ANDROID_PTOOLS/bin:$PATH
#PATH=$VAGRANT_HOME/bin:$PATH
#PATH="$DROID_HOME/bin:$DROID_HOME/sdk/tools:$DROID_HOME/sdk/platform-tools:$PATH"


echo 'bash_profile'
