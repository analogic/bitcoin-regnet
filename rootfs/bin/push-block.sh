#!/usr/bin/env bash

lock="/var/run/bitcoind/events-in.lock"
die() { echo "$*" 1>&2 ; exit 1; }

(
flock -x -w 3 200 || die "can't obtain lock $lock"

echo "sending notice about block $1"
timeout --signal=SIGTERM 1 echo $1 > $2 2> /dev/null
)200>$lock

exit 0
