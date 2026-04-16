#!/usr/bin/env bash

ARCH_32="i386"
if [[ "${TARGETARCH}" == "arm64" ]]; then
    ARCH_32="armhf"
fi

apt update
apt install -y libc6 \
    libcrypt1 \
    libgcc-s1 \
    libgl1 \
    libgl1-mesa-dri \
    libgpg-error0 \
    libstdc++6 \
    libtcmalloc-minimal4t64 \
    libudev1 \
    libva-x11-2 \
    libva2 \
    libxcb-dri3-0 \
    libxcb1 \
    libxi6 \
    libxinerama1 || exit 1

dpkg --add-architecture ${ARCH_32} || exit 1

if [[ "${ARCH_32}" == "i386" ]]; then
    apt update
elif [[ "${ARCH_32}" == "armhf" ]]; then
    apt update
    apt install -y libtcmalloc-minimal4t64:armhf
fi

apt install -y libc6:${ARCH_32} \
    libcrypt1:${ARCH_32} \
    libgcc-s1:${ARCH_32} \
    libgl1:${ARCH_32} \
    libgl1-mesa-dri:${ARCH_32} \
    libgpg-error0:${ARCH_32} \
    libnm0:${ARCH_32} \
    libstdc++6:${ARCH_32} \
    libudev1:${ARCH_32} \
    libva-x11-2:${ARCH_32} \
    libva2:${ARCH_32} \
    libxcb-dri3-0:${ARCH_32} \
    libxcb1:${ARCH_32} \
    libxi6:${ARCH_32} \
    libxinerama1:${ARCH_32} \
