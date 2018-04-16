#!/usr/bin/env bash

timeout --signal=SIGTERM 1 echo $1 > $2 2> /dev/null
exit 0