#!/bin/bash

cd ../../
mkdir sources
cd sources
git clone -b "u96-avnet" https://github.com/tonydg2/meta-adghw.git
git clone -b "u96_avnet" https://github.com/tonydg2/meta-adglayer.git

BRANCH="rel-v2023.2"
META_XLNX_SUBMOD_BRNCH="xlnx_rel_v2023.2"

git clone -b $BRANCH https://github.com/Xilinx/meta-openamp.git
git clone -b $BRANCH https://github.com/Xilinx/meta-openembedded.git
git clone -b $BRANCH https://github.com/Xilinx/meta-petalinux.git
git clone -b $BRANCH https://github.com/Xilinx/meta-qt5.git
git clone -b $BRANCH https://github.com/Xilinx/meta-ros.git
git clone -b $BRANCH https://github.com/Xilinx/meta-virtualization.git
git clone -b $BRANCH https://github.com/Xilinx/meta-xilinx.git
git clone -b $BRANCH https://github.com/Xilinx/meta-xilinx-tools.git
git clone -b $BRANCH https://github.com/Xilinx/poky.git

# yuk!
cd meta-xilinx
git submodule update --init --recursive
cd cd meta-xilinx-core/gen-machine-conf
git checkout $META_XLNX_SUBMOD_BRNCH
cd ../../../../

source sources/poky/oe-init-build-env

## add layers manually
# bitbake-layers add-layer ../sources/meta-openamp

##  these 3 are automatic
#  ../sources/poky/meta \
#  ../sources/poky/meta-poky \
#  ../sources/poky/meta-yocto-bsp \

bitbake-layers add-layer ../sources/meta-openembedded/meta-oe
bitbake-layers add-layer ../sources/meta-openembedded/meta-perl
bitbake-layers add-layer ../sources/meta-openembedded/meta-python
bitbake-layers add-layer ../sources/meta-openembedded/meta-filesystems
bitbake-layers add-layer ../sources/meta-openembedded/meta-networking
bitbake-layers add-layer ../sources/meta-openembedded/meta-gnome
bitbake-layers add-layer ../sources/meta-openembedded/meta-multimedia
bitbake-layers add-layer ../sources/meta-openembedded/meta-webserver
bitbake-layers add-layer ../sources/meta-openembedded/meta-xfce
bitbake-layers add-layer ../sources/meta-openembedded/meta-initramfs
bitbake-layers add-layer ../sources/meta-xilinx/meta-xilinx-core
bitbake-layers add-layer ../sources/meta-xilinx/meta-xilinx-standalone
bitbake-layers add-layer ../sources/meta-qt5
bitbake-layers add-layer ../sources/meta-petalinux
bitbake-layers add-layer ../sources/meta-adghw
bitbake-layers add-layer ../sources/meta-ros/meta-ros-common
bitbake-layers add-layer ../sources/meta-ros/meta-ros2
bitbake-layers add-layer ../sources/meta-ros/meta-ros2-humble
bitbake-layers add-layer ../sources/meta-xilinx/meta-microblaze
bitbake-layers add-layer ../sources/meta-openamp
bitbake-layers add-layer ../sources/meta-xilinx/meta-xilinx-bsp
bitbake-layers add-layer ../sources/meta-xilinx/meta-xilinx-vendor
bitbake-layers add-layer ../sources/meta-xilinx-tools
bitbake-layers add-layer ../sources/meta-virtualization
bitbake-layers add-layer ../sources/meta-adglayer

# update local.conf if necessary
# in build dir
mv conf/local.conf conf/local.conf.DEFAULT
cp ../yocto_setup/files/local.conf conf/local.conf

#MACHINE=myhardware-u96v2-zynqmp bitbake u96-image
