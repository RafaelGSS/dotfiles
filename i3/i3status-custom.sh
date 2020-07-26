#!/bin/bash

i3status --config ~/.config/i3/i3status.conf | while :
do
  read line
  case "$(xset -q|grep LED| awk '{ print $10 }')" in
    "00000002") KBD="En" ;;
    "00001002") KBD="Br" ;;
    *) KBD="unknown" ;;
  esac
  echo "KEY: $KBD | $line" || exit 1
done
