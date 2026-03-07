FROM ubuntu:20.04
RUN useradd -m ctf
COPY sources.list /etc/apt/sources.list
RUN rm -f /etc/apt/sources.list.d/ubuntu.sources || true && \
    apt-get update && \
    apt-get install -y libmicrohttpd12 supervisor --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*



COPY supervisord.conf /home/ctf/supervisord.conf

WORKDIR /home/ctf
RUN mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin
COPY ./start.sh /start.sh

RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

RUN chmod +x /start.sh

RUN rm .bash_logout && rm .bashrc && rm .profile

COPY ./httpd /home/ctf/
COPY ./login.html  /home/ctf/
COPY ./find.sh  /home/ctf/
COPY ./work.html  /home/ctf/
COPY ./log.html  /home/ctf/
COPY ./libc-2.31.so  /lib/
RUN chown -R root:ctf /home/ctf && chmod -R 777 /home/ctf
CMD ["/start.sh"]


EXPOSE 9999
