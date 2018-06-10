#!/bin/bash

# update-scripts.sh
# =================
#
# This script updates scripts in this git repository by copying them to a directory on path

REPO_DIR="$HOME/projects/scripts/"
PATH_DEST_DIR="/opt/bin/"

cp $REPO_DIR/* $PATH_DEST_DIR
