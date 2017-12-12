#!/bin/bash
# correctly identify the location of latex
# documentation the commands which update
# the system path are located in:
# /etc/profile.d/texmf.sh
if [ -d /usr/share/texlive/2017 ]
then
  # update manpath if needed
  export MANPATH="/usr/share/texlive/2017/texmf-dist/doc/man:$MANPATH"
  # update info path if needed
  export INFOPATH="/usr/share/texlive/2017/texmf-dist/doc/info:$INFOPATH"
fi
source ~/.bashrc
