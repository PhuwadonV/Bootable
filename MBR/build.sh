#!/bin/sh

SCRIPT_PATH=${0%/*}
[ -d "$SCRIPT_PATH" ] && cd "$SCRIPT_PATH"

. /etc/os-release
OS_ID_LIKE="$ID_LIKE"

OnError()
{
    case "$OS_ID_LIKE" in
        'cygwin arch')
            EXIT_STATUS=$?
            printf '\nPress any key to continue\n'
            read -rs -n 1
            exit $EXIT_STATUS ;;
    esac
}

command -V nasm || OnError

mkdir -p out || OnError

nasm -f bin -Werror src/main.asm -o out/MBR.raw || OnError
