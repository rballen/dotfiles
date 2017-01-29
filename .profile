# ~/.profile: executed by the command interpreter for login shells.  # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 002

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# my prefered bin
if [ -d "$HOME/.local/bin" ]; then
   PATH="$HOME/.local/bin:$PATH"
fi

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export JAVA_OPTS="-Xmx1024m -Djava.security.egd=file:/dev/./urandom"
export ANT_HOME=/media/data/Tools/ant-1.9.1

export MAVEN_OPTS="-Xmx1024m -Djava.security.egd=file:/dev/./urandom"
# -Xms256m -Xmx512m
export M2_HOME=/media/data/Tools/maven-3.3.9
export ROO_HOME=/media/data/Tools/spring-roo-2.0.0.M2
export CATALINA_HOME=/media/data/Tools/tomcat-8.0.27
#export IDEA_HOME=/home/ra/bin/idea-15.0.3/bin

export ROBO_HOME=/opt/robomongo
PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$ROBO_HOME/bin:$PATH


export GOPATH=/home/ra/Projects/go
#export PATH=$PATH:/usr/local/go/bin


export SASS_LIBSASS_PATH="$HOME/bin/libsass"
export IBUS_ENABLE_SYNC_MODE=1
echo 'profile'
