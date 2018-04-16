#!/usr/bin/env bash

/usr/bin/bitcoin-cli -conf=$1 gettransaction $2 | tr "\n" " " | timeout --signal=SIGTERM 1 sed "s/$/\n/"  > /var/run/bitcoind/events-in 2> /dev/null
exit 0