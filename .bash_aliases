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
    # either based on filenames passed, or wildcard (default)
    # then removes temp files with the following exts

    if [ $# -eq 0 ]
    then
	clean_pattern=\*.tex;
    else
	clean_pattern=$@
    fi

    exts=("-blx.bib" "-eps-converted-to" "-eps-converted-to.pdf"
          ".aux" ".bbl" ".bcf" ".blg" ".dvi" ".fdb_latexmk" ".fls"
	  ".fuse_hidden*" ".goutputstream" ".lof" ".log" ".lot"
	  ".nav" ".out" ".run.xml" ".snm" ".synctex.gz" ".synctex(busy)"
	  ".ps")

    find -L . -name "$clean_pattern" | while read fname; do
	stripped_filename="${fname%.tex}";
	stripped_key_filename="${fname%_KEY.tex}";
	for ext in ${exts[@]}; do
            tmpfile="$stripped_filename$ext"
	    if [ -f "$tmpfile" ]; then rm -v -- $tmpfile; fi
	    tmpfile="$stripped_key_filename$ext"
	    if [ -f "$tmpfile" ]; then rm -v -- $tmpfile; fi
	done;
    done;
}

randNums(){
    python3 -c "import random; print(random.sample(range($1,$2),$3))";
}

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

#auto complete filenames for cpKey
complete -f -o plusdirs -X '!*.tex' cpKey
cpKey(){
  #Function to compile the blank version of *_KEY.tex
  old_dir=$OLDPWD
  current_dir=$(pwd)
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
	echo "file doesn't exist"
	return -1
      fi
  fi
  if ls $(basename -- $(echo $pattern | cut --delimiter " " --fields 1)) 1> /dev/null 2>&1; then
    cd $current_dir
    for f in $pattern;
    do
	cd "$(dirname -- $f)";
	f=$(basename -- $f);
	ls $f
        cleanTex $f > /dev/null;

        echo "**************";
        echo "Compile blank: "$f
        JOBNAME=$(basename -s .tex ${f//"_KEY"/""})
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          -jobname='$JOBNAME' \
          '\PassOptionsToClass{noanswers}{exam}\input{%S}'"
        latexmk -pdf -silent -jobname="$JOBNAME" -g -pdflatex="$JOBOPTS" $f > /dev/null;

        echo "Compile key:   "$f
	JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          '\PassOptionsToClass{answers}{exam}\input{%S}'"
        latexmk -pdf -silent -g -pdflatex="$JOBOPTS" $f > /dev/null;
	echo "**************";
        echo "";
	cd $current_dir
    done;
    # return to prev dir before in case early exit
    cd $current_dir
    OLDPWD=$old_dir

    confirm "clean LaTeX temp files? (def Y)" -y && cleanTex;
    for f in $pattern;
    do
      # f=$(basename -- $f)
      #TODO: Check if file exists before opening
      exo-open ${f//"_KEY.tex"/""}*.pdf # *.pdf
    done;
  else
    echo "No files match *_KEY*.tex pattern";
  fi
  cdls $current_dir
  OLDPWD=$old_dir
}

cdls(){
    if [ -z ${1+x} ]; then
        cd;
        ls -F --group-directories-first && pwd;
    else
        cd "$1" && ls -F --group-directories-first && pwd;
    fi
}

function sarcasmString() {
    python3 -c "import sys; myStr=(' ').join(sys.argv[1:]); print(''.join(myStr[i].upper() if 0==i%2 else myStr[i].lower() for i in range(len(myStr))))" $@
}

#auto complete filenames for getPdfPages (lander_lecture_notes)
complete -f -o plusdirs -X '!*.pdf' getPdfPages.sh

ls -F --group-directories-first && pwd
export PATH=$PATH:/usr/local/go/bin
shopt -s direxpand
