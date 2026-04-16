#!/usr/bin/env bash

. /usr/bin/setdockerenv

if [[ -z "$(tty)" ]]; then
    echo -ne "[ERR]\tNo tty detected - please add `tty: true` to your compose\n"
    exit 1
fi

if [[ ! -d "${SRCDS_ROOT}" ]]; then
    echo -ne "[ERR]\t${SRCDS_ROOT} not found - please mount a volume here\n"
    exit 1
fi

usermod -u ${USER_UID:-1000} steam || exit 1
groupmod -g ${USER_GID:-1000} steam || exit 1

chown -R steam /home/steam
chgrp -R steam /home/steam

chown -R steam /srcds
chgrp -R steam /srcds

exec su steam /bin/bash -c '/run_srcds.sh'
