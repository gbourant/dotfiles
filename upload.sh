#!/bin/bash

CONFIG_DIR=./configuration
HOME=/home/gbourant

rm -rf $CONFIG_DIR

configFolder=(gtk-3.0 i3)

for folderName in "${configFolder[@]}"
do
    mkdir -p $CONFIG_DIR/.config/$folderName
    cp -r $HOME/.config/$folderName $CONFIG_DIR/.config
done

cp $HOME/.gtkrc-2.0 $CONFIG_DIR

git add -A
git commit -m "updated from script"
git push
