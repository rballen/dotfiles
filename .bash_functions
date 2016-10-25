#!/bin/bash
####################################
# ~/.bash_functions - somewhat useful collection of functions - sill working on the media related so don't use them
#
# @TODO finish linting check with http://www.shellcheck.net/
# git clone https://github.com/rballen/dotfiles.git
# wget https://raw.github.com/rballen/dotfiles/master/.bash_functions
#
# sourced in ~/.bashrc
# dirname="${file%/*}"
# file="$(basename "$fullfile")"
# ext="${filename##*.}"
# filename="${filename%.*}"
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
  echo 'dowhatnow -->       list functions in ~/.bash_functions'
  echo 'whatalias -->       list aliases in ~/.bash_aliases'
  echo '--------------------------'


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
  echo "shrinkpdf(input.pdf output.pdf)  --> shrink pdf file size"
  echo "buildIndex()  --> write certain files to index.md"
  echo "extract( file ) ---> extracts any archive"
  echo "extractToFolder ( )  ---> created folder based on name and extract into it"
  echo "getHtml (file ) ---> convert md to html"
  echo "getAllHtml ( ) ---> convert all md files in dir to html"
  echo "encrypt ( file) ---> encrypt file using gpg"
  echo "decrypt ( file) ---> decrypt file using gpg"
  echo "lowercase ( ) ---> mv's all files in dir to lowercase"
  echo "removeM ( file ) ---> removes the damned ^M"
  echo "moveUp (extension ) ---> mv all ./**/*.extension ./"
  echo "prepend (text file) --> add text to begining of every line"
  echo "append (text file) --> add text to end of every line"

  echo -e '\E[37;44m'"\033[1mother\033[0m"
  echo "mkd (foldername) ---> mkdir dir and cd in"
  echo "buildIndex  ---> create index.md with folder/file links"
  echo "lower-case() --> rename all JPG files to jpg"
  echo "slugify ---> remove spaces and set to lowercase"
  echo "sourceme() --> re-source yourself ~/.profile"
  echo "gc ( gitUrl) ---> clones the repo and converts md to html"
  echo "say ( ) ---> clones the repo and converts md to html"
  echo "say-translation (language phrase) ---> say-translation es come with me"

}

########### functions

# shrinkpdf(input.pdf output.pdf)
function shrinkpdf () {
 gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen  -dEmbedAllFonts=true \
   -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=72 -dGrayImageDownsampleType=/Bicubic \
    -dGrayImageResolution=72 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=72 -sOutputFile=$2 $1
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# create dir and cd in
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# build inde.md with folder/file links
function buildIndex(){
  shopt -s nullglob  # Bash extension, so globs with no matches return empty
   echo "$PWD" >> index.md
   echo "---------------------" >> index.md
   for f in ./* ; do
      if [ -f $f ]; then
        echo "- ["$f"]("$f")" >> index.md
     fi
   done

   for dir in ./* ; do        # Use "./*", NEVER bare "*"  for file in $1/*; do
     if [ -d $dir ]; then
         printf "\n" >> index.md
         echo "## [$(basename "$dir")]("$dir"/)" >> index.md
         #for files in $(find "$dir"/ -iname '*.html' -o -iname '*.md' -o -iname '*.pdf' -o -iname '*.scss' ) ; do
         for files in $(find "$dir"/ -maxdepth 3 -name '*.html' -o -iname 'readme.md' -o -iname '*.pdf' -o -name 'index.php' -o -iname '*.scss' ) ; do
          if [[ "$files" =~ "node_modules" ]]; then
              echo "skipping '$files'";
          elif  [[ "$files" =~ "bower_components" ]]; then
              echo "skipping '$files'";
          else
            file=${files##*/}

            case "$file" in
              "license.md"|"LICENSE.md")
                  echo "skiping $file"
                  ;;
              *)
                  echo "   - ["$file"]("$files")" >> index.md
                  ;;
            esac

          fi
         done
      fi
   done
}

function slugify () {
  for file in ./* ; do

    target="$(echo "${file}" | tr [:upper:] [:lower:])"  # lowercase
    target="$(echo ${target} |tr -d '+=[]{}(),')"        # remove bad chars

    if [ -d "$file" ]; then
        target="$(echo ${target}  | tr -s ' ' '-')"      # for dir change space to -
    else
        target="$(echo ${target}  | tr -s ' ' '_')"      # for files squeze space to _
        target="$(echo ${target}  | sed 's/_-_/-/g')"    # replace string _-_ with -; tr goes by char; sed goes by string
#	target="$(echo ${target}  | sed 's/^[0-9]-//g')"       # for files replace _-_ with single -
    fi

    if [ "$target" != "$file" ]; then
      mv "${file}" "${target}"
     # echo "${file} --> ${target}"
    fi

  done
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

# convert markdown to html
function getHtml() {
  cat "$1" | marked > ${1%.*}.html
}

# converts all markdown (*.md or *.markdown) in . to html.
# filename: ${file%.*}
# ext= ${file##*.}
function getAllHtml() {
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

# list git branch and head
function gitList {
	git fetch --all
	git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | sed 's/refs\/tags\//tag: /g' | sed 's/refs\/heads\///' | sed 's/refs\/remotes\/origin\///' | grep -i "<YOUR NAME>" | uniq
}

# imagemagick

alias rotate='jhead -autorot *.JPG'
# x480
function thumbs-med (){
  filelist=`ls | grep -i --include \*.jpg --include \*.jpeg`
  mkdir -p thumbs
  for f in $filelist
  do
    convert $f -auto-orient -resize x480 -unsharp 0x.5 ./thumbs/${f%.*}_x480.jpg
  done
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

echo 'bash_functions'

# wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=en&q=hello+world
# limit of 100 characters for the "q" parameter, so be careful. The "tl" parameter contains target language.

say() {
  say() { mplayer "http://translate.google.com/translate_tts?q=$1"; }
}
say(){ mplayer -user-agent Mozilla "http://translate.google.com/translate_tts?tl=en&q=$(echo $* | sed 's#\ #\+#g')" > /dev/null 2>&1 ;  }

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

lower-case () {
   rename 's/\.JPG$/\.jpg/' *
}
# rename 's/\.JPG$/\.jpg/' *
# mogrify -resize 800x *.jpg

