#!/bin/sh
docker rm -f webdav > /dev/null
docker run -d \
--name webdav \
-v /srv/mediacenter/disk1/app:/media \
-e USERNAME=root \
-e PASSWORD=pzhaoyang \
-p 9998:80 \
--restart=unless-stopped \
ugeek/webdav:arm

