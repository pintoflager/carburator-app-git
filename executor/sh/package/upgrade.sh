#!/bin/sh

path="$1"
branch="$2"

if [ -z "$path" ]; then
	carburator log error \
        "Full path to repository root dir has to be provided as \$1"
	exit 120
fi

if [ -z "$branch" ]; then
	branch=main
fi


git -C "$path" fetch --all
git -C "$path" branch "backup-$branch"
git -C "$path" reset --hard "origin/$branch"
