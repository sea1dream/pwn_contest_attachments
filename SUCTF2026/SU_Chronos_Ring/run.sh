#!/bin/sh
TIMEOUT=300

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