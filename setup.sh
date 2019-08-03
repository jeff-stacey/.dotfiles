#!/bin/bash

# setup.sh
# this script backs up old dotfiles and sets up the ones from github

sources=~/.dotfiles/files
olddir=~/.olddotfiles

echo "Creating directory for existing dotfiles..."
mkdir -p $olddir 

echo "Moving existing dotfiles to $olddir"

filelist=`ls $sources`

for file in $filelist; do
	echo "	$file"
	mv ~/.$file ~/.olddotfiles/
	ln -s $sources/$file ~/.$file
done

if [ -d ~/.config/nvim ]; then
    if [ -f ~/.config/nvim/init.vim ]; then
        echo "nvim init file already exists, skipping replacement"
    else
        echo "configuring nvim"
        echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
        let &packpath = &runtimepath
        source ~/.vimrc" > ~/.config/nvim/init.vim
    fi
else
    echo "nvim not installed, skipping configuration"
fi

echo "Done"
