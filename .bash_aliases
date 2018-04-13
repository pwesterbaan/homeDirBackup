export DROPBOX_PATH=~/Dropbox
export TEX_FOLDER=$DROPBOX_PATH/Coding/LaTex
export DEAL_II_DIR=/home/peter/dealii/dealii-8.5.1
alias ll='ls -alF'
alias la='ls -A'
alias lsd='ls -d */'
alias l='ls -CF'
alias cls='clear && ls --group-directories-first && pwd'
alias mkdir='mkdir -pv'
alias db='cdls $DROPBOX_PATH'
alias dbstat='dropbox status'
#alias dropbox='python $DROPBOX_PATH/dropbox.py'
alias findPi='nmap -sP 192.168.1.*/24'
alias IUP='cdls $DROPBOX_PATH/Grad_School/IUP/'
alias iup=IUP
alias clemson='cdls $DROPBOX_PATH/Grad_School/Clemson/'
alias tocp='xclip -selection clipboard'
alias cpwd='echo -n `pwd` | tocp'
alias cpTikz='cat $TEX_FOLDER/tikzTemplate.tex | tocp'
alias mvPics='mv -v $DROPBOX_PATH/Camera\ Uploads/* /mnt/Data/Pictures/Camera\ Uploads && echo Done!'
alias myip="curl http://ipecho.net/plain; echo"
alias mkTex='latexmk -pdf -synctex=1'
#alias gertrude='lp -d gertrude'
alias hpadmin1='lp -q 1 -o sides=one-sided -d hpadmin1'
alias gertrude='lp -q 1 -o sides=one-sided -d hpadmin4'
alias batcave='lp -q 1 -o sides=one-sided -d batcave'
alias customSty='ln -s /home/peter/texmf/tex/latex/local/texPreamble.sty .'
alias texpreamble='xdg-open $TEX_FOLDER/texPreamble.sty'
alias rwifi='nmcli r wifi off; read -p "Press enter"; nmcli r wifi on && cls'
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip'
alias snmr='sudo service network-manager restart'
alias findcc='find $DROPBOX_PATH -name *conflicted\ copy*'
alias arbf='find . -type f \( -iname \*.aux -o -iname \*.bbl -o -iname \*.blg -o -iname \*.fdb_latexmk -o -iname \*.fls -o -iname \*.log -o -iname \*.nav -o -iname \*.out -o -iname \*.snm -o -iname \*.synctex.gz -o -iname \*.toc -o -iname \*.lof -o -iname \*.lot -o -iname \*.dvi -o -iname \*-eps-converted-to -o -iname \*.goutputstream -o -iname \*.fuse_hidden* -o -iname \*-eps-converted-to.pdf \) -print -delete'
alias rbf='arbf
           read -p "Any key to continue"
           cls'

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

mkLaTeX(){
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
        exit 1;
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
      cp $TEX_FOLDER/PresentationTemplate/*.eps .
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
    cls;
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

rename(){
    for f in *"$1"*; 
    do 
        echo "$f""-->" "${f//"$1"/"$2"}"; 
    done;
    confirm "Rename as such?" && for f in *"$1"*; 
    do 
        mv "$f" "${f//"$1"/"$2"}"; 
    done;
    cls
}

cpKey(){ #Function to compile the blank version of *_KEY*.tex
  if [ $# -eq 0 ]
    then
      pattern=*_KEY*.tex;
    else
      pattern=$1
  fi
  if ls $pattern 1> /dev/null 2>&1; then
    for f in $pattern;
    do
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
        echo "***********";
        echo Compile key;
        echo "***********";
        latexmk -pdf -silent -g -pdflatex='pdflatex %O -interaction=nonstopmode -synctex=1 "\PassOptionsToClass{answers}{exam}\input{%S}"' $f > /dev/null;
    done;
    confirm "rbf? (def Y)" -y && arbf && cls;
    evince ${f//"_KEY.tex"/""}*.pdf & # *.pdf
  else
    echo "No files match *_KEY*.tex pattern";
  fi
}

cdls(){
    if [ -z ${1+x} ]; then
        cd;
        cls;
    else
        cd "$1" && cls;
    fi
}

mkcdir ()
{
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

cls

export PETSC_DIR=~/petsc
export PETSC_ARCH=linux-gnu
