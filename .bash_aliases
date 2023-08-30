export DEAL_II_DIR=/home/peter/dealii/dealii-8.5.1
export DROPBOX_PATH=~/Dropbox
export TEX_FOLDER=$DROPBOX_PATH/Coding/LaTex
export TEX_HOME=$(kpsewhich -var-value TEXMFHOME)/tex/latex/local/
export PETSC_ARCH=linux-gnu
export PETSC_DIR=~/petsc

alias batcave='lp -q 1 -o sides=one-sided -d batcave'
alias clemson='cdls $DROPBOX_PATH/Grad_School/Clemson/'
alias cls='clear && ls -F --group-directories-first && pwd'
alias connect_headphones='sudo bluetoothctl connect 2C:FD:B3:19:88:F6'
alias connect_jbl='sudo bluetoothctl connect 74:2A:8A:A6:2F:C3'
alias connect_mouse='sudo bluetoothctl connect E5:4A:11:2D:71:54'
alias cpTikz='emacs $TEX_FOLDER/tikz/tikzTemplate.tex &'
alias cpwd='echo -n `pwd` | tocp'
alias customSty='ln -s /home/peter/texmf/tex/latex/local/texPreamble.sty . && ln -s /home/peter/texmf/tex/latex/local/colorPalette.sty . && ln -s /home/peter/texmf/tex/latex/local/texShortcutsWesterbaan.tex .'
alias db='cdls $DROPBOX_PATH'
alias dbstat='dropbox status'
alias disconnect_jbl='sudo bluetoothctl disconnect 74:2A:8A:A6:2F:C3'
alias ffplayNodisp='ffplay -nodisp -autoexit -loglevel quiet'
alias findcc='find $DROPBOX_PATH -name *conflicted\ copy*'
alias findPi='nmap -sP 192.168.1.*/24'
alias firefox='firefox -P'
alias flaskCommands='export FLASK_APP=run.py; export FLASK_ENV=development; flask run'
alias foxPrank="ssh pi@130.127.186.127 'python3 foxPrank/foxSayPicker.py'"
#alias gertrude='lp -d gertrude'
alias getIP='ifconfig | grep -Po "inet.+broadcast" | grep -Po "(?:\d{1,3}\.){3}\d{1,3}" | head -n 1 > $DROPBOX_PATH/Documents/workhorseIP.txt && cat $DROPBOX_PATH/Documents/workhorseIP.txt'
alias hpadmin1='lp -q 1 -o sides=one-sided -d hpadmin1'
#alias hpadmin4='lp -q 1 -o sides=one-sided -d hpadmin4'
alias IUP='cdls $DROPBOX_PATH/Grad_School/IUP/'
alias iup=IUP
alias jn='jupyter notebook'
alias la='ls -A'
alias lCopier='lp -q 1 -d leftCopier'
alias ll='ls -alF'
alias l='ls -CF'
#https://www.reddit.com/r/linux/comments/lj4v0w/some_nifty_stuff_ffmpeg_can_do/?utm_source=share&utm_medium=web2x&context=3
alias lofiStudy='youtube-dl https://www.youtube.com/watch?v=5qap5aO4i9A -o - | ffplay - -nodisp -autoexit -loglevel quiet'
alias lsd='ls -d */'
alias matlab='matlab -nodesktop -r "opengl info, desktop"'
alias mera='lp -q 1 -o media=letter -d mera' #-o sides=one-sided
alias mkdir='mkdir -pv'
alias mkTex='latexmk -pdf -synctex=1'
#alias mthsc='pwester@mthsc.clemson.edu'
#alias mvPics='mv -v $DROPBOX_PATH/Camera\ Uploads/* /mnt/Data/Pictures/Camera\ Uploads && echo Done!'
alias myip="curl http://ipecho.net/plain; echo"
#alias opal="pwester@opal.ces.clemson.edu"
alias qtcreator='/opt/qtcreator-4.13.2/bin/qtcreator'
alias rbf='find . -type f \( -iname \*.aux -o -iname \*.bbl -o -iname \*.blg -o -iname \*.fdb_latexmk -o -iname \*.fls -o -iname \*.log -o -iname \*.nav -o -iname \*.out -o -iname \*.snm -o -iname \*.synctex.gz -o -iname \*.lof -o -iname \*.lot -o -iname \*.dvi -o -iname \*-eps-converted-to -o -iname \*.goutputstream -o -iname \*.fuse_hidden* -o -iname \*-eps-converted-to.pdf -o -iname \*.run.xml -o -iname \*-blx.bib \) -print -delete'
alias rCopier='lp -q 1 -d rightCopier'
alias rwifi='nmcli r wifi off; read -p "Press enter"; nmcli r wifi on && ls -F --group-directories-first && pwd'
alias snmr='sudo service network-manager restart'
alias solarSailer='youtube-dl https://www.youtube.com/watch?v=0gFyoH-JFFA -o - | ffplay - -nodisp -autoexit -loglevel quiet'
alias tex2png='~/.scripts/genEqnImage.sh'
alias texpreamble='emacs $TEX_HOME/texPreamble.sty'
alias texshortcuts='emacs $TEX_HOME/texShortcutsWesterbaan.tex'
alias tocp='xargs echo -n | xclip -selection clipboard'
alias todo='emacs /home/peter/Dropbox/Documents/todo.txt'
alias wego='/home/peter/.scripts/go/bin/wego'

durp(){ # This silly function is for testing purposes
    if [[ -n "${1+x}" && ${1:-4} != *.tex ]]; then
      filename="$1"".tex"
    elif [[ ${1:-4} == *.tex ]]; then
      filename=$1
    fi
    #echo $filename
    if [ $# -eq 0 ]
      then
        echo "No arguments supplied"
      else
        echo $1
    fi
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
      pattern="$(basename -- $1)"
      cd "$(dirname -- $1)"
  fi
  if ls $pattern 1> /dev/null 2>&1; then
    for f in $pattern;
    do
        rbf > /dev/null;
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
        echo "***********";
        echo Compile key;
        echo "***********";
        JOBOPTS="pdflatex %O \
          -interaction=nonstopmode \
          -synctex=1 \
          '\PassOptionsToClass{answers}{exam}\input{%S}'"
        latexmk -pdf -silent -g -pdflatex="$JOBOPTS" $f > /dev/null;
    done;
    confirm "rbf? (def Y)" -y && rbf && ls -F --group-directories-first && pwd;
    exo-open ${f//"_KEY.tex"/""}*.pdf & # *.pdf
    cdls $CURRENT_DIR
  else
    echo "No files match *_KEY*.tex pattern";
  fi
}

cdls(){
    if [ -z ${1+x} ]; then
        cd;
        ls -F --group-directories-first && pwd;
    else
        cd "$1" && ls -F --group-directories-first && pwd;
    fi
}

mkcdir ()
{
    # mkdir $NAME && cd $NAME
    mkdir -p -- "$1" &&
    cdls "$1"
}

function customExtract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
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

ls -F --group-directories-first && pwd;

shopt -s direxpand