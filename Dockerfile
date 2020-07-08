FROM php:7.2.31-cli

# https://getcomposer.org/doc/03-cli.md#composer-auth
ENV COMPOSER_AUTH=""

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update -y && \
    apt dist-upgrade -y && \
    apt install -y libcurl4-gnutls-dev libicu-dev libxml2-dev libxslt-dev zlib1g-dev git curl && \
    docker-php-ext-install curl intl mbstring mysqli pcntl pdo pdo_mysql xml xsl zip

RUN pecl install -o -f redis-5.0.2 \
  &&  rm -rf /tmp/pear \
  &&  docker-php-ext-enable redis

COPY --from=composer:1.10.8 /usr/bin/composer /usr/bin/composer

RUN composer global require hirak/prestissimo

ENTRYPOINT ["/bin/bash", "-c"]
