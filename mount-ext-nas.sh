#!/bin/sh

ip=192.168.31.17
dir=(/share /share2)
path=/srv/dev-disk-by-id-usb-ST950032_5AS_000000123ADA-0-0-part1

mount -t nfs ${ip}:${dir[0]} ${path}/nas-external
mount -t nfs ${ip}:${dir[1]} ${path}/nas-external2


