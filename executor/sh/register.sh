#!/usr/bin/env sh

# ATTENTION: Supports only client nodes, pointless to read role from $1
if [ "$1" = "server" ]; then
    carburator print terminal error \
        "Git registers only on client nodes. Package configuration error."
    exit 120
fi

# Git client is required
if ! carburator has program git; then
    carburator print terminal error \
        "Missing required program git. Trying to install..."
else
    carburator print terminal success "Git client found from the host"
    exit 0
fi

carburator prompt yes-no \
    "Should we try to install git on your computer?" \
        --yes-val "Yes try to install with a script" \
        --no-val "No, I'll install everything myself"; exitcode=$?

if [ $exitcode -ne 0 ]; then
    exit 120
fi

# TODO: Untested below
if carburator has program apt; then
    sudo apt-get -y update
    sudo apt-get -y install git

elif carburator has program pacman; then
    sudo pacman update
    sudo pacman -Sy git

elif carburator has program yum; then
    sudo yum makecache --refresh
    sudo yum install -y git

elif carburator has program dnf; then
    sudo dnf makecache --refresh
    sudo dnf install -y git

else
    carburator print terminal error \
        "Unable to detect linux package manager from client node"
    exit 120
fi
