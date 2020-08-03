#!/usr/bin/env sh

if [ $# -ne 2 ]; then
    echo >&2 "Usage: $(basename $0) DEVICE {on|off}"
    exit 1
fi

device="$1"
state="$2"

options="rx tx sg tso ufo gso gro lro rxvlan txvlan rxhash"
for option in $options; do
    ethtool --offload "$device" "$option" "$state" &>/dev/null || true
done
