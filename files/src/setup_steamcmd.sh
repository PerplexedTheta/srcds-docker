#!/usr/bin/env bash

. /usr/bin/setdockerenv

cd ${USER_HOME}
cp -r /usr/games/steam ${STEAMCMD_ROOT}

cd ${STEAMCMD_ROOT} || exit 1
${EMULATOR} ${STEAMCMD_ROOT}/steamcmd.sh +quit

ln -s ${STEAMCMD_ROOT}/linux32/steamclient.so ${STEAMCMD_ROOT}/linux32/steamservice.so || exit 1
if [[ -f "${STEAMCMD_ROOT}/linux64/steamclient.so" ]]; then
    ln -s ${STEAMCMD_ROOT}/linux64/steamclient.so ${STEAMCMD_ROOT}/linux64/steamservice.so || exit 1
fi

mkdir -p ${USER_HOME}/.steam/sdk32 || exit 1
ln -s ${STEAMCMD_ROOT}/linux32/steamclient.so ${USER_HOME}/.steam/sdk32/steamclient.so || exit 1

mkdir -p ${USER_HOME}/.steam/sdk64 || exit 1
if [[ -f "${STEAMCMD_ROOT}/linux64/steamclient.so" ]]; then
    ln -s ${STEAMCMD_ROOT}/linux64/steamclient.so ${USER_HOME}/.steam/sdk64/steamclient.so || exit 1
fi
