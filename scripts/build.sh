#!/bin/bash

# clone openwrt source
git clone --depth 1 $REPO_URL -b $REPO_BRANCH src
cd src

# update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# load custom config
#[ -e $CONFIG_FILE ] && mv $CONFIG_FILE ./.config && mv $CONFIG_FILE ./.config
mv /openwrt/devices/ax3600.config ./.config
# generate config file
make defconfig

# make download
make -j8 download
find dl -size -1024c -exec rm -f {} \;

# compile
make -j$(nproc) || make -j1 || make -j1 V=s
