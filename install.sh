#!/usr/bin/env bash

SCRIPT_PATH=${0%/*}

if [ -d $SCRIPT_PATH ]; then
    cd $SCRIPT_PATH
fi

. /etc/os-release

case "$ID_LIKE" in
    'cygwin arch')
        pacman --needed --noconfirm -S nasm mingw-w64-ucrt-x86_64-qemu unzip
        printf '\nPress any key to continue\n'
        read -rs -n 1 ;;
    'arch')
        sudo pacman --needed --noconfirm -S nasm qemu unzip ;;
esac
