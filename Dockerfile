FROM alpine:latest

LABEL Maintainer="Khisby Al Ghofari <khisby@gmail.com>" \
      Description="Niagahoster Fullstack Developer Test - Technical Test"

WORKDIR /var/www/html/

RUN apk add --no-cache tzdata

RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN echo "Asia/Jakarta" > /etc/timezone

RUN apk add --no-cache zip unzip curl sqlite nginx supervisor

RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

RUN apk add --no-cache php \
    php-common \
    php-fpm \
    php-pdo \
    php-opcache \
    php-zip \
    php-phar \
    php-iconv \
    php-cli \
    php-curl \
    php-openssl \
    php-mbstring \
    php-tokenizer \
    php-fileinfo \
    php-json \
    php-xml \
    php-xmlwriter \
    php-simplexml \
    php-dom \
    php-pdo_mysql \
    php-pdo_sqlite \
    php-tokenizer \
    php-ctype\
    php-gettext\
    php-session\
    wget

RUN rm -rf /usr/bin/php
RUN ln -s /usr/bin/php7 /usr/bin/php

RUN rm -rf \etc\nginx\http.d\default.conf

RUN mkdir -p /etc/supervisor.d/
COPY config/supervisord.ini /etc/supervisor.d/supervisord.ini

RUN mkdir -p /run/php/
RUN touch /run/php/php7-fpm.pid

COPY config/php-fpm.conf /etc/php7/php-fpm.conf
COPY config/nginx.conf /etc/nginx/
COPY config/nginx-site.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /run/nginx/
RUN touch /run/nginx/nginx.pid

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN wget https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip
RUN unzip BoxBilling.zip

COPY --chown=nobody:nobody src /var/www/html/

RUN mkdir -p /var/www/html/bb-data/cache /var/www/html/bb-data/log	/var/www/html/bb-data/uploads	
RUN chmod -R 765 /var/www/html/bb-data/cache /var/www/html/bb-data/log	/var/www/html/bb-data/uploads	

RUN chown -R nobody:nobody /var/www/html/

RUN rm -rf  /var/www/html/install

COPY config/crontab /etc/cron.d/crontab
RUN chmod 0644  /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log


EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
