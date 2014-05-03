dotfiles
========
started over and cleaned up, updated and consolidated dotfiles


```sh
git clone https://github.com/rballen/dotfiles.git
cd dotfiles
chmod  +x dotfiles.sh
./dotfiles.sh
```

### dotfiles.sh contents
```sh
#!/bin/bash
mkdir -p ~/.backup
mv ~/.profile ~/.bash_profile ~/.bashrc ~/.bash_aliases ~/.backup

git clone https://github.com/rballen/dotfiles.git
cd dotfiles

# arch, manjaro or ubuntu, debian, elementaryOS, xubuntu (voyager)
if [ -f /etc/debian_version ] ; then
   cp .profile ~/
elif [ -d /etc/pacman.d ] ; then
   cp .bash_profile ~/
fi

cp .bashrc ~/
cp .bash_aliases ~/
cp .bash_functions ~/
cp .gtk-bookmarks-acer ~/
cp .gitignore ~/
cp .gitconfig ~/
cp .gemrc/ ~/
cp .httrack.ini ~/
cp .sdirs ~/
cp .vimrc ~/
cp .vim/ ~/
cp .jCodeCollector/ ~/
```
