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

[ ! -f out/efi/boot/bootx64.efi ] && sh build.sh

if [ ! -f tmp/OVMF.fd ]; then
    [ ! -f tmp/OVMF.zip ] && wget https://efi.akeo.ie/OVMF/OVMF-X64.zip -P tmp
    unzip tmp/OVMF-X64.zip OVMF.fd -d tmp
    rm tmp/OVMF-X64.zip
fi

qemu-system-x86_64 -drive if=pflash,format=raw,file=tmp/OVMF.fd -drive format=raw,file=fat:rw:out || OnError
