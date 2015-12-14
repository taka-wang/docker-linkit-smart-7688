FROM ubuntu:14.04
MAINTAINER Taka Wang <taka@cmwang.net>
 
## Set environment variable
ENV DEBIAN_FRONTEND noninteractive

## Install required development packages
RUN apt-get update && apt-get install -y git g++ libncurses5-dev subversion libssl-dev gawk libxml-parser-perl build-essential unzip wget python
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

## Bootloader
WORKDIR /
RUN git clone https://github.com/MediaTek-Labs/linkit-smart-uboot.git
WORKDIR /linkit-smart-uboot
RUN tar xjf buildroot-gcc342.tar.bz2 -C /opt/
RUN rm buildroot-gcc342.tar.bz2 buildroot-gdb-src-pkt.tar.bz2
# RUN make

## OpenWRT Firmware
WORKDIR /
RUN git clone git://git.openwrt.org/15.05/openwrt.git
WORKDIR /openwrt
RUN cp feeds.conf.default feeds.conf && echo src-git linkit https://github.com/MediaTek-Labs/linkit-smart-7688-feed.git >> feeds.conf
RUN wget https://gist.githubusercontent.com/taka-wang/dee605a8420eebf94fe8/raw/15b15ed14ddef27bd73f9396e53dcadae07fcbc4/.config
RUN ./scripts/feeds update && ./scripts/feeds install -a
RUN make download
#RUN make menuconfig
#RUN make V=99
#RUN make -j 2 V=99
