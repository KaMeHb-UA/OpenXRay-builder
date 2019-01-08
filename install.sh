#!/bin/sh
mkdir -p /game/bin
cd /xray-16/bin
make DESTDIR=/game/bin install
