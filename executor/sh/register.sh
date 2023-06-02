#!/usr/bin/env sh

# Git client is required
if ! carburator has program git; then
    carburator print terminal error \
        "Missing required program git. Trying to install..."
else
    carburator print terminal success "Git client found from the host"
    exit 0
fi

# TODO: Untested below
if carburator has program apt; then
    apt-get -y update
    apt-get -y install git

elif carburator has program pacman; then
    pacman update
    pacman -Suy git

elif carburator has program yum; then
    yum makecache --refresh
    yum install -y git

elif carburator has program dnf; then
    dnf makecache --refresh
    dnf install -y git

else
    carburator print terminal error \
        "Unable to detect linux package manager from client node"
    exit 120
fi
