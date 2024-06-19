#! /usr/bin/env bash

# check that we have a version tag passed in
if [ -z "$1" ]; then
    echo "Please pass in a papercut version as the first argument in the format of major.minor.patch.build"
    echo "Example: ./build.sh 20.0.4.55447"
    echo "You can find Papercut versions here: https://www.papercut.com/products/mf/release-history/"
    exit 1
fi

# check if we're on amd64 and use buildx if not
if [ "$(uname -m)" != "x86_64" ]; then
    docker buildx build --platform linux/amd64 --build-arg="PAPERCUT_MF_VERSION=${1}" -t "papercut-mf:${1}" .
else
    docker build -t --build-arg="PAPERCUT_MF_VERSION=${1}" "papercut-mf:${1}" .
fi
