#!/bin/bash

# setup.sh
# this script backs up old dotfiles and sets up the ones from github

basedir=$(dirname $(readlink -f $0))
echo $basedir
olddir=~/.olddotfiles

echo "Creating directory for existing dotfiles..."
mkdir -p $olddir 

echo "Moving existing dotfiles to $olddir"

filelist=(
	"bashrc, ~/.bashrc"
	"zshrc, ~/.zshrc"
	"vimrc, ~/.vimrc"
    "ssh_config, ~/.ssh/config"
    "init.vim, ~/.config/nvim/init.vim"
)

for file_pair in $filelist; do
    IFS=',' read src tgt <<< "${i}"
	echo "	$src"
	mv $tgt ~/.olddotfiles/
	ln -s $basedir/configs/$src $tgt
done

echo "Done"
