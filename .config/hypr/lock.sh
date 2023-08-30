#!/bin/sh
for o in DP-3 eDP-1
do
	grim -o "$o" "/tmp/$o.png"
	corrupter "/tmp/$o.png" "/tmp/$o.png" &
done
wait
exec gtklock -s ~/.config/gtklock/style.css "$@"
