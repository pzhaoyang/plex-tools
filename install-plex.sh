#!/bin/sh

docker rm -f plex
docker run -d \
 --name plex \
 -p 32400:32400/tcp \
 -p 3005:3005/tcp \
 -p 8324:8324/tcp \
 -p 32469:32469/tcp \
 -p 32410:32410/udp \
 -p 32412:32412/udp \
 -p 32413:32413/udp \
 -p 32414:32414/udp \
 -e PLEX_UID=0 \
 -e PLEX_GID=0 \
 -e TZ="Asia/Shanghai" \
 -e ADVERTISE_IP="http://192.168.31.123:32400" \
 -h mediacenter \
 -v /srv/mediacenter/disk1/system/plex-config:/config \
 -v /srv/mediacenter/disk1/movies:/movies \
 -v /srv/mediacenter/disk1/tv:/tv \
 -v /srv/mediacenter/disk2/nas:/nas-disk2 \
 -v /srv/mediacenter/disk3/nas:/nas-disk3 \
 --restart unless-stopped \
 freesmall/plex
