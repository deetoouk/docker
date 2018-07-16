FROM php:7.2-fpm
MAINTAINER jordan.dobrev@deetoo.co.uk
# Install PHP extensions and PECL modules.
RUN buildDeps=" \
        libbz2-dev \
        libmysqlclient-dev \
        libsasl2-dev \
    " \
    runtimeDeps=" \
        cron \
        mysql-client \
        curl \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmcrypt-dev \
        libpng12-dev \
        libpq-dev \
        libxml2-dev \
    " \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $buildDeps $runtimeDeps \
    && docker-php-ext-install mbstring zip bcmath pcntl ftp exif calendar intl opcache pdo sockets sysvmsg sysvsem sysvshm mysqli pdo_mysql mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && pecl install redis \
    && docker-php-ext-enable redis.so \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -r /var/lib/apt/lists/*
# Set up PHP correctly
RUN sed -i "/pm.max_children =/c\pm.max_children = 50" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "/pm.start_servers =/c\pm.start_servers = 15" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "/pm.min_spare_servers =/c\pm.min_spare_servers = 15" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "/pm.max_spare_servers =/c\pm.max_spare_servers = 25" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "/pm.max_requests =/c\pm.max_requests = 500" /usr/local/etc/php-fpm.d/www.conf
COPY init.sh /home
RUN chmod +x /home/init.sh
RUN touch /var/log/cron.log
CMD ["/home/init.sh"]
