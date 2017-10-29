#!/bin/bash

CONFIG_DIR=./configuration
HOME=/home/gbourant

rm -rf $CONFIG_DIR

cp -rp $HOME/.config/gtk-3.0 $CONFIG_DIR
cp -rp $HOME/.config/i3 $CONFIG_DIR

git add -A
git commit -m "updated from script"
git push