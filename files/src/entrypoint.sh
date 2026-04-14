#!/usr/bin/env bash

. /usr/bin/setdockerenv

if [[ ! -d "${SRCDS_ROOT}" ]]; then
    echo -ne "[ERR]\t${SRCDS_ROOT} not found - please mount a volume here\n"
    exit 1
fi

usermod -u ${USER_UID:-1000} steam || exit 1
groupmod -g ${USER_GID:-1000} steam || exit 1

chown -R steam /home/steam || exit 1
chgrp -R steam /home/steam || exit 1

chown -R steam /srcds || exit 1
chgrp -R steam /srcds || exit 1

exec su steam /bin/bash -c '/run_srcds.sh'
