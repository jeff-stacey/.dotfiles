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
    "login,$HOME/.login"
    "commonprofile,$HOME/.commonprofile"
    "bashrc,$HOME/.bashrc"
    "vimrc,$HOME/.vimrc"
    "init.vim,$HOME/.config/nvim/init.vim"
)

for file_pair in ${filelist[@]}; do
    IFS=',' read src tgt <<< "${file_pair}"
	echo "	$basedir/configs/$src -> $tgt"
	mv $tgt $olddir
	mkdir -p $(dirname "$tgt")
ln -s $basedir/configs/$src $tgt
done

echo "Done"
