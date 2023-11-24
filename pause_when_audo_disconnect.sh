#!/bin/bash
pactl subscribe | grep --line-buffered "'remove' on sink" | xargs -L1 playerctl pause
