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

command -V qemu-system-x86_64 || OnError

[ ! -f out/MBR.img ] && (sh build.sh || exit $?)

qemu-system-x86_64 -drive format=raw,file=out/MBR.img || OnError
