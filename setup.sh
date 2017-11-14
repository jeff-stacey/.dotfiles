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



