# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export JAVA_HOME=/usr/lib/jvm/java-10-oracle
export ANT_HOME=/home/ra/bin/apache-ant-1.9.13
export M2_HOME=/home/ra/bin/apache-maven-3.5.4
export CATALINA_HOME=/home/ra/bin/apache-tomcat-9.0.10
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=128m"


PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$PATH

export PATH=$PATH:/usr/local/go/bin


echo ".profile"
