#!/bin/bash

CONFIG_DIR=/home/gbourant/.dotfiles/configuration
HOME=/home/gbourant

rm -rf $CONFIG_DIR

configFolders=(gtk-3.0 i3)

for folderName in "${configFolders[@]}"
do
    mkdir -p $CONFIG_DIR/.config/$folderName
    cp -r $HOME/.config/$folderName $CONFIG_DIR/.config
done

configFiles=(.gtkrc-2.0 .zshrc)

for fileName in "${configFiles[@]}"
do
    cp $HOME/$fileName $CONFIG_DIR
done

git add -A
git commit -m "updated from script"
git push
