####################################
# ~/.bash_aliases
#
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bash_aliases
#
# sourced in ~/.bashrc
#
# type 'whatalias'  for full list of aliases
# type 'dowhatnow'  for list of functions
####################################

# list all aliases on system
alias whatalias="alias -p | cut -d= -f1 | cut -d' ' -f2"
alias newalias="cp /media/data/Project/github/rballen/dotfiles/.bash_aliases ~/"

# debugging
alias whatport='netstat -tulpn'
alias free='free -m'
alias myports='netstat –lp --inet'
alias memhog='ps -elf|awk "{print \$10, \$3, \$4, \$15, \$16}"|sort -nr|head'
alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'
alias myip='curl icanhazip.com'

# distro
alias whichdistro='cat /etc/*-release'

# ls
alias ll='ls -Alh'                       # l = long list, A = not . or .., h = human readable size
alias ls='ls -F --color=auto'            # F = append */=>@| to entries(file,dir,sym link)
alias lsc='ls | wc -l'                    # count files
alias lsd='ls -d */'
#alias l='ls -CF'
alias listnew='ls -ltc'
alias nc='--color=no'

# app aliases
alias vi='vim'
alias less='less -r'

#alias grep='grep -ir --color=auto'
#alias fgrep='fgrep -ir --color=auto'
#alias egrep='egrep -ir --color=auto'

#terminal helpers
alias myterm="xfce4-terminal --tab --title=www --tab --title=robuntu"

# files i reference or update a lot
alias editkeys="haroopad /media/data/Dropbox/Documents/documents/keyboard-shortcuts.md"
alias openkeys="firefox /media/data/Dropbox/Documents/documents/keyboard-shortcuts.html"
alias editbash="subl /media/data/Dropbox/Documents/documents/bash.md"
alias editcommands="subl /media/data/Dropbox/Documents/documents/commands.md"
alias editnotes="subl /media/data/Dropbox/Documents/documents/notes.txt"
alias editro="subl /media/data/Dropbox/Documents/documents/roResources.json"
alias editwebdev="subl /media/data/Dropbox/Documents/documents/webdev-resources.md"
alias editemmet="subl /media/data/Dropbox/Documents/documents/emmet.md"
alias ffn='firefox-trunk -no-remote -P "nightly"'
alias monitor='gnome-system-monitor'


# sublime text
alias sublrballen="subl --project /media/data/Dropbox/Apps/sublime/rballen.sublime-project"
alias subldata="subl --project /media/data/Dropbox/Apps/sublime/data.sublime-project"
alias sublrobuntu="subl --project /media/data/Dropbox/Apps/sublime/robuntu.local.sublime-project"


# utils better-->https://github.com/benlinton/bash-slugify
alias slug="rename 'y/ /-/' *"            # convert space to dash
#slug=$(echo $title | sed "s/[\.':]//g;s/ /-/g" | tr 'A-Z' 'a-z')
alias rmsyms="find . -maxdepth 1 -type l -exec rm -f {} \;"

alias mountiso="sudo mount -o loop -t iso9660 $1 /media/iso"
alias umountiso="sudo umount -lf /media/iso"
alias makeiso="sudo dd if=/dev/cdrom of=/media/data/Videos/$1.iso"

alias search="google-chrome $1"
alias gmobile='google-chrome --disable-web-security'   #used with phonegap
alias private='encfs -i 5 /media/data/home/.private /home/ra/.private'

# git
alias gstat='git status -sb'
alias greset='git fetch --all;git reset --hard origin/master'

# webdev
alias rip='wget -E -H -k -K -p -U mozilla'      # THE wget that everyone wants :)
alias cw='compass watch'
alias cc='compass compile'
alias bs='bower search'
alias bid='bower install --save-dev'
alias nid='npm install --save-dev'
alias ls-npm='ls ~/.nvm/versions/node/v0.12.2/lib/node_modules/'  #  npm ls -g should be this and not every package
# media
alias ytl="youtube-dl -F"   # list available formats
alias yt="youtube-dl -f 18" # best for mp4
alias ytm="youtube-dl $1 --extract-audio --audio-format mp3"  #extract mp3



# jars
alias piggydb='java -jar /media/data/Tools/piggydb-standalone/piggydb-standalone.jar'
alias jcc='java -jar /media/data/Tools/jcodecollector/jcodecollector.jar -Dawt.useSystemAAFontSettings=o'


# typos
alias cd..='cd ..'
alias ..='cd ..'
alias clonse='clone'

if [ -f /etc/debian_version ] ; then

   # xfce voyager (le mellieur) , elementaryOS aliases

   alias sourceme="source ~/.profile"      #reload
   alias server="google-chrome http://$HOSTNAME:3000; python -m SimpleHTTPServer 3000"
   alias install='sudo apt install'
   alias update='sudo apt update'
   alias upgrade='sudo apt upgrade'
   alias autoremove='sudo apt-get autoremove'
   alias uninstall='sudo apt-get remove --purge'
   alias add='sudo add-apt-repository'
   alias search='apt-cache search'
   alias clean='sudo apt-get clean'
   alias autoclean='sudo apt-get autoclean'
   alias listapps='dpkg --list'
   alias backupapps='dpkg --get-selections > /media/data/Dropbox/Documents/Technology/linux/packages-ubuntu.txt'
   alias restoreapps='dpkg --set-selections < /media/data/Dropbox/Documents/Technology/linux/packages-ubuntu.txt'

elif [ -d /etc/pacman.d ] ; then

   # arch aliases

   alias sourceme="source ~/.bash_profile"      #reload
   alias server="google-chrome http://$HOSTNAME:4000; python3 -m http.server 4000"
   alias upgradeall='yaourt -Syua'
   alias update='sudo pacman -Syy'
   alias upgrade='sudo pacman -Syu'
   alias sync='sudo pacman -Syyu'
   alias upgradeaur='yaourt -Syu --aur'
   alias install='yaourt -S'
   alias uninstall='sudo pacman -Rns'
   alias search='yaourt -Ss'                       #  searching  packages' names and descriptions
   alias info='pacman -Si'                         #  detailed info
   alias orphan='sudo pacman -Qdt'                 #  list all orphaned packages
   alias autoremove="sudo pacman -Rns $(pacman -Qdtq)"  # remove orphaned packages
   alias clean="sudo pacman -Sc"                   # clean cache and outdated packages; better:  sudo cacheclean -v 2
   alias listapps='pacman -Qe'
   alias backupapps='pacman -Qe > /home/ra/Dropbox/Apps/backup/packages-arch.txt'

   # Pacman aliases from arch hq
   alias pacupg='sudo pacman -Syu'  # Synchronize repos and upgrade packages
   alias pacdl='pacman -Sw'      # Download specified package(s) as .tar.xz ball
   alias pacin='sudo pacman -S'     # Install specific package(s) from the repositories
   alias pacins='sudo pacman -U'    # Install specific package not from the repositories but from a file
   alias pacre='sudo pacman -R'     # Remove specified package(s), keeping its configuration(s) and dependencies
   alias pacrem='sudo pacman -Rns' # Remove specified package(s), configuration(s) and unneeded dependencies
   alias pacrep='pacman -Si'     # Display information about a given package in the repositories
   alias pacreps='pacman -Ss'    # Search for package(s) in the repositories
   alias pacloc='pacman -Qi'     # Display information about a given package in the local database
   alias paclocs='pacman -Qs'    # Search for package(s) in the local database
   alias paclo="pacman -Qdt"     # List all packages which are orphaned
   alias pacc="sudo pacman -Scc"    # Clean cache - delete all the package files in the cache
   alias paclf="pacman -Ql"      # List all files installed by a given package
   alias pacown="pacman -Qo"     # Show package(s) owning the specified file(s)
   alias pacexpl="pacman -D --asexp"   # Mark one or more installed packages as explicitly installed
   alias pacimpl="pacman -D --asdep"   # Mark one or more installed packages as non explicitly installed

   # Additional pacman alias examples
   alias pacupd='sudo pacman -Sy && sudo abs'   # Update refresh the local package and ABS databases against repositories
   alias pacinsd='sudo pacman -S --asdeps'      # Install given package(s) as dependencies
   alias pacmir='sudo pacman -Syy'              # Force refresh of package lists after updating /etc/pacman.d/mirrorlist

fi



echo 'bash_aliases'
