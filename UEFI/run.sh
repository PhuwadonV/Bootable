#!/usr/bin/env bash

SCRIPT_PATH=${0%/*}

if [ -d $SCRIPT_PATH ]; then
    cd $SCRIPT_PATH
fi

if [ ! -f out/efi/boot/bootx64.efi ]; then
    sh build.sh
fi

if [ ! -f tmp/OVMF.fd ]; then
    if [ ! -f tmp/OVMF.fd ]; then
        wget https://efi.akeo.ie/OVMF/OVMF-X64.zip -P tmp
    fi

    unzip tmp/OVMF-X64.zip OVMF.fd -d tmp
    rm tmp/OVMF-X64.zip
fi

qemu-system-x86_64 -drive if=pflash,format=raw,file=tmp/OVMF.fd -drive format=raw,file=fat:rw:out

if [ "$?" -ne 0 ]; then
    . /etc/os-release

    case "$ID_LIKE" in
        'cygwin arch')
            printf '\nPress any key to continue\n'
            read -rs -n 1 ;;
    esac
fi
