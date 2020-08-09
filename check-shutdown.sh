#!/bin/sh
# This scripts checks wheter shutdown is in progress
if [ -f /run/systemd/shutdown/scheduled ]; then
	perl -wne 'm/^USEC=(\d+)\d{6}$/ and printf("Shutting down at: %s\n", scalar localtime $1)' < /run/systemd/shutdown/scheduled
else
	echo "No shutdown in progress."
fi
