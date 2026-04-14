#!/usr/bin/env bash

if [[ "${TARGETARCH}" == "arm64" ]]; then
    dpkg -i /tmp/payload/box64.deb
fi

rm -f /tmp/payload/box64.deb
