FROM php:8.3-apache

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN sh nodesource_setup.sh
RUN apt-get update && apt-get install -y \
    git \
    zip \
    curl \
    sudo \
    unzip \
    libzip-dev \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++ \
    nodejs \
    libzip-dev \
    libxml2-dev \
    ffmpeg

COPY --from=composer:2.3 /usr/bin/composer /usr/local/bin/composer

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-configure intl
RUN docker-php-ext-install pdo pdo_mysql mysqli zip gd exif bcmath soap intl

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN echo "xdebug.mode=develop,debug,coverage,gcstats,profile,trace" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=VSCODE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_output_name=cachegrind.out.%R-%t-%s" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.output_dir=/var/www/html/aetherflo/app/storage/logs" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log=/var/www/html/aetherflo/app/storage/logs/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log_level=3" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY ./conf/apache2/sites-available/dev.test-site.loc.conf /etc/apache2/sites-available/dev.test-site.loc.conf

CMD apachectl -D FOREGROUND

RUN ln -s /etc/apache2/mods-available/ssl.load  /etc/apache2/mods-enabled/ssl.load
RUN a2enmod rewrite
RUN a2enmod mime
RUN a2ensite dev.test-site.loc

RUN service apache2 restart