#!/bin/bash
# script to generate latex equation and place *.png into clipboard
# For some reason, "--shell-escape" prevents \formula{$1} from reading $1
SRC=genLatexPicture
pdflatex "\\def\\formula{$1}" "\\include{$SRC}" > /dev/null
convert -flatten -density 2500 -resize 175x175 -quality 100 $SRC.pdf $SRC.png
xclip -selection clipboard -t "image/png" -i $SRC.png
rm $SRC.{aux,log,pdf,png}

