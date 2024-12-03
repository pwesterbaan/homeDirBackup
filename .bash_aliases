export COM_CENT_MAC=18:03:73:37:29:de
export DATA_PATH=/mnt/Data
# export DEAL_II_DIR=/home/peter/dealii
export DROPBOX_PATH=~/Dropbox
export JBL_MAC=74:2A:8A:A6:2F:C3
export RALINK_MAC=54:35:30:D9:B8:84
export TEX_FOLDER=$DROPBOX_PATH/Coding/LaTex
export TEX_HOME=$(kpsewhich -var-value TEXMFHOME)/tex/latex/local/
export WEGORC=/home/peter/.scripts/wegorc
export WORKHORSE_MAC=50:e5:49:da:c5:84

alias workhorse_ip="cat $DROPBOX_PATH/Documents/workhorseIP.txt"

alias arbf="find . -type f \( -iname \*.aux -o -iname \*.bbl -o -iname \*.blg -o -iname \*.fdb_latexmk -o -iname \*.fls -o -iname \*.log -o -iname \*.nav -o -iname \*.out -o -iname \*.snm -o -iname \*.synctex.gz -o -iname \*.lof -o -iname \*.lot -o -iname \*.dvi -o -iname \*-eps-converted-to -o -iname \*.goutputstream -o -iname \*.fuse_hidden* -o -iname \*-eps-converted-to.pdf -o -iname \*.bcf -o -iname \*.run.xml -o -iname \*-blx.bib \) -print -delete"
alias batcave="lp -q 1 -o sides=one-sided -d batcave"
alias clemson="cdls $DROPBOX_PATH/Clemson/"
alias cls="clear && ls -F --group-directories-first && pwd"
alias commandCenter="ssh peter@192.168.0.21"
alias cpTikz="emacs $TEX_FOLDER/tikz/tikzTemplate.tex &"
alias cpwd="pwd | tocp"
#alias connect_jbl='if ! (hcitool dev | grep -q $RALINK_MAC); then restartBluetooth; sleep 5; fi; bluetoothctl connect $JBL_MAC'
alias connect_jbl="/home/peter/.scripts/connect_jbl.sh"
alias customSty="ln -s /home/peter/texmf/tex/latex/local/texPreamble.sty ."
alias db="cdls $DROPBOX_PATH"
alias dbstat="dropbox status"
alias disconnect_jbl='bluetoothctl disconnect 74:2A:8A:A6:2F:C3'
#alias dropbox="python $DROPBOX_PATH/dropbox.py"
alias flaskCommands="export FLASK_APP=app.py; export FLASK_ENV=development; flask run"
alias gertrude="lp -d gertrude"
alias hpadmin1="lp -q 1 -o sides=one-sided -d hpadmin1"
#alias hpadmin4="lp -q 1 -o sides=one-sided -o fit-to-page -d hpadmin4"
alias IUP="cdls $DROPBOX_PATH/Grad_School/IUP/"
alias iup=IUP
alias jn="jupyter-notebook"
alias lander="cdls $DROPBOX_PATH/work/lander/"
alias la="ls -A"
alias ll="ls -alF"
alias l="ls -CF"
alias lofiStudy="youtube-dl https://www.youtube.com/watch?v=5qap5aO4i9A -o - | ffplay - -nodisp -autoexit -loglevel quiet"
alias lsd="ls -d */"
#alias matlab="/home/peter/.local/bin/matlab -nodesktop -r 'opengl info, desktop'"
alias mera="lp -q 1 -o sides=one-sided -o fit-to-page -d mera"
alias mkdir="mkdir -pv"
alias mkTex="latexmk -pdf -synctex=1"
alias mthsc="ssh pwester@mthsc.clemson.edu"
alias mvPics="mv -v $DROPBOX_PATH/Camera\ Uploads/* $DATA_PATH/Pictures/Camera\ Uploads && echo Done!"
alias myip="curl http://ipecho.net/plain; echo"
alias qtcreator="~/qtcreator-4.13.2/bin/qtcreator"
alias rbf="arbf; read -p 'Enter to continue'; ls -F --group-directories-first && pwd;"
alias restartBluetooth="/home/peter/.scripts/restartBluetooth.sh"
alias rwifi="nmcli r wifi off; read -p 'Press enter'; nmcli r wifi on"
alias scannet="sudo nmap -sP 192.168.0.*/24"
alias sleepWorkhorse="ssh -t peter@$(workhorse_ip) 'sudo /home/peter/.scripts/sleepWorkhorse.sh'"
alias snmr="sudo systemctl restart NetworkManager.service"
alias solarSailer="youtube-dl https://www.youtube.com/watch?v=0gFyoH-JFFA -o - | ffplay - -nodisp -autoexit -loglevel quiet"
#alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip"
#alias suspend="nmcli r wifi off; systemctl suspend"
alias texpreamble="emacs $TEX_HOME/texPreamble.sty"
alias texshortcuts="emacs $TEX_HOME/texShortcutsWesterbaan.tex"
alias tocp="xargs -0 echo -n | xclip -selection clipboard"
alias todo="emacs $DROPBOX_PATH/Documents/todo.txt"
alias updateZoom="/home/peter/.scripts/updateZoom.sh"
alias wakeCommandCenter="wakeonlan $COM_CENT_MAC"
alias wakeWorkhorse="wakeonlan $WORKHORSE_MAC"
alias wego="/home/peter/.scripts/go/bin/wego"
alias workhorse="ssh peter@$(workhorse_ip)"

durp(){ # This silly function is for testing purposes
    if [[ -n "${1+x}" && ${1:-4} != *.tex ]]; then
      filename="$1"".tex"
    elif [[ ${1:-4} == *.tex ]]; then
      filename=$1
    fi
    #echo $filename
    echo "durpy durpy durp durp"
}

calc(){
    # printf "%f\n" `echo $@ |bc -l`;
    python3 -c "print($1)"
}


LaTeXtemplate(){
    ########################################################
    ## Function to copy tex templates into pwd            ##
    ## mkLaTeX <name> <opt>                               ##
    ##   opt: -t: test, -k: tikz, -p: presentation        ##
    ##   default opt is homework                          ##
    ########################################################
    #
    #
    if [ $# -eq 0 ]; then
      base="${PWD##*/}"; dir="${PWD%/*}"; dir="${dir##*/}";
      filename=$dir"_"$base".tex"
      title=$dir" "$base
      if ! confirm "Use $filename? (def Y)" -y $1; then
        return 1;
      fi
    else title=${1%%.*}
    fi
    #
    #
    confirm "Include copy of custom .sty file?" && customSty;
    # if filename blank, base filename on current directory and sublevel
    # if filename given, give the filename the .tex extension
    if [[ -n "${1+x}" && ${1:-4} != *.tex ]]; then
      filename="$1"".tex"
    elif [[ ${1:-4} == *.tex ]]; then
      filename=$1
    fi
  #####################################
    # Include 4 cases here: homework, test, presentation
    # These cases should be triggered by flags with the default behavior being homework
  #####################################
    if [[ $* == *-t* ]]; then
      echo "Copying test template..."
      if [ -z ${filename+x} ]; then
        cp -i $TEX_FOLDER/examTemplate.tex .
        filename=examTemplate.tex
      else
        cp --backup -i $TEX_FOLDER/examTemplate.tex "$filename"
      fi
    elif [[ $* == *-p* ]]; then
      echo "Copying presentation template..."
      ln -s $TEX_FOLDER/PresentationTemplate/*{.eps,.jpg} .
      if [ -z ${filename+x} ]; then
          cp -i $TEX_FOLDER/PresentationTemplate/PresentationTemplate.tex .
          filename=PresentationTemplate.tex
      else
          cp --backup -i $TEX_FOLDER/PresentationTemplate/PresentationTemplate.tex "$filename"
      fi
    else
      echo "Copying homework template..."
      if [ -z ${filename+x} ]; then
        cp -i $TEX_FOLDER/HW_Template.tex .
        filename=HW_Template.tex
      else
        cp --backup -i $TEX_FOLDER/HW_Template.tex "$filename"
      fi
    fi
  #####################################
    confirm 'Custom title ('"$title"')? (def Y)' -y && retitle "$filename" "$title"
    confirm "Open $filename? (def Y)" -y && xdg-open "$filename";
    chmod -x *.{tex,pdf};
    ls -F --group-directories-first && pwd;
}

retitle(){
  filename=$1
  title=$2
  #echo $filename;
  if [ -a ${filename} ]; then
    #echo $filename;
    sed -i "s/Durp/${title}/" $filename
  fi
  cat $filename | grep '\\title'
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

# rename(){
#     for f in *"$1"*;
#     do
#         echo -e "$f""\n  -->" "${f//"$1"/"$2"}";
#     done;
#     confirm "Rename as such?" && for f in *"$1"*;
#     do
#         mv "$f" "${f//"$1"/"$2"}";
#     done;
#     ls -F --group-directories-first && pwd;
# }

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
        arbf > /dev/null;
        echo "*************";
        echo Compile blank;
        echo "*************";
        JOBNAME=$(basename -s .tex ${f//"_KEY"/""})
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          -jobname='$JOBNAME' \
          '\PassOptionsToClass{noanswers}{exam}\input{%S}'"
        latexmk -pdf -silent -jobname="$JOBNAME" -g -pdflatex="$JOBOPTS" $f > /dev/null;
    done;
    for f in $pattern;
    do
	f=$(basename -- $f);
        echo "***********";
        echo Compile key;
        echo "***********";
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          '\PassOptionsToClass{answers}{exam}\input{%S}'"
        latexmk -pdf -silent -g -pdflatex="$JOBOPTS" $f > /dev/null;
    done;
    confirm "rbf? (def Y)" -y && arbf;
    for f in $pattern;
    do
      f=$(basename -- $f)
      exo-open ${f//"_KEY.tex"/""}*.pdf & # *.pdf
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

function customExtract {
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

# function wakeWorkhorse {
    # WORKHORSE_IP=$(cat $DROPBOX_PATH/Documents/workhorseIP.txt)

    # ssh -t pwester@mathsci02.science.clemson.edu "/users/pwester/wol/wakeonlan $WORKHORSE_MAC"
    # sleep 10
    # ssh -t pwester@mathsci02.science.clemson.edu "ping -c 3 -i 5 $WORKHORSE_IP"
#}

ls -F --group-directories-first && pwd

export PETSC_DIR=~/petsc
export PETSC_ARCH=linux-gnu
export PATH=$PATH:/usr/local/go/bin
shopt -s direxpand
