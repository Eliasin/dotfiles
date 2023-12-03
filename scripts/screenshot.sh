#!/bin/bash

set -e

region=$(slurp)
wayshot -c -s "$region" --file "${HOME}/Screenshots/$(date +'Screenshot_%s.png')"
