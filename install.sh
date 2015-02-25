#!/bin/sh
DFILES=`pwd`
ln -fs ${DFILES}/vimrc ${HOME}/.vimrc 
ln -fs ${DFILES}/funcs.R ${HOME}/funcs.R 
ln -fs ${DFILES}/Rprofile ${HOME}/.Rprofile
ln -fs ${DFILES}/gitconfig ${HOME}/.gitconfig
ln -fs ${DFILES}/tmuxconf ${HOME}/.tmux.conf
ln -fs ${DFILES}/conkyrc ${HOME}/.conkyrc
