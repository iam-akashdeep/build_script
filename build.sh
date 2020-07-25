#!/usr/bin/env bash

# Copyright (C) 2020 Akash Deep

# Set variables
KERNEL_DIR=$wd"/home/akash/Kernel/android_kernel_xiaomi_sdm660"
ANYKERNEL_DIR=$wd"/home/akash/Kernel/AnyKernel3"
DATE="`date +%d%m%Y-%H%M%S`"
ZIMAGE=$KERNEL_DIR/arch/arm64/boot/zImage

# Define Color Code
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
nocol='\033[0m'         # Default

# Set paths
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="AkashDeep"
export KBUILD_BUILD_HOST="Home"
export CROSS_COMPILE=/home/akash/Kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/akash/Kernel/arm-eabi-4.8/bin/arm-eabi-

# Compilation Scripts Are Below
compile_kernel ()
{
echo -e "$Green***************************************"
echo "         Compiling Deep_Kernel             "
echo -e "***************************************$nocol"
cd "$KERNEL_DIR"
make clean && make mrproper
make whyred_defconfig
make -j4
}
compile_kernel

# Making A Flashable Zip
make_zip ()
{
echo -e "$Green**********************************************"
echo "    Making a flashable zip with AnyKernel3          "
echo -e "**********************************************$nocol"
export ZIPNAME=Deep_Kernel-$DATE.zip
cd "$ANYKERNEL_DIR"
rm -f Deep*.zip
rm -f Image.gz-dtb
cp $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb ${ANYKERNEL_DIR}/
zip -r9 $ZIPNAME * -x README.md kernel.zip
}
make_zip
