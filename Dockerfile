FROM stubby AS initial

FROM ubuntu:noble

ARG USER_UID="1000"
ARG USER_GID="1000"
ARG TARGETARCH

ARG USER_HOME="/home/steam"
ARG STEAMCMD_ROOT="${USER_HOME}/Steam"
ARG STEAMCMD_BIN="${STEAMCMD_ROOT}/steamcmd.sh"
ARG STEAMCMD_PLATFORM="linux32"

ARG SRCDS_ROOT="/srcds"
ARG SRCDS_BIN="${SRCDS_ROOT}/srcds_run"
ARG SRCDS_PLATFORM="linux32"

ARG STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"

COPY files/payload.tgz /tmp

RUN /usr/bin/apt update && \
    /usr/bin/apt install -y \
        adduser \
        ca-certificates \
        curl \
        debconf \
        file \
        gpg \
        gzip \
        locales \
        passwd \
        screen \
        sed \
        tar \
        wget \
        xz-utils && \
    /usr/bin/sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    /usr/sbin/dpkg-reconfigure --frontend=noninteractive locales && \
    /usr/bin/mkdir /tmp/payload && \
    /usr/bin/tar -xvf /tmp/payload.tgz -C /tmp/payload && \
    /usr/bin/mv /tmp/payload/entrypoint.sh / && \
    /usr/bin/mv /tmp/payload/run_srcds.sh / && \
    /usr/bin/mv /tmp/payload/setenv.sh /usr/bin/setdockerenv && \
    . /usr/bin/setdockerenv && \
    /usr/bin/sh -c /tmp/payload/install_deps.sh && \
    /usr/bin/sh -c /tmp/payload/install_box64+box32.sh && \
    /usr/bin/wget -O /tmp/steamcmd.tgz ${STEAMCMD_URL} && \
    /usr/bin/mkdir -p /usr/games/steam && \
    /usr/bin/tar -xvf /tmp/steamcmd.tgz -C /usr/games/steam && \
    /usr/sbin/userdel ubuntu && \
    /usr/bin/rm -rf /home/ubuntu && \
    /usr/sbin/groupadd -g ${USER_GID} steam && \
    /usr/sbin/useradd -u ${USER_UID} -g ${USER_GID} -m steam && \
    su steam -c /bin/bash -c '/tmp/payload/setup_steamcmd.sh' && \
    /usr/bin/ln -s ${STEAMCMD_ROOT}/linux32/steamclient.so ${I386_LIB_ROOT}/steamclient.so && \
    /usr/bin/ln -s ${STEAMCMD_ROOT}/linux64/steamclient.so ${AMD64_LIB_ROOT}/steamclient.so && \
    /usr/bin/rm -rf /tmp/payload && \
    /usr/bin/rm -f /tmp/*.sh && \
    /usr/bin/rm -f /tmp/*.tgz && \
    /usr/bin/rm -rf /var/lib/apt/lists/*

ENV USER_UID="${USER_UID}"
ENV USER_GID="${USER_GID}"
ENV TARGETARCH="${TARGETARCH}"

ENV STEAMCMD_ROOT="${STEAMCMD_ROOT}"
ENV STEAMCMD_BIN="${STEAMCMD_BIN}"
ENV STEAMCMD_PLATFORM="${STEAMCMD_PLATFORM}"

ENV SRCDS_ROOT="${SRCDS_ROOT}"
ENV SRCDS_BIN="${SRCDS_BIN}"
ENV SRCDS_PLATFORM="${SRCDS_PLATFORM}"

ENV STEAM_APPID="4020"
ENV SRCDS_ARGS="-game garrysmod +maxplayers 16 +exec server.cfg +map gm_construct"

EXPOSE 27015/udp
EXPOSE 27015/tcp

CMD ["/entrypoint.sh"]
