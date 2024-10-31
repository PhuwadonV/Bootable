#!/usr/bin/env bash

SCRIPT_PATH=${0%/*}

if [ -d $SCRIPT_PATH ]; then
    cd $SCRIPT_PATH
fi

mkdir -p out/efi/boot

nasm src/main.asm -f bin -o out/efi/boot/bootx64.efi

if [ "$?" -ne 0 ]; then
    . /etc/os-release

    case "$ID_LIKE" in
        'cygwin arch')
            printf '\nPress any key to continue\n'
            read -rs -n 1 ;;
    esac
fi
