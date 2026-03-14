#!/bin/sh

MAX_QEMU=80
TIMEOUT=300

CUR=$(pgrep -fc qemu-system-x86_64)
if [ "$CUR" -ge "$MAX_QEMU" ]; then
    echo "[-] Server is busy, please retry later."
    sleep 1
    exit 1
fi

exec timeout --signal=KILL ${TIMEOUT} \
qemu-system-x86_64 \
    -m 96M \
    -nographic \
    -enable-kvm \
    -smp 2 \
    -cpu max \
    -kernel ./bzImage \
    -initrd ./initramfs.cpio.gz \
    -monitor /dev/null \
    -append "console=ttyS0 kaslr no5lvl pti=on oops=panic panic=1 quiet" \
    -no-reboot