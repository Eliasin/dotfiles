#!/bin/bash

delay=$1

if [ -n "$delay" ] && [ "$delay" -eq 0 ];
then
     playerctl pause; swaylock --daemonize -i "${HOME}/Pictures/red_moon_3x2.jpg"
	 exit 0
elif [ -z "$delay" ];
then
	delay=30
fi

chayang -d "${delay}" && swaylock --daemonize -i "${HOME}/Pictures/red_moon_3x2.jpg" && playerctl pause
