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

command -V wget || OnError
command -V unzip || OnError
command -V qemu-system-x86_64 || OnError

[ ! -f out/efi/boot/bootx64.efi ] && (sh build.sh || exit $?)

if [ ! -f tmp/OVMF.fd ]; then
    [ ! -f tmp/OVMF.zip ] && wget https://efi.akeo.ie/OVMF/OVMF-X64.zip -P tmp || OnError
    unzip tmp/OVMF-X64.zip OVMF.fd -d tmp || OnError
    rm tmp/OVMF-X64.zip
fi

qemu-system-x86_64 -drive if=pflash,format=raw,file=tmp/OVMF.fd -drive format=raw,file=fat:rw:out || OnError
