#!/bin/bash
HOST="google.com"
if ping -c 1 $HOST > /dev/null 2>&1; then
    echo "$HOST is responding."
else
    echo "$HOST is not responding."
fi
