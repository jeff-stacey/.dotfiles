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
	bashrc
	zshrc
	vimrc
)

for file in $filelist; do
	echo "	$file"
	mv ~/.$file ~/.olddotfiles/
	ln -s $basedir/configs/$file ~/.$file
done

mv ~/.ssh/config ~/.olddotfiles/ssh_config
ln -s $basedir/configs/ssh_config ~/.ssh/config

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

echo "Copying terminal color scheme"
if [ -d ~/.local/share/xfce4/terminal/colorschemes ]; then
    cp xfce4-terminal-colours/base16-google.dark.theme ~/.local/share/xfce4/terminal/colorschemes
fi

echo "Setting up desktop files"
filelist=`ls $basedir/desktop`

for file in $filelist; do
    echo "  $file"
    ln -si $basedir/desktop/$file ~/.local/share/applications/$file
done

echo "Done"
