# Mostly taken from https://github.com/nextcloud/docker (see cron and imap example, I just needed both ;) )
FROM nextcloud:24-fpm-alpine
LABEL maintainer="Martin Biermair <martin@biermair.at>"

RUN apk add --no-cache supervisor gmp-dev imagemagick
 
RUN mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

# make sure, that the nextcloud volume gets upgraded on startup
ENV NEXTCLOUD_UPDATE 1

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]