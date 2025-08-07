FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y               \
        php7.4-fpm                   \
        php7.4-mysql                 \
        php7.4-curl                  \
        php7.4-gd                    \
        php7.4-mbstring              \
        php7.4-xml                   \
        php7.4-zip                   \
        php7.4-intl                  \
        php7.4-bcmath                \
        curl                         
RUN rm -rf /var/lib/apt/lists/*    

EXPOSE 9000

RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/wp-cli.phar  \
    && chmod +x wp-cli.phar                                                     \
    && mv wp-cli.phar /usr/local/bin/wp                                         \
    && mkdir -p /var/www/html                                                   \
    && mkdir -p /run/php                                                        \
    && chown -R www-data:www-data /var/www/html                                 #

WORKDIR /var/www/html

COPY ./config/config.cnf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./config/php.ini /etc/php/7.4/fpm/php.ini
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]