#!/usr/bin/env bash

if [[ ! -f ".env" ]]; then
    echo -ne "[ERR]\tCouldn't find .env file. cd to the working directory, and run:\n"
    echo -ne "[ERR]\tcp env/defaults.env .env\n"
    echo -ne "[ERR]\tEdit the file, save, and then rerun this script\n"
    exit 1
fi

. ./.env

ARCH="$(uname -m)"
if [[ "${ARCH}" == "x86_64" ]]; then
    ARCH="amd64"
fi
if [[ "${ARCH}" == "aarch64" ]]; then
    ARCH="arm64"
fi

if [[ -z "${STEAMCMD_VERSION}" ]]; then
    STEAMCMD_VERSION="latest"
    export STEAMCMD_VERSION
fi

if [[ -z "${DOCKER_REGISTRY}" ]]; then
    echo -ne "[ERR]\tDOCKER_REGISTRY unset, please add it to your .env\n"
    exit 1
fi
if [[ -z "${DOCKER_USERNAME}" ]]; then
    echo -ne "[ERR]\DOCKER_USERNAME unset, please add it to your .env\n"
    exit 1
fi
if [[ -z "${DOCKER_PROJECT}" ]]; then
    echo -ne "[ERR]\DOCKER_PROJECT unset, please add it to your .env\n"
    exit 1
fi

DIST="noble"
TAG="${DOCKER_REGISTRY}/${DOCKER_USERNAME}/${DOCKER_PROJECT}:${STEAMCMD_VERSION}"

echo -ne "[INFO]\tMerging for ${DIST} on amd64 and arm64\n"
docker buildx imagetools create -t ${TAG} ${TAG}-amd64 ${TAG}-arm64
echo -ne "[INFO]\tSuccess! Tagged as ${TAG}\n"
