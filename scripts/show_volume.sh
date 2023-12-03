#!/bin/bash
sleep 0.05
VOLUME=$(wpctl get-volume @DEFAULT_SINK@ | cut -d' ' -f2)
VOLUME_PERCENT=$(echo "${VOLUME} * 100 / 1" | bc -l)
VOLUME_ROUNDED=$(printf "%.0f" "${VOLUME_PERCENT}")
echo "$VOLUME_ROUNDED" > /tmp/wobpipe
