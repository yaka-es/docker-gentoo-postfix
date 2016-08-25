# docker-gentoo-postfix
Dockerized Postfix MTA, OpenDKIM and policyd-spf

Basic usage:

```
$ docker run --rm -it -v /mnt/docker/mail/etc/postfix/main.cf:/etc/postfix/main.cf -v /mnt/docker/mail/var/spool/postfix:/var/spool/postfix/ yakaes/docker-gentoo-postfix
```

