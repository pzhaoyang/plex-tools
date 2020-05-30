#!/bin/sh

docker rm -f shairport > /dev/null
docker run -d \
--name shairport \
--net host \
--device /dev/snd \
-e AIRPLAY_NAME=HomePod-$(hostname) \
freesmall/shairport-sync
