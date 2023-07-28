
FROM debian:stable-slim AS build-stage

WORKDIR /openwrt

RUN apt-get update
RUN apt-get install -y sudo build-essential clang flex g++ gawk gettext \
      git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev \
      file wget
RUN apt-get clean

RUN mkdir /openwrt/scripts
COPY ./scripts/entrypoint.sh /openwrt/scripts/entrypoint.sh
COPY ./scripts/build.sh /openwrt/scripts/build.sh
COPY ./scripts/ax3600.config /openwrt/scripts/ax3600.config
COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN mkdir /openwrt/firmware
RUN mkdir /openwrt/src
RUN groupadd -r openwrtgrp && useradd -r -g openwrtgrp openwrt
RUN chown -R openwrt:openwrtgrp /openwrt
USER openwrt
#CMD [ "/entrypoint.sh" ]
ENTRYPOINT ["tail", "-f", "/dev/null"]
