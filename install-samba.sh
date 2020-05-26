#!/bin/sh

docker rm -f samba
docker run -d \
--name samba \
-e USERID=0 \
-e GROUPID=0 \
-p 139:139 \
-p 445:445 \
-v /srv/mediacenter/disk1/downloads:/share \
--restart=unless-stopped \
dperson/samba -p \
-u "nobody;badpass;" \
-s "mediacenter;/share;yes;no;yes;all;none;;RaspSamba"
