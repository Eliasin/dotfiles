#!/bin/bash

if NUM_OPEN_PRS=$(ghp count); then
	if [ "$NUM_OPEN_PRS" -eq 0 ]; then
		echo    󰔓
	else
		echo "   $NUM_OPEN_PRS"
	fi
else
	echo  
fi
