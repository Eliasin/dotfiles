#!/bin/bash
mkfifo /tmp/wobpipe; tail -f /tmp/wobpipe | wob
