FROM ubuntu:22.04

ENV ANYCROSS_REGION=sg
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl lsof && \
    rm -rf /var/lib/apt/lists/*

ADD ./entrypoint.sh /entrypoint.sh

RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT [ "/entrypoint.sh" ]