#!/bin/bash

MODE=$1

VS_CODE_PLUGINS=$DOT_FILES/configuration/vscode/vs.config
VS_CODE_CONFIG=$DOT_FILES/configuration/vscode/settings.json

if [ "$MODE" = '1' ] ; then
    code --list-extensions >> $VS_CODE_PLUGINS
    cat $VS_CODE_PLUGINS | sort -u -o $VS_CODE_PLUGINS
    exit
fi

if [ "$MODE" = '2' ] ; then
    cat $VS_CODE_PLUGINS | xargs -L 1 code --install-extension
    exit
fi

if [ "$MODE" = '3' ] ; then
    cat /home/gbourant/.config/Code/User/settings.json > $VS_CODE_CONFIG
    exit
fi

if [ "$MODE" = '4' ] ; then
    cp $VS_CODE_CONFIG /home/gbourant/.config/Code/User
    exit
fi

echo "##############          MODE         #################"
echo "############## 1 -> BACKUP  PLUGINS  #################"
echo "############## 2 -> INSTALL PLUGINS  #################"
echo "############## 3 -> BACKUP  SETTINGS #################"
echo "############## 4 -> INSTALL SETTINGS #################"