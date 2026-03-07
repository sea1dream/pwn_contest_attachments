#!/bin/sh
qemu-system-x86_64 \
  -m 256M \
  -cpu kvm64,+smep,+smap \
  -smp cores=2 \
  -kernel bzImage \
  -hda ./rootfs.img \
  -nographic \
  -snapshot \
  -append "console=ttyS0 root=/dev/sda rw kaslr pti=on quiet oops=panic" \
  -monitor /dev/null \
  -no-reboot \
  -s
