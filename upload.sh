#!/bin/bash

CONFIG_DIR=./configuration
HOME=/home/gbourant

cp -rp $HOME/.config/gtk-3.0 .
cp -rp $HOME/.config/i3 .

rm -rf $CONFIG_DIR
git add -A
git commit
git push