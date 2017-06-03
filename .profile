# ~/.profile: executed by the command interpreter for login shells.  # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# for ssh logins, install and configure the libpam-umask package.
# same group can read ~/
if [ "$(id -gn)" = "$(id -un)" -a $EUID -gt 99 ] ; then
  umask 002
else
  umask 022
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi

    # set PATH so it includes user's private bin if it exists
	if [ -d "$HOME/bin" ] ; then
	    PATH="$HOME/bin:$PATH"
	fi

	# my prefered bin
	if [ -d "$HOME/.local/bin" ]; then
	   PATH="$HOME/.local/bin:$PATH"
	fi
fi

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export ANT_HOME=/media/data/Tools/ant-1.9.1
export M2_HOME=/media/data/Tools/maven-3.3.9
export ROO_HOME=/media/data/Tools/spring-roo-2.0.0.M2
export CATALINA_HOME=/media/data/Tools/tomcat-8.0.27
export ROBO_HOME=/opt/robomongo
export IBUS_ENABLE_SYNC_MODE=1            # for intelli/android studio
export GTK2_RC_FILES=/home/ra/.gtkrc-2.0  # for anki

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export JAVA_OPTS="-Xmx1024m -Djava.security.egd=file:/dev/./urandom"
export MAVEN_OPTS="-Xmx1024m -Djava.security.egd=file:/dev/./urandom"
# -Xms256m -Xmx512m
#export GOPATH=/home/ra/Projects/go

PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$ROBO_HOME/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

echo "~/.profile"
