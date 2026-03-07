#!/bin/sh
# Add your startup script
echo $DASFLAG > /flag
# DO NOT DELETE
#/etc/init.d/xinetd start;
/bin/sh /home/ctf/find.sh &
/usr/bin/supervisord -c /home/ctf/supervisord.conf

sleep infinity;




