FROM ubuntu:bionic
MAINTAINER sh@analogic.cz

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin
    
ADD https://github.com/just-containers/socklog-overlay/releases/download/v3.1.0-1/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /
    
ENTRYPOINT ["/init"]

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y bitcoind nmap

RUN mkdir /var/run/bitcoind

EXPOSE 18332 18335

VOLUME ["/data"]
ADD rootfs /
