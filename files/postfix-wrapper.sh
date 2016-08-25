#!/bin/sh

# See http://superuser.com/questions/168412/using-supervisord-to-control-the-postfix-mta

trap "postfix stop" SIGINT
trap "postfix stop" SIGTERM
trap "postfix reload" SIGHUP

# force new copy of hosts there (otherwise links could be outdated)
cp /etc/hosts /var/spool/postfix/etc/hosts

# start postfix
postfix start

# lets give postfix some time to start
sleep 3

# wait until postfix is dead (triggered by trap)
while kill -0 $(cat /var/spool/postfix/pid/master.pid); do
	sleep 3
done

