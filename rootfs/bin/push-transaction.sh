#!/usr/bin/env bash

lock="/var/run/bitcoind/events-in.lock"
die() { echo "$*" 1>&2 ; exit 1; }

(
flock -x -w 3 200 || die "can't obtain lock $lock"

echo "sending notice about tx $2"
/usr/bin/bitcoin-cli -conf=$1 gettransaction $2 | tr "\n" " " | timeout --signal=SIGTERM 1 sed "s/$/\n/"  > /var/run/bitcoind/events-in 2> /dev/null
)200>$lock

exit 0
