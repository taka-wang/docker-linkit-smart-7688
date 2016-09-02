FROM ubuntu:14.04
MAINTAINER Taka Wang <taka@cmwang.net>
 
## Set environment variable
ENV DEBIAN_FRONTEND noninteractive

## Install required development packages
RUN apt-get update \
        && apt-get install -y \
        build-essential \
        git \
        g++ \
        gawk \
        libncurses5-dev \
        libssl-dev \
        libxml-parser-perl \
        python \
        subversion \
        unzip \
        wget \
    && dpkg --add-architecture i386 \
        && apt-get update \
        && apt-get install -y \
        libc6:i386 \
        libncurses5:i386 \
        libstdc++6:i386 \
    && rm /bin/sh \
        && ln -s /bin/bash /bin/sh

## Bootloader
WORKDIR /
RUN git clone https://github.com/MediaTek-Labs/linkit-smart-uboot.git \
    && cd linkit-smart-uboot \
    && tar xjf buildroot-gcc342.tar.bz2 -C /opt/ \
    && rm buildroot-gcc342.tar.bz2 buildroot-gdb-src-pkt.tar.bz2
# RUN make

## OpenWRT Firmware
WORKDIR /
RUN git clone git://git.openwrt.org/15.05/openwrt.git \
    && cd openwrt \
    && cp feeds.conf.default feeds.conf \
    && echo src-git linkit https://github.com/MediaTek-Labs/linkit-smart-7688-feed.git >> feeds.conf \
    && wget https://gist.githubusercontent.com/taka-wang/dee605a8420eebf94fe8/raw/15b15ed14ddef27bd73f9396e53dcadae07fcbc4/.config \
    && ./scripts/feeds update \
    && ./scripts/feeds install -a \
    && make download
#RUN make menuconfig
#RUN make V=99
#RUN make -j 2 V=99
