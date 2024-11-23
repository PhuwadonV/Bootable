#!/bin/sh

SCRIPT_PATH=${0%/*}
[ -d "$SCRIPT_PATH" ] && cd "$SCRIPT_PATH"

. /etc/os-release
OS_ID_LIKE="$ID_LIKE"

case "$OS_ID_LIKE" in
    'cygwin arch')
        pacman -Rcns nasm mingw-w64-ucrt-x86_64-qemu unzip
        printf '\nPress any key to continue\n'
        read -rs -n 1 ;;
    'arch')
        sudo pacman -Rcns nasm qemu unzip ;;
esac
