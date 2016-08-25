#!/bin/sh

set -e

case "$1" in
	server)
		shift
		;;
	*)
		exec $*
		;;
esac

mkdir -p /var/lib/postfix
chown postfix:postfix /var/lib/postfix

mkdir -p /var/spool/postfix
chown root:root /var/spool/postfix

exec /usr/bin/supervisord -c /etc/supervisord.conf $*

