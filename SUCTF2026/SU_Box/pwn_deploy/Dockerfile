FROM eclipse-temurin:21-jdk-noble

RUN apt-get update && \
    apt-get install -y --no-install-recommends xinetd libatomic1 && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf

WORKDIR /app

COPY linux-x86_64.jar /app/lib/
COPY App.java /app/src/

RUN javac -cp /app/lib/linux-x86_64.jar -d /app/classes /app/src/App.java

COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

COPY ctf.xinetd /etc/xinetd.d/ctf
COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

RUN echo "SUCTF{xxxxxx}" > /flag && chmod 444 /flag

EXPOSE 10008

CMD ["/start.sh"]
