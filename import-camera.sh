#!/bin/bash
#
# import-camera.sh
# ================
# Imports photos and videos from sd-card. It expects specific dir structure to sony a6000 and maybe other similar cameras.
# The script imports raw, jpegs and videos to separate folders.
#
# usage: import-camera.sh OUTPUT_DIR

function usage(){
    echo "usage: import-camera.sh OUTPUT_DIR"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

OUTPUT_DIR="$1"
JPG_DIR=$OUTPUT_DIR/jpg
RAW_DIR=$OUTPUT_DIR/raw
VIDEO_DIR=$OUTPUT_DIR/video
MEDIA_DIR="/run/media/$USER/"
SD_CARD_ROOT=""

for f in $MEDIA_DIR/*; do
  if [ -d $f -a -d $f/DCIM ] ; then
      SD_CARD_ROOT="$f/"
  fi
done

if [ -z "$SD_CARD_ROOT" ]; then
    echo "No SD card found"
    exit 2
fi

PHOTOS_SOURCE="$SD_CARD_ROOT/DCIM/100MSDCF/"
VIDEOS_SOURCE="$SD_CARD_ROOT/PRIVATE/AVCHD/BDMV/STREAM/"

mkdir -p $JPG_DIR
mkdir -p $RAW_DIR
mkdir -p $VIDEO_DIR

echo "Importing $(ls -l $PHOTOS_SOURCE/*.JPG | wc -l)  JPGs..."
cp $PHOTOS_SOURCE/*.JPG $JPG_DIR
echo "Importing $(ls -l $PHOTOS_SOURCE/*.ARW | wc -l)  RAWs..."
cp $PHOTOS_SOURCE/*.ARW $RAW_DIR
echo "Importing $(ls -l $VIDEOS_SOURCE/* | wc -l) videos..."
cp $VIDEOS_SOURCE/* $VIDEO_DIR

echo "Done!"
