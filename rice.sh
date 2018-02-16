#!/bin/bash

CONFIG_DIR=/home/gbourant/.dotfiles/configuration
HOME=/home/gbourant

configFolder=(gtk-3.0 i3)

for folderName in "${configFolder[@]}"
do
    rm -rf $HOME/.config/$folderName
    mkdir -p $HOME/.config/$folderName
    cp -r  $CONFIG_DIR/.config/$folderName $HOME/.config
done

configFiles=(.gtkrc-2.0 .zshrc)

for fileName in "${configFiles[@]}"
do
    rm -f $HOME/$fileName
    cp $CONFIG_DIR/$fileName $HOME
done

 cp -r $CONFIG_DIR/.scripts $HOME