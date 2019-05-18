# Mostly taken from https://github.com/nextcloud/docker (see cron and imap example, I just needed both ;) )
FROM nextcloud:16-fpm-alpine
LABEL maintainer="Martin Biermair <martin@biermair.at>"

RUN apk upgrade --update \
 && apk add imap-dev openssl-dev krb5-dev supervisor \
 && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 && docker-php-ext-install imap \
 && mkdir /var/log/supervisord /var/run/supervisord \
 && rm -rf /var/cache/apk/*

COPY supervisord.conf /etc/supervisor/supervisord.conf

# make sure, that the nextcloud volume gets upgraded on startup
ENV NEXTCLOUD_UPDATE 1

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]