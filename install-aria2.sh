#!/bin/sh

docker rm -f aria2-pro ariang
docker run -d \
  --name aria2-pro \
  --restart unless-stopped \
  --log-opt max-size=1m \
  -e PUID=65534 \
  -e PGID=65534 \
  -e RPC_SECRET=pzhaoyang \
  -p 6800:6800 \
  -p 6888:6888 \
  -p 6888:6888/udp \
  -v /srv/mediacenter/disk1/system/aria2-config:/config \
  -v /srv/mediacenter/disk1/downloads:/downloads \
  p3terx/aria2-pro

docker run -d \
  --name ariang \
  -p 6080:80 \
  --restart unless-stopped \
  leonismoe/ariang:arm32v6-latest
