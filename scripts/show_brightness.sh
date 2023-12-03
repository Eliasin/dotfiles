#!/bin/bash
BRIGHTNESS=$(brightnessctl -m | grep "amdgpu_bl1" | cut -d',' -f4 | cut -d'%' -f1)
echo "${BRIGHTNESS}" > /tmp/wobpipe
