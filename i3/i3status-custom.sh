#!/bin/bash

i3status ~/.config/i3/i3status.conf | while :
do
    read line
    gmail=`perl gmail.pl`
    echo "GMAIL $gmail | $line" || exit 1
done
