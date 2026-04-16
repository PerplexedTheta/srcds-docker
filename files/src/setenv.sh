#!/bin/sh

unset LD_LIBRARY_PATH
LD_LIBRARY_PATH="/srcds:/srcds/bin:/srcds/linux32:/srcds/linux64:/home/steam/Steam/linux32:/home/steam/Steam/linux64"

EMULATOR=""
if [ "${TARGETARCH}" = "arm64" ]; then
    EMULATOR="/usr/local/bin/box64"
fi

I386_LIB_ROOT="/usr/lib/i386-linux-gnu"
AMD64_LIB_ROOT="/usr/lib/x86_64-linux-gnu"
if [ "${TARGETARCH}" = "arm64" ]; then
    I386_LIB_ROOT="/usr/lib/box64-i386-linux-gnu"
    AMD64_LIB_ROOT="/usr/lib/box64-x86_64-linux-gnu"
fi

export LD_LIBRARY_PATH
export EMULATOR
export I386_LIB_ROOT
export AMD64_LIB_ROOT
