#!/usr/bin/env bash

. /usr/bin/setdockerenv

echo -ne "[INFO]\tUpdating server at ${SRCDS_ROOT} with AppID ${STEAM_APPID} . . . \n"

while [[ ! -f "${SRCDS_BIN}" ]]; do
    echo -ne "[INFO]\t${SRCDS_BIN} not found - running installation\n"
    ${EMULATOR} ${STEAMCMD_BIN} \
        +force_install_dir ${SRCDS_ROOT} \
        +login anonymous \
        +app_update ${STEAM_APPID} \
        +quit

    sleep 15s
done

echo -ne "[INFO]\tChecking AppID ${STEAM_APPID} for updates\n"
${EMULATOR} ${STEAMCMD_BIN} \
    +force_install_dir ${SRCDS_ROOT} \
    +login anonymous \
    +app_update ${STEAM_APPID} \
    +quit

echo -ne "[INFO]\tExecuting server binary with the following flags:\n"
echo -ne "[INFO]\t${SRCDS_ARGS}\n"
exec ${EMULATOR} ${SRCDS_BIN} -console ${SRCDS_ARGS}
