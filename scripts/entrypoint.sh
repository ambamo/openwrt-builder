#!/bin/bash

# prepare
CONFIG_FILE=/openwrt/config/$TARGET.config

# build firmware
sh /openwrt/scripts/build.sh

# # move firmware
# FIRMWARE_DIR=/openwrt/firmware/$TARGET-$(date +"%Y%m%d%H%M")
# mkdir -p $FIRMWARE_DIR
# mv -f /openwrt/src/bin/targets/* $FIRMWARE_DIR
