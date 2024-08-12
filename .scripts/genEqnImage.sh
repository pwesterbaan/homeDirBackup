#!/bin/bash
# script to generate latex equation and place *.png into clipboard
# For some reason, "--shell-escape" prevents \formula{$1} from reading $1

#TODO: default bash argument or error message
if [ $# -eq 0 ]
then
    echo "You must include the equation you wish to render!"
else

    DIR=/home/peter/.scripts/
    SRC=genLatexPicture

    cd $DIR
    echo Attempting to generate the equation $1
    pdflatex --halt-on-error "\\def\\formula{$1} \\include{$SRC}" #> /dev/null
    convert -flatten -density 2500 -resize 175x175 -quality 300 -colorspace RGB $SRC.pdf $SRC.png
    xclip -selection clipboard -t "image/png" -i $SRC.png
    rm $SRC.{aux,log,pdf,png}
    cd -
fi
