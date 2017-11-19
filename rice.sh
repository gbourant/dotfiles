#!/bin/bash

CONFIG_DIR=./configuration
HOME=/home/gbourant

configFolder=(gtk-3.0 i3)

for folderName in "${configFolder[@]}"
do
    rm -rf $HOME/.config/$folderName
    cp -r  $CONFIG_DIR/.config/$folderName $HOME/.config
done

cp $CONFIG_DIR/.gtkrc-2.0 $HOME

git add -A
git commit -m "updated from script"
git push
