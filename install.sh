#!/bin/sh
DFILES=`pwd`

uname -a | grep -il darwin
if [ ! $? -eq 0 ]
then
	ln -fs ${DFILES}/conkyrc ${HOME}/.conkyrc
fi

if [[ -f ${HOME}/.i3/config ]]
then
  rm ${HOME}/.i3/config
  ln -fs ${DFILES}/i3config ${HOME}/.i3/config
fi

ln -fs ${DFILES}/vimrc ${HOME}/.vimrc 
ln -fs ${DFILES}/funcs.R ${HOME}/funcs.R 
ln -fs ${DFILES}/Rprofile ${HOME}/.Rprofile
ln -fs ${DFILES}/gitconfig ${HOME}/.gitconfig
ln -fs ${DFILES}/tmuxconf ${HOME}/.tmux.conf
