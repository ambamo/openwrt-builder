#!/bin/bash

start=`date +%s.%N`

# clone openwrt source
git clone --depth 1 $REPO_URL -b $REPO_BRANCH src
cd src
git pull
#rm ./feeds/nss_host
#ln -s ./feeds/nss_packages/qca/feeds/nss-host ./feeds/nss_host

# update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# load custom config
#[ -e $CONFIG_FILE ] && mv $CONFIG_FILE ./.config && mv $CONFIG_FILE ./.config
echo "load ax3600 config"
rm /openwrt/src/.config
cp /openwrt/scripts/ax3600.config /openwrt/src/.config
# make menuconfig
# generate config file
#make defconfig

middle=`date +%s.%N`
echo "middle $middle"


# make download
make -j8 download
find dl -size -1024c -exec rm -f {} \;

# compile
make -j$(nproc) || make -j1 || make -j1 V=sc

end=`date +%s.%N`
echo "middle $end"