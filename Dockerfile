FROM ubuntu:16.04

# Environments vars
ENV TERM=xterm


RUN apt-get update -y
RUN apt-get install -y software-properties-common python-software-properties language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php 
RUN apt-get update -y
# install php
RUN apt-get install -y --allow-unauthenticated php7.1 php7.1-bcmath php7.1-bz2 php7.1-cgi php7.1-cli php7.1-common php7.1-curl php7.1-dba php7.1-dev php7.1-enchant php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-interbase php7.1-intl php7.1-json php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-odbc php7.1-opcache php7.1-pgsql php7.1-phpdbg php7.1-pspell php7.1-readline php7.1-recode php7.1-snmp php7.1-soap php7.1-sqlite3 php7.1-sybase php7.1-tidy php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php-xdebug

RUN apt-get -y install php-xdebug
RUN apt-get install apache2 libapache2-mod-php7.1 -y --allow-unauthenticated

RUN apt-get install php-mbstring -y --allow-unauthenticated


RUN mkdir -p /usr/local/openssl/include/openssl/ && \
    ln -s /usr/include/openssl/evp.h /usr/local/openssl/include/openssl/evp.h && \
    mkdir -p /usr/local/openssl/lib/ && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.a /usr/local/openssl/lib/libssl.a && \
    ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/local/openssl/lib/

RUN a2enmod rewrite
RUN phpenmod mcrypt

# Composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Update the default apache site with the config we created.
ADD config/apache/apache-virtual-hosts.conf /etc/apache2/sites-enabled/000-default.conf
ADD config/apache/apache2.conf /etc/apache2/apache2.conf
ADD config/apache/ports.conf /etc/apache2/ports.conf
ADD config/apache/envvars /etc/apache2/envvars

# Update php.ini
ADD config/php/php.conf /etc/php/7.1/apache2/php.ini

# Init
ADD init.sh /init.sh
RUN chmod 755 /*.sh

# Add phpinfo script for INFO purposes
RUN echo "<?php phpinfo();" >> /var/www/index.php

RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.1/apache2/php.ini

RUN service apache2 restart

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www

# Volume
VOLUME /var/www

# Ports: apache2
EXPOSE 80

CMD ["/init.sh"]