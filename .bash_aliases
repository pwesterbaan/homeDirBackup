shopt -s cdable_vars
export COM_CENT_IP=$(tailscale ip -4 command-center)
export COM_CENT_MAC=18:03:73:37:29:de
export DATA_PATH=/mnt/Data
export DROPBOX_PATH=~/Dropbox
export EDITOR="emacs"
export JBL_MAC=74:2A:8A:A6:2F:C3
export RALINK_MAC=54:35:30:D9:B8:84
export TEX_FOLDER=$DROPBOX_PATH/Coding/LaTex
export TEX_HOME=$(kpsewhich -var-value TEXMFHOME)/tex/latex/local/
export WEGORC=/home/peter/.scripts/wegorc

alias clemson="cdls $DROPBOX_PATH/Clemson/"
alias cls="clear && ls -F --group-directories-first && pwd"
alias commandCenter="ssh commandCenter"
alias cpTikz="emacs $TEX_FOLDER/tikz/tikzTemplate.tex &"
alias cpwd="pwd | tocp"
alias connect_jbl="/home/peter/.scripts/connect_jbl.sh"
alias customSty="ln -s /home/peter/texmf/tex/latex/local/texPreamble.sty ."
alias db="cdls $DROPBOX_PATH"
alias dbstat="dropbox status"
alias disconnect_jbl='bluetoothctl disconnect 74:2A:8A:A6:2F:C3'
alias flaskCommands="export FLASK_APP=app.py; export FLASK_ENV=development; flask run"
alias IUP="cdls $DROPBOX_PATH/Grad_School/IUP/"
alias iup=IUP
alias jn="jupyter-notebook"
alias lander="cdls $DROPBOX_PATH/work/lander/"
alias la="ls -A"
alias ll="ls -alF"
alias l="ls -CF"
alias lofiStudy="youtube-dl https://www.youtube.com/watch?v=5qap5aO4i9A -o - | ffplay - -nodisp -autoexit -loglevel quiet"
alias lsd="ls -d */"
alias mkdir="mkdir -pv"
alias mkTex="latexmk -pdf -synctex=1"
alias mthsc="ssh pwester@mthsc.clemson.edu"
alias mvPics="mv -v $DROPBOX_PATH/Camera\ Uploads/* $DATA_PATH/Pictures/Camera\ Uploads && echo Done!"
alias myip="curl http://ipecho.net/plain; echo"
alias qtcreator="~/qtcreator-4.13.2/bin/qtcreator"
alias rbf="cleanTex; read -p 'Enter to continue'; ls -F --group-directories-first && pwd;"
alias restartBluetooth="/home/peter/.scripts/restartBluetooth.sh"
alias rwifi="nmcli r wifi off; read -p 'Press enter'; nmcli r wifi on"
alias scannet="sudo nmap -sP 192.168.1.*/24"
alias snmr="sudo systemctl restart NetworkManager.service"
alias solarSailer="youtube-dl https://www.youtube.com/watch?v=0gFyoH-JFFA -o - | ffplay - -nodisp -autoexit -loglevel quiet"
alias texpreamble="emacs $TEX_HOME/texPreamble.sty"
alias texshortcuts="emacs $TEX_HOME/texShortcutsWesterbaan.tex"
alias tocp="xargs -0 echo -n | xclip -selection clipboard"
alias todo="emacs $DROPBOX_PATH/Documents/todo.txt"
alias updateZoom="/home/peter/.scripts/updateZoom.sh"
alias wakeCommandCenter="wakeonlan $COM_CENT_MAC"
alias wego="/home/peter/.scripts/go/bin/wego"

durp(){ # This silly function is for testing purposes
    # echo ${1:-4}
    # if [[ -n "${1+x}" && ${1:-4} != *.tex ]]; then
    #   filename="$1"".tex"
    # elif [[ ${1:-4} == *.tex ]]; then
    #   filename=$1
    # fi
    # echo $filename
    echo "durpy durpy durp durp"
}

calc(){
    # printf "%f\n" `echo $@ |bc -l`;
    python3 -c "import math; import numpy as np; print($1)"
}

cleanTex(){
    # locates *.tex files in current dir and sub dirs,
    # then removes temp files with the following EXTS

    EXTS=("-blx.bib" "-eps-converted-to" "-eps-converted-to.pdf"
          ".aux" ".bbl" ".bcf" ".blg" ".dvi" ".fdb_latexmk" ".fls"
	  ".fuse_hidden*" ".goutputstream" ".lof" ".log" ".lot"
	  ".nav" ".out" ".run.xml" ".snm" ".synctex.gz")

    find . -name \*.tex | while read fname; do
      STRIPPED_FILENAME="${fname%.tex}";
      for ext in ${EXTS[@]}; do
        TMPFILE="$STRIPPED_FILENAME$ext"
	if [ -f $TMPFILE ]; then ls $TMPFILE; rm $TMPFILE; fi
      done;
    done;
}


# LaTeXtemplate(){
#     ########################################################
#     ## Function to copy tex templates into pwd            ##
#     ## mkLaTeX <name> <opt>                               ##
#     ##   opt: -t: test, -k: tikz, -p: presentation        ##
#     ##   default opt is homework                          ##
#     ########################################################
#     #
#     #
#     if [ $# -eq 0 ]; then
#       base="${PWD##*/}"; dir="${PWD%/*}"; dir="${dir##*/}";
#       filename=$dir"_"$base".tex"
#       title=$dir" "$base
#       if ! confirm "Use $filename? (def Y)" -y $1; then
#         return 1;
#       fi
#     else title=${1%%.*}
#     fi
#     #
#     #
#     confirm "Include copy of custom .sty file?" && customSty;
#     # if filename blank, base filename on current directory and sublevel
#     # if filename given, give the filename the .tex extension
#     if [[ -n "${1+x}" && ${1:-4} != *.tex ]]; then
#       filename="$1"".tex"
#     elif [[ ${1:-4} == *.tex ]]; then
#       filename=$1
#     fi
#   #####################################
#     # Include 4 cases here: homework, test, presentation
#     # These cases should be triggered by flags with the default behavior being homework
#   #####################################
#     if [[ $* == *-t* ]]; then
#       echo "Copying test template..."
#       if [ -z ${filename+x} ]; then
#         cp -i $TEX_FOLDER/examTemplate.tex .
#         filename=examTemplate.tex
#       else
#         cp --backup -i $TEX_FOLDER/examTemplate.tex "$filename"
#       fi
#     elif [[ $* == *-p* ]]; then
#       echo "Copying presentation template..."
#       ln -s $TEX_FOLDER/PresentationTemplate/*{.eps,.jpg} .
#       if [ -z ${filename+x} ]; then
#           cp -i $TEX_FOLDER/PresentationTemplate/PresentationTemplate.tex .
#           filename=PresentationTemplate.tex
#       else
#           cp --backup -i $TEX_FOLDER/PresentationTemplate/PresentationTemplate.tex "$filename"
#       fi
#     else
#       echo "Copying homework template..."
#       if [ -z ${filename+x} ]; then
#         cp -i $TEX_FOLDER/HW_Template.tex .
#         filename=HW_Template.tex
#       else
#         cp --backup -i $TEX_FOLDER/HW_Template.tex "$filename"
#       fi
#     fi
#   #####################################
#     confirm 'Custom title ('"$title"')? (def Y)' -y && retitle "$filename" "$title"
#     confirm "Open $filename? (def Y)" -y && xdg-open "$filename";
#     chmod -x *.{tex,pdf};
#     ls -F --group-directories-first && pwd;
# }

randNums(){
    python3 -c "import random; print(random.sample(range($1,$2),$3))";
}

# retitle(){
#   filename=$1
#   title=$2
#   #echo $filename;
#   if [ -a ${filename} ]; then
#     #echo $filename;
#     sed -i "s/Durp/${title}/" $filename
#   fi
#   cat $filename | grep '\\title'
# }

confirm(){
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            if [[ $response != n && $* == *-y* ]]; then
              true
            else
              false
            fi
            ;;
    esac
}

cpKey(){
  #Function to compile the blank version of *_KEY.tex
  CURRENT_DIR=$(pwd)
  if [ $# -eq 0 ]
    then
      pattern=*_KEY*.tex;
  else
      #check if file exists
      if [ -f $1 ]
      then
	# echo "file exists!"
	# pattern="$(basename -- $1)"
	#grab all files given. Get basename later
	pattern=$@
	cd "$(dirname -- $1)"
      else
	# echo "file doesn't exist"
	return -1
      fi

  fi
  if ls $(basename -- $(echo $pattern | cut --delimiter " " --fields 1)) 1> /dev/null 2>&1; then
    for f in $pattern;
    do
	f=$(basename -- $f);
        cleanTex > /dev/null;

        echo "*************";
        echo Compile blank: $f
        echo "*************";
        JOBNAME=$(basename -s .tex ${f//"_KEY"/""})
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          -jobname='$JOBNAME' \
          '\PassOptionsToClass{noanswers}{exam}\input{%S}'"
        latexmk -pdf -silent -jobname="$JOBNAME" -g -pdflatex="$JOBOPTS" $f > /dev/null;

	echo "*************";
        echo Compile key:   $f
	echo "*************";
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          '\PassOptionsToClass{answers}{exam}\input{%S}'"
        latexmk -pdf -silent -g -pdflatex="$JOBOPTS" $f > /dev/null;
    done;
    confirm "clean LaTeX temp files? (def Y)" -y && cleanTex;
    for f in $pattern;
    do
      f=$(basename -- $f)
      exo-open ${f//"_KEY.tex"/""}*.pdf # *.pdf
    done;
  else
    echo "No files match *_KEY*.tex pattern";
  fi
  cdls $CURRENT_DIR

}

cdls(){
    if [ -z ${1+x} ]; then
        cd;
        ls -F --group-directories-first && pwd;
    else
        cd "$1" && ls -F --group-directories-first && pwd;
    fi
}

# function customExtract {
#  if [ -z "$1" ]; then
#     # display usage if no parameters given
#     echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
#  else
#     if [ -f $1 ] ; then
#         # NAME=${1%.*}
#         # mkdir $NAME && cd $NAME
#         case $1 in
#           *.tar.bz2)   tar xvjf ../$1    ;;
#           *.tar.gz)    tar xvzf ../$1    ;;
#           *.tar.xz)    tar xvJf ../$1    ;;
#           *.lzma)      unlzma ../$1      ;;
#           *.bz2)       bunzip2 ../$1     ;;
#           *.rar)       unrar x -ad ../$1 ;;
#           *.gz)        gunzip ../$1      ;;
#           *.tar)       tar xvf ../$1     ;;
#           *.tbz2)      tar xvjf ../$1    ;;
#           *.tgz)       tar xvzf ../$1    ;;
#           *.zip)       unzip ../$1       ;;
#           *.Z)         uncompress ../$1  ;;
#           *.7z)        7z x ../$1        ;;
#           *.xz)        unxz ../$1        ;;
#           *.exe)       cabextract ../$1  ;;
#           *)           echo "extract: '$1' - unknown archive method" ;;
#         esac
#     else
#         echo "$1 - file does not exist"
#     fi
# fi
# }

function sarcasmString() {
    python3 -c "import sys; myStr=(' ').join(sys.argv[1:]); print(''.join(myStr[i].upper() if 0==i%2 else myStr[i].lower() for i in range(len(myStr))))" $@
}

ls -F --group-directories-first && pwd

# export PETSC_DIR=~/petsc
# export PETSC_ARCH=linux-gnu
export PATH=$PATH:/usr/local/go/bin
shopt -s direxpand
