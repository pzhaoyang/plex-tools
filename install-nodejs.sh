#!/bin/sh

[ $# = 1 ] || { echo -e "Please input the js file in app, like hello.js\n"; exit 0; }

[ -f "/srv/mediacenter/disk1/app/${1}" ] || { echo -e "The file("$1") is not exist\n"; exit 0; }

docker rm -f nodejs > /dev/null

docker run -d \
--net=host \
--name nodejs \
-v /srv/mediacenter/disk1/app:/srv/app \
--restart=unless-stopped \
webhippie/nodejs node $1
