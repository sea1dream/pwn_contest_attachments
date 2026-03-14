FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    socat \
    cpio \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

ADD ./initramfs.cpio.gz .
ADD ./run.sh .
ADD ./bzImage .
ADD ./flag .
RUN chmod +x ./run.sh
RUN sed -i 's/\r$//' ./run.sh && chmod +x ./run.sh

CMD ["socat", "TCP-LISTEN:10001,reuseaddr,fork,nodelay", "EXEC:./run.sh,pty,stderr,setsid,ctty,rawer,echo=0"]