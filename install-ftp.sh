#!/bin/sh

docker rm -f ftp
docker run -d \
--name ftp \
-v /srv/mediacenter/disk3/nas:/home/vsftpd \
-p 20:20 \
-p 21:21 \
-p 47400-47470:47400-47470 \
-e FTP_USER=pi \
-e FTP_PASS=pzhaoyang \
-e PASV_ADDRESS=192.168.31.123 \
--restart=unless-stopped \
freesmall/ftp
