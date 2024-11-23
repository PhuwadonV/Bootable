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

[ ! -f out/MBR.raw ] && sh build.sh

qemu-system-x86_64 -drive format=raw,file=out/MBR.raw || OnError
