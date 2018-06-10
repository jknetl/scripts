#!/bin/bash
#
# backup-photos.sh
# ================
# A simple script for backing up photos from my laptop to ssd

source_dir=${1:-$HOME/storage/fotky/}
dest_dir=${2:-/run/media/$USER/SeagateBackupPlus/Multimedia/FOTO/}

sync.sh "$source_dir" "$dest_dir"

