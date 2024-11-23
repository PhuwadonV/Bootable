#!/bin/sh

SCRIPT_PATH=${0%/*}
[ -d "$SCRIPT_PATH" ] && cd "$SCRIPT_PATH"

for dir in */ ; do
    sh ${dir%/}/clean.sh &
done
