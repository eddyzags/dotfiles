#!/bin/bash

# To avoid possible race condition. More details here: https://code.google.com/archive/p/xmonad/issues/476
sleep 0.2

scrot '%Y-%m-%d_%H-%M-%S.png' -s -e 'mv $f ~/Pictures/screenshots'

FILENAME=`ls -l $HOME/Pictures/screenshots | awk -F ' ' '{print $9}' | awk NF | sort -r | head -2 | tail -1`

rm $HOME/Pictures/screenshots/latest && ln -s $HOME/Pictures/screenshots/$FILENAME $HOME/Pictures/screenshots/latest
