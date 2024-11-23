#!/bin/sh

SCRIPT_PATH=${0%/*}
[ -d "$SCRIPT_PATH" ] && cd "$SCRIPT_PATH"

. /etc/os-release
OS_ID_LIKE="$ID_LIKE"

OnError()
{
    case "$OS_ID_LIKE" in
        'cygwin arch')
            printf '\nPress any key to continue\n'
            read -rs -n 1
            exit $? ;;
    esac
}

mkdir -p out/efi/boot || OnError

nasm src/main.asm -i src -f bin -o out/efi/boot/bootx64.efi || OnError
