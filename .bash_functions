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
  echo "thumbs-med ( ) ---> autorotates and resizes all jpgs to max h/w of 450"

  echo -e '\E[37;44m'"\033[1mfile manipulation\033[0m"
  echo "shrinkpdf(input.pdf output.pdf)  --> shrink pdf file size"
  echo "extract( file ) ---> extracts any archive"
  echo "extractToFolder ( )  ---> created folder based on name and extract into it"
  echo "getHtml (file ) ---> convert md to html"
  echo "getAllHtml ( ) ---> convert all md files in dir to html"
  echo "encrypt ( file) ---> encrypt file using gpg"
  echo "decrypt ( file) ---> decrypt file using gpg"
  echo "lower-files ( ) ---> mv's all files in dir to lowercase"
  echo "lower-dirs ()  --> change all dirs to lowercaser"
  echo "removeM ( file ) ---> removes the damned ^M"
  echo "moveUp (extension ) ---> mv all ./**/*.extension ./"
  echo "prepend (text file) --> add text to begining of every line"
  echo "append (text file) --> add text to end of every line"
  echo "slugify ---> remove spaces and set to lowercase"
  echo "www ---> folders to 775, files to 664, group to www-data "

  echo -e '\E[37;44m'"\033[1mother\033[0m"
  echo "mkd (foldername) ---> mkdir dir and cd in"
  echo "buildIndex  ---> create index.md with folder/file links"
  echo "say ( ) ---> clones the repo and converts md to html"
  echo "say-translation (language phrase) ---> say-translation es come with me"
  echo "short-url( url )  ---> Create a git.io short URL"
  echo "gitList () --> list git branch and head"
}

########### functions

# shrinkpdf(input.pdf output.pdf)
function shrinkpdf () {
 gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen  -dEmbedAllFonts=true \
   -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=72 -dGrayImageDownsampleType=/Bicubic \
    -dGrayImageResolution=72 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=72 -sOutputFile=$2 $1
}


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
          *.xz) tar xf "$1" ;;
          *.zip) unzip "$1" ;;
          *.Z) uncompress "$1" ;;
          *.7z) 7z x "$1" ;;
          *) echo "'$1' cannot be extracted " ;;
        esac
    else
    echo "'$1' is not a valid file"
  fi
}

# build inde.md with folder/file links
function buildIndex(){
  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  # shopt -s globstar
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

function listFiles () {
shopt -s nullglob
for file in *.html
do
  echo "- ["$file"](./"$file")" 
done

}

function example2 () {
  #$( ... ) runs a shell command and inserts its output at that point in the command line

  for file in Data/*.txt
  do
      for ((i = 0; i < 3; i++))
      do
          name=${file##*/}
          base=${name%.txt}
          ./MyProgram.exe "$file" Logs/"${base}_Log$i.txt"
      done
  done
}


function example () {
  _base="/jail/.conf"
  _dfiles="${base}/nginx/etc/conf/*.conf"
   
  for f in $_dfiles
  do
          lb2file="/tmp/${f##*/}.$$"   #tmp file
          sed 's/Load_Balancer-1/Load_Balancer-2/' "$f" > "${lb2file}"   # update signature 
          scp "${lb2file}" nginx@lb2.nixcraft.net.in:${f}   # scp updated file to lb2
          rm -f "${lb2file}"
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

# directories to 755 (drwxr-xr-x),  files to 644 (-rw-r--r--), owner www-data
function www () {
  sudo chgrp -R www-data .
  find . -type d -exec sudo chmod 775 {} \;
  find . -type f -exec sudo chmod 664 {} \;
}


# renames fils in lowercase
function lower-files() {
  for file in * ; do
    if [[ -f $file ]]; then
      name="$(echo ${file} | tr [:upper:] [:lower:])"
       if [ "$file" != "$name" ]; then
         echo "${file} ${name}"    
         mv ${file} ${name}  
      fi     
  fi
  done
}

# renames directories in lowercase
function lower-dirs() {
  for file in * ; do
    if [[ -d $file ]]; then
      name="$(echo ${file} | tr [:upper:] [:lower:])"
       if [ "$file" != "$name" ]; then
         echo "${file} ${name}"    
         mv ${file} ${name}  
      fi     
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
function decrypt (){
  gpg --no-options "$1"
}

# list git branch and head
function gitList {
	git fetch --all
	git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | sed 's/refs\/tags\//tag: /g' | sed 's/refs\/heads\///' | sed 's/refs\/remotes\/origin\///' | grep -i "<YOUR NAME>" | uniq
}

# imagemagick

function thumbs-med (){
  filelist = 'ls | grep -i --include \*.jpg .'
  #filelist=`ls | grep -i --include \*.jpg --include \*.jpeg`
  #mkdir -p thumbs
  for f in $filelist
  do
    convert $f -auto-orient -resize x480 -unsharp 0x.5 ./thumbs/${f%.*}_x480.jpg
  done
}

function all-jpg (){
  mogrify -format jpg *.png
}
# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Create a git.io short URL
function short-url() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}



# wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=en&q=hello+world
# limit of 100 characters for the "q" parameter, so be careful. The "tl" parameter contains target language.

# say() {
#   say() { mplayer "http://translate.google.com/translate_tts?q=$1"; }
# }
# say(){ mplayer -user-agent Mozilla "http://translate.google.com/translate_tts?tl=en&q=$(echo $* | sed 's#\ #\+#g')" > /dev/null 2>&1 ;  }

#####
# scripts from https://github.com/gotbletu


# http://www.youtube.com/watch?v=UhVKuAozSMc
function say() {
        # limit to 100 character or less
        # language code: http://developers.google.com/translate/v2/using_rest#language-params
        # useage: say <language code> <phase>
        # example: say es come with me
  mplayer -user-agent Mozilla \
        "http://translate.google.com/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
        | cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;
}

function say-translation() {
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
        "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$trans" > /dev/null 2>&1 ;
}


# rename 's/\.JPG$/\.jpg/' *
# mogrify -resize 800x *.jpg

# lower-files () {
#    rename 's/\.JPG$/\.jpg/' *
# }


# mogrify  -resize x800  *.jpg
# mogrify -auto-orient -thumbnail x800 -unsharp 0x.5  '*.jpg'
# x480
# 
# 
echo 'bash_functions'
