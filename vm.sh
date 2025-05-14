#!/usr/bin/env bash

sudo qemu-system-x86_64 --enable-kvm --cpu host \
    -m 16G \
    -smp 8 \
    -device intel-hda -device hda-duplex \
    -drive file=./OVMF_CODE.fd,if=pflash,format=raw,readonly=on \
    -drive file=./OVMF_VARS.fd,if=pflash,format=raw,unit=1 \
    -drive file=/dev/disk/by-id/ata-WDC_WDS500G1B0A-00H9H0_173206800096,index=0,media=disk,driver=raw
