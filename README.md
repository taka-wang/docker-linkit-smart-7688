Dockerized Toolchain for Linkit Smart 7688
===

Build the based docker image
---
You may change the image name as you like.

```
docker build --rm -t linkit-smart .
```

Building an OpenWRT firmware
---
Notice for the menuconfig step, please select the following options to set target profile per below: 

- Target System: Ralink RT288x/RT3xxx- Subtarget: MT7688 based boards- Target Profile: LinkIt 7688

```
docker run -it linkit-smart /bin/bash
cd /openwrt
./scripts/feeds update && ./scripts/feeds install -a
make menuconfig
make V=99
```

Building a bootloader
---
The resulting bootloader file is uboot.bin

```
docker run -it linkit-smart /bin/bash
cd /linkit-smart-uboot
make
```

