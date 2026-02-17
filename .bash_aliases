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
alias db="cdls $DROPBOX_PATH"
alias jn="jupyter-notebook"
alias lander="cdls $DROPBOX_PATH/work/lander/"
alias lofiStudy="youtube-dl https://www.youtube.com/watch?v=5qap5aO4i9A -o - | ffplay - -nodisp -autoexit -loglevel quiet"
alias mkdir="mkdir -pv"
alias mkTex="latexmk -pdf -synctex=1"
alias myip="curl http://ipecho.net/plain; echo"
alias qtcreator="~/qtcreator-4.13.2/bin/qtcreator"
alias rbf="cleanTex; read -p 'Enter to continue'; ls -F --group-directories-first && pwd;"
alias restartBluetooth="/home/peter/.scripts/restartBluetooth.sh"
alias rwifi="nmcli r wifi off; read -p 'Press enter'; nmcli r wifi on"
alias scannet="sudo nmap -sP 192.168.1.*/24"
alias schedule="exo-open /home/peter/Dropbox/work/lander/misc/schedules/schedule.pdf"
alias snmr="sudo systemctl restart NetworkManager.service"
alias solarSailer="youtube-dl https://www.youtube.com/watch?v=0gFyoH-JFFA -o - | ffplay - -nodisp -autoexit -loglevel quiet"
alias texpreamble="emacs $TEX_HOME/texPreamble.sty"
alias texshortcuts="emacs $TEX_HOME/texShortcutsWesterbaan.tex"
alias tocp="xargs -0 echo -n | xclip -selection clipboard"
alias todo="emacs $DROPBOX_PATH/Documents/todo.txt"
alias updateZoom="/home/peter/.scripts/updateZoom.sh"
alias wakeCommandCenter="wakeonlan $COM_CENT_MAC"
alias wego="/home/peter/.scripts/go/bin/wego"

calc(){
    # printf "%f\n" `echo $@ |bc -l`;
    python3 -c "import math; import numpy as np; print($1)"
}

randNums(){
    # Use python to generate $1 psuedo random numbers between
    # $2 and $3 with default values defined below.
    python3 -c "
import numpy as np
n=int('$1' or 5)
a=int('$2' or -5)
b=int('$3' or 5)
print(np.random.randint(a,b+1,size=n).tolist())";
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

#auto complete
# filenames for getPdfPages (lander_lecture_notes)
# TODO: Move to .bashrc.d? (need to cd into working dir)
complete -f -o plusdirs -X '!*.pdf' getPdfPages.sh

ls -F --group-directories-first && pwd
export PATH=$PATH:/usr/local/go/bin
shopt -s direxpand
