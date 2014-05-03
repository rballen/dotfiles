####################################
# ~/.bash_functions - somewhat useful collection of functions
#
# @TODO finish linting check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bash_functions
#
# sourced in ~/.bashrc
#
# type 'whatalias'  for full list of aliases
# type 'dowhatnow'  as a reminder for all my functions lest i forgive, i mean forget
####################################

# @ra; make these into functions; prompt for distro & version
#cat /etc/os-release | perl -n -e '/^NAME=\"([a-zA-Z ]*)\"$/ && print "$1\n"'
#alias listapps='dpkg --list'
#alias backupapps='dpkg --get-selections > ~/Dropbox/Documents/Technology/packages-lsb_release.txt'
#alias restoreapps='dpkg --set-selections < ~/Dropbox/Documents/Technology/packages-lsb_release.txt'
#alias listarch='pacman -Qe > ~/Dropbox/Documents/Technology/packages-arch.txt'


# lists all my reminder functions
alias dowhatnow="overview | less"

function overview () {
  echo '--------------------------'
  echo 'bashmarks -->       list commands for ~/.local/bin/bashmarks'
  echo 'dowhatnow -->       list functions in ~/.bash_functions'
  echo 'whatalias -->       list aliases in ~/.bash_aliases'
  echo 'rakeys    -->       list all my and snipppet triggers and eventually key bindings'
  echo '--------------------------'

  echo -e '\E[37;44m'"\033[1mstats\033[0m"
  echo "my_ps ( ) ---> list ps"
  echo "pp ( ) ---> xxxxx"
  echo "my_ip ( ) ---> show my ip"

  echo -e '\E[37;44m'"\033[1maudio-video\033[0m"
  echo "getMp3 ( videofile ) ---> convert video to 160k cbr mp3"
  echo "getMp4 ( videofile ) ---> convert video to mp4 - leave original sizing"
  echo "makeiso ( name.iso ) ---> convert dvd to iso"
  echo "mountiso ( name.iso ) ---> mount iso to /mnt/iso dvd to iso"
  echo "umountiso ( name.iso ) ---> convert dvd to iso"
  echo "ripdvd ( name.mp4 ) ---> rip the dvd to mp4"
  echo "rotate ( ) ---> autorotates all JPGs in dir"
  echo "thumbs-med ( ) ---> autorotates and resizes all jpgs to max h/w of 450"


  echo -e '\E[37;44m'"\033[1mfile manipulation\033[0m"
  echo "noserver( file, cssPreFix, jsPreFix ) ---> replace /css-prefix.css with css/file.css and same for js"

  echo "extract( file ) ---> extracts any archive"
  echo "extractToFolder ( )  ---> created folder based on name and extract into it"
  echo "md2html (file ) ---> convert file to markdown"
  echo "all2html ( ) ---> convert all files in dir to markdown"
  echo "encrypt ( file) ---> encrypt file using gpg"
  echo "decrypt ( file) ---> decrypt file using gpg"
  echo "lowercase ( ) ---> mv's all files in dir to lowercase"
  echo "removeM ( file ) ---> removes the damned ^M"
  echo "moveUp (extension ) ---> mv all ./**/*.extension ./"
  echo "prepend (text file) --> add text to begining of every line"
  echo "append (text file) --> add text to end of every line"

  echo -e '\E[37;44m'"\033[1mimage magick\033[0m"
  echo "rotate ( ) ---> autorotates all JPG's in dir"
  echo "thumbsx480 ( ) ---> autorotates and resizes all jpg's to max h/w of 450"

  echo -e '\E[37;44m'"\033[1mother\033[0m"
  echo "sourceme() --> re-source yourself bitch ~/.profile"
  echo "ff ( name ) ---> find a file whose name contains given string"
  echo "gc ( gitUrl) ---> clones the repo and converts md to html"
  echo "say ( ) ---> clones the repo and converts md to html"
  echo "say-translation (language phrase) ---> say-translation es come with me"

}

# list bashmarks' commands
function bashmarks () {
  echo -e '\E[37;44m'"\033[1mbashmarks\033[0m"
  echo 'https://github.com/huyng/bashmarks'
  echo " s bookmarkname - saves the curr dir as bookmarkname"
  echo " g bookmarkname - jumps to the that bookmark"
  echo " g b[TAB] - tab completion is available"
  echo " p bookmarkname - prints the bookmark"
  echo " p b[TAB] - tab completion is available"
  echo " d bookmarkname - deletes the bookmark"
  echo " d [TAB] - tab completion is available"
  echo " l - list all bookmarks"
}

function rakeys () {
  echo 'ramdhtml ----> sublime-text html, markdown or md file for strapdown snippet'
  echo 'ratbfluid ----> sublime-text html file for twitter bootstrap fluid standalone page snippet'
  echo 'raajax ----> sublime-text html file for zurb foundation4 fluid standalone page snippet'
  echo 'rajq ----> sublime-text html file for jquery document.ready snippet'

}

########### functions
function extract () {
  if [ -f "$1" ] ; then
    case "$1" in
          *.tar.bz2) tar xjf "$1" ;;
          *.tar.gz) tar xzf "$1" ;;
          *.bz2) bunzip2 "$1" ;;
          *.rar) unrar e "$1" ;;
          *.gz) gunzip "$1" ;;
          *.tar) tar xf "$1" ;;
          *.tbz2) tar xjf "$1" ;;
          *.tgz) tar xzf "$1" ;;
          *.zip) unzip "$1" ;;
          *.Z) uncompress "$1" ;;
          *.7z) 7z x "$1" ;;
          *) echo "'$1' cannot be extracted " ;;
        esac
    else
    echo "'$1' is not a valid file"
  fi
}

# to serve files with a server change  "/dir/file.css" to "css/file.css" same for *.js
function noserver( ) {
# file = $1; cssPrefix = $2; jsPrefix = $3;
  // sudo sed -i 's/"\/css/"css/g' $1
  sed -i 's|$2|"css|g'  $1
  sed -i 's|$3|"js|g'  $1

}

# find a file whose name contains a given string
ff() {
    find . -type f -iname '*'$*'*' ;
}

# creates folder based on filename and extracts zip into it
function extractToFolder() {
 for f in *.zip
    do
      if [ -d "${f%.*}"  ];
      then
        echo "you already have dir $f ....skipping"
      else
        mkdir "${f%.*}"
        unzip "$f"  -d "${f%.*}"
      fi
   done
}

# move filenames to lowercase
function lowercase() {
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}


function moveUp (){
 folderlist='ls -d */'
 for f in $folderlist
 do
     mv $f/* .
 done
}

function prepend() {
  sed -i "s/$/$1/"  $2
}

function append() {
  sed -i 's/^/"$1"/'  $2
}

function removeM(){
   sudo sed -i 's/^M///g' $1
   #alias removeM="sudo sed -i 's/^M///g'"
}

function my_ps() {
  ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ;
}

function pp() {
  my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ;
}

function my_ip() {
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | \
sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | \
sed -e s/P-t-P://)
}

# demux - convert audio to 160k mp3
function getMp3(){
   filename=$(basename "$1")
   filename="${filename%.*}"

   #ffmpeg -i "My Video File.mp4"  -ab 128 "My Video File.mp3"
   ffmpeg -i "$1" -vn -ar 44100 -ac 2 -ab 160k -f mp3 $filename.mp3
}

# convert video to mp4 - leave original sizing -
function getMp4 () {
  filename=$(basename "$1")
  filename="${filename%.*}"

  #ffmpeg -i "$1" -c:v libx264 -b:v 1000k -maxrate 1500k -bufsize 1000k -profile:v baseline c:a aac -b:a 96k output.mp4

  #ffmpeg -i input -c:v libx264 -preset medium -qp 0 output.mp4
  #  ffmpeg -i "$1" -acodec aac -ac 2 -strict experimental -ab 128k -vcodec libx264 -preset slow \
#   -profile:v baseline -level 30 -maxrate 10000000 -bufsize 10000000 -b 1200k -f mp4 -threads 0 $filename.mp4
}

# "$1" is name.iso ; if /dev/cdrom doesn't work use /dev/sr0
function makeiso () {
  sudo dd if=/dev/sr0 of=/media/data/Videos/$1
}

function mountiso() {
  mount -o loop -t iso9660 "$1" /mnt/isoimage
}

function umountiso (){
  umount -lf /mnt/isoimage
}

# create iso on hd then convert iso to mp4 or what not
function ripdvd () {
  makeiso $1
  sudo dd if=/dev/cdrom of=/media/data/Videos/$1.iso
}

# convert single file to markdown
function md2html() {
  cat "$1" | marked > ${1%.*}.html
}

# converts all markdown (*.md or *.markdown) into html.
# filename: ${file%.*}
# ext= ${file##*.}
function all2html() {
    shopt -s nullglob

    for f in *.md
    do
      cat $f | marked > ${f%.*}.html
      #rm $f
    done

    for f in *.markdown
    do
      cat $f | marked > ${f%.*}.html
      #rm $f
    done
}


#encrypt any file
function encrypt (){
  gpg -ac --no-options "$1"
}

#udecrypt same file
decrypt (){
  gpg --no-options "$1"
}


# imagemagick

alias rotate='jhead -autorot *.JPG'
# x480
function thumbs-med (){
  filelist=`ls | grep -i '.jpg'`
  mkdir -p thumbs
  for f in $filelist
  do
    convert $f -auto-orient -resize x480 -unsharp 0x.5 ./thumbs/${f%.*}_x480.jpg
  done
}

echo '.bash_functions'

#####
# scripts from https://github.com/gotbletu


# http://www.youtube.com/watch?v=UhVKuAozSMc
say() {
        # limit to 100 character or less
        # language code: http://developers.google.com/translate/v2/using_rest#language-params
        # useage: say <language code> <phase>
        # example: say es come with me
  mplayer -user-agent Mozilla \
        "http://translate.google.com/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
        | cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;}

say-translation() {
        # by: gotbletu
        # requires: http://www.soimort.org/google-translate-cli/
        # limit to 100 character or less
        # language code: http://developers.google.com/translate/v2/using_rest#language-params
        # useage: say-translation <language code> <phrase>
        # example: say-translation es come with me
        lang=$1
        trans=$(translate {=$lang} "$(echo "$@" | cut -d ' ' -f2- | sed 's/ /\+/g')" )
        echo $trans
        mplayer -user-agent Mozilla \
        "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$trans" > /dev/null 2>&1 ;}
