FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y                                                    \
    && apt-get install -y                                                                   \
        php7.4-fpm                                                                          \
        php7.4-mysql                                                                        \
        php7.4-curl                                                                         \
        php7.4-gd                                                                           \
        php7.4-mbstring                                                                     \
        php7.4-xml                                                                          \
        php7.4-zip                                                                          \
        php7.4-intl                                                                         \
        php7.4-bcmath                                                                       \
        curl                                                                                \
    && rm -rf /var/lib/apt/lists/*                                                          \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar    \
    && chmod +x wp-cli.phar                                                                 \
    && mv wp-cli.phar /usr/local/bin/wp                                                     #

WORKDIR /var/www/html

COPY ./config/config.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh                                                   \
    && chown -R root:root /var/www/html                                                     #

ENTRYPOINT ["entrypoint.sh"]