#!/bin/bash
# usage: rm_older_than DIR [DAYS]

function print_usage {
  echo "usage: rm_older_than.sh DIR [DAYS]"
}

if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

DIR="$1"
DAYS=${2:-30}

find "$DIR" -atime +${DAYS} -print0 | xargs -0 /bin/rm -f
