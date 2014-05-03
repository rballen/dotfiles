dotfiles
========
started overand cleaned up, updated and consolidated dotfiles

I have a common home on /media/data/home for things I can share between distros.
Then in my distro home or ~/, I sym link to the files and folders in /media/data/home/dotfiles,
thus keeping everything in order for a multiboot system.

```sh
git clone https://github.com/rballen/dotfiles.git
cd dotfiles
chmod  +x dotfiles.sh
./dotfiles.sh
```

### dotfiles.sh contents
```sh
#!/bin/bash
mkdir -p /media/data/home
cd /media/data/home
git clone https://github.com/rballen/dotfiles.git
cd dotfiles

mkdir -p ~/.backup
cp ~/.profile ~/.bash_profile ~/.bashrc ~/.bash_aliases ~/.backup

# arch, manjaro or ubuntu, debian, elementaryOS, xubuntu (voyager)
if [ -f /etc/debian_version ] ; then
   ln -s /media/data/home/dotfiles/profile ~/.profile
elif [ -d /etc/pacman.d ] ; then
   ln -s /media/data/home/dotfiles/bash_profile ~/.bash_profile
fi

ln -s /media/data/home/dotfiles/bashrc ~/.bashrc
ln -s /media/data/home/dotfiles/bash_aliases ~/.bash_aliases
ln -s /media/data/home/dotfiles/bash_functions ~/.bash_functions
ln -s /media/data/home/dotfiles/gtk-bookmarks-acer ~/.gtk-bookmarks
ln -s /media/data/home/dotfiles/gitignore ~/.gitignore
ln -s /media/data/home/dotfiles/gitconfig ~/.gitconfig
ln -s /media/data/home/dotfiles/gemrc/ ~/.gemrc
ln -s /media/data/home/dotfiles/httrack.ini ~/.httrack.ini
ln -s /media/data/home/dotfiles/sdirs ~/.sdirs
ln -s /media/data/home/dotfiles/vimrc ~/.vimrc
ln -s /media/data/home/dotfiles/vim/ ~/.vim
ln -s /media/data/home/dotfiles/jCodeCollector/ ~/.jCodeCollector
```