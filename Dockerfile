
FROM gentoo/stage3-amd64-hardened

RUN \
	wget -O - --no-verbose "http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2" | tar -C /usr -jxf - && \
	mkdir -p /etc/portage/package.use /etc/portage/package.keywords && \
	echo "mail-mta/postfix ldap sasl" >> /etc/portage/package.use/postfix \
	echo "dev-libs/cyrus-sasl kerberos openldap" >> /etc/portage/package.use/postfix && \
	echo "net-nds/openldap -tcpd" >> /etc/portage/package.use/postfix && \
	echo "dev-libs/openssl sctp -bindist" >> /etc/portage/package.use/postfix && \
	echo "net-misc/openssh sctp -bindist" >> /etc/portage/package.use/postfix && \
	env FEATURES="-sandbox -usersandbox" PORTAGE_SSH_OPTS="" emerge -qv \
		app-admin/supervisor dev-libs/openssl net-misc/openssh \
		mail-mta/postfix mail-filter/opendkim mail-filter/pypolicyd-spf && \
	rm -R /usr/portage/*

COPY files/entrypoint.sh /entrypoint.sh
COPY files/postfix-wrapper.sh /usr/bin/postfix-wrapper.sh
COPY files/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/entrypoint.sh"]

CMD ["server"]

