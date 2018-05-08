#!/bin/bash
#
# sync.sh
# ================
# A simple script for synchronizing files using rsync.

source_dir=${1}
dest_dir=${2}

if [ -z "$source_dir" ]; then
    print_usage
fi

if [ -z "$dest_dir" ]; then
    print_usage
fi

if [ ! -d "$source_dir" ]; then
    echo "Source directory doesn't exists: $source_dir" >&2
    exit 2
fi

if [ ! -d "$dest_dir" ]; then
    echo "Source directory doesn't exists: $dest_dir" >&2
    exit 3
fi

echo "Running in dry run:"

RSYNC_OPTS="-av"
rsync $RSYNC_OPTS -n "$source_dir" "$dest_dir"


read -p "Would you like to proceed? [y/n]: " input

until [ $input == "y" -o $input == "n" ]; do
    read -p "Would you like to proceed? Enter \"y\" or \"n\": " input
done

if [ $input == "n" ]; then
    exit 0
fi

echo "syncing..."
rsync $RSYNC_OPTS "$source_dir" "$dest_dir"
