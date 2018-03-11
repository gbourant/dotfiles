#!/bin/zsh

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

if [[ -f $HOME/.scripts/lock/screen-lock.png ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file ~/.scripts/lock/screen-lock.png | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)

    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    #SR=$(xrandr --query | grep ' connected' | cut -f3 -d' ')
    SR=("${(f)SR}")#zsh
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1 | tr -d '\n')                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1 | tr -d '\n')  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2 | tr -d '\n') # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3 | tr -d '\n') # y offset
        
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
        
        convert /tmp/screen.png $HOME/.scripts/lock/screen-lock.png -geometry +$PX+$PY -composite -matte  /tmp/screen.png
    done
fi
i3lock -e -u -n -i /tmp/screen.png