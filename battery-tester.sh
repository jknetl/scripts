#!/bin/bash
#
# Script for estimating battery life. This script should run infinitely
# until a battery of laptop dies. It writes time to an output file.

OUTFILE=battery-status.txt

while true ; do
    date +%T >> $OUTFILE
    cat /sys/class/power_supply/BAT0/energy_now >> $OUTFILE
    sync
    sleep 60
done

