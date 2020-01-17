#!/bin/bash

i3status ~/.config/i3/i3status.conf | while :
do
  read line
  KEY=$(setxkbmap -print | grep xkb_symbols | awk -F"+" '{print $2}')
  echo "KEY: $KEY | $line" || exit 1
done
