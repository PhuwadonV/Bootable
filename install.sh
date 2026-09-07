#!/bin/sh

SCRIPT_PATH=${0%/*}
[ -d "$SCRIPT_PATH" ] && cd "$SCRIPT_PATH"

. /etc/os-release
OS_ID_LIKE="$ID_LIKE"

case "$OS_ID_LIKE" in
    'cygwin arch')
        pacman -Syu --needed --noconfirm nasm mingw-w64-ucrt-x86_64-qemu unzip
        printf '\nPress any key to continue\n'
        read -rs -n 1 ;;
    'arch')
        sudo pacman -Syu --needed --noconfirm nasm qemu unzip ;;
esac
