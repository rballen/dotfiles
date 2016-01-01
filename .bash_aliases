####################################
# ~/.bash_aliases
# use \alias to disable temporarily
# check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bash_aliases
#
# sourced in ~/.bashrc
#
# type 'whatalias'  for full list of aliases
# type 'dowhatnow'  for list of functions
####################################
# grep -ir "my phrase" *.txt
#
#
# list all aliases on system
alias whatalias="alias -p | cut -d= -f1 | cut -d' ' -f2"

# debugging
alias size='df -h'
alias whatport='netstat -tulpn'
alias free='free -m'
alias myports='netstat –lp --inet'
alias memhog='ps -elf|awk "{print \$10, \$3, \$4, \$15, \$16}"|sort -nr|head'
alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'
alias myip='curl icanhazip.com'
alias ping='ping -c 5'
alias headers='curl -I'
alias monitor='gnome-system-monitor'

# distro
alias whichdistro='cat /etc/*-release'

# ls
alias ll='ls -Alh'                       # l = long list, A = not . or .., h = human readable size
alias ls='ls -F --color=auto'            # F = append */=>@| to entries(file,dir,sym link)
alias lsc='ls | wc -l'                    # count files
alias lsd='ls -d */'                      # list dirs only
alias l.='ls -d .*'                       # show hidden files
#alias l='ls -CF'
alias listnew='ls -ltc'
alias nc='--color=no'

### grep
alias grep='grep -ir --color=auto'
alias fgrep='fgrep -ir --color=auto'
alias egrep='egrep -ir --color=auto'

# app aliases
alias vi='vim'
alias less='less -r'
alias newcheat='cheat -e'
alias style="sassc style.scss style.css"
alias dimmer="xrandr --output HDMI1 --brightness 0.8"
alias restclient='java -jar /media/resources/Tools/restclient-ui-3.5-jar-with-dependencies.jar &'


### docker
alias docker-stop='docker rm -v $(docker ps -a -q -f status=exited)'
#delete dangling images
alias docker-del='docker rmi $(docker images -q -f dangling=true)'



### files i reference or update a lot
alias editkeys="haroopad /media/data/Dropbox/Documents/documents/keyboard-shortcuts.md"
alias openkeys="firefox /media/data/Dropbox/Documents/documents/keyboard-shortcuts.html"
alias editbash="subl ~/git//media/data/Dropbox/Documents/documents/bash.md"
alias editcommands="subl /media/data/Dropbox/Documents/documents/commands.md"
alias editnotes="subl /media/data/Dropbox/notes.txt"
alias editro="subl /media/data/Dropbox/Documents/documents/roResources.json"
alias editwebdev="subl /media/data/Dropbox/Documents/documents/webdev-resources.md"


### sublime text
alias subldot="subl --project ~/.sublime/dot.sublime-project"
alias subllinux="subl --project ~/.sublime/linux.sublime-project"
alias subldocker="subl --project ~/.sublime/docker.sublime-project"
alias sublmaterial="subl --project ~/.sublime/material.sublime-project"
alias sublom="subl --project ~/.sublime/ombuntu.sublime-project"
alias sublpublic="subl --project ~/.sublime/public.sublime-project"
alias sublresources="subl --project ~/.sublime/resources.sublime-project"




alias private='encfs -i 5 /media/data/home/.private /home/ra/.private'

# git
alias gstat='git status -sb'
alias greset='git fetch --all;git reset --hard origin/master'

### webdev
alias rip='wget -E -H -k -K -p -U mozilla'      # THE wget that everyone wants :)
# wget -r -nc -p -k -np --user-agent="Mozilla/5.0 (Windows NT 6.2; rv:22.0) Gecko/20130405 Firefox/23.0" --html-extension --restrict-file-names=windows --domains=example.com example.com http://flattyshadow.com/

#    -r: recursive download
#    -nc: no-clobber or skip downloads on existing files
#    -p: get all page requisites to properly display html
#    -k: convert links to working local files
#    -np: don’t ascend to parent directory
#    –user-agent: as AGENT
#    –html-extension: make sure downloaded files will have its corresponding suffixes
#    –restrict-file-names: filenames that will also work on windows
#    –domains: domain/s to be followed

alias bs='bower search'
alias bi='bower install --save'
alias ni='npm install --save'
alias ls-node='ls ~/.nvm/versions/node/"$(node --version)"/lib/node_modules/'  # cant read ls npm -g


# youtube-dl
alias ytl='youtube-dl -F'       # list youtube formats
alias ytv='youtube-dl --restrict-filenames -f 18/22'    # download video
alias ytm='youtube-dl --restrict-filenames --extract-audio --audio-format mp3 --audio-quality 5'



# jars
alias piggydb='java -jar /media/data/Tools/piggydb-standalone/piggydb-standalone.jar'
alias jcc='java -jar /media/data/Tools/jcodecollector/jcodecollector.jar -Dderby.system.home=~/.jCodeCollector &'


# typos
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias clonse='clone'


alias su='sudo -i'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'

## use same .bash_alias for debian based and arch based
if [ -f /etc/debian_version ] ; then

   # xfce voyager (le mellieur) , elementaryOS aliases

   alias sourceme="source ~/.profile"      #reload
   alias server="google-chrome http://$HOSTNAME:3000; python -m SimpleHTTPServer 3000"
   alias install='sudo apt-get install -y'
   alias update='sudo apt-get update'
   alias upgrade='sudo apt-get upgrade'
   alias autoremove='sudo apt-get autoremove'
   alias uninstall='sudo apt-get remove --purge'
   alias add='sudo add-apt-repository'
   alias search='apt-cache search'
   alias clean='sudo apt-get clean'
   alias autoclean='sudo apt-get autoclean'
   alias listapps='dpkg --list'
   alias backupapps='dpkg --get-selections > /media/data/Dropbox/Documents/Technology/linux/packages-ubuntu.txt'

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

fi

echo 'bash_aliases'
