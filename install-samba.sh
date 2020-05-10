#!/bin/sh

docker rm -f samba
docker run -d \
--name samba \
-e USERID=65534 \
-e GROUPID=65534 \
-p 139:139 \
-p 445:445 \
-v /srv/mediacenter/disk1:/share1 \
-v /srv/mediacenter/disk2:/share2 \
-v /srv/mediacenter/disk3:/share3 \
--restart=unless-stopped \
freesmall/samba -p \
-u "nobody;badpass;" \
-s "mediacenter1;/share1;yes;no;yes;all;none;;RaspSamba" \
-s "mediacenter2;/share2;yes;no;yes;all;none;;RaspSamba" \
-s "mediacenter3;/share3;yes;no;yes;all;none;;RaspSamba"
