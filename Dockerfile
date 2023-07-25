
FROM debian:stable-slim AS build-stage

WORKDIR /openwrt

RUN apt-get update
RUN apt-get install -y sudo build-essential clang flex g++ gawk gettext \
      git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev \
      file wget
RUN apt-get clean


COPY . /openwrt/
COPY entrypoint.sh /entrypoint.sh
RUN mkdir /openwrt/firmware
RUN groupadd -r openwrtgrp && useradd -r -g openwrtgrp openwrt
RUN chown -R openwrt:openwrtgrp /openwrt
USER openwrt
CMD [ "/entrypoint.sh" ]
